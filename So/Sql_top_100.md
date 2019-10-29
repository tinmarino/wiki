---
title: Sql <- StackOverflow top 100
category: sql
wiki_css: ../Css/color_dark_solarized.css, ../Css/layout_toc.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

<section class="level2">

</b> </em> </i> </small> </strong> </sub> </sup>

### 1: How do I UPDATE from a SELECT in SQL Server? (score [4028296](https://stackoverflow.com/q/2334712) in 2019)

#### Question
In <strong>SQL Server</strong>, it's possible to `insert` into a table using a `SELECT` statement:  

```sql
INSERT INTO Table (col1, col2, col3)
SELECT col1, col2, col3 
FROM other_table 
WHERE sql = 'cool'
```

Is it also possible to <em>update</em> via a `SELECT`? I have a temporary table containing the values and would like to update another table using those values. Perhaps something like this:  

```sql
UPDATE Table SET col1, col2
SELECT col1, col2 
FROM other_table 
WHERE sql = 'cool'
WHERE Table.id = other_table.id
```

#### Answer accepted (score 5105)
```sql
UPDATE
    Table_A
SET
    Table_A.col1 = Table_B.col1,
    Table_A.col2 = Table_B.col2
FROM
    Some_Table AS Table_A
    INNER JOIN Other_Table AS Table_B
        ON Table_A.id = Table_B.id
WHERE
    Table_A.col3 = 'cool'
```

#### Answer 2 (score 737)
In SQL Server 2008 (or better), use <a href="http://technet.microsoft.com/en-us/library/bb510625.aspx" rel="noreferrer">`MERGE`</a>  

```sql
MERGE INTO YourTable T
   USING other_table S 
      ON T.id = S.id
         AND S.tsql = 'cool'
WHEN MATCHED THEN
   UPDATE 
      SET col1 = S.col1, 
          col2 = S.col2;
```

Alternatively:  

```sql
MERGE INTO YourTable T
   USING (
          SELECT id, col1, col2 
            FROM other_table 
           WHERE tsql = 'cool'
         ) S
      ON T.id = S.id
WHEN MATCHED THEN
   UPDATE 
      SET col1 = S.col1, 
          col2 = S.col2;
```

#### Answer 3 (score 616)
```sql
UPDATE table 
SET Col1 = i.Col1, 
    Col2 = i.Col2 
FROM (
    SELECT ID, Col1, Col2 
    FROM other_table) i
WHERE 
    i.ID = table.ID
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 2: How do I perform an IF...THEN in an SQL SELECT? (score [3492496](https://stackoverflow.com/q/63447) in 2018)

#### Question
How do I perform an `IF...THEN` in an `SQL SELECT` statement?  

For example:  

```sql
SELECT IF(Obsolete = 'N' OR InStock = 'Y' ? 1 : 0) AS Saleable, * FROM Product
```

#### Answer accepted (score 1679)
The `CASE` statement is the closest to IF in SQL and is supported on all versions of SQL Server.  

```sql
SELECT CAST(
             CASE
                  WHEN Obsolete = 'N' or InStock = 'Y'
                     THEN 1
                  ELSE 0
             END AS bit) as Saleable, *
FROM Product
```

You only need to do the `CAST` if you want the result as a Boolean value. If you are happy with an `int`, this works:  

```sql
SELECT CASE
            WHEN Obsolete = 'N' or InStock = 'Y'
               THEN 1
               ELSE 0
       END as Saleable, *
FROM Product
```

`CASE` statements can be embedded in other `CASE` statements and even included in aggregates.  

SQL Server Denali (SQL Server 2012) adds the <a href="http://msdn.microsoft.com/en-us/library/hh213574%28v=sql.110%29.aspx" rel="noreferrer">IIF</a> statement which is also available in <a href="http://www.techonthenet.com/access/functions/advanced/iif.php" rel="noreferrer">access</a> (pointed out by <a href="https://stackoverflow.com/questions/63447/how-do-you-perform-an-if-then-in-an-sql-select/6769805#6769805">Martin Smith</a>):  

```sql
SELECT IIF(Obsolete = 'N' or InStock = 'Y', 1, 0) as Saleable, * FROM Product
```

#### Answer 2 (score 317)
The case statement is your friend in this situation, and takes one of two forms:  

The simple case:  

```sql
SELECT CASE <variable> WHEN <value>      THEN <returnvalue>
                       WHEN <othervalue> THEN <returnthis>
                                         ELSE <returndefaultcase>
       END AS <newcolumnname>
FROM <table>
```

The extended case:  

```sql
SELECT CASE WHEN <test>      THEN <returnvalue>
            WHEN <othertest> THEN <returnthis>
                             ELSE <returndefaultcase>
       END AS <newcolumnname>
FROM <table>
```

You can even put case statements in an order by clause for really fancy ordering.  

#### Answer 3 (score 258)
From SQL Server 2012 you can use the <a href="http://msdn.microsoft.com/en-us/library/hh213574(v=sql.110).aspx" rel="noreferrer"><strong>`IIF`</strong> function</a> for this.  

```sql
SELECT IIF(Obsolete = 'N' OR InStock = 'Y', 1, 0) AS Salable, *
FROM   Product
```

This is effectively just a shorthand (albeit not standard SQL) way of writing `CASE`.  

I prefer the conciseness when compared with the expanded `CASE` version.  

Both `IIF()` and `CASE` resolve as expressions within a SQL statement and can only be used in well-defined places.  

<blockquote>
  <p>The CASE expression cannot be used to control the flow of execution of
  Transact-SQL statements, statement blocks, user-defined functions, and
  stored procedures.</p>
</blockquote>

If your needs can not be satisfied by these limitations (for example, a need to return differently shaped result sets dependent on some condition) then SQL Server does also have a procedural <a href="http://msdn.microsoft.com/en-gb/library/ms182717.aspx" rel="noreferrer">`IF`</a> keyword.  

```sql
IF @IncludeExtendedInformation = 1
  BEGIN
      SELECT A,B,C,X,Y,Z
      FROM   T
  END
ELSE
  BEGIN
      SELECT A,B,C
      FROM   T
  END
```

<a href="https://dba.stackexchange.com/a/9874/3690">Care must sometimes be taken to avoid parameter sniffing issues with this approach however</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 3: OR is not supported with CASE Statement in SQL Server (score [2977623](https://stackoverflow.com/q/5487892) in 2019)

#### Question
The `OR` operator in the `WHEN` clause of a `CASE` statement is not supported. How can I do this?  

```sql
CASE ebv.db_no 
    WHEN 22978 OR 23218 OR 23219 THEN 'WECS 9500' 
    ELSE 'WECS 9520' 
END as wecs_system 
```

#### Answer accepted (score 1059)
That format requires you to use either:  

```sql
CASE ebv.db_no 
  WHEN 22978 THEN 'WECS 9500' 
  WHEN 23218 THEN 'WECS 9500'  
  WHEN 23219 THEN 'WECS 9500' 
  ELSE 'WECS 9520' 
END as wecs_system 
```

Otherwise, use:  

```sql
CASE  
  WHEN ebv.db_no IN (22978, 23218, 23219) THEN 'WECS 9500' 
  ELSE 'WECS 9520' 
END as wecs_system 
```

#### Answer 2 (score 243)
```sql
CASE
  WHEN ebv.db_no = 22978 OR 
       ebv.db_no = 23218 OR
       ebv.db_no = 23219
  THEN 'WECS 9500' 
  ELSE 'WECS 9520' 
END as wecs_system 
```

#### Answer 3 (score 57)
```sql
CASE WHEN ebv.db_no  IN (22978, 23218, 23219) THEN 'WECS 9500' 
  ELSE 'WECS 9520' 
END as wecs_system 
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 4: How do I import an SQL file using the command line in MySQL? (score [2945526](https://stackoverflow.com/q/17666249) in 2019)

#### Question
I have a `.sql` file with an export from `phpMyAdmin`. I want to import it into a different server using the command line.  

I have a <a href="http://en.wikipedia.org/wiki/Windows_Server_2008" rel="noreferrer">Windows Server 2008</a> R2 installation. I placed the `.sql` file on the <strong><em>C drive</em></strong>, and I tried this command  

```sql
database_name < file.sql
```

It is not working. I get syntax errors.  

<ul>
<li>How can I import this file without a problem?</li>
<li>Do I need to create a database first?</li>
</ul>

#### Answer accepted (score 3384)
Try:  

```sql
mysql -u username -p database_name < file.sql
```

Check <a href="http://dev.mysql.com/doc/refman/5.0/en/mysql-command-options.html" rel="noreferrer">MySQL Options</a>.  

<strong>Note-1:</strong> It is better to use the full path of the SQL file `file.sql`.  

<strong>Note-2:</strong> Use `-R` and `--triggers` to keep the routines and triggers of original database. They are not copied by default.  

<strong>Note-3</strong> You may have to create the (empty) database from mysql if it doesn't exist already and the exported SQL don't contain `CREATE DATABASE` (exported with `--no-create-db` or `-n` option), before you can import it.  

#### Answer 2 (score 694)
A common use of <a href="http://dev.mysql.com/doc/refman/5.1/en/mysqldump.html" rel="noreferrer">mysqldump</a> is for making a backup of an entire database:  

```sql
shell> mysqldump db_name > backup-file.sql
```

You can load the dump file back into the server like this:  

<strong>UNIX</strong>  

```sql
shell> mysql db_name < backup-file.sql
```

The same in <strong>Windows</strong> command prompt:  

```sql
mysql -p -u [user] [database] < backup-file.sql
```

<strong>PowerShell</strong>  

```sql
C:\> cmd.exe /c "mysql -u root -p db_name < backup-file.sql"
```

<strong>MySQL command line</strong>  

```sql
mysql> use db_name;
mysql> source backup-file.sql;
```

#### Answer 3 (score 289)
Regarding the time taken for importing huge files: most importantly, it takes more time because the default setting of MySQL is `autocommit = true`. You must set that off before importing your file and then check how import works like a gem.  

You just need to do the following thing:  

```sql
mysql> use db_name;

mysql> SET autocommit=0 ; source the_sql_file.sql ; COMMIT ;
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 5: Add a column with a default value to an existing table in SQL Server (score [2693765](https://stackoverflow.com/q/92082) in 2018)

#### Question
How can a column with a default value be added to an existing table in <a href="http://en.wikipedia.org/wiki/Microsoft_SQL_Server#Genesis" rel="noreferrer">SQL Server 2000</a> / <a href="http://en.wikipedia.org/wiki/Microsoft_SQL_Server#SQL_Server_2005" rel="noreferrer">SQL Server 2005</a>?  

#### Answer accepted (score 3307)
<h5>Syntax:</h2>

```sql
ALTER TABLE {TABLENAME} 
ADD {COLUMNNAME} {TYPE} {NULL|NOT NULL} 
CONSTRAINT {CONSTRAINT_NAME} DEFAULT {DEFAULT_VALUE}
WITH VALUES
```

<h5>Example:</h2>

```sql
ALTER TABLE SomeTable
        ADD SomeCol Bit NULL --Or NOT NULL.
 CONSTRAINT D_SomeTable_SomeCol --When Omitted a Default-Constraint Name is autogenerated.
    DEFAULT (0)--Optional Default-Constraint.
WITH VALUES --Add if Column is Nullable and you want the Default Value for Existing Records.
```

<h5>Notes:</h2>

<p><strong>Optional Constraint Name:</strong><br />
If you leave out `CONSTRAINT D_SomeTable_SomeCol` then SQL Server will autogenerate<br />
&nbsp; &nbsp; a Default-Contraint with a funny Name like: `DF__SomeTa__SomeC__4FB7FEF6`<br /></p>

<p><strong>Optional With-Values Statement:</strong><br />
The `WITH VALUES` is only needed when your Column is Nullable<br />
&nbsp; &nbsp; and you want the Default Value used for Existing Records.<br />
If your Column is `NOT NULL`, then it will automatically use the Default Value<br />
&nbsp; &nbsp; for all Existing Records, whether you specify `WITH VALUES` or not.</p>

<p><strong>How Inserts work with a Default-Constraint:</strong><br />
If you insert a Record into `SomeTable` and do <strong><em>not</em></strong> Specify `SomeCol`'s value, then it will Default to `0`.<br />
If you insert a Record <strong><em>and</em></strong> Specify `SomeCol`'s value as `NULL` (and your column allows nulls),<br />
&nbsp; &nbsp; then the Default-Constraint will <strong><em>not</em></strong> be used and `NULL` will be inserted as the Value.<br /></p>

<p>Notes were based on everyone's great feedback below.<br />
Special Thanks to:<br />
&nbsp; &nbsp; @Yatrix, @WalterStabosz, @YahooSerious, and @StackMan for their Comments.</p>

#### Answer 2 (score 957)
```sql
ALTER TABLE Protocols
ADD ProtocolTypeID int NOT NULL DEFAULT(1)
GO
```

The inclusion of the <strong>DEFAULT</strong> fills the column in <strong>existing</strong> rows with the default value, so the NOT NULL constraint is not violated.   

#### Answer 3 (score 224)
When adding a <em>nullable column</em>, `WITH VALUES` will ensure that the specific DEFAULT value is applied to existing rows:  

```sql
ALTER TABLE table
ADD column BIT     -- Demonstration with NULL-able column added
CONSTRAINT Constraint_name DEFAULT 0 WITH VALUES
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 6: How to return only the Date from a SQL Server DateTime datatype (score [2620097](https://stackoverflow.com/q/113045) in 2017)

#### Question
```sql
SELECT GETDATE()
```

Returns: `2008-09-22 15:24:13.790`  

I want that date part without the time part: `2008-09-22 00:00:00.000`  

How can I get that?  

#### Answer accepted (score 2379)
On `SQL Server 2008` and higher, you should `CONVERT` to date:  

```sql
SELECT CONVERT(date, getdate())
```

On older versions, you can do the following:  

```sql
SELECT DATEADD(dd, 0, DATEDIFF(dd, 0, @your_date))
```

for example  

```sql
SELECT DATEADD(dd, 0, DATEDIFF(dd, 0, GETDATE()))
```

gives me     

```sql
2008-09-22 00:00:00.000
```

Pros:   

<ul>
<li>No `varchar`&lt;->`datetime` conversions required</li>
<li>No need to think about `locale`</li>
</ul>

<hr/>

As suggested by <a href="https://stackoverflow.com/users/241211/michael">Michael</a>  

Use this variant: `SELECT DATEADD(dd, 0, DATEDIFF(dd, 0, getdate()))`  

```sql
select getdate()

SELECT DATEADD(hh, DATEDIFF(hh, 0, getdate()), 0)
SELECT DATEADD(hh, 0, DATEDIFF(hh, 0, getdate()))

SELECT DATEADD(dd, DATEDIFF(dd, 0, getdate()), 0)
SELECT DATEADD(dd, 0, DATEDIFF(dd, 0, getdate()))

SELECT DATEADD(mm, DATEDIFF(mm, 0, getdate()), 0)
SELECT DATEADD(mm, 0, DATEDIFF(mm, 0, getdate()))

SELECT DATEADD(yy, DATEDIFF(yy, 0, getdate()), 0)
SELECT DATEADD(yy, 0, DATEDIFF(yy, 0, getdate()))
```

Output:  

```sql
2019-04-19 08:09:35.557

2019-04-19 08:00:00.000
4763-02-17 00:00:00.000

2019-04-19 00:00:00.000
2019-04-19 00:00:00.000

2019-04-01 00:00:00.000
1903-12-03 00:00:00.000

2019-01-01 00:00:00.000
1900-04-30 00:00:00.000
```

#### Answer 2 (score 703)
SQLServer 2008 now has a 'date' data type which contains only a date with no time component. Anyone using SQLServer 2008 and beyond can do the following:  

```sql
SELECT CONVERT(date, GETDATE())
```

#### Answer 3 (score 159)
If using SQL 2008 and above:  

```sql
select cast(getdate() as date)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 7: Finding duplicate values in a SQL table (score [2602064](https://stackoverflow.com/q/2594829) in 2019)

#### Question
It's easy to find duplicates with one field:  

```sql
SELECT name, COUNT(email) 
FROM users
GROUP BY email
HAVING COUNT(email) > 1
```

So if we have a table  

```sql
ID   NAME   EMAIL
1    John   asd@asd.com
2    Sam    asd@asd.com
3    Tom    asd@asd.com
4    Bob    bob@asd.com
5    Tom    asd@asd.com
```

This query will give us John, Sam, Tom, Tom because they all have the same `email`.  

However, what I want is to get duplicates with the same `email` <strong>and</strong> `name`.  

That is, I want to get "Tom", "Tom".  

The reason I need this: I made a mistake, and allowed to insert duplicate `name` and `email` values. Now I need to remove/change the duplicates, so I need to <em>find</em> them first.  

#### Answer accepted (score 2777)
```sql
SELECT
    name, email, COUNT(*)
FROM
    users
GROUP BY
    name, email
HAVING 
    COUNT(*) > 1
```

Simply group on both of the columns.  

Note: the older ANSI standard is to have all non-aggregated columns in the GROUP BY but this has changed with the idea of <a href="https://blog.jooq.org/2015/12/10/sql-group-by-and-functional-dependencies-a-very-useful-feature/" rel="noreferrer">"functional dependency"</a>:  

<blockquote>
  In relational database theory, a functional dependency is a constraint between two sets of attributes in a relation from a database. In other words, functional dependency is a constraint that describes the relationship between attributes in a relation.  
</blockquote>

Support is not consistent:  

<ul>
<li>Recent PostgreSQL <a href="https://www.postgresql.org/docs/current/static/sql-select.html#SQL-GROUPBY" rel="noreferrer">supports it</a>.</li>
<li>SQL Server (as at SQL Server 2017) still requires all non-aggregated columns in the GROUP BY.</li>
<li>MySQL is unpredictable and you need `sql_mode=only_full_group_by`:

<ul>
<li><a href="https://stackoverflow.com/q/10894820/27535">GROUP BY lname ORDER BY showing wrong results</a>;</li>
<li><a href="https://stackoverflow.com/questions/6060241/which-is-the-least-expensive-aggregate-function-in-the-absence-of-any/6060414#6060414">Which is the least expensive aggregate function in the absence of ANY()</a> (see comments in accepted answer).</li>
</ul></li>
<li>Oracle isn't mainstream enough (warning: humour, I don't know about Oracle).</li>
</ul>

#### Answer 2 (score 346)
try this:  

```sql
declare @YourTable table (id int, name varchar(10), email varchar(50))

INSERT @YourTable VALUES (1,'John','John-email')
INSERT @YourTable VALUES (2,'John','John-email')
INSERT @YourTable VALUES (3,'fred','John-email')
INSERT @YourTable VALUES (4,'fred','fred-email')
INSERT @YourTable VALUES (5,'sam','sam-email')
INSERT @YourTable VALUES (6,'sam','sam-email')

SELECT
    name,email, COUNT(*) AS CountOf
    FROM @YourTable
    GROUP BY name,email
    HAVING COUNT(*)>1
```

OUTPUT:  

```sql
name       email       CountOf
---------- ----------- -----------
John       John-email  2
sam        sam-email   2

(2 row(s) affected)
```

if you want the IDs of the dups use this:  

```sql
SELECT
    y.id,y.name,y.email
    FROM @YourTable y
        INNER JOIN (SELECT
                        name,email, COUNT(*) AS CountOf
                        FROM @YourTable
                        GROUP BY name,email
                        HAVING COUNT(*)>1
                    ) dt ON y.name=dt.name AND y.email=dt.email
```

OUTPUT:  

```sql
id          name       email
----------- ---------- ------------
1           John       John-email
2           John       John-email
5           sam        sam-email
6           sam        sam-email

(4 row(s) affected)
```

to delete the duplicates try:  

```sql
DELETE d
    FROM @YourTable d
        INNER JOIN (SELECT
                        y.id,y.name,y.email,ROW_NUMBER() OVER(PARTITION BY y.name,y.email ORDER BY y.name,y.email,y.id) AS RowRank
                        FROM @YourTable y
                            INNER JOIN (SELECT
                                            name,email, COUNT(*) AS CountOf
                                            FROM @YourTable
                                            GROUP BY name,email
                                            HAVING COUNT(*)>1
                                        ) dt ON y.name=dt.name AND y.email=dt.email
                   ) dt2 ON d.id=dt2.id
        WHERE dt2.RowRank!=1
SELECT * FROM @YourTable
```

OUTPUT:   

```sql
id          name       email
----------- ---------- --------------
1           John       John-email
3           fred       John-email
4           fred       fred-email
5           sam        sam-email

(4 row(s) affected)
```

#### Answer 3 (score 109)
Try this:  

```sql
SELECT name, email
FROM users
GROUP BY name, email
HAVING ( COUNT(*) > 1 )
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 8: Inserting multiple rows in a single SQL query? (score [2497025](https://stackoverflow.com/q/452859) in 2019)

#### Question
I have multiple set of data to insert at once, say 4 rows. My table has three columns: `Person`, `Id` and `Office`.  

```sql
INSERT INTO MyTable VALUES ("John", 123, "Lloyds Office");
INSERT INTO MyTable VALUES ("Jane", 124, "Lloyds Office");
INSERT INTO MyTable VALUES ("Billy", 125, "London Office");
INSERT INTO MyTable VALUES ("Miranda", 126, "Bristol Office");
```

Can I insert all 4 rows in a single SQL statement?  

#### Answer 2 (score 2131)
In SQL Server 2008 you can insert multiple rows using a single SQL INSERT statement.  

```sql
INSERT INTO MyTable ( Column1, Column2 ) VALUES
( Value1, Value2 ), ( Value1, Value2 )
```

For reference to this have a look at MOC Course 2778A - Writing SQL Queries in SQL Server 2008.  

For example:  

```sql
INSERT INTO MyTable
  ( Column1, Column2, Column3 )
VALUES
  ('John', 123, 'Lloyds Office'), 
  ('Jane', 124, 'Lloyds Office'), 
  ('Billy', 125, 'London Office'),
  ('Miranda', 126, 'Bristol Office');
```

#### Answer 3 (score 780)
If you are inserting into a single table, you can write your query like this (maybe only in MySQL):  

```sql
INSERT INTO table1 (First, Last)
VALUES
    ('Fred', 'Smith'),
    ('John', 'Smith'),
    ('Michael', 'Smith'),
    ('Robert', 'Smith');
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 9: Insert into ... values ( SELECT ... FROM ... ) (score [2393511](https://stackoverflow.com/q/25969) in 2018)

#### Question
I am trying to `INSERT INTO` a table using the input from another table. Although this is entirely feasible for many database engines, I always seem to struggle to remember the correct syntax for the `SQL` engine of the day (<a href="http://en.wikipedia.org/wiki/MySQL" rel="noreferrer">MySQL</a>, <a href="http://en.wikipedia.org/wiki/Oracle_Database" rel="noreferrer">Oracle</a>, <a href="http://en.wikipedia.org/wiki/Microsoft_SQL_Server" rel="noreferrer">SQL Server</a>, <a href="http://en.wikipedia.org/wiki/IBM_Informix" rel="noreferrer">Informix</a>, and <a href="http://en.wikipedia.org/wiki/IBM_DB2" rel="noreferrer">DB2</a>).  

Is there a silver-bullet syntax coming from an SQL standard (for example, <a href="http://en.wikipedia.org/wiki/SQL-92" rel="noreferrer">SQL-92</a>) that would allow me to insert the values without worrying about the underlying database?  

#### Answer accepted (score 1522)
Try:  

```sql
INSERT INTO table1 ( column1 )
SELECT  col1
FROM    table2  
```

This is standard ANSI SQL and should work on any DBMS  

It definitely works for:  

<ul>
<li>Oracle  </li>
<li>MS SQL Server  </li>
<li>MySQL  </li>
<li>Postgres  </li>
<li>SQLite v3  </li>
<li>Teradata</li>
<li>DB2  </li>
<li>Sybase</li>
<li>Vertica</li>
<li>HSQLDB</li>
<li>H2</li>
<li>AWS RedShift</li>
<li>SAP HANA</li>
</ul>

#### Answer 2 (score 865)
@<a href="https://stackoverflow.com/a/25971/282110">Shadow_x99</a>: That should work fine, and you can also have multiple columns and other data as well:  

```sql
INSERT INTO table1 ( column1, column2, someInt, someVarChar )
SELECT  table2.column1, table2.column2, 8, 'some string etc.'
FROM    table2
WHERE   table2.ID = 7;
```

Edit: I should mention that I've only used this syntax with Access, SQL 2000/2005/Express, MySQL, and PostgreSQL, so those should be covered. A commenter has pointed out that it'll work with SQLite3.  

#### Answer 3 (score 126)
To get only one value in a multi value `INSERT` from another table I did the following in SQLite3:  

```sql
INSERT INTO column_1 ( val_1, val_from_other_table ) 
VALUES('val_1', (SELECT  val_2 FROM table_2 WHERE val_2 = something))
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 10: What is the difference between "INNER JOIN" and "OUTER JOIN"? (score [2264024](https://stackoverflow.com/q/38549) in 2019)

#### Question
Also how do `LEFT JOIN`, `RIGHT JOIN` and `FULL JOIN` fit in?  

#### Answer accepted (score 5940)
Assuming you're joining on columns with no duplicates, which is a very common case:  

<ul>
<li><p>An inner join of A and B gives the result of A intersect B, i.e. the inner part of a <a href="http://en.wikipedia.org/wiki/Venn_diagram" rel="noreferrer">Venn diagram</a> intersection.</p></li>
<li><p>An outer join of A and B gives the results of A union B, i.e. the outer parts of a Venn diagram union.</p></li>
</ul>

<strong>Examples</strong>  

Suppose you have two tables, with a single column each, and data as follows:  

```sql
A    B
-    -
1    3
2    4
3    5
4    6
```

Note that (1,2) are unique to A, (3,4) are common, and (5,6) are unique to B.  

<strong>Inner join</strong>  

An inner join using either of the equivalent queries gives the intersection of the two tables, i.e. the two rows they have in common.  

```sql
select * from a INNER JOIN b on a.a = b.b;
select a.*, b.*  from a,b where a.a = b.b;

a | b
--+--
3 | 3
4 | 4
```

<strong>Left outer join</strong>  

A left outer join will give all rows in A, plus any common rows in B.  

```sql
select * from a LEFT OUTER JOIN b on a.a = b.b;
select a.*, b.*  from a,b where a.a = b.b(+);

a |  b
--+-----
1 | null
2 | null
3 |    3
4 |    4
```

<strong>Right outer join</strong>  

A right outer join will give all rows in B, plus any common rows in A.  

```sql
select * from a RIGHT OUTER JOIN b on a.a = b.b;
select a.*, b.*  from a,b where a.a(+) = b.b;

a    |  b
-----+----
3    |  3
4    |  4
null |  5
null |  6
```

<strong>Full outer join</strong>  

A full outer join will give you the union of A and B, i.e. all the rows in A and all the rows in B. If something in A doesn't have a corresponding datum in B, then the B portion is null, and vice versa.  

```sql
select * from a FULL OUTER JOIN b on a.a = b.b;

 a   |  b
-----+-----
   1 | null
   2 | null
   3 |    3
   4 |    4
null |    6
null |    5
```

#### Answer 2 (score 671)
The Venn diagrams don't really do it for me.   

They don't show any distinction between a cross join and an inner join, for example, or more generally show any distinction between different types of join predicate or provide a framework for reasoning about how they will operate.  

There is no substitute for understanding the logical processing and it is relatively straightforward to grasp anyway.   

<ol>
<li>Imagine a cross join.</li>
<li>Evaluate the `on` clause against all rows from step 1 keeping those where the predicate evaluates to `true`</li>
<li>(For outer joins only) add back in any outer rows that were lost in step 2.</li>
</ol>

(NB: In practice the query optimiser may find more efficient ways of executing the query than the purely logical description above but the final result must be the same)  

I'll start off with an animated version of a <strong>full outer join</strong>. Further explanation follows.  

<a href="https://i.stack.imgur.com/VUkfU.gif" rel="noreferrer"><img src="https://i.stack.imgur.com/VUkfU.gif" alt="enter image description here"></a>  

<hr>

<h5>Explanation</h1>

<strong>Source Tables</strong>  

<img src="https://i.stack.imgur.com/LVYKx.png" alt="enter link description here">  

First start with a `CROSS JOIN` (AKA Cartesian Product). This does not have an `ON` clause and simply returns every combination of rows from the two tables.  

<strong>SELECT A.Colour, B.Colour FROM A CROSS JOIN B</strong>  

<img src="https://i.stack.imgur.com/cv3t6.png" alt="enter link description here">  

Inner and Outer joins have an "ON" clause predicate.   

<ul>
<li><strong>Inner Join.</strong> Evaluate the condition in the "ON" clause for all rows in the cross join result. If true return the joined row. Otherwise discard it.</li>
<li><strong>Left Outer Join.</strong> Same as inner join then for any rows in the left table that did not match anything output these with NULL values for the right table columns.</li>
<li><strong>Right Outer Join.</strong> Same as inner join then for any rows in the right table that did not  match anything output these with NULL values for the left table columns.</li>
<li><strong>Full Outer Join.</strong> Same as inner join then preserve left non matched rows as in left outer join and right non matching rows as per right outer join.</li>
</ul>

<h5>Some examples</h1>

<strong>SELECT A.Colour, B.Colour FROM A INNER JOIN B ON A.Colour = B.Colour</strong>  

The above is the classic equi join.  

<img src="https://i.stack.imgur.com/a8IHd.png" alt="Inner Join">  

<h5>Animated Version</h2>

<a href="https://i.stack.imgur.com/kZcvR.gif" rel="noreferrer"><img src="https://i.stack.imgur.com/kZcvR.gif" alt="enter image description here"></a>  

<h5>SELECT A.Colour, B.Colour FROM A INNER JOIN B ON A.Colour NOT IN ('Green','Blue')</h3>

The inner join condition need not necessarily be an equality condition and it need not reference columns from both (or even either) of the tables. Evaluating `A.Colour NOT IN ('Green','Blue')` on each row of the cross join returns.  

<img src="https://i.stack.imgur.com/ZwoCi.png" alt="inner 2">  

<strong>SELECT A.Colour, B.Colour FROM A INNER JOIN B ON 1 =1</strong>  

The join condition evaluates to true for all rows in the cross join result so this is just the same as a cross join. I won't repeat the picture of the 16 rows again.  

<h5>SELECT A.Colour, B.Colour FROM A LEFT OUTER JOIN B ON A.Colour = B.Colour</h3>

Outer Joins are logically evaluated in the same way as inner joins except that if a row from the left table (for a left join) does not join with any rows from the right hand table at all it is preserved in the result with `NULL` values for the right hand columns.  

<img src="https://i.stack.imgur.com/4bzv2.png" alt="LOJ">  

<h5>SELECT A.Colour, B.Colour FROM A LEFT OUTER JOIN B ON A.Colour = B.Colour WHERE B.Colour IS NULL</h3>

This simply restricts the previous result to only return the rows where `B.Colour IS NULL`. In this particular case these will be the rows that were preserved as they had no match in the right hand table and the query returns the single red row not matched in table `B`. This is known as an anti semi join.  

It is important to select a column for the `IS NULL` test that is either not nullable or for which the join condition ensures that any `NULL` values will be excluded in order for this pattern to work correctly and avoid just bringing back rows which happen to have a `NULL` value for that column in addition to the un matched rows.  

<img src="https://i.stack.imgur.com/d6CVF.png" alt="loj is null">  

<h5>SELECT A.Colour, B.Colour FROM A RIGHT OUTER JOIN B ON A.Colour = B.Colour</h3>

Right outer joins act similarly to left outer joins except they preserve non matching rows from the right table and null extend the left hand columns.  

<img src="https://i.stack.imgur.com/LIOW4.png" alt="ROJ">  

<h5>SELECT A.Colour, B.Colour FROM A FULL OUTER JOIN B ON A.Colour = B.Colour</h3>

Full outer joins combine the behaviour of left and right joins and preserve the non matching rows from both the left and the right tables.  

<img src="https://i.stack.imgur.com/iVoqu.png" alt="FOJ">  

<h5>SELECT A.Colour, B.Colour FROM A FULL OUTER JOIN B ON 1 = 0</h3>

No rows in the cross join match the `1=0` predicate. All rows from both sides are preserved using normal outer join rules with NULL in the columns from the table on the other side.   

<img src="https://i.stack.imgur.com/gtIhf.png" alt="FOJ 2">  

<h5>SELECT COALESCE(A.Colour, B.Colour) AS Colour FROM A FULL OUTER JOIN B ON 1 = 0</h3>

With a minor amend to the preceding query one could simulate a `UNION ALL` of the two tables.   

<img src="https://i.stack.imgur.com/WPu9W.png" alt="UNION ALL">  

<h5>SELECT A.Colour, B.Colour FROM A LEFT OUTER JOIN B ON A.Colour = B.Colour WHERE B.Colour = 'Green'</h3>

Note that the `WHERE` clause (if present) logically runs after the join. One common error is to perform a left outer join and then include a WHERE clause with a condition on the right table that ends up excluding the non matching rows. The above ends up performing the outer join...  

<img src="https://i.stack.imgur.com/4bzv2.png" alt="LOJ">  

... And then the "Where" clause runs. `NULL= 'Green'` does not evaluate to true so the row preserved by the outer join ends up discarded (along with the blue one) effectively converting the join back to an inner one.  

<img src="https://i.stack.imgur.com/tRHdf.png" alt="LOJtoInner">   

If the intention was to include only rows from B where Colour is Green and all rows from A regardless the correct syntax would be  

<h5>SELECT A.Colour, B.Colour FROM A LEFT OUTER JOIN B ON A.Colour = B.Colour AND B.Colour = 'Green'</h3>

<img src="https://i.stack.imgur.com/cvJ1s.png" alt="enter image description here">  

<h5>SQL Fiddle</h2>

See these examples <a href="http://sqlfiddle.com/#!17/10d3d/29" rel="noreferrer">run live at SQLFiddle.com</a>.  

#### Answer 3 (score 159)
<p><strong>Joins</strong> are used to combine the data from two tables, with the result being a new, temporary table. Joins are performed based on something called a predicate, which specifies the condition to use in order to perform a join.  The difference between an inner join and an outer join is that an inner join will return only the rows that actually match based on the join predicate.
For eg- Lets consider Employee and Location table:</p>

<img src="https://i.stack.imgur.com/fZ2IZ.png" alt="enter image description here">  

<p><strong><em>Inner Join:-</em></strong>
Inner join creates a new result table by combining column values of two tables (<em>Employee</em> and <em>Location</em>) based upon the join-predicate. The query compares each row of <em>Employee</em> with each row of <em>Location</em> to find all pairs of rows which satisfy the join-predicate. When the join-predicate is satisfied by matching non-NULL values, column values for each matched pair of rows of <em>Employee</em> and <em>Location</em> are combined into a result row.
Here’s what the SQL for an inner join will look like:</p>

```sql
select  * from employee inner join location on employee.empID = location.empID
OR
select  * from employee, location where employee.empID = location.empID
```

<p>Now, here is what the result of running that SQL would look like:
<img src="https://i.stack.imgur.com/RmdJE.png" alt="enter image description here">
<a href="https://i.stack.imgur.com/LgreJ.png" rel="noreferrer"><img src="https://i.stack.imgur.com/LgreJ.png" alt="enter image description here"></a></p>

<p><strong>Outer Join:-</strong>
An outer join does not require each record in the two joined tables to have a matching record. The joined table retains each record—even if no other matching record exists. Outer joins subdivide further into left outer joins and right outer joins, depending on which table's rows are retained (left or right).</p>

<p><strong><em>Left Outer Join:-</em></strong>
The result of a left outer join (or simply left join) for tables <em>Employee</em> and <em>Location</em> always contains all records of the "left" table (<em>Employee</em>), even if the join-condition does not find any matching record in the "right" table (<em>Location</em>).
Here is what the SQL for a left outer join would look like, using the tables above:</p>

```sql
select  * from employee left outer join location on employee.empID = location.empID;
//Use of outer keyword is optional
```

<p>Now, here is what the result of running this SQL would look like:
<img src="https://i.stack.imgur.com/U9lNP.png" alt="enter image description here">
<a href="https://i.stack.imgur.com/drdng.png" rel="noreferrer"><img src="https://i.stack.imgur.com/drdng.png" alt="enter image description here"></a></p>

<p><strong><em>Right Outer Join:-</em></strong>
A right outer join (or right join) closely resembles a left outer join, except with the treatment of the tables reversed. Every row from the "right" table (<em>Location</em>) will appear in the joined table at least once. If no matching row from the "left" table (<em>Employee</em>) exists, NULL will appear in columns from <em>Employee</em> for those records that have no match in <em>Location</em>.
This is what the SQL looks like:</p>

```sql
select * from employee right outer join location  on employee.empID = location.empID;
//Use of outer keyword is optional
```

Using the tables above, we can show what the result set of a right outer join would look like:  

<img src="https://i.stack.imgur.com/c8Jtn.png" alt="enter image description here"><a href="https://i.stack.imgur.com/buKqD.png" rel="noreferrer"><img src="https://i.stack.imgur.com/buKqD.png" alt="enter image description here"></a>  

<p><strong>Full Outer Joins:-</strong>
Full Outer Join or Full Join is to retain the nonmatching information by including nonmatching rows in the results of a join, use a full outer join. It includes all rows from both tables, regardless of whether or not the other table has a matching value.
<a href="https://i.stack.imgur.com/23AMx.png" rel="noreferrer"><img src="https://i.stack.imgur.com/23AMx.png" alt="enter image description here"></a></p>

<a href="http://www.sql-join.com/sql-join-types/" rel="noreferrer">Image Source</a>  

<a href="https://dev.mysql.com/doc/refman/8.0/en/join.html" rel="noreferrer">MySQL 8.0 Reference Manual - Join Syntax</a>  

<a href="https://docs.oracle.com/javadb/10.8.3.0/ref/rrefsqlj29840.html" rel="noreferrer">Oracle Join operations</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 11: How to concatenate text from multiple rows into a single text string in SQL server? (score [2175107](https://stackoverflow.com/q/194852) in 2018)

#### Question
Consider a database table holding names, with three rows:  

```sql
Peter
Paul
Mary
```

Is there an easy way to turn this into a single string of `Peter, Paul, Mary`?  

#### Answer accepted (score 1338)
If you are on SQL Server 2017 or Azure, see <a href="https://stackoverflow.com/a/42778050/1178676">Mathieu Renda answer</a>.   

I had a similar issue when I was trying to join two tables with one-to-many relationships. In SQL 2005 I found that `XML PATH` method can handle the concatenation of the rows very easily.  

If there is a table called `STUDENTS`  

```sql
SubjectID       StudentName
----------      -------------
1               Mary
1               John
1               Sam
2               Alaina
2               Edward
```

Result I expected was:  

```sql
SubjectID       StudentName
----------      -------------
1               Mary, John, Sam
2               Alaina, Edward
```

I used the following `T-SQL`:  

```sql
SELECT Main.SubjectID,
       LEFT(Main.Students,Len(Main.Students)-1) As "Students"
FROM
    (
        SELECT DISTINCT ST2.SubjectID, 
            (
                SELECT ST1.StudentName + ',' AS [text()]
                FROM dbo.Students ST1
                WHERE ST1.SubjectID = ST2.SubjectID
                ORDER BY ST1.SubjectID
                FOR XML PATH ('')
            ) [Students]
        FROM dbo.Students ST2
    ) [Main]
```

You can do the same thing in a more compact way if you can concat the commas at the beginning and use `substring` to skip the first one so you don't need to do a sub-query:  

```sql
SELECT DISTINCT ST2.SubjectID, 
    SUBSTRING(
        (
            SELECT ','+ST1.StudentName  AS [text()]
            FROM dbo.Students ST1
            WHERE ST1.SubjectID = ST2.SubjectID
            ORDER BY ST1.SubjectID
            FOR XML PATH ('')
        ), 2, 1000) [Students]
FROM dbo.Students ST2
```

#### Answer 2 (score 976)
<blockquote>
  <strong>This answer may return <a href="https://stackoverflow.com/questions/15138593/nvarchar-concatenation-index-nvarcharmax-inexplicable-behavior/15163136#15163136">unexpected results</a> For consistent results, use one of the FOR XML PATH methods detailed in other answers.</strong>  
</blockquote>

Use `COALESCE`:  

```sql
DECLARE @Names VARCHAR(8000) 
SELECT @Names = COALESCE(@Names + ', ', '') + Name 
FROM People
```

Just some explanation (since this answer seems to get relatively regular views):  

<ul>
<li>Coalesce is really just a helpful cheat that accomplishes two things: </li>
</ul>

1) No need to initialize `@Names` with an empty string value.   

2) No need to strip off an extra separator at the end.  

<ul>
<li>The solution above will give incorrect results if a row has a <em>NULL</em> Name value (if there is a <em>NULL</em>, the <em>NULL</em> will make `@Names` <em>NULL</em> after that row, and the next row will start over as an empty string again.  Easily fixed with one of two solutions:</li>
</ul>

```sql
DECLARE @Names VARCHAR(8000) 
SELECT @Names = COALESCE(@Names + ', ', '') + Name
FROM People
WHERE Name IS NOT NULL
```

or:  

```sql
DECLARE @Names VARCHAR(8000) 
SELECT @Names = COALESCE(@Names + ', ', '') + 
    ISNULL(Name, 'N/A')
FROM People
```

Depending on what behavior you want (the first option just filters <em>NULL</em>s out, the second option keeps them in the list with a marker message [replace 'N/A' with whatever is appropriate for you]).  

#### Answer 3 (score 344)
<h5>SQL Server 2017+ and SQL Azure: STRING_AGG</h1>

Starting with the next version of SQL Server, we can finally concatenate across rows without having to resort to any variable or XML witchery.  

<a href="https://docs.microsoft.com/en-us/sql/t-sql/functions/string-agg-transact-sql" rel="noreferrer">STRING_AGG (Transact-SQL)</a>  

<strong>Without grouping</strong>  

```sql
SELECT STRING_AGG(Name, ', ') AS Departments
FROM HumanResources.Department;
```

<strong>With grouping :</strong>  

```sql
SELECT GroupName, STRING_AGG(Name, ', ') AS Departments
FROM HumanResources.Department
GROUP BY GroupName;
```

<strong>With grouping and sub-sorting</strong>  

```sql
SELECT GroupName, STRING_AGG(Name, ', ') WITHIN GROUP (ORDER BY Name ASC) AS Departments
FROM HumanResources.Department 
GROUP BY GroupName;
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 12: Get list of all tables in Oracle? (score [2096870](https://stackoverflow.com/q/205736) in 2015)

#### Question
How do I query an Oracle database to display the names of all tables in it?  

#### Answer accepted (score 1330)
```sql
SELECT owner, table_name
  FROM dba_tables
```

This is assuming that you have access to the `DBA_TABLES` data dictionary view.  If you do not have those privileges but need them, you can request that the DBA explicitly grants you privileges on that table, or, that the DBA grants you the `SELECT ANY DICTIONARY` privilege or the `SELECT_CATALOG_ROLE` role (either of which would allow you to query any data dictionary table).  Of course, you may want to exclude certain schemas like `SYS` and `SYSTEM` which have large numbers of Oracle tables that you probably don't care about.  

Alternatively, if you do not have access to `DBA_TABLES`, you can see all the tables that your account has access to through the `ALL_TABLES` view:  

```sql
SELECT owner, table_name
  FROM all_tables
```

Although, that may be a subset of the tables available in the database (`ALL_TABLES` shows you the information for all the tables that your user has been granted access to).    

If you are only concerned with the tables that you own, not those that you have access to, you could use `USER_TABLES`:  

```sql
SELECT table_name
  FROM user_tables
```

Since `USER_TABLES` only has information about the tables that you own, it does not have an `OWNER` column – the owner, by definition, is you.  

Oracle also has a number of legacy data dictionary views-- `TAB`, `DICT`, `TABS`, and `CAT` for example-- that could be used.  In general, I would not suggest using these legacy views unless you absolutely need to backport your scripts to Oracle 6.  Oracle has not changed these views in a long time so they often have problems with newer types of objects.  For example, the `TAB` and `CAT` views both show information about tables that are in the user's recycle bin while the `[DBA|ALL|USER]_TABLES` views all filter those out.  `CAT` also shows information about materialized view logs with a `TABLE_TYPE` of "TABLE" which is unlikely to be what you really want.  `DICT` combines tables and synonyms and doesn't tell you who owns the object.  

#### Answer 2 (score 176)
<p>Querying `user_tables` and `dba_tables` didn't work.<br>
This one did:  </p>

```sql
select table_name from all_tables  
```

#### Answer 3 (score 65)
Going one step further, there is another view called cols (all_tab_columns) which can be used to ascertain which tables contain a given column name.  

For example:  

```sql
SELECT table_name, column_name
FROM cols
WHERE table_name LIKE 'EST%'
AND column_name LIKE '%CALLREF%';
```

to find all tables having a name beginning with EST and columns containing CALLREF anywhere in their names.  

This can help when working out what columns you want to join on, for example, depending on your table and column naming conventions.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 13: Find all tables containing column with specified name - MS SQL Server (score [1904000](https://stackoverflow.com/q/4849652) in 2018)

#### Question
Is it possible to query for table names which contain columns being  

```sql
LIKE '%myName%'
```

?  

#### Answer 2 (score 1672)
<strong>Search Tables:</strong>  

```sql
SELECT      c.name  AS 'ColumnName'
            ,t.name AS 'TableName'
FROM        sys.columns c
JOIN        sys.tables  t   ON c.object_id = t.object_id
WHERE       c.name LIKE '%MyName%'
ORDER BY    TableName
            ,ColumnName;
```

<strong>Search Tables &amp; Views:</strong>  

```sql
SELECT      COLUMN_NAME AS 'ColumnName'
            ,TABLE_NAME AS  'TableName'
FROM        INFORMATION_SCHEMA.COLUMNS
WHERE       COLUMN_NAME LIKE '%MyName%'
ORDER BY    TableName
            ,ColumnName;
```

#### Answer 3 (score 290)
We can also use the following syntax:-  

```sql
select * from INFORMATION_SCHEMA.COLUMNS 
where COLUMN_NAME like '%clientid%' 
order by TABLE_NAME
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 14: Insert results of a stored procedure into a temporary table (score [1868029](https://stackoverflow.com/q/653714) in 2018)

#### Question
How do I do a `SELECT * INTO [temp table] FROM [stored procedure]`? Not `FROM [Table]` and without defining `[temp table]`?  

`Select` all data from `BusinessLine` into `tmpBusLine` works fine.  

```sql
select *
into tmpBusLine
from BusinessLine
```

I am trying the same, but using a `stored procedure` that returns data, is not quite the same.  

```sql
select *
into tmpBusLine
from
exec getBusinessLineHistory '16 Mar 2009'
```

<strong>Output message:</strong>  

<blockquote>
  <p>Msg 156, Level 15, State 1, Line 2
  Incorrect syntax near the keyword
  'exec'.</p>
</blockquote>

I have read several examples of creating a temporary table with the same structure as the output stored procedure, which works fine, but it would be nice to not supply any columns.  

#### Answer 2 (score 679)
You can use <a href="http://msdn.microsoft.com/en-us/library/ms190312%28v=sql.100%29.aspx" rel="noreferrer">OPENROWSET</a> for this.  Have a look.  I've also included the sp_configure code to enable Ad Hoc Distributed Queries, in case it isn't already enabled.  

```sql
CREATE PROC getBusinessLineHistory
AS
BEGIN
    SELECT * FROM sys.databases
END
GO

sp_configure 'Show Advanced Options', 1
GO
RECONFIGURE
GO
sp_configure 'Ad Hoc Distributed Queries', 1
GO
RECONFIGURE
GO

SELECT * INTO #MyTempTable FROM OPENROWSET('SQLNCLI', 'Server=(local)\SQL2008;Trusted_Connection=yes;',
     'EXEC getBusinessLineHistory')

SELECT * FROM #MyTempTable
```

#### Answer 3 (score 589)
If you want to do it without first declaring the temporary table, you could try creating a user-defined function rather than a <a href="http://en.wikipedia.org/wiki/Stored_procedure" rel="noreferrer">stored procedure</a> and make that user-defined function return a table. Alternativly, if you want to use the stored procedure, try something like this:  

```sql
CREATE TABLE #tmpBus
(
   COL1 INT,
   COL2 INT
)

INSERT INTO #tmpBus
Exec SpGetRecords 'Params'
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 15: SQL SELECT WHERE field contains words (score [1644153](https://stackoverflow.com/q/14290857) in 2017)

#### Question
I need a select which would return results like this:  

```sql
SELECT * FROM MyTable WHERE Column1 CONTAINS 'word1 word2 word3'
```

And I need all results, i.e. this includes strings with 'word2 word3 word1' or 'word1 word3 word2' or any other combination of the three.  

All words need to be in the result.  

#### Answer accepted (score 705)
Rather slow, but working method to include <strong>any</strong> of words:  

```sql
SELECT * FROM mytable
WHERE column1 LIKE '%word1%'
   OR column1 LIKE '%word2%'
   OR column1 LIKE '%word3%'
```

If you need <strong>all</strong> words to be present, use this:  

```sql
SELECT * FROM mytable
WHERE column1 LIKE '%word1%'
  AND column1 LIKE '%word2%'
  AND column1 LIKE '%word3%'
```

If you want something faster, you need to look into full text search, and this is very specific for each database type.  

#### Answer 2 (score 68)
Note that if you use `LIKE` to determine if a string is a substring of another string, you must escape the pattern matching characters in your search string.  

If your SQL dialect supports `CHARINDEX`, it's a lot easier to  use it instead:  

```sql
SELECT * FROM MyTable
WHERE CHARINDEX('word1', Column1) > 0
  AND CHARINDEX('word2', Column1) > 0
  AND CHARINDEX('word3', Column1) > 0
```

Also, please keep in mind that this and the method in the accepted answer only cover substring matching rather than word matching. So, for example, the string `'word1word2word3'` would still match.  

#### Answer 3 (score 17)
<h5>Function</h1>

```sql
 CREATE FUNCTION [dbo].[fnSplit] ( @sep CHAR(1), @str VARCHAR(512) )
 RETURNS TABLE AS
 RETURN (
           WITH Pieces(pn, start, stop) AS (
           SELECT 1, 1, CHARINDEX(@sep, @str)
           UNION ALL
           SELECT pn + 1, stop + 1, CHARINDEX(@sep, @str, stop + 1)
           FROM Pieces
           WHERE stop > 0
      )

      SELECT
           pn AS Id,
           SUBSTRING(@str, start, CASE WHEN stop > 0 THEN stop - start ELSE 512 END) AS Data
      FROM
           Pieces
 )
```

<h5>Query</h1>

```sql
 DECLARE @FilterTable TABLE (Data VARCHAR(512))

 INSERT INTO @FilterTable (Data)
 SELECT DISTINCT S.Data
 FROM fnSplit(' ', 'word1 word2 word3') S -- Contains words

 SELECT DISTINCT
      T.*
 FROM
      MyTable T
      INNER JOIN @FilterTable F1 ON T.Column1 LIKE '%' + F1.Data + '%'
      LEFT JOIN @FilterTable F2 ON T.Column1 NOT LIKE '%' + F2.Data + '%'
 WHERE
      F2.Data IS NULL
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 16: How can I prevent SQL injection in PHP? (score [1643165](https://stackoverflow.com/q/60174) in 2016)

#### Question
If user input is inserted without modification into an SQL query, then the application becomes vulnerable to <a href="https://stackoverflow.com/a/332367/">SQL injection</a>, like in the following example:  

```sql
$unsafe_variable = $_POST['user_input']; 

mysql_query("INSERT INTO `table` (`column`) VALUES ('$unsafe_variable')");
```

That's because the user can input something like `value'); DROP TABLE table;--`, and the query becomes:  

```sql
INSERT INTO `table` (`column`) VALUES('value'); DROP TABLE table;--')
```

What can be done to prevent this from happening?  

#### Answer accepted (score 8673)
<strong>Use prepared statements and parameterized queries.</strong> These are SQL statements that are sent to and parsed by the database server separately from any parameters. This way it is impossible for an attacker to inject malicious SQL.  

You basically have two options to achieve this:  

<ol>
<li><p>Using <a href="http://php.net/manual/en/book.pdo.php" rel="noreferrer">PDO</a> (for any supported database driver):</p>

```sql
$stmt = $pdo->prepare('SELECT * FROM employees WHERE name = :name');

$stmt->execute(array('name' => $name));

foreach ($stmt as $row) {
    // Do something with $row
}
```</li>
<li><p>Using <a href="http://php.net/manual/en/book.mysqli.php" rel="noreferrer">MySQLi</a> (for MySQL):</p>

```sql
$stmt = $dbConnection->prepare('SELECT * FROM employees WHERE name = ?');
$stmt->bind_param('s', $name); // 's' specifies the variable type => 'string'

$stmt->execute();

$result = $stmt->get_result();
while ($row = $result->fetch_assoc()) {
    // Do something with $row
}
```</li>
</ol>

If you're connecting to a database other than MySQL, there is a driver-specific second option that you can refer to (for example, `pg_prepare()` and `pg_execute()` for PostgreSQL). PDO is the universal option.  

<h5>Correctly setting up the connection</h2>

Note that when using `PDO` to access a MySQL database <em>real</em> prepared statements are <strong>not used by default</strong>. To fix this you have to disable the emulation of prepared statements. An example of creating a connection using PDO is:  

```sql
$dbConnection = new PDO('mysql:dbname=dbtest;host=127.0.0.1;charset=utf8', 'user', 'password');

$dbConnection->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
$dbConnection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
```

In the above example the error mode isn't strictly necessary, <strong>but it is advised to add it</strong>. This way the script will not stop with a `Fatal Error` when something goes wrong. And it gives the developer the chance to `catch` any error(s) which are `throw`n as `PDOException`s.  

What is <strong>mandatory</strong>, however, is the first `setAttribute()` line, which tells PDO to disable emulated prepared statements and use <em>real</em> prepared statements. This makes sure the statement and the values aren't parsed by PHP before sending it to the MySQL server (giving a possible attacker no chance to inject malicious SQL).  

Although you can set the `charset` in the options of the constructor, it's important to note that 'older' versions of PHP (before 5.3.6) <a href="http://php.net/manual/en/ref.pdo-mysql.connection.php" rel="noreferrer">silently ignored the charset parameter</a> in the DSN.  

<h5>Explanation</h2>

The SQL statement you pass to `prepare` is parsed and compiled by the database server. By specifying parameters (either a `?` or a named parameter like `:name` in the example above) you tell the database engine where you want to filter on. Then when you call `execute`, the prepared statement is combined with the parameter values you specify.  

The important thing here is that the parameter values are combined with the compiled statement, not an SQL string. SQL injection works by tricking the script into including malicious strings when it creates SQL to send to the database. So by sending the actual SQL separately from the parameters, you limit the risk of ending up with something you didn't intend.  

Any parameters you send when using a prepared statement will just be treated as strings (although the database engine may do some optimization so parameters may end up as numbers too, of course). In the example above, if the `$name` variable contains `'Sarah'; DELETE FROM employees` the result would simply be a search for the string `"'Sarah'; DELETE FROM employees"`, and you will not end up with <a href="http://xkcd.com/327/" rel="noreferrer">an empty table</a>.  

Another benefit of using prepared statements is that if you execute the same statement many times in the same session it will only be parsed and compiled once, giving you some speed gains.  

Oh, and since you asked about how to do it for an insert, here's an example (using PDO):  

```sql
$preparedStatement = $db->prepare('INSERT INTO table (column) VALUES (:column)');

$preparedStatement->execute(array('column' => $unsafeValue));
```

<h5>Can prepared statements be used for dynamic queries?</h2>

While you can still use prepared statements for the query parameters, the structure of the dynamic query itself cannot be parametrized and certain query features cannot be parametrized.  

For these specific scenarios, the best thing to do is use a whitelist filter that restricts the possible values.  

```sql
// Value whitelist
// $dir can only be 'DESC', otherwise it will be 'ASC'
if (empty($dir) || $dir !== 'DESC') {
   $dir = 'ASC';
}
```

#### Answer 2 (score 1616)
<blockquote>
  <p><strong>Deprecated Warning:</strong>
  This answer's sample code (like the question's sample code) uses PHP's `MySQL` extension, which was deprecated in PHP 5.5.0 and removed entirely in PHP 7.0.0.</p>
  
  <strong>Security Warning</strong>: This answer is not in line with security best practices. <a href="https://paragonie.com/blog/2015/05/preventing-sql-injection-in-php-applications-easy-and-definitive-guide" rel="noreferrer">Escaping is inadequate to prevent SQL injection</a>, use <em>prepared statements</em> instead. Use the strategy outlined below at your own risk. (Also, `mysql_real_escape_string()` was removed in PHP 7.)  
</blockquote>

If you're using a recent version of PHP, the `mysql_real_escape_string` option outlined below will no longer be available (though `mysqli::escape_string` is a modern equivalent). These days the `mysql_real_escape_string` option would only make sense for legacy code on an old version of PHP.  

<hr>

You've got two options - escaping the special characters in your `unsafe_variable`, or using a parameterized query. Both would protect you from SQL injection. The parameterized query is considered the better practice but will require changing to a newer MySQL extension in PHP before you can use it.  

We'll cover the lower impact string escaping one first.  

```sql
//Connect

$unsafe_variable = $_POST["user-input"];
$safe_variable = mysql_real_escape_string($unsafe_variable);

mysql_query("INSERT INTO table (column) VALUES ('" . $safe_variable . "')");

//Disconnect
```

See also, the details of the <a href="http://php.net/mysql_real_escape_string" rel="noreferrer">`mysql_real_escape_string`</a> function.  

To use the parameterized query, you need to use <a href="http://php.net/mysqli" rel="noreferrer">MySQLi</a> rather than the <a href="http://php.net/mysql" rel="noreferrer">MySQL</a> functions. To rewrite your example, we would need something like the following.  

```sql
<?php
    $mysqli = new mysqli("server", "username", "password", "database_name");

    // TODO - Check that connection was successful.

    $unsafe_variable = $_POST["user-input"];

    $stmt = $mysqli->prepare("INSERT INTO table (column) VALUES (?)");

    // TODO check that $stmt creation succeeded

    // "s" means the database expects a string
    $stmt->bind_param("s", $unsafe_variable);

    $stmt->execute();

    $stmt->close();

    $mysqli->close();
?>
```

The key function you'll want to read up on there would be <a href="http://php.net/mysqli.prepare" rel="noreferrer">`mysqli::prepare`</a>.  

Also, as others have suggested, you may find it useful/easier to step up a layer of abstraction with something like <a href="http://php.net/pdo" rel="noreferrer">PDO</a>.  

Please note that the case you asked about is a fairly simple one and that more complex cases may require more complex approaches. In particular:  

<ul>
<li>If you want to alter the structure of the SQL based on user input, parameterized queries are not going to help, and the escaping required is not covered by `mysql_real_escape_string`. In this kind of case, you would be better off passing the user's input through a whitelist to ensure only 'safe' values are allowed through.</li>
<li>If you use integers from user input in a condition and take the `mysql_real_escape_string` approach, you will suffer from the problem described by <a href="https://stackoverflow.com/users/978756/polynomial">Polynomial</a> in the comments below. This case is trickier because integers would not be surrounded by quotes, so you could deal with by validating that the user input contains only digits.</li>
<li>There are likely other cases I'm not aware of. You might find <a href="http://webappsec.org/projects/articles/091007.txt" rel="noreferrer">this</a> is a useful resource on some of the more subtle problems you can encounter.</li>
</ul>

#### Answer 3 (score 1043)
<p>Every answer here covers only part of the problem.
In fact, there are <strong>four</strong> different query parts which we can add to it dynamically: -</p>

<ul>
<li>a string</li>
<li>a number</li>
<li>an identifier</li>
<li>a syntax keyword.</li>
</ul>

And prepared statements cover only two of them.  

<p>But sometimes we have to make our query even more dynamic, adding operators or identifiers as well.
So, we will need different protection techniques.</p>

In general, such a protection approach is based on <em>whitelisting</em>.  

<p>In this case, every dynamic parameter should be hardcoded in your script and chosen from that set.
For example, to do dynamic ordering:</p>

```sql
$orders  = array("name", "price", "qty"); // Field names
$key     = array_search($_GET['sort'], $orders)); // See if we have such a name
$orderby = $orders[$key]; // If not, first one will be set automatically. smart enuf :)
$query   = "SELECT * FROM `table` ORDER BY $orderby"; // Value is safe
```

However, there is another way to secure identifiers - escaping. As long as you have an identifier quoted, you can escape backticks inside by doubling them.  

As a further step, we can borrow a truly brilliant idea of using some placeholder (a proxy to represent the actual value in the query) from the prepared statements and invent a placeholder of another type - an identifier placeholder.  

So, to make the long story short: it's a <strong>placeholder</strong>, not <strong>prepared statement</strong> can be considered as a silver bullet.  

<p>So, a general recommendation may be phrased as
<strong>As long as you are adding dynamic parts to the query using placeholders (and these placeholders properly processed of course), you can be sure that your query is safe</strong>.</p>

Still, there is an issue with SQL syntax keywords (such as `AND`, `DESC` and such), but white-listing seems the only approach in this case.  

<h5>Update</h3>

Although there is a general agreement on the best practices regarding SQL injection protection, there are <strong>still many bad practices as well.</strong> And some of them too deeply rooted in the minds of PHP users. For instance, on this very page there are (although invisible to most visitors) <strong>more than 80 deleted answers</strong> - all removed by the community due to bad quality or promoting bad and outdated practices. Worse yet, some of the bad answers aren't deleted, but rather prospering.  

For example, <a href="https://stackoverflow.com/a/11802479">there(1)</a> <a href="https://stackoverflow.com/a/6381189">are(2)</a> <a href="https://stackoverflow.com/a/60195/">still(3)</a> <a href="https://stackoverflow.com/a/12426697/">many(4)</a> <a href="https://stackoverflow.com/a/21179234">answers(5)</a>, including the <a href="https://stackoverflow.com/a/60442">second most upvoted answer</a> suggesting you manual string escaping - an outdated approach that is proven to be insecure.  

Or there is a slightly better answer that suggests just <a href="https://stackoverflow.com/a/12710285">another method of string formatting</a> and even boasts it as the ultimate panacea. While of course, it is not. This method is no better than regular string formatting, yet it keeps all its drawbacks: it is applicable to strings only and, like any other manual formatting, it's essentially optional, non-obligatory measure, prone to human error of any sort.  

I think that all this because of one very old superstition, supported by such authorities like <a href="https://www.owasp.org/index.php/SQL_Injection_Prevention_Cheat_Sheet#Defense_Option_4:_Escaping_All_User_Supplied_Input" rel="noreferrer">OWASP</a> or <a href="http://php.net/manual/en/function.mysql-real-escape-string.php#refsect1-function.mysql-real-escape-string-description" rel="noreferrer">the PHP manual</a>, which proclaims equality between whatever "escaping" and protection from SQL injections.  

Regardless of what PHP manual said for ages, <strong>`*_escape_string` by no means makes data safe</strong> and never has been intended to. Besides being useless for any SQL part other than string, manual escaping is wrong, because it is manual as opposite to automated.  

And OWASP makes it even worse, stressing on escaping <em>user input</em> which is an utter nonsense: there should be no such words in the context of injection protection. Every variable is potentially dangerous - no matter the source! Or, in other words - every variable has to be properly formatted to be put into a query - no matter the source again. It's the destination that matters. The moment a developer starts to separate the sheep from the goats (thinking whether some particular variable is "safe" or not) he/she takes his/her first step towards disaster. Not to mention that even the wording suggests bulk escaping at the entry point, resembling the very magic quotes feature - already despised, deprecated and removed.  

So, unlike whatever "escaping", prepared statements <em>is</em> the measure that indeed protects from SQL injection (when applicable).  

If you're still not convinced, here are a step-by-step explanation I wrote, <em><a href="http://phpdelusions.net/sql_injection" rel="noreferrer">The Hitchhiker's Guide to SQL Injection prevention</a></em>, where I explained all these matters in detail and even compiled a section entirely dedicated to bad practices and their disclosure.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 17: SQL update from one Table to another based on a ID match (score [1639088](https://stackoverflow.com/q/224732) in 2018)

#### Question
I have a database with `account numbers` and `card numbers`. I match these to a file to `update` any card numbers to the account number, so that I am only working with account numbers.   

I created a view linking the table to the account/card database to return the `Table ID` and the related account number, and now I need to update those records where the ID matches with the Account Number.  

This is the `Sales_Import` table, where the `account number` field needs to be updated:  

```sql
LeadID  AccountNumber
147         5807811235
150         5807811326
185         7006100100007267039
```

And this is the `RetrieveAccountNumber` table, where I need to update from:  

```sql
LeadID  AccountNumber
147         7006100100007266957
150         7006100100007267039
```

I tried the below, but no luck so far:  

```sql
UPDATE [Sales_Lead].[dbo].[Sales_Import] 
SET    [AccountNumber] = (SELECT RetrieveAccountNumber.AccountNumber 
                          FROM   RetrieveAccountNumber 
                          WHERE  [Sales_Lead].[dbo].[Sales_Import]. LeadID = 
                                                RetrieveAccountNumber.LeadID) 
```

It updates the card numbers to account numbers, but the account numbers gets replaced by `NULL`  

#### Answer 2 (score 1298)
I believe an `UPDATE FROM` with a `JOIN` will help:  

<h5>MS SQL</h2>

```sql
UPDATE
    Sales_Import
SET
    Sales_Import.AccountNumber = RAN.AccountNumber
FROM
    Sales_Import SI
INNER JOIN
    RetrieveAccountNumber RAN
ON 
    SI.LeadID = RAN.LeadID;
```

<h5>MySQL and MariaDB</h2>

```sql
UPDATE
    Sales_Import SI,
    RetrieveAccountNumber RAN
SET
    SI.AccountNumber = RAN.AccountNumber
WHERE
    SI.LeadID = RAN.LeadID;
```

#### Answer 3 (score 278)
The simple Way to copy the content from one table to other is as follow:  

```sql
UPDATE table2 
SET table2.col1 = table1.col1, 
table2.col2 = table1.col2,
...
FROM table1, table2 
WHERE table1.memberid = table2.memberid
```

You can also add the condition to get the particular data copied.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 18: SQL query to select dates between two dates (score [1619137](https://stackoverflow.com/q/5125076) in 2017)

#### Question
I have a `start_date` and `end_date`. I want to get the list of dates in between these two dates. Can anyone help me pointing the mistake in my query.  

```sql
select Date,TotalAllowance 
from Calculation 
where EmployeeId=1
  and Date between 2011/02/25 and 2011/02/27
```

Here `Date` is a `datetime` variable.  

#### Answer accepted (score 435)
you should put those two dates between single quotes like..  

```sql
select Date, TotalAllowance from Calculation where EmployeeId = 1
             and Date between '2011/02/25' and '2011/02/27'
```

or can use  

```sql
select Date, TotalAllowance from Calculation where EmployeeId = 1
             and Date >= '2011/02/25' and Date <= '2011/02/27'
```

#### Answer 2 (score 113)
Since a datetime without a specified time segment will have a value of `date 00:00:00.000`, if you want to be sure you get all the dates in your range, you must either supply the time for your ending date or increase your ending date and use `&lt;`.  

```sql
select Date,TotalAllowance from Calculation where EmployeeId=1 
and Date between '2011/02/25' and '2011/02/27 23:59:59.999'
```

OR  

```sql
select Date,TotalAllowance from Calculation where EmployeeId=1 
and Date >= '2011/02/25' and Date < '2011/02/28'
```

OR   

```sql
select Date,TotalAllowance from Calculation where EmployeeId=1 
and Date >= '2011/02/25' and Date <= '2011/02/27 23:59:59.999'
```

DO NOT use the following, as it could return some records from 2011/02/28 if their times are 00:00:00.000.  

```sql
select Date,TotalAllowance from Calculation where EmployeeId=1 
and Date between '2011/02/25' and '2011/02/28'
```

#### Answer 3 (score 13)
Try this:  

```sql
select Date,TotalAllowance from Calculation where EmployeeId=1
             and [Date] between '2011/02/25' and '2011/02/27'
```

The date values need to be typed as strings.  

To ensure future-proofing your query for SQL Server 2008 and higher, `Date` should be escaped because it's a reserved word in later versions.  

Bear in mind that the dates without times take midnight as their defaults, so you may not have the correct value there.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 19: How can I get column names from a table in SQL Server? (score [1538227](https://stackoverflow.com/q/1054984) in 2017)

#### Question
I would like to query the name of all columns of a table. I found how to do this in:  

<ul>
<li><a href="https://stackoverflow.com/q/452464/419956">Oracle</a></li>
<li><a href="https://stackoverflow.com/q/193780/419956">MySQL</a></li>
<li><a href="https://dba.stackexchange.com/q/22362/5089">PostgreSQL</a></li>
</ul>

But I need to know: <strong>how can this be done in <em>Microsoft SQL Server</em> (2008 in my case)?</strong>  

#### Answer accepted (score 762)
You can obtain this information and much, much more by querying the <a href="http://msdn.microsoft.com/en-us/library/aa933204%28SQL.80%29.aspx" rel="noreferrer">Information Schema views</a>.  

This sample query:   

```sql
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = N'Customers'
```

Can be made over all these DB objects:    

<ul>
<li><a href="https://docs.microsoft.com/en-us/sql/relational-databases/system-information-schema-views/check-constraints-transact-sql" rel="noreferrer">CHECK_CONSTRAINTS</a>  </li>
<li><a href="https://docs.microsoft.com/en-us/sql/relational-databases/system-information-schema-views/column-domain-usage-transact-sql" rel="noreferrer">COLUMN_DOMAIN_USAGE</a></li>
<li><a href="https://docs.microsoft.com/en-us/sql/relational-databases/system-information-schema-views/column-privileges-transact-sql" rel="noreferrer">COLUMN_PRIVILEGES</a>  </li>
<li><a href="https://docs.microsoft.com/en-us/sql/relational-databases/system-information-schema-views/columns-transact-sql" rel="noreferrer">COLUMNS</a>  </li>
<li><a href="https://docs.microsoft.com/en-us/sql/relational-databases/system-information-schema-views/constraint-column-usage-transact-sql" rel="noreferrer">CONSTRAINT_COLUMN_USAGE</a>  </li>
<li><a href="https://docs.microsoft.com/en-us/sql/relational-databases/system-information-schema-views/constraint-table-usage-transact-sql" rel="noreferrer">CONSTRAINT_TABLE_USAGE</a>  </li>
<li><a href="https://docs.microsoft.com/en-us/sql/relational-databases/system-information-schema-views/domain-constraints-transact-sql" rel="noreferrer">DOMAIN_CONSTRAINTS</a>  </li>
<li><a href="https://docs.microsoft.com/en-us/sql/relational-databases/system-information-schema-views/domains-transact-sql" rel="noreferrer">DOMAINS</a>  </li>
<li><a href="https://docs.microsoft.com/en-us/sql/relational-databases/system-information-schema-views/key-column-usage-transact-sql" rel="noreferrer">KEY_COLUMN_USAGE</a>  </li>
<li><a href="https://docs.microsoft.com/en-us/sql/relational-databases/system-information-schema-views/parameters-transact-sql" rel="noreferrer">PARAMETERS</a>  </li>
<li><a href="https://docs.microsoft.com/en-us/sql/relational-databases/system-information-schema-views/referential-constraints-transact-sql" rel="noreferrer">REFERENTIAL_CONSTRAINTS</a>  </li>
<li><a href="https://docs.microsoft.com/en-us/sql/relational-databases/system-information-schema-views/routines-transact-sql" rel="noreferrer">ROUTINES</a>  </li>
<li><a href="https://docs.microsoft.com/en-us/sql/relational-databases/system-information-schema-views/routine-columns-transact-sql" rel="noreferrer">ROUTINE_COLUMNS</a>  </li>
<li><a href="https://docs.microsoft.com/en-us/sql/relational-databases/system-information-schema-views/schemata-transact-sql" rel="noreferrer">SCHEMATA</a>  </li>
<li><a href="https://docs.microsoft.com/en-us/sql/relational-databases/system-information-schema-views/table-constraints-transact-sql" rel="noreferrer">TABLE_CONSTRAINTS</a>  </li>
<li><a href="https://docs.microsoft.com/en-us/sql/relational-databases/system-information-schema-views/table-privileges-transact-sql" rel="noreferrer">TABLE_PRIVILEGES</a>  </li>
<li><a href="https://docs.microsoft.com/en-us/sql/relational-databases/system-information-schema-views/tables-transact-sql" rel="noreferrer">TABLES</a>  </li>
<li><a href="https://docs.microsoft.com/en-us/sql/relational-databases/system-information-schema-views/view-column-usage-transact-sql" rel="noreferrer">VIEW_COLUMN_USAGE</a>  </li>
<li><a href="https://docs.microsoft.com/en-us/sql/relational-databases/system-information-schema-views/view-table-usage-transact-sql" rel="noreferrer">VIEW_TABLE_USAGE</a>  </li>
<li><a href="https://docs.microsoft.com/en-us/sql/relational-databases/system-information-schema-views/views-transact-sql" rel="noreferrer">VIEWS</a>  </li>
</ul>

#### Answer 2 (score 187)
You can use the stored procedure sp_columns which would return information pertaining to all columns for a given table. More info can be found here <a href="http://msdn.microsoft.com/en-us/library/ms176077.aspx" rel="noreferrer">http://msdn.microsoft.com/en-us/library/ms176077.aspx</a>  

You can also do it by a SQL query. Some thing like this should help:  

```sql
SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('dbo.yourTableName') 
```

Or a variation would be:  

```sql
SELECT   o.Name, c.Name
FROM     sys.columns c 
         JOIN sys.objects o ON o.object_id = c.object_id 
WHERE    o.type = 'U' 
ORDER BY o.Name, c.Name
```

This gets all columns from all tables, ordered by table name and then on column name.  

#### Answer 3 (score 141)
```sql
select *
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME='tableName'
```

This is better than getting from `sys.columns` because it shows `DATA_TYPE` directly.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 20: How can I do an UPDATE statement with JOIN in SQL? (score [1502329](https://stackoverflow.com/q/1293330) in 2018)

#### Question
I need to update this table in <strong>SQL Server 2005</strong> with data from its 'parent' table, see below:  

<strong>sale</strong>  

```sql
id (int)
udid (int)
assid (int)
```

<strong>ud</strong>  

```sql
id  (int)
assid  (int)
```

`sale.assid` contains the correct value to update `ud.assid`.   

What query will do this? I'm thinking a `join` but I'm not sure if it's possible.  

#### Answer accepted (score 2284)
Syntax strictly depends on which SQL DBMS you're using. Here are some ways to do it in ANSI/ISO (aka should work on any SQL DBMS), MySQL, SQL Server, and Oracle. Be advised that my suggested ANSI/ISO method will typically be much slower than the other two methods, but if you're using a SQL DBMS other than MySQL, SQL Server, or Oracle, then it may be the only way to go (e.g. if your SQL DBMS doesn't support `MERGE`):  

ANSI/ISO:  

```sql
update ud 
     set assid = (
          select sale.assid 
          from sale 
          where sale.udid = ud.id
     )
 where exists (
      select * 
      from sale 
      where sale.udid = ud.id
 );
```

MySQL:  

```sql
update ud u
inner join sale s on
    u.id = s.udid
set u.assid = s.assid
```

SQL Server:  

```sql
update u
set u.assid = s.assid
from ud u
    inner join sale s on
        u.id = s.udid
```

PostgreSQL:  

```sql
update ud
  set ud.assid = s.assid
from sale s 
where ud.id = s.udid;
```

Note that the target table must not be repeated in the `FROM` clause for Postgres.  

Oracle:  

```sql
update
    (select
        u.assid as new_assid,
        s.assid as old_assid
    from ud u
        inner join sale s on
            u.id = s.udid) up
set up.new_assid = up.old_assid
```

SQLite:  

```sql
update ud 
     set assid = (
          select sale.assid 
          from sale 
          where sale.udid = ud.id
     )
 where RowID in (
      select RowID 
      from ud 
      where sale.udid = ud.id
 );
```

#### Answer 2 (score 139)
This should work in SQL Server:  

```sql
update ud 
set assid = sale.assid
from sale
where sale.udid = id
```

#### Answer 3 (score 93)
postgres  

```sql
UPDATE table1
SET    COLUMN = value
FROM   table2,
       table3
WHERE  table1.column_id = table2.id
       AND table1.column_id = table3.id
       AND table1.COLUMN = value
       AND table2.COLUMN = value
       AND table3.COLUMN = value 
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 21: How can I SELECT rows with MAX(Column value), DISTINCT by another column in SQL? (score [1406300](https://stackoverflow.com/q/612231) in 2018)

#### Question
<strong>My table is:</strong>   

```sql
id  home  datetime     player   resource
---|-----|------------|--------|---------
1  | 10  | 04/03/2009 | john   | 399 
2  | 11  | 04/03/2009 | juliet | 244
5  | 12  | 04/03/2009 | borat  | 555
3  | 10  | 03/03/2009 | john   | 300
4  | 11  | 03/03/2009 | juliet | 200
6  | 12  | 03/03/2009 | borat  | 500
7  | 13  | 24/12/2008 | borat  | 600
8  | 13  | 01/01/2009 | borat  | 700
```

I need to select each distinct `home` holding the maximum value of `datetime`.   

<strong>Result would be:</strong>   

```sql
id  home  datetime     player   resource 
---|-----|------------|--------|---------
1  | 10  | 04/03/2009 | john   | 399
2  | 11  | 04/03/2009 | juliet | 244
5  | 12  | 04/03/2009 | borat  | 555
8  | 13  | 01/01/2009 | borat  | 700
```

<strong>I have tried:</strong>  

```sql
-- 1 ..by the MySQL manual: 

SELECT DISTINCT
  home,
  id,
  datetime AS dt,
  player,
  resource
FROM topten t1
WHERE datetime = (SELECT
  MAX(t2.datetime)
FROM topten t2
GROUP BY home)
GROUP BY datetime
ORDER BY datetime DESC
```

<p>Doesn't work. Result-set has 130 rows although database holds 187. 
Result includes some duplicates of `home`.</p>

```sql
-- 2 ..join

SELECT
  s1.id,
  s1.home,
  s1.datetime,
  s1.player,
  s1.resource
FROM topten s1
JOIN (SELECT
  id,
  MAX(datetime) AS dt
FROM topten
GROUP BY id) AS s2
  ON s1.id = s2.id
ORDER BY datetime 
```

Nope. Gives all the records.  

```sql
-- 3 ..something exotic: 
```

With various results.  

#### Answer accepted (score 880)
You are so close!  All you need to do is select BOTH the home and its max date time, then join back to the `topten` table on BOTH fields:  

```sql
SELECT tt.*
FROM topten tt
INNER JOIN
    (SELECT home, MAX(datetime) AS MaxDateTime
    FROM topten
    GROUP BY home) groupedtt 
ON tt.home = groupedtt.home 
AND tt.datetime = groupedtt.MaxDateTime
```

#### Answer 2 (score 71)
Here goes <strong>T-SQL</strong> version:  

```sql
-- Test data
DECLARE @TestTable TABLE (id INT, home INT, date DATETIME, 
  player VARCHAR(20), resource INT)
INSERT INTO @TestTable
SELECT 1, 10, '2009-03-04', 'john', 399 UNION
SELECT 2, 11, '2009-03-04', 'juliet', 244 UNION
SELECT 5, 12, '2009-03-04', 'borat', 555 UNION
SELECT 3, 10, '2009-03-03', 'john', 300 UNION
SELECT 4, 11, '2009-03-03', 'juliet', 200 UNION
SELECT 6, 12, '2009-03-03', 'borat', 500 UNION
SELECT 7, 13, '2008-12-24', 'borat', 600 UNION
SELECT 8, 13, '2009-01-01', 'borat', 700

-- Answer
SELECT id, home, date, player, resource 
FROM (SELECT id, home, date, player, resource, 
    RANK() OVER (PARTITION BY home ORDER BY date DESC) N
    FROM @TestTable
)M WHERE N = 1

-- and if you really want only home with max date
SELECT T.id, T.home, T.date, T.player, T.resource 
    FROM @TestTable T
INNER JOIN 
(   SELECT TI.id, TI.home, TI.date, 
        RANK() OVER (PARTITION BY TI.home ORDER BY TI.date) N
    FROM @TestTable TI
    WHERE TI.date IN (SELECT MAX(TM.date) FROM @TestTable TM)
)TJ ON TJ.N = 1 AND T.id = TJ.id
```

<p><strong>EDIT</strong><br>
Unfortunately, there are no RANK() OVER function in MySQL.<br>
But it can be emulated, see <a href="http://www.oreillynet.com/pub/a/mysql/2007/03/29/emulating-analytic-aka-ranking-functions-with-mysql.html?page=3" rel="noreferrer">Emulating Analytic (AKA Ranking) Functions with MySQL</a>.<br>
So this is <strong>MySQL</strong> version:</p>

```sql
SELECT id, home, date, player, resource 
FROM TestTable AS t1 
WHERE 
    (SELECT COUNT(*) 
            FROM TestTable AS t2 
            WHERE t2.home = t1.home AND t2.date > t1.date
    ) = 0
```

#### Answer 3 (score 68)
The fastest `MySQL` solution, without inner queries and without `GROUP BY`:  

```sql
SELECT m.*                    -- get the row that contains the max value
FROM topten m                 -- "m" from "max"
    LEFT JOIN topten b        -- "b" from "bigger"
        ON m.home = b.home    -- match "max" row with "bigger" row by `home`
        AND m.datetime < b.datetime           -- want "bigger" than "max"
WHERE b.datetime IS NULL      -- keep only if there is no bigger than max
```

<strong>Explanation</strong>:  

Join the table with itself using the `home` column. The use of `LEFT JOIN` ensures all the rows from table `m` appear in the result set. Those that don't have a match in table `b` will have `NULL`s for the columns of `b`.  

The other condition on the `JOIN` asks to match only the rows from `b` that have bigger value on the `datetime` column than the row from `m`.  

Using the data posted in the question, the `LEFT JOIN` will produce this pairs:  

```sql
+------------------------------------------+--------------------------------+
|              the row from `m`            |    the matching row from `b`   |
|------------------------------------------|--------------------------------|
| id  home  datetime     player   resource | id    home   datetime      ... |
|----|-----|------------|--------|---------|------|------|------------|-----|
| 1  | 10  | 04/03/2009 | john   | 399     | NULL | NULL | NULL       | ... | *
| 2  | 11  | 04/03/2009 | juliet | 244     | NULL | NULL | NULL       | ... | *
| 5  | 12  | 04/03/2009 | borat  | 555     | NULL | NULL | NULL       | ... | *
| 3  | 10  | 03/03/2009 | john   | 300     | 1    | 10   | 04/03/2009 | ... |
| 4  | 11  | 03/03/2009 | juliet | 200     | 2    | 11   | 04/03/2009 | ... |
| 6  | 12  | 03/03/2009 | borat  | 500     | 5    | 12   | 04/03/2009 | ... |
| 7  | 13  | 24/12/2008 | borat  | 600     | 8    | 13   | 01/01/2009 | ... |
| 8  | 13  | 01/01/2009 | borat  | 700     | NULL | NULL | NULL       | ... | *
+------------------------------------------+--------------------------------+
```

Finally, the `WHERE` clause keeps only the pairs that have `NULL`s in the columns of `b` (they are marked with `*` in the table above); this means, due to the second condition from the `JOIN` clause, the row selected from `m` has the biggest value in column `datetime`.  

Read the <a href="https://pragprog.com/book/bksqla/sql-antipatterns" rel="noreferrer">SQL Antipatterns: Avoiding the Pitfalls of Database Programming</a> book for other SQL tips.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 22: How to convert DateTime to VarChar (score [1396857](https://stackoverflow.com/q/74385) in 2015)

#### Question
I am working on a query in Sql Server 2005 where I need to convert a value in `DateTime` variable into a `varchar` variable in `yyyy-mm-dd` format (without time part). How do I do that?  

#### Answer accepted (score 254)
With Microsoft Sql Server:  

```sql
--
-- Create test case
--
DECLARE @myDateTime DATETIME
SET @myDateTime = '2008-05-03'

--
-- Convert string
--
SELECT LEFT(CONVERT(VARCHAR, @myDateTime, 120), 10)
```

#### Answer 2 (score 363)
Here's some test sql for all the styles.  

```sql
DECLARE @now datetime
SET @now = GETDATE()
select convert(nvarchar(MAX), @now, 0) as output, 0 as style 
union select convert(nvarchar(MAX), @now, 1), 1
union select convert(nvarchar(MAX), @now, 2), 2
union select convert(nvarchar(MAX), @now, 3), 3
union select convert(nvarchar(MAX), @now, 4), 4
union select convert(nvarchar(MAX), @now, 5), 5
union select convert(nvarchar(MAX), @now, 6), 6
union select convert(nvarchar(MAX), @now, 7), 7
union select convert(nvarchar(MAX), @now, 8), 8
union select convert(nvarchar(MAX), @now, 9), 9
union select convert(nvarchar(MAX), @now, 10), 10
union select convert(nvarchar(MAX), @now, 11), 11
union select convert(nvarchar(MAX), @now, 12), 12
union select convert(nvarchar(MAX), @now, 13), 13
union select convert(nvarchar(MAX), @now, 14), 14
--15 to 19 not valid
union select convert(nvarchar(MAX), @now, 20), 20
union select convert(nvarchar(MAX), @now, 21), 21
union select convert(nvarchar(MAX), @now, 22), 22
union select convert(nvarchar(MAX), @now, 23), 23
union select convert(nvarchar(MAX), @now, 24), 24
union select convert(nvarchar(MAX), @now, 25), 25
--26 to 99 not valid
union select convert(nvarchar(MAX), @now, 100), 100
union select convert(nvarchar(MAX), @now, 101), 101
union select convert(nvarchar(MAX), @now, 102), 102
union select convert(nvarchar(MAX), @now, 103), 103
union select convert(nvarchar(MAX), @now, 104), 104
union select convert(nvarchar(MAX), @now, 105), 105
union select convert(nvarchar(MAX), @now, 106), 106
union select convert(nvarchar(MAX), @now, 107), 107
union select convert(nvarchar(MAX), @now, 108), 108
union select convert(nvarchar(MAX), @now, 109), 109
union select convert(nvarchar(MAX), @now, 110), 110
union select convert(nvarchar(MAX), @now, 111), 111
union select convert(nvarchar(MAX), @now, 112), 112
union select convert(nvarchar(MAX), @now, 113), 113
union select convert(nvarchar(MAX), @now, 114), 114
union select convert(nvarchar(MAX), @now, 120), 120
union select convert(nvarchar(MAX), @now, 121), 121
--122 to 125 not valid
union select convert(nvarchar(MAX), @now, 126), 126
union select convert(nvarchar(MAX), @now, 127), 127
--128, 129 not valid
union select convert(nvarchar(MAX), @now, 130), 130
union select convert(nvarchar(MAX), @now, 131), 131
--132 not valid
order BY style
```

Here's the result  

```sql
output                   style
Apr 28 2014  9:31AM          0
04/28/14                     1
14.04.28                     2
28/04/14                     3
28.04.14                     4
28-04-14                     5
28 Apr 14                    6
Apr 28, 14                   7
09:31:28                     8
Apr 28 2014  9:31:28:580AM   9
04-28-14                     10
14/04/28                     11
140428                       12
28 Apr 2014 09:31:28:580     13
09:31:28:580                 14
2014-04-28 09:31:28          20
2014-04-28 09:31:28.580      21
04/28/14  9:31:28 AM         22
2014-04-28                   23
09:31:28                     24
2014-04-28 09:31:28.580      25
Apr 28 2014  9:31AM          100
04/28/2014                   101
2014.04.28                   102
28/04/2014                   103
28.04.2014                   104
28-04-2014                   105
28 Apr 2014                  106
Apr 28, 2014                 107
09:31:28                     108
Apr 28 2014  9:31:28:580AM   109
04-28-2014                   110
2014/04/28                   111
20140428                     112
28 Apr 2014 09:31:28:580     113
09:31:28:580                 114
2014-04-28 09:31:28          120
2014-04-28 09:31:28.580      121
2014-04-28T09:31:28.580      126
2014-04-28T09:31:28.580      127
28 جمادى الثانية 1435  9:31:28:580AM    130
28/06/1435  9:31:28:580AM    131
```

Make `nvarchar(max)` shorter to trim the time. For example:  

```sql
select convert(nvarchar(11), GETDATE(), 0)
union select convert(nvarchar(max), GETDATE(), 0)
```

outputs:  

```sql
May 18 2018
May 18 2018  9:57AM
```

#### Answer 3 (score 184)
Try the following:  

```sql
CONVERT(varchar(10), [MyDateTimecolumn], 20)
```

For a full date time and not just date do:     

```sql
CONVERT(varchar(23), [MyDateTimecolumn], 121)
```

See this page for convert styles:  

<p><a href="http://msdn.microsoft.com/en-us/library/ms187928.aspx" rel="noreferrer">http://msdn.microsoft.com/en-us/library/ms187928.aspx</a><br>
OR<br>
<a href="http://www.w3schools.com/sql/func_convert.asp" rel="noreferrer">SQL Server CONVERT() Function</a></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 23: NOT IN vs NOT EXISTS (score [1367238](https://stackoverflow.com/q/173041) in 2012)

#### Question
Which of these queries is the faster?  

NOT EXISTS:  

```sql
SELECT ProductID, ProductName 
FROM Northwind..Products p
WHERE NOT EXISTS (
    SELECT 1 
    FROM Northwind..[Order Details] od 
    WHERE p.ProductId = od.ProductId)
```

Or NOT IN:  

```sql
SELECT ProductID, ProductName 
FROM Northwind..Products p
WHERE p.ProductID NOT IN (
    SELECT ProductID 
    FROM Northwind..[Order Details])
```

The query execution plan says they both do the same thing.  If that is the case, which is the recommended form?  

This is based on the NorthWind database.  

[Edit]  

<p>Just found this helpful article: 
<a href="http://weblogs.sqlteam.com/mladenp/archive/2007/05/18/60210.aspx" rel="noreferrer">http://weblogs.sqlteam.com/mladenp/archive/2007/05/18/60210.aspx</a></p>

I think I'll stick with NOT EXISTS.  

#### Answer accepted (score 657)
I always default to `NOT EXISTS`.  

The execution plans may be the same at the moment but if either column is altered in the future to allow `NULL`s the `NOT IN` version will need to do more work (even if no `NULL`s are actually present in the data) and the semantics of `NOT IN` if `NULL`s <em>are</em> present are unlikely to be the ones you want anyway.  

When neither `Products.ProductID` or `[Order Details].ProductID` allow `NULL`s the `NOT IN` will be treated identically to the following query.  

```sql
SELECT ProductID,
       ProductName
FROM   Products p
WHERE  NOT EXISTS (SELECT *
                   FROM   [Order Details] od
                   WHERE  p.ProductId = od.ProductId) 
```

The exact plan may vary but for my example data I get the following.  

<img src="https://i.stack.imgur.com/lCTsG.png" alt="Neither NULL">  

A reasonably common misconception seems to be that correlated sub queries are always "bad" compared to joins. They certainly can be when they force a nested loops plan (sub query evaluated row by row) but  this plan includes an anti semi join logical operator. Anti semi joins are not restricted to nested loops but can use hash or merge (as in this example) joins too.  

```sql
/*Not valid syntax but better reflects the plan*/ 
SELECT p.ProductID,
       p.ProductName
FROM   Products p
       LEFT ANTI SEMI JOIN [Order Details] od
         ON p.ProductId = od.ProductId 
```

If `[Order Details].ProductID` is `NULL`-able the query then becomes  

```sql
SELECT ProductID,
       ProductName
FROM   Products p
WHERE  NOT EXISTS (SELECT *
                   FROM   [Order Details] od
                   WHERE  p.ProductId = od.ProductId)
       AND NOT EXISTS (SELECT *
                       FROM   [Order Details]
                       WHERE  ProductId IS NULL) 
```

The reason for this is that the correct semantics if `[Order Details]` contains any `NULL` `ProductId`s is to return no results. See the extra anti semi join and row count spool to verify this that is added to the plan.  

<img src="https://i.stack.imgur.com/mPYhd.png" alt="One NULL">  

If `Products.ProductID` is also changed to become `NULL`-able the query then becomes  

```sql
SELECT ProductID,
       ProductName
FROM   Products p
WHERE  NOT EXISTS (SELECT *
                   FROM   [Order Details] od
                   WHERE  p.ProductId = od.ProductId)
       AND NOT EXISTS (SELECT *
                       FROM   [Order Details]
                       WHERE  ProductId IS NULL)
       AND NOT EXISTS (SELECT *
                       FROM   (SELECT TOP 1 *
                               FROM   [Order Details]) S
                       WHERE  p.ProductID IS NULL) 
```

The reason for that one is because a `NULL` `Products.ProductId` should not be returned in the results <strong>except</strong> if the `NOT IN` sub query were to return no results at all (i.e. the `[Order Details]` table is empty). In which case it should. In the plan for my sample data this is implemented by adding another anti semi join as below.  

<img src="https://i.stack.imgur.com/8XAh1.png" alt="Both NULL">  

The effect of this is shown in <a href="http://sqlinthewild.co.za/index.php/2010/02/18/not-exists-vs-not-in/" rel="noreferrer">the blog post already linked by Buckley</a>. In the example there the number of logical reads increase from around 400 to 500,000.  

Additionally the fact that a single `NULL` can reduce the row count to zero makes cardinality estimation very difficult. If SQL Server assumes that this will happen but in fact there were no `NULL` rows in the data the rest of the execution plan may be catastrophically worse, if this is just part of a larger query, <a href="https://dba.stackexchange.com/q/117306/3690">with inappropriate nested loops causing repeated execution of an expensive sub tree for example</a>.   

This is not the only possible execution plan for a `NOT IN` on a `NULL`-able column however. <a href="http://bradsruminations.blogspot.co.uk/2011/10/t-sql-tuesday-023-flip-side-of-join.html" rel="noreferrer">This article shows another one</a> for a query against the `AdventureWorks2008` database.  

For the `NOT IN` on a `NOT NULL` column or the `NOT EXISTS` against either a nullable or non nullable column it gives the following plan.  

<img src="https://i.stack.imgur.com/nahUD.png" alt="Not EXists">  

When the column changes to `NULL`-able the `NOT IN` plan now looks like  

<img src="https://i.stack.imgur.com/8o9PQ.png" alt="Not In - Null">  

It adds an extra inner join operator to the plan. This apparatus is <a href="https://dba.stackexchange.com/a/14812/3690">explained here</a>. It is all there to convert the previous single correlated index seek on `Sales.SalesOrderDetail.ProductID = &lt;correlated_product_id&gt;` to two seeks per outer row. The additional one is on `WHERE Sales.SalesOrderDetail.ProductID IS NULL`.   

As this is under an anti semi join if that one returns any rows the second seek will not occur. However if `Sales.SalesOrderDetail` does not contain any `NULL` `ProductID`s it will double the number of seek operations required.  

#### Answer 2 (score 78)
Also be aware that NOT IN is not equivalent to NOT EXISTS when it comes to null.  

This post explains it very well   

<a href="http://sqlinthewild.co.za/index.php/2010/02/18/not-exists-vs-not-in/">http://sqlinthewild.co.za/index.php/2010/02/18/not-exists-vs-not-in/</a>  

<blockquote>
  <p>When the subquery returns even one null, NOT IN will not match any
  rows.</p>
  
  <p>The reason for this can be found by looking at the details of what the
  NOT IN operation actually means.</p>
  
  <p>Let’s say, for illustration purposes that there are 4 rows in the
  table called t, there’s a column called ID with values 1..4</p>

```sql
WHERE SomeValue NOT IN (SELECT AVal FROM t)
```
  
  is equivalent to  

```sql
WHERE SomeValue != (SELECT AVal FROM t WHERE ID=1)
AND SomeValue != (SELECT AVal FROM t WHERE ID=2)
AND SomeValue != (SELECT AVal FROM t WHERE ID=3)
AND SomeValue != (SELECT AVal FROM t WHERE ID=4)
```
  
  <p>Let’s further say that AVal is NULL where ID = 4. Hence that !=
  comparison returns UNKNOWN. The logical truth table for AND states
  that UNKNOWN and TRUE is UNKNOWN, UNKNOWN and FALSE is FALSE. There is
  no value that can be AND’d with UNKNOWN to produce the result TRUE</p>
  
  <p>Hence, if any row of that subquery returns NULL, the entire NOT IN
  operator will evaluate to either FALSE or NULL and no records will be
  returned</p>
</blockquote>

#### Answer 3 (score 23)
If the execution planner says they're the same, they're the same. Use whichever one will make your intention more obvious -- in this case, the second.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 24: 'IF' in 'SELECT' statement - choose output value based on column values (score [1331519](https://stackoverflow.com/q/5951157) in 2015)

#### Question
```sql
SELECT id, amount FROM report
```

I need `amount` to be `amount` if `report.type='P'` and `-amount` if `report.type='N'`. How do I add this to the above query?  

#### Answer accepted (score 997)
```sql
SELECT id, 
       IF(type = 'P', amount, amount * -1) as amount
FROM report
```

See <a href="http://dev.mysql.com/doc/refman/5.0/en/control-flow-functions.html" rel="noreferrer">http://dev.mysql.com/doc/refman/5.0/en/control-flow-functions.html</a>.  

Additionally, you could handle when the condition is null. In the case of a null amount:  

```sql
SELECT id, 
       IF(type = 'P', IFNULL(amount,0), IFNULL(amount,0) * -1) as amount
FROM report
```

The part `IFNULL(amount,0)` means <em>when amount is not null return amount else return 0</em>.  

#### Answer 2 (score 243)
Use a `case` statement:  

```sql
select id,
    case report.type
        when 'P' then amount
        when 'N' then -amount
    end as amount
from
    `report`
```

#### Answer 3 (score 93)
```sql
SELECT CompanyName, 
    CASE WHEN Country IN ('USA', 'Canada') THEN 'North America'
         WHEN Country = 'Brazil' THEN 'South America'
         ELSE 'Europe' END AS Continent
FROM Suppliers
ORDER BY CompanyName;
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 25: What's the difference between INNER JOIN, LEFT JOIN, RIGHT JOIN and FULL JOIN? (score [1324680](https://stackoverflow.com/q/5706437) in 2018)

#### Question
<p>What's the difference between `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN` and `FULL JOIN` 
in <strong><em>MySQL</em></strong>?</p>

#### Answer accepted (score 3088)
Reading this original article on <strong>The Code Project</strong> will help you a lot: <a href="http://www.codeproject.com/KB/database/Visual_SQL_Joins.aspx" rel="noreferrer">Visual Representation of SQL Joins</a>.  

<img src="https://i.stack.imgur.com/VQ5XP.png" alt="alt text">  

Also check this post: <a href="http://blog.sqlauthority.com/2008/04/22/sql-server-better-performance-left-join-or-not-in/" rel="noreferrer">SQL SERVER – Better Performance – LEFT JOIN or NOT IN?</a>.  

Find original one at: <a href="https://stackoverflow.com/questions/3308122/how-do-i-decide-when-to-use-right-joins-left-joins-or-inner-joins-or-how-to-dete/3308153#3308153">Difference between JOIN and OUTER JOIN in MySQL</a>.  

#### Answer 2 (score 674)
<strong>INNER JOIN</strong> gets all records that are common between both tables based on the supplied ON clause.  

<strong>LEFT JOIN</strong> gets all records from the LEFT linked table but if you have selected some columns from the RIGHT table, if there is no related records, these columns will contain NULL.  

<strong>RIGHT JOIN</strong> is like the above but gets all records in the RIGHT table.  

<strong>FULL JOIN</strong> gets all records from both tables and puts NULL in the columns where related records do not exist in the opposite table.  

#### Answer 3 (score 646)
<blockquote>
  <p>An SQL JOIN clause is used to combine rows from two or more tables,
  based on a common field between them.</p>
</blockquote>

There are different types of joins available in SQL:  

<strong>INNER JOIN</strong>: returns rows when there is a match in both tables.  

<strong>LEFT JOIN</strong>: returns all rows from the left table, even if there are no matches in the right table.  

<strong>RIGHT JOIN</strong>: returns all rows from the right table, even if there are no matches in the left table.  

<strong>FULL JOIN</strong>: It combines the results of both left and right outer joins.  

The joined table will contain all records from both the tables and fill in NULLs for missing matches on either side.  

<strong>SELF JOIN</strong>: is used to join a table to itself as if the table were two tables, temporarily renaming at least one table in the SQL statement.  

<strong>CARTESIAN JOIN</strong>: returns the Cartesian product of the sets of records from the two or more joined tables.  

WE can take each first four joins in Details :  

We have two tables with the following values.  

<strong>TableA</strong>  

```sql
id  firstName                  lastName
.......................................
1   arun                        prasanth                 
2   ann                         antony                   
3   sruthy                      abc                      
6   new                         abc                                           
```

<strong>TableB</strong>  

```sql
id2 age Place
................
1   24  kerala
2   24  usa
3   25  ekm
5   24  chennai
```

....................................................................  

<strong>INNER JOIN</strong>  

<strong>Note</strong> :it gives the intersection of the two tables, i.e.  rows they have common in TableA and TableB  

Syntax  

```sql
SELECT table1.column1, table2.column2...
  FROM table1
 INNER JOIN table2
    ON table1.common_field = table2.common_field;
```

Apply it in our sample table :  

```sql
SELECT TableA.firstName,TableA.lastName,TableB.age,TableB.Place
  FROM TableA
 INNER JOIN TableB
    ON TableA.id = TableB.id2;
```

Result Will Be   

```sql
firstName       lastName       age  Place
..............................................
arun            prasanth        24  kerala
ann             antony          24  usa
sruthy          abc             25  ekm
```

<strong>LEFT JOIN</strong>  

<strong>Note</strong> : will give all selected rows in TableA, plus any common selected rows in TableB.  

Syntax   

```sql
SELECT table1.column1, table2.column2...
  FROM table1
  LEFT JOIN table2
    ON table1.common_field = table2.common_field;
```

Apply it in our sample table :  

```sql
SELECT TableA.firstName,TableA.lastName,TableB.age,TableB.Place
  FROM TableA
  LEFT JOIN TableB
    ON TableA.id = TableB.id2;
```

Result  

```sql
firstName                   lastName                    age   Place
...............................................................................
arun                        prasanth                    24    kerala
ann                         antony                      24    usa
sruthy                      abc                         25    ekm
new                         abc                         NULL  NULL
```

<strong>RIGHT JOIN</strong>  

<strong>Note</strong> : will give all selected rows in TableB, plus any common selected rows in TableA.  

Syntax   

```sql
SELECT table1.column1, table2.column2...
  FROM table1
 RIGHT JOIN table2
    ON table1.common_field = table2.common_field;
```

Apply it in our sample table :  

```sql
SELECT TableA.firstName,TableA.lastName,TableB.age,TableB.Place
  FROM TableA
 RIGHT JOIN TableB
    ON TableA.id = TableB.id2;
```

Result   

```sql
firstName                   lastName                    age     Place
...............................................................................
arun                        prasanth                    24     kerala
ann                         antony                      24     usa
sruthy                      abc                         25     ekm
NULL                        NULL                        24     chennai
```

<strong>FULL JOIN</strong>  

<strong>Note</strong> :It will return all selected values from both tables.  

Syntax   

```sql
SELECT table1.column1, table2.column2...
  FROM table1
  FULL JOIN table2
    ON table1.common_field = table2.common_field;
```

Apply it in our sample table :  

```sql
SELECT TableA.firstName,TableA.lastName,TableB.age,TableB.Place
  FROM TableA
  FULL JOIN TableB
    ON TableA.id = TableB.id2;
```

Result   

```sql
firstName                   lastName                    age    Place
...............................................................................
arun                        prasanth                    24    kerala
ann                         antony                      24    usa
sruthy                      abc                         25    ekm
new                         abc                         NULL  NULL
NULL                        NULL                        24    chennai
```

<strong>Interesting Fact</strong>  

For INNER joins the order doesn't matter  

For (LEFT, RIGHT or FULL) OUTER joins,the order matter  

Better to go check this <strong><a href="https://stackoverflow.com/questions/9614922/does-the-join-order-matter-in-sql">Link</a></strong> it will give you interesting details about join order  

</b> </em> </i> </small> </strong> </sub> </sup>

### 26: How do I limit the number of rows returned by an Oracle query after ordering? (score [1310688](https://stackoverflow.com/q/470542) in 2018)

#### Question
Is there a way to make an `Oracle` query behave like it contains a `MySQL limit` clause?  

In `MySQL`, I can do this:  

```sql
select * 
from sometable
order by name
limit 20,10
```

to get the 21st to the 30th rows (skip the first 20, give the next 10). The rows are selected after the `order by`, so it really starts on the 20th name alphabetically.  

In `Oracle`, the only thing people mention is the `rownum` pseudo-column, but it is evaluated <em>before</em> `order by`, which means this:  

```sql
select * 
from sometable
where rownum <= 10
order by name
```

will return a random set of ten rows ordered by name, which is not usually what I want. It also doesn't allow for specifying an offset.  

#### Answer accepted (score 515)
Starting from Oracle 12c R1 (12.1), there <em>is</em> a <a href="http://www.oracle-base.com/articles/12c/row-limiting-clause-for-top-n-queries-12cr1.php" rel="noreferrer">row limiting clause</a>. It does not use familiar `LIMIT` syntax, but it can do the job better with more options. You can find the <a href="http://docs.oracle.com/database/121/SQLRF/statements_10002.htm#BABBADDD" rel="noreferrer">full syntax here</a>.  

To answer the original question, here's the query:  

```sql
SELECT * 
FROM   sometable
ORDER BY name
OFFSET 20 ROWS FETCH NEXT 10 ROWS ONLY;
```

(For earlier Oracle versions, please refer to other answers in this question)  

<hr>

<h5>Examples:</h2>

Following examples were quoted from <a href="http://www.oracle-base.com/articles/12c/row-limiting-clause-for-top-n-queries-12cr1.php" rel="noreferrer">linked page</a>, in the hope of preventing link rot.  

<h5>Setup</h3>

```sql
CREATE TABLE rownum_order_test (
  val  NUMBER
);

INSERT ALL
  INTO rownum_order_test
SELECT level
FROM   dual
CONNECT BY level <= 10;

COMMIT;
```

<h5>What's in the table?</h3>

```sql
SELECT val
FROM   rownum_order_test
ORDER BY val;

       VAL
----------
         1
         1
         2
         2
         3
         3
         4
         4
         5
         5
         6
         6
         7
         7
         8
         8
         9
         9
        10
        10

20 rows selected.
```

<h5>Get first `N` rows</h3>

```sql
SELECT val
FROM   rownum_order_test
ORDER BY val DESC
FETCH FIRST 5 ROWS ONLY;

       VAL
----------
        10
        10
         9
         9
         8

5 rows selected.
```

<h5>Get first `N` rows, if `N`<sup>th</sup> row has ties, get all the tied rows</h3>

```sql
SELECT val
FROM   rownum_order_test
ORDER BY val DESC
FETCH FIRST 5 ROWS WITH TIES;

       VAL
----------
        10
        10
         9
         9
         8
         8

6 rows selected.
```

<h5>Top `x`% of rows</h3>

```sql
SELECT val
FROM   rownum_order_test
ORDER BY val
FETCH FIRST 20 PERCENT ROWS ONLY;

       VAL
----------
         1
         1
         2
         2

4 rows selected.
```

<h5>Using an offset, very useful for pagination</h3>

```sql
SELECT val
FROM   rownum_order_test
ORDER BY val
OFFSET 4 ROWS FETCH NEXT 4 ROWS ONLY;

       VAL
----------
         3
         3
         4
         4

4 rows selected.
```

<h5>You can combine offset with percentages</h3>

```sql
SELECT val
FROM   rownum_order_test
ORDER BY val
OFFSET 4 ROWS FETCH NEXT 20 PERCENT ROWS ONLY;

       VAL
----------
         3
         3
         4
         4

4 rows selected.
```

#### Answer 2 (score 767)
You can use a subquery for this like  

```sql
select *
from  
( select * 
  from emp 
  order by sal desc ) 
where ROWNUM <= 5;
```

Have also a look at the topic <a href="http://www.oracle.com/technetwork/issue-archive/2006/06-sep/o56asktom-086197.html" rel="noreferrer">On ROWNUM and limiting results</a> at Oracle/AskTom for more information.  

<p><strong>Update</strong>:
To limit the result with both lower and upper bounds things get a bit more bloated with</p>

```sql
select * from 
( select a.*, ROWNUM rnum from 
  ( <your_query_goes_here, with order by> ) a 
  where ROWNUM <= :MAX_ROW_TO_FETCH )
where rnum  >= :MIN_ROW_TO_FETCH;
```

(Copied from specified AskTom-article)  

<p><strong>Update 2</strong>:
Starting with Oracle 12c (12.1) there is a syntax available to limit rows or start at offsets.</p>

```sql
SELECT * 
FROM   sometable
ORDER BY name
OFFSET 20 ROWS FETCH NEXT 10 ROWS ONLY;
```

See <a href="https://stackoverflow.com/a/26051830/57601">this answer</a> for more examples. Thanks to Krumia for the hint.  

#### Answer 3 (score 178)
I did some performance testing for the following approaches:  

<h5>Asktom</h3>

```sql
select * from (
  select a.*, ROWNUM rnum from (
    <select statement with order by clause>
  ) a where rownum <= MAX_ROW
) where rnum >= MIN_ROW
```

<h5>Analytical</h3>

```sql
select * from (
  <select statement with order by clause>
) where myrow between MIN_ROW and MAX_ROW
```

<h5>Short Alternative</h3>

```sql
select * from (
  select statement, rownum as RN with order by clause
) where a.rn >= MIN_ROW and a.rn <= MAX_ROW
```

<h5>Results</h1>

Table had 10 million records, sort was on an unindexed datetime row:  

<ul>
<li>Explain plan showed same value for all three selects (323168)</li>
<li>But the winner is AskTom (with analytic following close behind)</li>
</ul>

Selecting first 10 rows took:  

<ul>
<li>AskTom: 28-30 seconds</li>
<li>Analytical: 33-37 seconds</li>
<li>Short alternative: 110-140 seconds</li>
</ul>

Selecting rows between 100,000 and 100,010:  

<ul>
<li>AskTom: 60 seconds</li>
<li>Analytical: 100 seconds</li>
</ul>

Selecting rows between 9,000,000 and 9,000,010:  

<ul>
<li>AskTom: 130 seconds</li>
<li>Analytical: 150 seconds</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 27: What is the difference between UNION and UNION ALL? (score [1265525](https://stackoverflow.com/q/49925) in 2018)

#### Question
What is the difference between `UNION` and `UNION ALL`?  

#### Answer accepted (score 1641)
`UNION` removes duplicate records (where all columns in the results are the same), `UNION ALL` does not.  

There is a performance hit when using `UNION` instead of `UNION ALL`, since the database server must do additional work to remove the duplicate rows, but usually you do not want the duplicates (especially when developing reports).  

<h5>UNION Example:</h1>

```sql
SELECT 'foo' AS bar UNION SELECT 'foo' AS bar
```

<strong>Result:</strong>   

```sql
+-----+
| bar |
+-----+
| foo |
+-----+
1 row in set (0.00 sec)
```

<h5>UNION ALL example:</h1>

```sql
SELECT 'foo' AS bar UNION ALL SELECT 'foo' AS bar
```

<strong>Result:</strong>  

```sql
+-----+
| bar |
+-----+
| foo |
| foo |
+-----+
2 rows in set (0.00 sec)
```

#### Answer 2 (score 268)
Both UNION and UNION ALL concatenate the result of two different SQLs. They differ in the way they handle duplicates.  

<ul>
<li><p>UNION performs a DISTINCT on the result set, eliminating any duplicate rows.</p></li>
<li><p>UNION ALL does not remove duplicates, and it therefore faster than UNION.</p></li>
</ul>

<blockquote>
  <strong>Note:</strong> While using this commands all selected columns need to be of the same data type.    
</blockquote>

Example: If we have two tables, 1) Employee and 2) Customer  

<ol>
<li>Employee table data: </li>
</ol>

<img src="https://i.stack.imgur.com/huYEL.png" alt="enter image description here">  

<ol start="2">
<li>Customer table data:</li>
</ol>

<img src="https://i.stack.imgur.com/FEaKe.png" alt="enter image description here">  

<ol start="3">
<li>UNION Example (It removes all duplicate records):</li>
</ol>

<img src="https://i.stack.imgur.com/lLiS1.png" alt="enter image description here">  

<ol start="4">
<li>UNION ALL Example (It just concatenate records, not eliminate duplicates, so it is faster than UNION):</li>
</ol>

<img src="https://i.stack.imgur.com/n5gvq.png" alt="enter image description here">  

#### Answer 3 (score 46)
`UNION` removes duplicates, whereas `UNION ALL` does not.  

In order to remove duplicates the result set must be sorted, and this <em>may</em> have an impact on the performance of the UNION, depending on the volume of data being sorted, and the settings of various RDBMS parameters ( For Oracle `PGA_AGGREGATE_TARGET` with `WORKAREA_SIZE_POLICY=AUTO` or `SORT_AREA_SIZE` and `SOR_AREA_RETAINED_SIZE` if `WORKAREA_SIZE_POLICY=MANUAL` ).  

Basically, the sort is faster if it can be carried out in memory, but the same caveat about the volume of data applies.  

Of course, if you need data returned without duplicates then you <em>must</em> use UNION, depending on the source of your data.  

I would have commented on the first post to qualify the "is much less performant" comment, but have insufficient reputation (points) to do so.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 28: Search text in stored procedure in SQL Server (score [1248594](https://stackoverflow.com/q/14704105) in 2018)

#### Question
I want to search a text from all my database stored procedures. I use the below SQL:  

```sql
SELECT DISTINCT
       o.name AS Object_Name,
       o.type_desc
  FROM sys.sql_modules m
       INNER JOIN
       sys.objects o
         ON m.object_id = o.object_id
 WHERE m.definition Like '%[ABD]%';
```

I want to search for `[ABD]` in all stored procedures including square brackets, but it's not giving the proper result. How can I change my query to achieve this?  

#### Answer accepted (score 528)
Escape the square brackets:  

```sql
...
WHERE m.definition Like '%\[ABD\]%' ESCAPE '\'
```

Then the square brackets will be treated as a string literals not as wild cards.  

#### Answer 2 (score 297)
Try this request:  

<strong>Query</strong>  

```sql
SELECT name
FROM   sys.procedures
WHERE  Object_definition(object_id) LIKE '%strHell%'
```

#### Answer 3 (score 54)
Have you tried using some of the third party tools to do the search? There are several available out there that are free and that saved me a ton of time in the past.   

Below are two SSMS Addins I used with good success.  

<a href="http://www.apexsql.com/sql_tools_search.aspx">ApexSQL Search</a> – Searches both schema and data in databases and has additional features such as dependency tracking and more…    

<a href="http://www.ssmstoolspack.com/">SSMS Tools pack</a> – Has same search functionality as previous one and several other cool features. Not free for SQL Server 2012 but still very affordable.   

I know this answer is not 100% related to the questions (which was more specific) but hopefully others will find this useful.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 29: How to Delete using INNER JOIN with SQL Server? (score [1236813](https://stackoverflow.com/q/16481379) in 2018)

#### Question
I want to delete using `INNER JOIN` in <strong>SQL Server 2008</strong>.  

But I get this error:  

<blockquote>
  <p>Msg 156, Level 15, State 1, Line 15<br>
  Incorrect syntax near the keyword 'INNER'.</p>
</blockquote>

My code:  

```sql
DELETE FROM WorkRecord2 
INNER JOIN Employee ON EmployeeRun=EmployeeNo
WHERE Company = '1' AND Date = '2013-05-06'
```

#### Answer accepted (score 2033)
You need to specify what table you are deleting from, here is a version with an alias:  

```sql
DELETE w
FROM WorkRecord2 w
INNER JOIN Employee e
  ON EmployeeRun=EmployeeNo
WHERE Company = '1' AND Date = '2013-05-06'
```

#### Answer 2 (score 131)
Just add the name of the table between `DELETE` and `FROM` from where you want to delete records because we have to specify the table to delete. Also remove `ORDER BY` clause because there is nothing to order while deleting records.  

So your final query should be like this:  

```sql
    DELETE WorkRecord2 
      FROM WorkRecord2 
INNER JOIN Employee 
        ON EmployeeRun=EmployeeNo
     WHERE Company = '1' 
       AND Date = '2013-05-06';
```

#### Answer 3 (score 28)
Possible this be helpful for you -  

```sql
DELETE FROM dbo.WorkRecord2 
WHERE EmployeeRun IN (
    SELECT e.EmployeeNo
    FROM dbo.Employee e
    WHERE ...
)
```

Or try this -  

```sql
DELETE FROM dbo.WorkRecord2 
WHERE EXISTS(
    SELECT 1
    FROM dbo.Employee e
    WHERE EmployeeRun = e.EmployeeNo
        AND ....
)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 30: SQL Inner-join with 3 tables? (score [1220486](https://stackoverflow.com/q/10195451) in 2019)

#### Question
I'm trying to join 3 tables in a view; here is the situation:  

I have a table that contains information of students who are applying to live on this College Campus. I have another table that lists the Hall Preferences (3 of them) for each Student. But each of these preferences are merely an ID Number, and the ID Number has a corresponding Hall Name in a third table (did not design this database...).  

Pretty much, I have `INNER JOIN` on the table with their preferences, and their information, the result is something like...  

```sql
 John Doe | 923423 | Incoming Student | 005
```

Where `005` would be the `HallID`. So Now I want to match that `HallID` to a third table, where this table contains a `HallID` and `HallName`.  

So pretty much, I want my result to be like...  

```sql
 John Doe | 923423 | Incoming Student | Foley Hall <---(INSTEAD OF 005)
```

Here is what I currently have:  

```sql
SELECT
  s.StudentID, s.FName, 
  s.LName, s.Gender, s.BirthDate, s.Email, 
  r.HallPref1, r.HallPref2, r.HallPref3
FROM
  dbo.StudentSignUp AS s 
  INNER JOIN RoomSignUp.dbo.Incoming_Applications_Current AS r 
    ON s.StudentID = r.StudentID 
  INNER JOIN HallData.dbo.Halls AS h 
    ON r.HallPref1 = h.HallID
```

#### Answer accepted (score 465)
You can do the following (I guessed on table fields,etc)  

```sql
SELECT s.studentname
    , s.studentid
    , s.studentdesc
    , h.hallname
FROM students s
INNER JOIN hallprefs hp
    on s.studentid = hp.studentid
INNER JOIN halls h
    on hp.hallid = h.hallid
```

Based on your request for multiple halls you could do it this way. You just join on your Hall table multiple times for each room pref id:  

```sql
SELECT     s.StudentID
    , s.FName
    , s.LName
    , s.Gender
    , s.BirthDate
    , s.Email
    , r.HallPref1
    , h1.hallName as Pref1HallName
    , r.HallPref2 
    , h2.hallName as Pref2HallName
    , r.HallPref3
    , h3.hallName as Pref3HallName
FROM  dbo.StudentSignUp AS s 
INNER JOIN RoomSignUp.dbo.Incoming_Applications_Current AS r 
    ON s.StudentID = r.StudentID 
INNER JOIN HallData.dbo.Halls AS h1 
    ON r.HallPref1 = h1.HallID
INNER JOIN HallData.dbo.Halls AS h2
    ON r.HallPref2 = h2.HallID
INNER JOIN HallData.dbo.Halls AS h3
    ON r.HallPref3 = h3.HallID
```

#### Answer 2 (score 44)
```sql
SELECT column_Name1,column_name2,......
  From tbl_name1,tbl_name2,tbl_name3
  where tbl_name1.column_name = tbl_name2.column_name 
  and tbl_name2.column_name = tbl_name3.column_name
```

#### Answer 3 (score 38)
If you have 3 tables with the same `ID` to be joined, I think it would be like this:  

```sql
SELECT * FROM table1 a
JOIN table2 b ON a.ID = b.ID
JOIN table3 c ON a.ID = c.ID
```

Just replace `*` with what you want to get from the tables.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 31: How to reset AUTO_INCREMENT in MySQL? (score [1163265](https://stackoverflow.com/q/8923114) in 2018)

#### Question
How can I <strong><em>reset</em></strong> the `AUTO_INCREMENT` of a field? I want it to start counting from `1` again.  

#### Answer accepted (score 1883)
You can reset the counter with:  

```sql
ALTER TABLE tablename AUTO_INCREMENT = 1
```

For InnoDB you cannot set the `auto_increment` value lower or equal to the highest current index. (quote from <a href="http://viralpatel.net/blogs/reseting-mysql-autoincrement-column/" rel="noreferrer">ViralPatel</a>):  

<blockquote>
  <p>Note that you cannot reset the counter to a value less than or equal
  to any that have already been used. For MyISAM, if the value is less
  than or equal to the maximum value currently in the AUTO_INCREMENT
  column, the value is reset to the current maximum plus one. For
  InnoDB, if the value is less than the current maximum value in the
  column, no error occurs and the current sequence value is not changed.</p>
</blockquote>

See <em><a href="https://stackoverflow.com/q/2410689/367456">How to Reset an MySQL AutoIncrement using a MAX value from another table?</a></em> on how to dynamically get an acceptable value.  

#### Answer 2 (score 146)
```sql
ALTER TABLE tablename AUTO_INCREMENT = 1
```

#### Answer 3 (score 72)
```sql
SET  @num := 0;

UPDATE your_table SET id = @num := (@num+1);

ALTER TABLE your_table AUTO_INCREMENT =1;
```

I think this will do it  

</b> </em> </i> </small> </strong> </sub> </sup>

### 32: Convert INT to VARCHAR SQL (score [1158597](https://stackoverflow.com/q/19979532) in 2015)

#### Question
I am using Sybase and I am doing a select which returns me a column called "iftype", but its type is int and I need to convert into varchar. When I try to do the select without the convert function I get this error:  

<blockquote>
  Error code 257, SQL state 37000: Implicit conversion from datatype 'VARCHAR' to 'INT' is not allowed.  Use the CONVERT function to run this query.  
</blockquote>

I dont know how to implement the function `CONVERT`. Can anyone help me, please ?  

#### Answer accepted (score 556)
Use the convert function.  

```sql
SELECT CONVERT(varchar(10), field_name) FROM table_name
```

#### Answer 2 (score 88)
Use the `STR` function:  

```sql
SELECT STR(field_name) FROM table_name
```

<hr>

<h5><strong>Arguments</strong></h2>

<strong>float_expression</strong>  

Is an expression of approximate numeric (float) data type with a decimal point.  

<strong>length</strong>  

Is the total length. This includes decimal point, sign, digits, and spaces. The default is 10.  

<strong>decimal</strong>  

Is the number of places to the right of the decimal point. decimal must be less than or equal to 16. If decimal is more than 16 then the result is truncated to sixteen places to the right of the decimal point.  

source: <a href="https://msdn.microsoft.com/en-us/library/ms189527.aspx" rel="noreferrer">https://msdn.microsoft.com/en-us/library/ms189527.aspx</a>  

#### Answer 3 (score 23)
You can use `CAST` function:  

```sql
SELECT CAST(your_column_name AS varchar(10)) FROM your_table_name
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 33: How to create Temp table with SELECT * INTO tempTable FROM CTE Query (score [1073684](https://stackoverflow.com/q/11491240) in 2013)

#### Question
I have a MS SQL CTE query from which I want to create a temporary table. I am not sure how to do it as it gives an `Invalid Object name` error.  

Below is the whole query for reference  

```sql
SELECT * INTO TEMPBLOCKEDDATES FROM 
;with Calendar as (
    select EventID, EventTitle, EventStartDate, EventEndDate, EventEnumDays,EventStartTime,EventEndTime, EventRecurring, EventStartDate as PlannedDate
    ,EventType from EventCalender
    where EventActive = 1 AND LanguageID =1 AND EventBlockDate = 1
    union all
    select EventID, EventTitle, EventStartDate, EventEndDate, EventEnumDays,EventStartTime,EventEndTime, EventRecurring, dateadd(dd, 1, PlannedDate)
    ,EventType from Calendar
    where EventRecurring = 1
        and dateadd(dd, 1, PlannedDate) <= EventEndDate 
)
select EventID, EventStartDate, EventEndDate, PlannedDate as [EventDates], Cast(PlannedDate As datetime) AS DT, Cast(EventStartTime As time) AS ST,Cast(EventEndTime As time) AS ET, EventTitle
,EventType from Calendar
where (PlannedDate >= GETDATE()) AND ',' + EventEnumDays + ',' like '%,' + cast(datepart(dw, PlannedDate) as char(1)) + ',%'
    or EventEnumDays is null
order by EventID, PlannedDate
option (maxrecursion 0)
```

I would appreciate a point in the right direction or if I can create a temporary table from this CTE query   

#### Answer accepted (score 208)
<h5>Sample DDL</h2>

```sql
create table #Temp
(
    EventID int, 
    EventTitle Varchar(50), 
    EventStartDate DateTime, 
    EventEndDate DatetIme, 
    EventEnumDays int,
    EventStartTime Datetime,
    EventEndTime DateTime, 
    EventRecurring Bit, 
    EventType int
)
```

<hr>

```sql
;WITH Calendar
AS (SELECT /*...*/)

Insert Into #Temp
Select EventID, EventStartDate, EventEndDate, PlannedDate as [EventDates], Cast(PlannedDate As datetime) AS DT, Cast(EventStartTime As time) AS ST,Cast(EventEndTime As time) AS ET, EventTitle
,EventType from Calendar
where (PlannedDate >= GETDATE()) AND ',' + EventEnumDays + ',' like '%,' + cast(datepart(dw, PlannedDate) as char(1)) + ',%'
    or EventEnumDays is null
```

<hr>

Make sure that the table is deleted after use  

```sql
If(OBJECT_ID('tempdb..#temp') Is Not Null)
Begin
    Drop Table #Temp
End
```

#### Answer 2 (score 126)
Really the format can be quite simple - sometimes there's no need to predefine a temp table - it will be created from results of the select.  

```sql
Select FieldA...FieldN 
into #MyTempTable 
from MyTable
```

So unless you want different types or are very strict on definition, keep things simple. Note also that any temporary table created inside a stored procedure is automatically dropped when the stored procedure finishes executing. If stored procedure A creates a temp table and calls stored procedure B, then B will be able to use the temporary table that A created.   

However, it's generally considered good coding practice to explicitly drop every temporary table you create anyway.  

#### Answer 3 (score 22)
The `SELECT ... INTO` needs to be in the select from the CTE.  

```sql
;WITH Calendar
     AS (SELECT /*... Rest of CTE definition removed for clarity*/)
SELECT EventID,
       EventStartDate,
       EventEndDate,
       PlannedDate                   AS [EventDates],
       Cast(PlannedDate AS DATETIME) AS DT,
       Cast(EventStartTime AS TIME)  AS ST,
       Cast(EventEndTime AS TIME)    AS ET,
       EventTitle,
       EventType
INTO TEMPBLOCKEDDATES /* <---- INTO goes here*/        
FROM   Calendar
WHERE  ( PlannedDate >= Getdate() )
       AND ',' + EventEnumDays + ',' LIKE '%,' + Cast(Datepart(dw, PlannedDate) AS CHAR(1)) + ',%'
        OR EventEnumDays IS NULL
ORDER  BY EventID,
          PlannedDate
OPTION (maxrecursion 0) 
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 34: Rename column SQL Server 2008 (score [1064792](https://stackoverflow.com/q/16296622) in 2018)

#### Question
I am using SQL Server 2008 and Navicat. I need to rename a column in a table using SQL.  

```sql
ALTER TABLE table_name RENAME COLUMN old_name to new_name;
```

This statement doesn't work.  

#### Answer accepted (score 1116)
Use `sp_rename`  

```sql
EXEC sp_RENAME 'TableName.OldColumnName' , 'NewColumnName', 'COLUMN'
```

See: <a href="http://blog.sqlauthority.com/2008/08/26/sql-server-how-to-rename-a-column-name-or-table-name/" rel="noreferrer">SQL SERVER – How to Rename a Column Name or Table Name</a>  

Documentation: <a href="https://docs.microsoft.com/de-de/sql/relational-databases/system-stored-procedures/sp-rename-transact-sql" rel="noreferrer"><strong>sp_rename</strong> (Transact-SQL)</a>  

For your case it would be:  

```sql
EXEC sp_RENAME 'table_name.old_name', 'new_name', 'COLUMN'
```

Remember to use single quotes to enclose your values.   

#### Answer 2 (score 95)
Alternatively to `SQL`, you can do this in Microsoft SQL Server Management Studio. Here are a few quick ways using the GUI:  

<h5>First Way</h3>

Slow double-click on the column. The column name will become an editable text box.  

<hr>

<h5>Second Way</h3>

Right click on column and choose Rename from the context menu.  

For example:  

<img src="https://i.stack.imgur.com/zygEz.jpg" alt="To Rename column name">  

<hr>

<h5>Third Way</h3>

<em>This way is preferable for when you need to rename multiple columns in one go.</em>  

<ol>
<li>Right-click on the table that contains the column that needs renaming.</li>
<li>Click <em>Design</em>.</li>
<li>In the table design panel, click and edit the textbox of the column name you want to alter.</li>
</ol>

<p>For example:
<img src="https://i.stack.imgur.com/UwVU4.png" alt="MSSMS Table Design Example"></p>

<sub><strong>NOTE:</strong> I know OP specifically asked for SQL solution, thought this might help others :)</sub>  

#### Answer 3 (score 57)
Try:  

```sql
EXEC sp_rename 'TableName.OldName', 'NewName', 'COLUMN'
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 35: Get all table names of a particular database by SQL query? (score [1044124](https://stackoverflow.com/q/3913620) in 2016)

#### Question
I am working on application which can deal with multiple database servers like "MySQL" and "MS SQL Server".  

I want to get tables' names of a particular database using a general query which should suitable for all database types. I have tried following:  

```sql
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'
```

But it is giving table names of all databases of a particular server but I want to get tables names of selected database only. How can I restrict this query to get tables of a particular database?  

#### Answer accepted (score 454)
Probably due to the way different sql dbms deal with schemas.  

Try the following  

For SQL Server:  

```sql
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_CATALOG='dbName'
```

For MySQL:  

```sql
SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_SCHEMA='dbName' 
```

For Oracle I think the equivalent would be to use `DBA_TABLES`.  

#### Answer 2 (score 77)
Stolen from <a href="http://blog.sqlauthority.com/2007/06/26/sql-server-2005-list-all-tables-of-database/" rel="noreferrer">here</a>:  

```sql
USE YOURDBNAME
GO 
SELECT *
FROM sys.Tables
GO
```

#### Answer 3 (score 26)
The following query will select all of the `Tables` in the database named `DBName`:  

```sql
USE DBName
GO 
SELECT *
FROM sys.Tables
GO
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 36: SQL select only rows with max value on a column (score [1041887](https://stackoverflow.com/q/7745609) in 2019)

#### Question
I have this table for documents (simplified version here):  

```sql
+------+-------+--------------------------------------+
| id   | rev   | content                              |
+------+-------+--------------------------------------+
| 1    | 1     | ...                                  |
| 2    | 1     | ...                                  |
| 1    | 2     | ...                                  |
| 1    | 3     | ...                                  |
+------+-------+--------------------------------------+
```

<p>How do I select one row per id and only the greatest rev?<br>
With the above data, the result should contain two rows: `[1, 3, ...]` and `[2, 1, ..]`. I'm using <strong><em>MySQL</em></strong>.</p>

Currently I use checks in the `while` loop to detect and over-write old revs from the resultset. But is this the only method to achieve the result? Isn't there a <strong>SQL</strong> solution?  

<p><strong>Update</strong><br>
As the answers suggest, there <em>is</em> a SQL solution, and <a href="http://sqlfiddle.com/#!9/3d74dc/1" rel="noreferrer">here a sqlfiddle demo</a>. </p>

<p><strong>Update 2</strong><br>
I noticed after adding the above <em>sqlfiddle</em>, the rate at which the question is upvoted has surpassed the upvote rate of the answers. That has not been the intention! The fiddle is based on the answers, especially the accepted answer.</p>

#### Answer accepted (score 1743)
<h5>At first glance...</h2>

All you need is a `GROUP BY` clause with the `MAX` aggregate function:  

```sql
SELECT id, MAX(rev)
FROM YourTable
GROUP BY id
```

<h5>It's never that simple, is it?</h2>

I just noticed you need the `content` column as well.  

This is a very common question in SQL: find the whole data for the row with some max value in a column per some group identifier. I heard that a lot during my career. Actually, it was one the questions I answered in my current job's technical interview.   

It is, actually, so common that StackOverflow community has created a single tag just to deal with questions like that: <a href="/questions/tagged/greatest-n-per-group" class="post-tag" title="show questions tagged &#39;greatest-n-per-group&#39;" rel="tag">greatest-n-per-group</a>.  

Basically, you have two approaches to solve that problem:  

<h5>Joining with simple `group-identifier, max-value-in-group` Sub-query</h2>

In this approach, you first find the `group-identifier, max-value-in-group` (already solved above) in a sub-query. Then you join your table to the sub-query with equality on both `group-identifier` and `max-value-in-group`:  

```sql
SELECT a.id, a.rev, a.contents
FROM YourTable a
INNER JOIN (
    SELECT id, MAX(rev) rev
    FROM YourTable
    GROUP BY id
) b ON a.id = b.id AND a.rev = b.rev
```

<h5>Left Joining with self, tweaking join conditions and filters</h2>

In this approach, you left join the table with itself. Equality, of course, goes in the `group-identifier`. Then, 2 smart moves:   

<ol>
<li>The second join condition is having left side value less than right value</li>
<li>When you do step 1, the row(s) that actually have the max value will have `NULL` in the right side (it's a `LEFT JOIN`, remember?). Then, we filter the joined result, showing only the rows where the right side is `NULL`.</li>
</ol>

So you end up with:  

```sql
SELECT a.*
FROM YourTable a
LEFT OUTER JOIN YourTable b
    ON a.id = b.id AND a.rev < b.rev
WHERE b.id IS NULL;
```

<h5>Conclusion</h2>

Both approaches bring the exact same result.   

If you have two rows with `max-value-in-group` for `group-identifier`, both rows will be in the result in both approaches.  

Both approaches are SQL ANSI compatible, thus, will work with your favorite RDBMS, regardless of its "flavor".  

Both approaches are also performance friendly, however your mileage may vary (RDBMS, DB Structure, Indexes, etc.). So when you pick one approach over the other, <em>benchmark</em>. And make sure you pick the one which make most of sense to you.  

#### Answer 2 (score 227)
My preference is to use as little code as possible...  

<p>You can do it using `IN`
try this:</p>

```sql
SELECT * 
FROM t1 WHERE (id,rev) IN 
( SELECT id, MAX(rev)
  FROM t1
  GROUP BY id
)
```

to my mind it is less complicated... easier to read and maintain.  

#### Answer 3 (score 75)
Yet another solution is to use a correlated subquery:  

```sql
select yt.id, yt.rev, yt.contents
    from YourTable yt
    where rev = 
        (select max(rev) from YourTable st where yt.id=st.id)
```

Having an index on (id,rev) renders the subquery almost as a simple lookup...  

Following are comparisons to the solutions in @AdrianCarneiro's answer (subquery, leftjoin), based on MySQL measurements with InnoDB table of ~1million records, group size being: 1-3.  

While for full table scans subquery/leftjoin/correlated timings relate to each other as 6/8/9, when it comes to direct lookups or batch (`id in (1,2,3)`), subquery is much slower then the others (Due to rerunning the subquery). However I couldnt differentiate between leftjoin and correlated solutions in speed.  

One final note, as leftjoin creates n*(n+1)/2 joins in groups, its performance can be heavily affected by the size of groups...  

</b> </em> </i> </small> </strong> </sub> </sup>

### 37: Should I use != or <> for not equal in T-SQL? (score [1016642](https://stackoverflow.com/q/723195) in 2018)

#### Question
I have seen `SQL` that uses both `!=` and `&lt;&gt;` for <strong><em>not equal</em></strong>. What is the preferred syntax and why?  

I like `!=`, because `&lt;&gt;` reminds me of `Visual Basic`.  

#### Answer accepted (score 520)
Technically they function the same if you’re using SQL&nbsp;Server AKA T-SQL.  If you're using it in stored procedures there is no performance reason to use one over the other. It then comes down to personal preference. I prefer to use &lt;> as it is ANSI compliant.  

You can find links to the various ANSI standards at...  

<a href="http://en.wikipedia.org/wiki/SQL" rel="noreferrer">http://en.wikipedia.org/wiki/SQL</a>  

#### Answer 2 (score 705)
Most databases support `!=` (popular programming languages) and `&lt;&gt;` (ANSI).  

Databases that support both `!=` and `&lt;&gt;`:  

<ul>
<li>MySQL 5.1: <a href="http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html#operator_not-equal" rel="noreferrer">`!=` and `&lt;&gt;`</a></li>
<li>PostgreSQL 8.3: <a href="http://www.postgresql.org/docs/current/static/functions-comparison.html#FUNCTIONS-COMPARISON-TABLE" rel="noreferrer">`!=` and `&lt;&gt;`</a></li>
<li>SQLite: <a href="http://www.sqlite.org/lang_expr.html#binaryops" rel="noreferrer">`!=` and `&lt;&gt;`</a></li>
<li>Oracle 10g: <a href="http://download-west.oracle.com/docs/cd/B19306_01/server.102/b14200/conditions002.htm#CJAGAABC" rel="noreferrer">`!=` and `&lt;&gt;`</a></li>
<li>Microsoft SQL Server 2000/2005/2008/2012/2016: <a href="http://msdn.microsoft.com/en-us/library/ms190296.aspx" rel="noreferrer">`!=`</a> and <a href="http://msdn.microsoft.com/en-us/library/ms176020.aspx" rel="noreferrer">`&lt;&gt;`</a></li>
<li>IBM Informix Dynamic Server 10: <a href="http://publib.boulder.ibm.com/infocenter/idshelp/v10/index.jsp?topic=/com.ibm.sqlt.doc/sqltmst46.htm" rel="noreferrer">`!=` and `&lt;&gt;`</a></li>
<li>InterBase/Firebird: <a href="http://www.ibphoenix.com/main.nfs?a=ibphoenix&amp;s=1239054922:316459&amp;page=ibp_60_sqlref" rel="noreferrer">`!=` and `&lt;&gt;`</a></li>
<li>Apache Derby 10.6: <a href="http://db.apache.org/derby/docs/10.6/ref/rrefsqlj23075.html" rel="noreferrer">`!=` and `&lt;&gt;`</a></li>
<li>Sybase Adaptive Server Enterprise 11.0: <a href="http://infocenter.sybase.com/help/index.jsp?topic=/com.sybase.help.sqlanywhere.11.0.0/dbreference_en11/coco.html" rel="noreferrer">`!=` and `&lt;&gt;`</a></li>
</ul>

Databases that support the ANSI standard operator, <strong>exclusively</strong>:  

<ul>
<li>IBM DB2 UDB 9.5: <a href="http://publib.boulder.ibm.com/infocenter/iseries/v5r3/topic/db2/rbafzmstch2pred.htm" rel="noreferrer">`&lt;&gt;`</a></li>
<li>Microsoft Access 2010: <a href="http://office.microsoft.com/en-us/access-help/table-of-operators-HA010235862.aspx" rel="noreferrer">`&lt;&gt;`</a></li>
</ul>

#### Answer 3 (score 105)
`'&lt;&gt;'` is from the <a href="http://www.contrib.andrew.cmu.edu/~shadow/sql/sql1992.txt" rel="noreferrer">SQL-92 standard</a> and `'!='` is a <a href="http://msdn.microsoft.com/en-us/library/ms188074(SQL.90).aspx" rel="noreferrer">proprietary</a> T-SQL operator. It's available in other databases as well, but since it isn't standard you have to take it on a case-by-case basis.  

In most cases, you'll know what database you're connecting to so this isn't really an issue. At worst you might have to do a search and replace in your SQL.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 38: How do I escape a single quote in SQL Server? (score [1006028](https://stackoverflow.com/q/1586560) in 2019)

#### Question
I'm trying to `insert` some text data into a table in `SQL Server` 9.  

The text includes a single quote(').  

How do I escape that?  

I tried using two single quotes, but it threw me some errors.  

eg. `insert into my_table values('hi, my name''s tim.');`  

#### Answer accepted (score 1258)
<strong>Single quotes are escaped by doubling them up</strong>, just as you've shown us in your example. The following SQL illustrates this functionality. I tested it on SQL Server 2008:  

```sql
DECLARE @my_table TABLE (
    [value] VARCHAR(200)
)

INSERT INTO @my_table VALUES ('hi, my name''s tim.')

SELECT * FROM @my_table
```

<h5>Results</h3>

```sql
value
==================
hi, my name's tim.
```

#### Answer 2 (score 64)
If escaping your single quote with another single quote isn't working for you (like it didn't for one of my recent `REPLACE()` queries), you can use `SET QUOTED_IDENTIFIER OFF` before your query, then `SET QUOTED_IDENTIFIER ON` after your query.  

For example  

```sql
SET QUOTED_IDENTIFIER OFF;

UPDATE TABLE SET NAME = REPLACE(NAME, "'S", "S");

SET QUOTED_IDENTIFIER ON;
-- set OFF then ON again
```

#### Answer 3 (score 41)
How about:  

```sql
insert into my_table values('hi, my name'+char(39)+'s tim.')
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 39: How do I query for all dates greater than a certain date in SQL Server? (score [968312](https://stackoverflow.com/q/10643379) in 2018)

#### Question
I'm trying:   

```sql
SELECT * 
FROM dbo.March2010 A
WHERE A.Date >= 2010-04-01;
```

`A.Date` looks like: `2010-03-04 00:00:00.000`  

However, this is not working.   

Can anyone provide a reference for why?  

#### Answer accepted (score 428)
```sql
select *  
from dbo.March2010 A 
where A.Date >= Convert(datetime, '2010-04-01' )
```

In your query, `2010-4-01` is treated as a mathematical expression, so in essence it read   

```sql
select *  
from dbo.March2010 A 
where A.Date >= 2005; 
```

<p>(`2010 minus 4 minus 1 is 2005`
Converting it to a proper `datetime`, and using single quotes will fix this issue.)</p>

Technically, the parser might allow you to get away with  

```sql
select *  
from dbo.March2010 A 
where A.Date >= '2010-04-01'
```

it will do the conversion for you, but in my opinion it is less readable than explicitly converting to a `DateTime` for the maintenance programmer that will come after you.  

#### Answer 2 (score 51)
Try enclosing your date into a character string.  

```sql
 select * 
 from dbo.March2010 A
 where A.Date >= '2010-04-01';
```

#### Answer 3 (score 13)
We can use like below as well  

```sql
SELECT * 
FROM dbo.March2010 A
WHERE CAST(A.Date AS Date) >= '2017-03-22';

SELECT * 
    FROM dbo.March2010 A
    WHERE CAST(A.Date AS Datetime) >= '2017-03-22 06:49:53.840';
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 40: Using group by on multiple columns (score [950952](https://stackoverflow.com/q/2421388) in 2018)

#### Question
I understand the point of `GROUP BY x`   

But how does `GROUP BY x, y` work, and what does it mean?  

#### Answer accepted (score 1894)
`Group By X` means <strong>put all those with the same value for X in the one group</strong>.  

`Group By X, Y` means <strong>put all those with the same values for both X and Y in the one group</strong>.  

To illustrate using an example, let's say we have the following table, to do with who is attending what subject at a university:  

```sql
Table: Subject_Selection

Subject   Semester   Attendee
---------------------------------
ITB001    1          John
ITB001    1          Bob
ITB001    1          Mickey
ITB001    2          Jenny
ITB001    2          James
MKB114    1          John
MKB114    1          Erica
```

When you use a `group by` on the subject column only; say:  

```sql
select Subject, Count(*)
from Subject_Selection
group by Subject
```

You will get something like:  

```sql
Subject    Count
------------------------------
ITB001     5
MKB114     2
```

...because there are 5 entries for ITB001, and 2 for MKB114  

If we were to `group by` two columns:  

```sql
select Subject, Semester, Count(*)
from Subject_Selection
group by Subject, Semester
```

we would get this:  

```sql
Subject    Semester   Count
------------------------------
ITB001     1          3
ITB001     2          2
MKB114     1          2
```

This is because, when we group by two columns, it is saying <strong>"Group them so that all of those with the same Subject and Semester are in the same group, and then calculate all the aggregate functions</strong> (Count, Sum, Average, etc.) <strong>for each of those groups"</strong>. In this example, this is demonstrated by the fact that, when we count them, there are <strong>three</strong> people doing ITB001 in semester 1, and <strong>two</strong> doing it in semester 2. Both of the people doing MKB114 are in semester 1, so there is no row for semester 2 (no data fits into the group "MKB114, Semester 2")  

Hopefully that makes sense.  

#### Answer 2 (score 26)
The `GROUP BY` clause is used in conjunction with the aggregate functions to group the result-set by one or more columns. e.g.:  

```sql
SELECT column_name, aggregate_function(column_name)
FROM table_name
WHERE column_name operator value
GROUP BY column_name;
```

Remember this order:  

<blockquote>
  1) SELECT (is used to select data from a database)  
  
  2) FROM (clause is used to list the tables)  
  
  3) WHERE (clause is used to filter records)  
  
  <p>4) GROUP BY (clause can be used in a SELECT statement to collect data
  across multiple records and group the results by one or more columns)</p>
  
  <p>5) HAVING (clause is used in combination with the GROUP BY clause to
  restrict the groups of returned rows to only those whose the condition
  is TRUE)</p>
  
  6) ORDER BY (keyword is used to sort the result-set)  
</blockquote>

You can use all of these if you are using aggregate functions, and this is the order that they must be set, otherwise you can get an error.   

Aggregate Functions are:  

<blockquote>
  MIN              returns the smallest value in a given column  
  
  SUM      returns the sum of the numeric values in a given column  
  
  AVG              returns the average value of a given column  
  
  COUNT    returns the total number of values in a given column  
  
  COUNT(*)  returns the number of rows in a table  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 41: How to list the tables in a SQLite database file that was opened with ATTACH? (score [950088](https://stackoverflow.com/q/82875) in 2019)

#### Question
What SQL can be used to list the tables, and the rows within those tables in a SQLite database file - once I have attached it with the `ATTACH` command on the SQLite 3 command line tool?  

#### Answer accepted (score 549)
The `.tables`, and `.schema` "helper" functions don't look into ATTACHed databases: they just query the `SQLITE_MASTER` table for the "main" database. Consequently, if you used  

```sql
ATTACH some_file.db AS my_db;
```

then you need to do  

```sql
SELECT name FROM my_db.sqlite_master WHERE type='table';
```

Note that temporary tables don't show up with `.tables` either: you have to list `sqlite_temp_master` for that:  

```sql
SELECT name FROM sqlite_temp_master WHERE type='table';
```

#### Answer 2 (score 1250)
There are a few steps to see the tables in an SQLite database:  

<ol>
<li><p>List the tables in your database:</p>

```sql
.tables
```</li>
<li><p>List how the table looks:</p>

```sql
.schema tablename
```</li>
<li><p>Print the entire table:</p>

```sql
SELECT * FROM tablename;
```</li>
<li><p>List all of the available SQLite prompt commands:</p>

```sql
.help
```</li>
</ol>

#### Answer 3 (score 438)
It appears you need to go through the <strong>sqlite_master</strong> table, like this:  

```sql
SELECT * FROM dbname.sqlite_master WHERE type='table';
```

And then manually go through each table with a `SELECT` or similar to look at the rows.  

The `.DUMP` and `.SCHEMA` commands doesn't appear to see the database at all.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 42: Convert Month Number to Month Name Function in SQL (score [931125](https://stackoverflow.com/q/185520) in 2012)

#### Question
I have months stored in SQL Server as 1,2,3,4,...12. I would like to display them as January,February etc. Is there a function in SQL Server like MonthName(1) = January? I am trying to avoid a CASE statement, if possible.  

#### Answer accepted (score 151)
A little hacky but should work:  

```sql
SELECT DATENAME(month, DATEADD(month, @mydate-1, CAST('2008-01-01' AS datetime)))
```

#### Answer 2 (score 255)
I think this is the best way to get the <strong>month name</strong> when you have the <strong>month number</strong>  

```sql
Select DateName( month , DateAdd( month , @MonthNumber , 0 ) - 1 )
```

Or   

```sql
Select DateName( month , DateAdd( month , @MonthNumber , -1 ) )
```

#### Answer 3 (score 90)
```sql
SELECT DATENAME(month, GETDATE()) AS 'Month Name'
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 43: Select first row in each GROUP BY group? (score [921853](https://stackoverflow.com/q/3800551) in 2018)

#### Question


As the title suggests, I'd like to select the first row of each set of rows grouped with a `GROUP BY`.  

Specifically, if I've got a `purchases` table that looks like this:  

```sql
SELECT * FROM purchases;
```

<strong>My Output:</strong>  

<pre>
id | customer | total
---+----------+------
 1 | Joe      | 5
 2 | Sally    | 3
 3 | Joe      | 2
 4 | Sally    | 1
</pre>

I'd like to query for the `id` of the largest purchase (`total`) made by each `customer`. Something like this:  

```sql
SELECT FIRST(id), customer, FIRST(total)
FROM  purchases
GROUP BY customer
ORDER BY total DESC;
```

<strong>Expected Output:</strong>  

<pre>
FIRST(id) | customer | FIRST(total)
----------+----------+-------------
        1 | Joe      | 5
        2 | Sally    | 3
</pre>

#### Answer accepted (score 997)
<h5>On Oracle 9.2+ (not 8i+ as originally stated), SQL Server 2005+, PostgreSQL 8.4+, DB2, Firebird 3.0+, Teradata, Sybase, Vertica:</h2>

```sql
WITH summary AS (
    SELECT p.id, 
           p.customer, 
           p.total, 
           ROW_NUMBER() OVER(PARTITION BY p.customer 
                                 ORDER BY p.total DESC) AS rk
      FROM PURCHASES p)
SELECT s.*
  FROM summary s
 WHERE s.rk = 1
```

<h5>Supported by any database:</h2>

But you need to add logic to break ties:  

```sql
  SELECT MIN(x.id),  -- change to MAX if you want the highest
         x.customer, 
         x.total
    FROM PURCHASES x
    JOIN (SELECT p.customer,
                 MAX(total) AS max_total
            FROM PURCHASES p
        GROUP BY p.customer) y ON y.customer = x.customer
                              AND y.max_total = x.total
GROUP BY x.customer, x.total
```

#### Answer 2 (score 1027)
In <strong>PostgreSQL</strong> this is typically <strong>simpler and faster</strong> (more performance optimization below):  

```sql
SELECT <b>DISTINCT ON</b> (customer)
       id, customer, total
FROM   purchases
ORDER  BY customer, total DESC, id;```

Or shorter (if not as clear) with ordinal numbers of output columns:  

```sql
SELECT DISTINCT ON (2)
       id, customer, total
FROM   purchases
ORDER  BY 2, 3 DESC, 1;
```

If `total` can be NULL (won't hurt either way, but you'll want to match existing indexes):  

```sql
...
ORDER  BY customer, total DESC <b>NULLS LAST</b>, id;```

<h5>Major points</h3>

<ul>
<li><p><a href="https://www.postgresql.org/docs/current/sql-select.html#SQL-DISTINCT" rel="noreferrer"><strong>`DISTINCT ON`</strong></a> is a PostgreSQL extension of the standard (where only `DISTINCT` on the whole `SELECT` list is defined).</p></li>
<li><p>List any number of expressions in the `DISTINCT ON` clause, the combined row value defines duplicates. <a href="https://www.postgresql.org/docs/current/queries-select-lists.html#QUERIES-DISTINCT" rel="noreferrer">The manual:</a></p>

<blockquote>
  <p>Obviously, two rows are considered distinct if they differ in at least
  one column value. <strong>Null values are considered equal in this comparison.</strong></p>
</blockquote>

Bold emphasis mine.  </li>
<li><p>`DISTINCT ON` can be combined with <strong>`ORDER BY`</strong>. Leading expressions have to match leading `DISTINCT ON` expressions in the same order. You can add <em>additional</em> expressions to `ORDER BY` to pick a particular row from each group of peers. I added `id` as last item to break ties:</p>

<em>"Pick the row with the smallest `id` from each group sharing the highest `total`."</em>  

To order results in a way that disagrees with the sort order determining the first per group, you can nest above query in an outer query with another `ORDER BY`. Like:  

<ul>
<li><a href="https://stackoverflow.com/questions/9795660/postgresql-distinct-on-with-different-order-by/9796104#9796104">PostgreSQL DISTINCT ON with different ORDER BY</a></li>
</ul></li>
<li><p>If `total` can be NULL, you <em>most probably</em> want the row with the greatest non-null value. Add <strong>`NULLS LAST`</strong> like demonstrated. Details:</p>

<ul>
<li><a href="https://stackoverflow.com/questions/9510509/postgresql-sort-by-datetime-asc-null-first/9511492#9511492">PostgreSQL sort by datetime asc, null first?</a></li>
</ul></li>
<li><p><strong>The `SELECT` list</strong> is not constrained by expressions in `DISTINCT ON` or `ORDER BY` in any way. (Not needed in the simple case above):</p>

<ul>
<li><p>You <em>don't have to</em> include any of the expressions in `DISTINCT ON` or `ORDER BY`.</p></li>
<li><p>You <em>can</em> include any other expression in the `SELECT` list. This is instrumental for replacing much more complex queries with subqueries and aggregate / window functions.</p></li>
</ul></li>
<li><p>I tested with Postgres versions 8.3 – 12. But the feature has been there at least since version 7.1, so basically always.</p></li>
</ul>

<h5>Index</h2>

The <em>perfect</em> index for the above query would be a <a href="https://www.postgresql.org/docs/current/indexes-multicolumn.html" rel="noreferrer">multi-column index</a> spanning all three columns in matching sequence and with matching sort order:  

```sql
CREATE INDEX purchases_3c_idx ON purchases (customer, total DESC, id);
```

May be too specialized. But use it if read performance for the particular query is crucial. If you have `DESC NULLS LAST` in the query, use the same in the index so that sort order matches and the index is applicable.  

<h5>Effectiveness / Performance optimization</h2>

Weigh cost and benefit before creating tailored indexes for each query. The potential of above index largely depends on <strong>data distribution</strong>.  

The index is used because it delivers pre-sorted data. In Postgres 9.2 or later the query can also benefit from an <strong><a href="https://www.postgresql.org/docs/current/indexes-index-only-scans.html" rel="noreferrer">index only scan</a></strong> if the index is smaller than the underlying table. The index has to be scanned in its entirety, though.  

<ul>
<li><p>For <strong><em>few</em> rows per customer</strong> (high cardinality in column `customer`), this is very efficient. Even more so if you need sorted output anyway. The benefit shrinks with a growing number of rows per customer.<br>
Ideally, you have enough <a href="https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-WORK-MEM" rel="noreferrer"><strong>`work_mem`</strong></a> to process the involved sort step in RAM and not spill to disk. But generally setting `work_mem` <em>too</em> high can have adverse effects. Consider `SET LOCAL` for exceptionally big queries. Find how much you need with `EXPLAIN ANALYZE`. Mention of "<em>Disk:</em>" in the sort step indicates the need for more:</p>

<ul>
<li><a href="https://stackoverflow.com/questions/8106181/configuration-parameter-work-mem-in-postgresql-on-linux/8108807#8108807">Configuration parameter work_mem in PostgreSQL on Linux</a></li>
<li><a href="https://dba.stackexchange.com/questions/48630/optimize-simple-query-using-order-by-date-and-text/48633#48633">Optimize simple query using ORDER BY date and text</a></li>
</ul></li>
<li><p>For <strong><em>many</em> rows per customer</strong> (low cardinality in column `customer`), a <a href="https://wiki.postgresql.org/wiki/Loose_indexscan" rel="noreferrer"><strong>loose index scan</strong></a> (a.k.a. "skip scan") would be (much) more efficient, but that's not implemented up to Postgres 12. (An implementation for index-only scans is in development for Postgres 13. See <a href="https://commitfest.postgresql.org/19/1741/" rel="noreferrer">here</a> and <a href="https://www.postgresql.org/message-id/flat/707b6f68-16fa-7aa7-96e5-eeb4865e6a30@redhat.com" rel="noreferrer">here</a>.)<br>
For now, there are <strong>faster query techniques</strong> to substitute for this. In particular if you have a separate table holding unique customers, which is the typical use case. But also if you don't:</p>

<ul>
<li><strong><a href="https://stackoverflow.com/questions/25536422/optimize-group-by-query-to-retrieve-latest-record-per-user/25536748#25536748">Optimize GROUP BY query to retrieve latest row per user</a></strong></li>
<li><a href="https://stackoverflow.com/questions/24244026/optimize-groupwise-maximum-query/24377356#24377356">Optimize groupwise maximum query</a></li>
<li><a href="https://stackoverflow.com/questions/25957558/querying-last-n-related-records-in-postgres/25965393#25965393">Query last N related rows per row</a></li>
</ul></li>
</ul>

<h5>Benchmark</h2>

I had a simple benchmark here which is outdated by now. I replaced it with a <a href="https://stackoverflow.com/a/34715134/939860"><strong>detailed benchmark in this separate answer</strong></a>.  

#### Answer 3 (score 119)
<h5>Benchmark</h1>

Testing the most interesting candidates with Postgres <strong>9.4</strong> and <strong>9.5</strong> with a halfway realistic table of <strong>200k rows</strong> in `purchases` and <strong>10k distinct `customer_id`</strong> (<em>avg. 20 rows per customer</em>).  

For Postgres 9.5 I ran a 2nd test with effectively 86446 distinct customers. See below (<em>avg. 2.3 rows per customer</em>).  

<h5>Setup</h3>

Main table  

```sql
CREATE TABLE purchases (
  id          serial
, customer_id int  -- REFERENCES customer
, total       int  -- could be amount of money in Cent
, some_column text -- to make the row bigger, more realistic
);
```

I use a `serial` (PK constraint added below) and an integer `customer_id` since that's a more typical setup. Also added `some_column` to make up for typically more columns.  

Dummy data, PK, index - a typical table also has some dead tuples:  

```sql
INSERT INTO purchases (customer_id, total, some_column)    -- insert 200k rows
SELECT (random() * 10000)::int             AS customer_id  -- 10k customers
     , (random() * random() * 100000)::int AS total     
     , 'note: ' || repeat('x', (random()^2 * random() * random() * 500)::int)
FROM   generate_series(1,200000) g;

ALTER TABLE purchases ADD CONSTRAINT purchases_id_pkey PRIMARY KEY (id);

DELETE FROM purchases WHERE random() > 0.9; -- some dead rows

INSERT INTO purchases (customer_id, total, some_column)
SELECT (random() * 10000)::int             AS customer_id  -- 10k customers
     , (random() * random() * 100000)::int AS total     
     , 'note: ' || repeat('x', (random()^2 * random() * random() * 500)::int)
FROM   generate_series(1,20000) g;  -- add 20k to make it ~ 200k

CREATE INDEX purchases_3c_idx ON purchases (customer_id, total DESC, id);

VACUUM ANALYZE purchases;
```

`customer` table - for superior query  

```sql
CREATE TABLE customer AS
SELECT customer_id, 'customer_' || customer_id AS customer
FROM   purchases
GROUP  BY 1
ORDER  BY 1;

ALTER TABLE customer ADD CONSTRAINT customer_customer_id_pkey PRIMARY KEY (customer_id);

VACUUM ANALYZE customer;
```

In my <strong>second test</strong> for 9.5 I used the same setup, but with `random() * 100000` to generate `customer_id` to get only few rows per `customer_id`.  

<h5>Object sizes for table `purchases`</h3>

Generated with <a href="https://dba.stackexchange.com/questions/23879/measure-the-size-of-a-postgresql-table-row/23933#23933">this query</a>.  

```sql
               what                | bytes/ct | bytes_pretty | bytes_per_row
-----------------------------------+----------+--------------+---------------
 core_relation_size                | 20496384 | 20 MB        |           102
 visibility_map                    |        0 | 0 bytes      |             0
 free_space_map                    |    24576 | 24 kB        |             0
 table_size_incl_toast             | 20529152 | 20 MB        |           102
 indexes_size                      | 10977280 | 10 MB        |            54
 total_size_incl_toast_and_indexes | 31506432 | 30 MB        |           157
 live_rows_in_text_representation  | 13729802 | 13 MB        |            68
 ------------------------------    |          |              |
 row_count                         |   200045 |              |
 live_tuples                       |   200045 |              |
 dead_tuples                       |    19955 |              |
```

<h5>Queries</h1>

<h5>1. `row_number()` in CTE, (<a href="https://stackoverflow.com/a/3800572/939860">see other answer</a>)</h3>

```sql
WITH cte AS (
   SELECT id, customer_id, total
        , row_number() OVER(PARTITION BY customer_id ORDER BY total DESC) AS rn
   FROM   purchases
   )
SELECT id, customer_id, total
FROM   cte
WHERE  rn = 1;
```

<h5>2. `row_number()` in subquery (my optimization)</h3>

```sql
SELECT id, customer_id, total
FROM   (
   SELECT id, customer_id, total
        , row_number() OVER(PARTITION BY customer_id ORDER BY total DESC) AS rn
   FROM   purchases
   ) sub
WHERE  rn = 1;
```

<h5>3. `DISTINCT ON` (<a href="https://stackoverflow.com/a/7630564/939860">see other answer</a>)</h3>

```sql
SELECT DISTINCT ON (customer_id)
       id, customer_id, total
FROM   purchases
ORDER  BY customer_id, total DESC, id;
```

<h5>4. rCTE with `LATERAL` subquery (<a href="https://stackoverflow.com/a/25536748/939860">see here</a>)</h3>

```sql
WITH RECURSIVE cte AS (
   (  -- parentheses required
   SELECT id, customer_id, total
   FROM   purchases
   ORDER  BY customer_id, total DESC
   LIMIT  1
   )
   UNION ALL
   SELECT u.*
   FROM   cte c
   ,      LATERAL (
      SELECT id, customer_id, total
      FROM   purchases
      WHERE  customer_id > c.customer_id  -- lateral reference
      ORDER  BY customer_id, total DESC
      LIMIT  1
      ) u
   )
SELECT id, customer_id, total
FROM   cte
ORDER  BY customer_id;
```

<h5>5. `customer` table with `LATERAL` (<a href="https://stackoverflow.com/a/25536748/939860">see here</a>)</h3>

```sql
SELECT l.*
FROM   customer c
,      LATERAL (
   SELECT id, customer_id, total
   FROM   purchases
   WHERE  customer_id = c.customer_id  -- lateral reference
   ORDER  BY total DESC
   LIMIT  1
   ) l;
```

<h5>6. `array_agg()` with `ORDER BY` (<a href="https://stackoverflow.com/a/25534279/939860">see other answer</a>)</h3>

```sql
SELECT (array_agg(id ORDER BY total DESC))[1] AS id
     , customer_id
     , max(total) AS total
FROM   purchases
GROUP  BY customer_id;
```

<h5>Results</h1>

Execution time for above queries with `EXPLAIN ANALYZE` (and all options <em>off</em>), <em>best of 5 runs</em>.  

<em>All</em> queries used an <strong>Index Only Scan</strong> on `purchases2_3c_idx` (among other steps). Some of them just for the smaller size of the index, others more effectively.  

<h5>A. Postgres 9.4 with 200k rows and ~ 20 per `customer_id`</h3>

```sql
1. 273.274 ms  
2. 194.572 ms  
3. 111.067 ms  
4.  92.922 ms  
5.  37.679 ms  -- winner
6. 189.495 ms
```

<h5>B. The same with Postgres 9.5</h3>

```sql
1. 288.006 ms
2. 223.032 ms  
3. 107.074 ms  
4.  78.032 ms  
5.  33.944 ms  -- winner
6. 211.540 ms  
```

<h5>C. Same as B., but with ~ 2.3 rows per `customer_id`</h3>

```sql
1. 381.573 ms
2. 311.976 ms
3. 124.074 ms  -- winner
4. 710.631 ms
5. 311.976 ms
6. 421.679 ms
```

<hr>

<h5>Related benchmarks</h2>

Here is a new one by "ogr" testing with <strong>10M rows and 60k unique "customers"</strong> on <strong>Postgres 11.5</strong> (current as of Sep. 2019). Results are still in line with what we have seen so far:  

<ul>
<li><a href="https://stackoverflow.com/questions/57893251/proper-way-to-access-latest-row-for-each-individual-identifier/57975451#57975451">Proper way to access latest row for each individual identifier?</a></li>
</ul>

<h5>Original (outdated) benchmark from 2011</h3>

<p>I ran three tests with PostgreSQL <strong>9.1</strong> on a real life table of 65579 rows and single-column btree indexes on each of the three columns involved and took the best <em>execution time</em> of 5 runs.<br>
Comparing <a href="https://stackoverflow.com/a/3800572/939860">@OMGPonies'</a> first query (<strong>`A`</strong>) to the <a href="https://stackoverflow.com/a/7630564/939860">above `DISTINCT ON` solution</a> (<strong>`B`</strong>):</p>

<ol>
<li><p>Select the whole table, results in 5958 rows in this case.</p>

```sql
A: 567.218 ms
B: 386.673 ms
```</li>
<li><p>Use condition `WHERE customer BETWEEN x AND y` resulting in 1000 rows.</p>

```sql
A: 249.136 ms
B:  55.111 ms
```</li>
<li><p>Select a single customer with `WHERE customer = x`.</p>

```sql
A:   0.143 ms
B:   0.072 ms
```</li>
</ol>

Same test repeated with the index described in the other answer  

```sql
CREATE INDEX purchases_3c_idx ON purchases (customer, total DESC, id);
```

  </p>

```sql
1A: 277.953 ms  
1B: 193.547 ms

2A: 249.796 ms -- special index not used  
2B:  28.679 ms

3A:   0.120 ms  
3B:   0.048 ms
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 44: How to insert a line break in a SQL Server VARCHAR/NVARCHAR string (score [920209](https://stackoverflow.com/q/31057) in 2013)

#### Question
I didn't see any similar questions asked on this topic, and I had to research this for something I'm working on right now. Thought I would post the answer for it in case anyone else had the same question.  

#### Answer accepted (score 260)
I found the answer here: <a href="http://blog.sqlauthority.com/2007/08/22/sql-server-t-sql-script-to-insert-carriage-return-and-new-line-feed-in-code/" rel="noreferrer">http://blog.sqlauthority.com/2007/08/22/sql-server-t-sql-script-to-insert-carriage-return-and-new-line-feed-in-code/</a>  

You just concatenate the string and insert a `CHAR(13)` where you want your line break.   

Example:  

```sql
DECLARE @text NVARCHAR(100)
SET @text = 'This is line 1.' + CHAR(13) + 'This is line 2.'
SELECT @text
```

This prints out the following:  

<blockquote>
  <p>This is line 1.<br>
  This is line 2.</p>
</blockquote>

#### Answer 2 (score 559)
`char(13)` is `CR`. For DOS-/Windows-style `CRLF` linebreaks, you want `char(13)+char(10)`, like:  

```sql
'This is line 1.' + CHAR(13)+CHAR(10) + 'This is line 2.'
```

#### Answer 3 (score 80)
Another way to do this is as such:  

```sql
INSERT CRLF SELECT 'fox 
jumped'
```

That is, simply inserting a line break in your query while writing it will add the like break to the database. This works in SQL server Management studio and Query Analyzer. I believe this will also work in C# if you use the @ sign on strings.   

```sql
string str = @"INSERT CRLF SELECT 'fox 
    jumped'"
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 45: How do I see active SQL Server connections? (score [917310](https://stackoverflow.com/q/1248423) in 2019)

#### Question
I am using SQL Server 2008 Enterprise. I want to see any active SQL Server connections, and the related information of all the connections, like from which IP address, connect to which database or something.  

Are there existing commands to solve this issue?  

#### Answer accepted (score 329)
You can use the <a href="http://msdn.microsoft.com/en-us/library/ms174313.aspx" rel="noreferrer">`sp_who`</a> stored procedure.   

<blockquote>
  Provides information about current users, sessions, and processes in an instance of the Microsoft SQL Server Database Engine. The information can be filtered to return only those processes that are not idle, that belong to a specific user, or that belong to a specific session.  
</blockquote>

#### Answer 2 (score 313)
```sql
SELECT 
    DB_NAME(dbid) as DBName, 
    COUNT(dbid) as NumberOfConnections,
    loginame as LoginName
FROM
    sys.sysprocesses
WHERE 
    dbid > 0
GROUP BY 
    dbid, loginame
;
```

See also the Microsoft documentation for <a href="https://docs.microsoft.com/en-us/sql/relational-databases/system-compatibility-views/sys-sysprocesses-transact-sql" rel="noreferrer">sys.sysprocesses</a>.  

#### Answer 3 (score 51)
Apart from `sp_who`, you can also use the "undocumented" `sp_who2` system stored procedure which gives you more detailed information. See <em><a href="http://www.sqlteam.com/forums/topic.asp?TOPIC_ID=100099" rel="noreferrer">Difference between sp_who and sp_who2</a></em>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 46: Getting only Month and Year from SQL DATE (score [894623](https://stackoverflow.com/q/1781946) in 2018)

#### Question
I need to access only Month.Year from Date field in SQL Server.  

#### Answer accepted (score 157)
<p>As well as the suggestions given already, there is one other possiblity I can infer from your question:<br>
- You still want the result to be a date<br>
- But you want to 'discard' the Days, Hours, etc<br>
- Leaving a year/month only date field  </p>

```sql
SELECT
   DATEADD(MONTH, DATEDIFF(MONTH, 0, <dateField>), 0) AS [year_month_date_field]
FROM
   <your_table>
```

This gets the number of whole months from a base date (0) and then adds them to that base date.  Thus rounding Down to the month in which the date is in.  

<p>NOTE: In SQL Server 2008, You will still have the TIME attached as 00:00:00.000
This is not exactly the same as "removing" any notation of day and time altogether.
Also the DAY set to the first. e.g. 2009-10-01 00:00:00.000</p>

#### Answer 2 (score 120)
```sql
select month(dateField), year(dateField)
```

#### Answer 3 (score 32)
```sql
SELECT DATEPART(yy, DateVal)
SELECT DATEPART(MM, DateVal)
SELECT DATENAME(MM, DateVal)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 47: How to query MongoDB with "like"? (score [894279](https://stackoverflow.com/q/3305561) in 2019)

#### Question
I want to query something with SQL's `like` query:  

```sql
SELECT * FROM users  WHERE name LIKE '%m%'
```

How to do I achieve the same in MongoDB?  I can't find an operator for `like` in the <a href="http://www.mongodb.org/display/DOCS/Advanced+Queries" rel="noreferrer">documentation</a>.  

#### Answer accepted (score 1780)
That would have to be:  

```sql
db.users.find({"name": /.*m.*/})
```

or, similar:  

```sql
db.users.find({"name": /m/})
```

You're looking for something that contains "m" somewhere (SQL's '`%`' operator is equivalent to Regexp's '`.*`'), not something that has "m" anchored to the beginning of the string.  

#### Answer 2 (score 330)
```sql
db.users.insert({name: 'paulo'})
db.users.insert({name: 'patric'})
db.users.insert({name: 'pedro'})

db.users.find({name: /a/})  //like '%a%'
```

out: paulo, patric  

```sql
db.users.find({name: /^pa/}) //like 'pa%' 
```

out: paulo, patric  

```sql
db.users.find({name: /ro$/}) //like '%ro'
```

out: pedro  

#### Answer 3 (score 250)
In   

<ul>
<li><strong>PyMongo</strong> using <strong>Python</strong></li>
<li><strong>Mongoose</strong> using <strong>Node.js</strong> </li>
<li><strong>Jongo</strong>, using <strong>Java</strong></li>
<li><strong>mgo</strong>, using <strong>Go</strong></li>
</ul>

you can do:  

```sql
db.users.find({'name': {'$regex': 'sometext'}})
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 48: Convert Date format into DD/MMM/YYYY format in SQL Server (score [891524](https://stackoverflow.com/q/17205441) in 2016)

#### Question
I have a query in sql, I have to get date in a format of `dd/mmm/yy`   

Example: `25/jun/2013`.   

How can I convert it for SQL server?  

#### Answer accepted (score 63)
I'm not sure there is an exact match for the format you want. But you can get close with <a href="http://msdn.microsoft.com/en-us/library/ms187928.aspx" rel="noreferrer">`convert()`</a> and style `106`. Then, replace the spaces:  

```sql
SELECT replace(convert(NVARCHAR, getdate(), 106), ' ', '/')
```

#### Answer 2 (score 44)
There are already <a href="https://msdn.microsoft.com/en-us/library/ms187928.aspx">multiple answers and formatting types</a>  for SQL server 2008. But this method somewhat ambiguous and it would be difficult for you to remember the number with respect to Specific Date Format. That's why in next versions of SQL server there is better option.  

<h5>If you are using SQL Server 2012 or above versions, you should use  <a href="https://msdn.microsoft.com/en-us/library/hh213505.aspx">Format() function</a></h2>

```sql
FORMAT ( value, format [, culture ] )
```

With culture option, you can specify date as per your viewers.  

```sql
DECLARE @d DATETIME = '10/01/2011';
SELECT FORMAT ( @d, 'd', 'en-US' ) AS 'US English Result'
      ,FORMAT ( @d, 'd', 'en-gb' ) AS 'Great Britain English Result'
      ,FORMAT ( @d, 'd', 'de-de' ) AS 'German Result'
      ,FORMAT ( @d, 'd', 'zh-cn' ) AS 'Simplified Chinese (PRC) Result'; 

SELECT FORMAT ( @d, 'D', 'en-US' ) AS 'US English Result'
      ,FORMAT ( @d, 'D', 'en-gb' ) AS 'Great Britain English Result'
      ,FORMAT ( @d, 'D', 'de-de' ) AS 'German Result'
      ,FORMAT ( @d, 'D', 'zh-cn' ) AS 'Chinese (Simplified PRC) Result';

US English Result Great Britain English Result  German Result Simplified Chinese (PRC) Result
----------------  ----------------------------- ------------- -------------------------------------
10/1/2011         01/10/2011                    01.10.2011    2011/10/1

US English Result            Great Britain English Result  German Result                    Chinese (Simplified PRC) Result
---------------------------- ----------------------------- -----------------------------  ---------------------------------------
Saturday, October 01, 2011   01 October 2011               Samstag, 1. Oktober 2011        2011年10月1日
```

For OP's solution, we can use following format, which is already mentioned by @Martin Smith:  

```sql
FORMAT(GETDATE(), 'dd/MMM/yyyy', 'en-us')
```

Some sample date formats:  

<a href="https://i.stack.imgur.com/07jfP.png"><img src="https://i.stack.imgur.com/07jfP.png" alt="enter image description here"></a>  

If you want more date formats of SQL server, you should visit:  

<ol>
<li><a href="https://msdn.microsoft.com/en-us/library/8kb3ddd4(v=vs.110).aspx">Custom Date and Time Format</a></li>
<li><a href="https://msdn.microsoft.com/en-us/library/az4se3k1(v=vs.110).aspx">Standard Date and Time Format</a></li>
</ol>

#### Answer 3 (score 30)
we can convert date into many formats like  

```sql
SELECT convert(varchar, getdate(), 106)
```

This returns `dd mon yyyy`   

<a href="http://anubhavg.wordpress.com/2009/06/11/how-to-format-datetime-date-in-sql-server-2005/" rel="noreferrer">More Here</a> This may help you  

</b> </em> </i> </small> </strong> </sub> </sup>

### 49: Oracle SQL: Update a table with data from another table (score [884573](https://stackoverflow.com/q/7030699) in 2017)

#### Question
Table 1:  

```sql
id    name    desc
-----------------------
1     a       abc
2     b       def
3     c       adf
```

Table 2:  

```sql
id    name    desc
-----------------------
1     x       123
2     y       345
```

In oracle SQL, how do I run an <strong>sql update</strong> query that can update Table 1 with Table 2's `name` and `desc` using the same `id`? So the end result I would get is  

Table 1:  

```sql
id    name    desc
-----------------------
1     x       123
2     y       345
3     c       adf
```

Question is taken from <a href="https://stackoverflow.com/questions/5036918/sql-update-query-with-data-from-another-table">update one table with data from another</a>, but specifically for oracle SQL.  

#### Answer accepted (score 473)
This is called a correlated update  

```sql
UPDATE table1 t1
   SET (name, desc) = (SELECT t2.name, t2.desc
                         FROM table2 t2
                        WHERE t1.id = t2.id)
 WHERE EXISTS (
    SELECT 1
      FROM table2 t2
     WHERE t1.id = t2.id )
```

Assuming the join results in a key-preserved view, you could also  

```sql
UPDATE (SELECT t1.id, 
               t1.name name1,
               t1.desc desc1,
               t2.name name2,
               t2.desc desc2
          FROM table1 t1,
               table2 t2
         WHERE t1.id = t2.id)
   SET name1 = name2,
       desc1 = desc2
```

#### Answer 2 (score 103)
Try this:  

```sql
MERGE INTO table1 t1
USING
(
-- For more complicated queries you can use WITH clause here
SELECT * FROM table2
)t2
ON(t1.id = t2.id)
WHEN MATCHED THEN UPDATE SET
t1.name = t2.name,
t1.desc = t2.desc;
```

#### Answer 3 (score 17)
try  

```sql
UPDATE Table1 T1 SET
T1.name = (SELECT T2.name FROM Table2 T2 WHERE T2.id = T1.id),
T1.desc = (SELECT T2.desc FROM Table2 T2 WHERE T2.id = T1.id)
WHERE T1.id IN (SELECT T2.id FROM Table2 T2 WHERE T2.id = T1.id);
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 50: Reset identity seed after deleting records in SQL Server (score [884214](https://stackoverflow.com/q/21824478) in 2016)

#### Question
I have inserted records into a SQL Server database table. The table had a primary key defined and the auto increment identity seed is set to “Yes”. This is done primarily because in SQL Azure, each table has to have a primary key and identity defined.   

But since I have to delete some records from the table, the identity seed for those tables will be disturbed and the index column (which is auto-generated with an increment of 1) will get disturbed.  

<strong>How can I reset the identity column after I deleted the records so that the column has sequence in ascending numerical order?</strong>  

The identity column is not used as a foreign key anywhere in database.  

#### Answer accepted (score 1001)
The <a href="http://technet.microsoft.com/en-us/library/ms176057.aspx" rel="noreferrer">`DBCC CHECKIDENT`</a> management command is used to reset identity counter. The command syntax is:  

```sql
DBCC CHECKIDENT (table_name [, { NORESEED | { RESEED [, new_reseed_value ]}}])
[ WITH NO_INFOMSGS ]
```

Example:   

```sql
DBCC CHECKIDENT ('[TestTable]', RESEED, 0);
GO
```

It was not supported in a previous versions of Azure SQL Database, but is supported now.  

<hr>

Please note that `new_reseed_value` argument is varied across SQL Server versions <a href="https://docs.microsoft.com/en-us/sql/t-sql/database-console-commands/dbcc-checkident-transact-sql" rel="noreferrer">according to documentation</a>:   

<blockquote>
  If rows are present in the table, the next row is inserted with the <em>new_reseed_value</em> value. In version SQL Server 2008 R2 and earlier, the next row inserted uses <em>new_reseed_value</em> + the current increment value.  
</blockquote>

However, <strong>I find this information misleading</strong> (just plain wrong actually) because observed behaviour indicates that at least SQL Server 2012 is still uses <em>new_reseed_value</em> + the current increment value logic. Microsoft even contradicts with its own `Example C` found on same page:  

<blockquote>
  C. Forcing the current identity value to a new value  
  
  <p>The following example forces the current identity value in the
  AddressTypeID column in the AddressType table to a value of 10.
  Because the table has existing rows, the next row inserted will use 11
  as the value, that is, the new current increment value defined for the
  column value plus 1.</p>
</blockquote>

```sql
USE AdventureWorks2012;  
GO  
DBCC CHECKIDENT ('Person.AddressType', RESEED, 10);  
GO
```

Still, this all leaves an option for different behaviour on newer SQL Server versions. I guess the only way to be sure, until Microsoft clear up things in its own documentation, is to do actual tests before usage.  

#### Answer 2 (score 200)
```sql
DBCC CHECKIDENT ('TestTable', RESEED, 0)
GO
```

Where 0 is `identity` Start value  

#### Answer 3 (score 80)
It should be noted that IF <em>all</em> of the data is being removed from the table via the `DELETE` (i.e. no `WHERE` clause), then as long as a) permissions allow for it, and b) there are no FKs referencing the table (which appears to be the case here), using `TRUNCATE TABLE` would be preferred as it does a more efficient `DELETE` <em>and</em> resets the `IDENTITY` seed at the same time. The following details are taken from the MSDN page for <a href="http://msdn.microsoft.com/en-us/library/ms177570.aspx" rel="noreferrer">TRUNCATE TABLE</a>:  

<blockquote>
  Compared to the DELETE statement, TRUNCATE TABLE has the following advantages:  
  
  <ul>
  <li><p>Less transaction log space is used.</p>
  
  The DELETE statement removes rows one at a time and records an entry in the transaction log for each deleted row. TRUNCATE TABLE removes the data by deallocating the data pages used to store the table data and records only the page deallocations in the transaction log.  </li>
  <li><p>Fewer locks are typically used.</p>
  
  When the DELETE statement is executed using a row lock, each row in the table is locked for deletion. TRUNCATE TABLE always locks the table (including a schema (SCH-M) lock) and page but not each row.  </li>
  <li><p>Without exception, zero pages are left in the table.</p>
  
  After a DELETE statement is executed, the table can still contain empty pages. For example, empty pages in a heap cannot be deallocated without at least an exclusive (LCK_M_X) table lock. If the delete operation does not use a table lock, the table (heap) will contain many empty pages. For indexes, the delete operation can leave empty pages behind, although these pages will be deallocated quickly by a background cleanup process.  </li>
  </ul>
  
  If the table contains an identity column, the counter for that column is reset to the seed value defined for the column. If no seed was defined, the default value 1 is used. To retain the identity counter, use DELETE instead.  
</blockquote>

So the following:  

```sql
DELETE FROM [MyTable];
DBCC CHECKIDENT ('[MyTable]', RESEED, 0);
```

Becomes just:  

```sql
TRUNCATE TABLE [MyTable];
```

Please see the `TRUNCATE TABLE` documentation (linked above) for additional information on restrictions, etc.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 51: How to create id with AUTO_INCREMENT on Oracle? (score [874399](https://stackoverflow.com/q/11296361) in 2017)

#### Question
It appears that there is no concept of AUTO_INCREMENT in Oracle, up until and including version 11g.  

How can I create a column that behaves like auto increment in Oracle 11g?  

#### Answer accepted (score 546)
There is no such thing as "auto_increment" or "identity" columns in Oracle <em>as of Oracle 11g</em>. However, you can model it easily with a sequence and a trigger:  

Table definition:  

```sql
CREATE TABLE departments (
  ID           NUMBER(10)    NOT NULL,
  DESCRIPTION  VARCHAR2(50)  NOT NULL);

ALTER TABLE departments ADD (
  CONSTRAINT dept_pk PRIMARY KEY (ID));

CREATE SEQUENCE dept_seq START WITH 1;
```

Trigger definition:  

```sql
CREATE OR REPLACE TRIGGER dept_bir 
BEFORE INSERT ON departments 
FOR EACH ROW

BEGIN
  SELECT dept_seq.NEXTVAL
  INTO   :new.id
  FROM   dual;
END;
/
```

<h5>UPDATE:</h3>

<a href="http://docs.oracle.com/database/121/DRDAA/migr_tools_feat.htm#DRDAA109" rel="noreferrer">`IDENTITY`</a> column is now available on Oracle 12c:  

```sql
create table t1 (
    c1 NUMBER GENERATED by default on null as IDENTITY,
    c2 VARCHAR2(10)
    );
```

or specify starting and increment values, also preventing any insert into the identity column (`GENERATED ALWAYS`) (again, Oracle 12c+ only)  

```sql
create table t1 (
    c1 NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
    c2 VARCHAR2(10)
    );
```

Alternatively, Oracle 12 also allows to use a sequence as a default value:  

```sql
CREATE SEQUENCE dept_seq START WITH 1;

CREATE TABLE departments (
  ID           NUMBER(10)    DEFAULT dept_seq.nextval NOT NULL,
  DESCRIPTION  VARCHAR2(50)  NOT NULL);

ALTER TABLE departments ADD (
  CONSTRAINT dept_pk PRIMARY KEY (ID));
```

#### Answer 2 (score 85)
`SYS_GUID` returns a GUID-- a globally unique ID.  A <a href="http://docs.oracle.com/cd/B12037_01/server.101/b10759/functions153.htm">`SYS_GUID`</a> is a `RAW(16)`.  It does not generate an incrementing numeric value.  

If you want to create an incrementing numeric key, you'll want to create a sequence.    

```sql
CREATE SEQUENCE name_of_sequence
  START WITH 1
  INCREMENT BY 1
  CACHE 100;
```

You would then either use that sequence in your `INSERT` statement  

```sql
INSERT INTO name_of_table( primary_key_column, <<other columns>> )
  VALUES( name_of_sequence.nextval, <<other values>> );
```

Or you can define a trigger that automatically populates the primary key value using the sequence  

```sql
CREATE OR REPLACE TRIGGER trigger_name
  BEFORE INSERT ON table_name
  FOR EACH ROW
BEGIN
  SELECT name_of_sequence.nextval
    INTO :new.primary_key_column
    FROM dual;
END;
```

If you are using Oracle 11.1 or later, you can simplify the trigger a bit  

```sql
CREATE OR REPLACE TRIGGER trigger_name
  BEFORE INSERT ON table_name
  FOR EACH ROW
BEGIN
  :new.primary_key_column := name_of_sequence.nextval;
END;
```

If you really want to use `SYS_GUID`  

```sql
CREATE TABLE table_name (
  primary_key_column raw(16) default sys_guid() primary key,
  <<other columns>>
)
```

#### Answer 3 (score 47)
In Oracle 12c onward you could do something like,  

```sql
CREATE TABLE MAPS
(
  MAP_ID INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
  MAP_NAME VARCHAR(24) NOT NULL,
  UNIQUE (MAP_ID, MAP_NAME)
);
```

<hr>

And in Oracle (Pre 12c).  

```sql
-- create table
CREATE TABLE MAPS
(
  MAP_ID INTEGER NOT NULL ,
  MAP_NAME VARCHAR(24) NOT NULL,
  UNIQUE (MAP_ID, MAP_NAME)
);

-- create sequence
CREATE SEQUENCE MAPS_SEQ;

-- create tigger using the sequence
CREATE OR REPLACE TRIGGER MAPS_TRG 
BEFORE INSERT ON MAPS 
FOR EACH ROW
WHEN (new.MAP_ID IS NULL)
BEGIN
  SELECT MAPS_SEQ.NEXTVAL
  INTO   :new.MAP_ID
  FROM   dual;
END;
/
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 52: How to turn IDENTITY_INSERT on and off using SQL Server 2008? (score [872201](https://stackoverflow.com/q/7063501) in 2013)

#### Question
Why am I getting an error doing an insert when `IDENTITY_INSERT` is set to OFF?    

How do I turn it on properly in SQL Server 2008? Is it by using SQL Server Management Studio?  

I have run this query:  

```sql
SET IDENTITY_INSERT Database. dbo. Baskets ON
```

<p>Then I got the message back in the console that the Command(s) completed successfully.
However when I run the application, it still gives me the error shown below:</p>

```sql
Cannot insert explicit value for identity column in table 'Baskets' when 
IDENTITY_INSERT is set to OFF.
```

#### Answer accepted (score 703)
Via SQL as per <a href="https://docs.microsoft.com/en-us/sql/t-sql/statements/set-identity-insert-transact-sql" rel="noreferrer">MSDN</a>  

```sql
SET IDENTITY_INSERT sometableWithIdentity ON

INSERT sometableWithIdentity (IdentityColumn, col2, col3, ...)
VALUES (AnIdentityValue, col2value, col3value, ...)

SET IDENTITY_INSERT sometableWithIdentity OFF
```

The complete error message tells you <em>exactly</em> what is wrong...  

<blockquote>
  Cannot insert explicit value for identity column in table 'sometableWithIdentity' when IDENTITY_INSERT is set to OFF.  
</blockquote>

#### Answer 2 (score 53)
I had a problem where it did not allow me to insert it even after setting the IDENTITY_INSERT ON.  

The problem was that i did not specify the column names and for some reason it did not like it.   

```sql
INSERT INTO tbl Values(vals)
```

<strong>So basically do the full INSERT INTO tbl(cols) Values(vals)</strong>  

#### Answer 3 (score 34)
<p><strong>Import:</strong>
You must write columns in `INSERT` statement</p>

```sql
INSERT INTO TABLE
SELECT * FROM    
```

Is not correct.  

```sql
Insert into Table(Field1,...)
Select (Field1,...) from TABLE
```

Is correct   

</b> </em> </i> </small> </strong> </sub> </sup>

### 53: SQL Server query - Selecting COUNT(*) with DISTINCT (score [856305](https://stackoverflow.com/q/1521605) in 2019)

#### Question
In SQL Server 2005 I have a table cm_production that lists all the code that's been put into production. The table has a ticket_number, program_type, and program_name and push_number along with some other columns.   

GOAL: Count all the DISTINCT program names by program type and push number  

What I have so far is:  

```sql
DECLARE @push_number INT;
SET @push_number = [HERE_ADD_NUMBER];

SELECT DISTINCT COUNT(*) AS Count, program_type AS [Type] 
FROM cm_production 
WHERE push_number=@push_number 
GROUP BY program_type
```

This gets me partway there, but it's counting all the program names, not the distinct ones (which I don't expect it to do in that query). I guess I just can't wrap my head around how to tell it to count only the distinct program names without selecting them. Or something.   

#### Answer accepted (score 677)
<blockquote>
  Count all the DISTINCT program names by program type and push number  
</blockquote>

```sql
SELECT COUNT(DISTINCT program_name) AS Count,
  program_type AS [Type] 
FROM cm_production 
WHERE push_number=@push_number 
GROUP BY program_type
```

`DISTINCT COUNT(*)` will return a row for each unique count. What you want is <a href="http://msdn.microsoft.com/en-us/library/ms175997.aspx" rel="noreferrer">`COUNT(DISTINCT &lt;expression&gt;)`</a>: evaluates expression for each row in a group and returns the number of unique, non-null values.  

#### Answer 2 (score 99)
<p>I needed to get the number of occurrences of each distinct value. The column contained Region info.
The simple SQL query I ended up with was:</p>

```sql
SELECT Region, count(*)
FROM item
WHERE Region is not null
GROUP BY Region
```

Which would give me a list like, say:  

```sql
Region, count
Denmark, 4
Sweden, 1
USA, 10
```

#### Answer 3 (score 35)
You have to create a derived table for the distinct columns and then query the count from that table:   

```sql
SELECT COUNT(*) 
FROM (SELECT DISTINCT column1,column2
      FROM  tablename  
      WHERE condition ) as dt
```

Here `dt` is a derived table.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 54: How do I (or can I) SELECT DISTINCT on multiple columns? (score [850430](https://stackoverflow.com/q/54418) in 2014)

#### Question
I need to retrieve all rows from a table where 2 columns combined are all different. So I want all the sales that do not have any other sales that happened on the same day for the same price. The sales that are unique based on day and price will get updated to an active status.  

So I'm thinking:  

```sql
UPDATE sales
SET status = 'ACTIVE'
WHERE id IN (SELECT DISTINCT (saleprice, saledate), id, count(id)
             FROM sales
             HAVING count = 1)
```

But my brain hurts going any farther than that.  

#### Answer accepted (score 413)
```sql
SELECT DISTINCT a,b,c FROM t
```

is <em>roughly</em> equivalent to:    

```sql
SELECT a,b,c FROM t GROUP BY a,b,c
```

It's a good idea to get used to the GROUP BY syntax, as it's more powerful.    

For your query, I'd do it like this:  

```sql
UPDATE sales
SET status='ACTIVE'
WHERE id IN
(
    SELECT id
    FROM sales S
    INNER JOIN
    (
        SELECT saleprice, saledate
        FROM sales
        GROUP BY saleprice, saledate
        HAVING COUNT(*) = 1 
    ) T
    ON S.saleprice=T.saleprice AND s.saledate=T.saledate
 )
```

#### Answer 2 (score 328)
If you put together the answers so far, clean up and improve, you would arrive at this superior query:  

```sql
UPDATE sales
SET    status = 'ACTIVE'
WHERE  (saleprice, saledate) IN (
    SELECT saleprice, saledate
    FROM   sales
    GROUP  BY saleprice, saledate
    HAVING count(*) = 1 
    );
```

Which is <em>much</em> faster than either of them. Nukes the performance of the currently accepted answer by factor 10 - 15 (in my tests on PostgreSQL 8.4 and 9.1).  

But this is still far from optimal. Use a <a href="https://www.postgresql.org/docs/current/functions-subquery.html#FUNCTIONS-SUBQUERY-EXISTS" rel="noreferrer"><strong>`NOT EXISTS`</strong></a> (anti-)semi-join for even better performance. `EXISTS` is standard SQL, has been around forever (at least since PostgreSQL 7.2, long before this question was asked) and fits the presented requirements perfectly:  

```sql
UPDATE sales s
SET    status = 'ACTIVE'
WHERE  NOT EXISTS (
   SELECT FROM sales s1                     -- SELECT list can be empty for EXISTS
   WHERE  s.saleprice = s1.saleprice
   AND    s.saledate  = s1.saledate
   AND    s.id <> s1.id                     -- except for row itself
   )
AND    s.status IS DISTINCT FROM 'ACTIVE';  -- avoid empty updates. see below
```

<p><em>db&lt;>fiddle <a href="https://dbfiddle.uk/?rdbms=postgres_11&amp;fiddle=26c7eb96c3a22330a9c271d554c869fe" rel="noreferrer">here</a></em><br>
<a href="http://sqlfiddle.com/#!17/6b5ef/1" rel="noreferrer">Old SQL Fiddle</a></p>

<h5>Unique key to identify row</h3>

If you don't have a primary or unique key for the table (`id` in the example), you can substitute with the system column `ctid` for the purpose of this query (but not for some other purposes):  

```sql
   AND    s1.ctid <> s.ctid
```

<sub>Every table should have a primary key. Add one if you didn't have one, yet. I suggest a `serial` or an `IDENTITY` column in Postgres 10+.</sub>  

Related:  

<ul>
<li><a href="https://stackoverflow.com/questions/17500013/in-order-sequence-generation/17503095#17503095">In-order sequence generation</a></li>
<li><a href="https://stackoverflow.com/questions/9875223/auto-increment-table-column/9875517#9875517">Auto increment table column</a></li>
</ul>

<h5>How is this faster?</h3>

The subquery in the `EXISTS` anti-semi-join can stop evaluating as soon as the first dupe is found (no point in looking further). For a base table with few duplicates this is only mildly more efficient. With lots of duplicates this becomes <em>way</em> more efficient.  

<h5>Exclude empty updates</h3>

For rows that already have `status = 'ACTIVE'` this update would not change anything, but still insert a new row version at full cost (minor exceptions apply). Normally, you do not want this. Add another `WHERE` condition like demonstrated above to avoid this and make it even faster:  

If `status` is defined `NOT NULL`, you can simplify to:  

```sql
AND status <> 'ACTIVE';
```

<h5>Subtle difference in NULL handling</h3>

This query (unlike the <a href="https://stackoverflow.com/a/54430/939860">currently accepted answer by Joel</a>) does not treat NULL values as equal. The following two rows for `(saleprice, saledate)` would qualify as "distinct" (though looking identical to the human eye):  

```sql
(123, NULL)
(123, NULL)
```

Also passes in a unique index and almost anywhere else, since NULL values do not compare equal according to the SQL standard. See:  

<ul>
<li><a href="https://stackoverflow.com/questions/8289100/create-unique-constraint-with-null-columns/8289253#8289253">Create unique constraint with null columns</a></li>
</ul>

OTOH, `GROUP BY`, `DISTINCT` or `DISTINCT ON ()` treat NULL values as equal. Use an appropriate query style depending on what you want to achieve. You can still use this faster query with <a href="https://www.postgresql.org/docs/current/functions-comparison.html#FUNCTIONS-COMPARISON-PRED-TABLE" rel="noreferrer">`IS NOT DISTINCT FROM`</a> instead of `=` for any or all comparisons to make NULL compare equal. More:  

<ul>
<li><a href="https://stackoverflow.com/questions/26769454/how-to-delete-duplicate-rows-without-unique-identifier/26773018#26773018">How to delete duplicate rows without unique identifier</a></li>
</ul>

If all columns being compared are defined `NOT NULL`, there is no room for disagreement.  

#### Answer 3 (score 23)
The problem with your query is that when using a GROUP BY clause (which you essentially do by using distinct) you can only use columns that you group by or aggregate functions. You cannot use the column id because there are potentially different values. In your case there is always only one value because of the HAVING clause, but most RDBMS are not smart enough to recognize that.  

This should work however (and doesn't need a join):  

```sql
UPDATE sales
SET status='ACTIVE'
WHERE id IN (
  SELECT MIN(id) FROM sales
  GROUP BY saleprice, saledate
  HAVING COUNT(id) = 1
)
```

You could also use MAX or AVG instead of MIN, it is only important to use a function that returns the value of the column if there is only one matching row.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 55: SQL update query using joins (score [847493](https://stackoverflow.com/q/982919) in 2014)

#### Question
I have to update a field with a value which is returned by a join of 3 tables.  

Example:   

```sql
select
    im.itemid
    ,im.sku as iSku
    ,gm.SKU as GSKU
    ,mm.ManufacturerId as ManuId
    ,mm.ManufacturerName
    ,im.mf_item_number
    ,mm.ManufacturerID
from 
    item_master im, group_master gm, Manufacturer_Master mm 
where
    im.mf_item_number like 'STA%'
    and im.sku=gm.sku
    and gm.ManufacturerID = mm.ManufacturerID
    and gm.manufacturerID=34
```

I want to update the `mf_item_number` field values of table `item_master` with some other value which is joined in the above condition.  

How can I do this in MS SQL Server?  

#### Answer accepted (score 1203)
```sql
UPDATE im
SET mf_item_number = gm.SKU --etc
FROM item_master im
JOIN group_master gm
    ON im.sku = gm.sku 
JOIN Manufacturer_Master mm
    ON gm.ManufacturerID = mm.ManufacturerID
WHERE im.mf_item_number like 'STA%' AND
      gm.manufacturerID = 34
```

To make it clear... The `UPDATE` clause can refer to an table alias specified in the `FROM` clause. So `im` in this case is valid  

<h5>Generic example</h3>

```sql
UPDATE A
SET foo = B.bar
FROM TableA A
JOIN TableB B
    ON A.col1 = B.colx
WHERE ...
```

#### Answer 2 (score 66)
One of the easiest way is to use a common table expression (since you're already on SQL 2005):  

```sql
with cte as (
select
    im.itemid
    ,im.sku as iSku
    ,gm.SKU as GSKU
    ,mm.ManufacturerId as ManuId
    ,mm.ManufacturerName
    ,im.mf_item_number
    ,mm.ManufacturerID
    , <your other field>
from 
    item_master im, group_master gm, Manufacturer_Master mm 
where
    im.mf_item_number like 'STA%'
    and im.sku=gm.sku
    and gm.ManufacturerID = mm.ManufacturerID
    and gm.manufacturerID=34)
update cte set mf_item_number = <your other field>
```

The query execution engine will figure out on its own how to update the record.  

#### Answer 3 (score 61)
Adapting this to MySQL -- there is no `FROM` clause in `UPDATE`, but this works:  

```sql
UPDATE
    item_master im
    JOIN
    group_master gm ON im.sku=gm.sku 
    JOIN
    Manufacturer_Master mm ON gm.ManufacturerID=mm.ManufacturerID
SET
    im.mf_item_number = gm.SKU --etc
WHERE
    im.mf_item_number like 'STA%'
    AND
    gm.manufacturerID=34
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 56: How to find third or nth maximum salary from salary table? (score [839668](https://stackoverflow.com/q/16234983) in 2015)

#### Question
How to find `third or nth` maximum salary from salary `table(EmpID,EmpName,EmpSalary)` in Optimized way?  

#### Answer accepted (score 75)
Use `ROW_NUMBER`(if you want a single) or `DENSE_RANK`(for all related rows):  

```sql
WITH CTE AS
(
    SELECT EmpID, EmpName, EmpSalary,
           RN = ROW_NUMBER() OVER (ORDER BY EmpSalary DESC)
    FROM dbo.Salary
)
SELECT EmpID, EmpName, EmpSalary
FROM CTE
WHERE RN = @NthRow
```

#### Answer 2 (score 85)
Row Number :  

```sql
SELECT Salary,EmpName
FROM
  (
   SELECT Salary,EmpName,ROW_NUMBER() OVER(ORDER BY Salary) As RowNum
   FROM EMPLOYEE
   ) As A
WHERE A.RowNum IN (2,3)
```

Sub Query :  

```sql
SELECT *
FROM Employee Emp1
WHERE (N-1) = (
               SELECT COUNT(DISTINCT(Emp2.Salary))
               FROM Employee Emp2
               WHERE Emp2.Salary > Emp1.Salary
               )
```

Top Keyword :  

```sql
SELECT TOP 1 salary
FROM (
      SELECT DISTINCT TOP n salary
      FROM employee
      ORDER BY salary DESC
      ) a
ORDER BY salary
```

#### Answer 3 (score 58)
Try this   

```sql
SELECT TOP 1 salary FROM (
   SELECT TOP 3 salary 
   FROM employees 
   ORDER BY salary DESC) AS emp 
ORDER BY salary ASC
```

For 3 you can replace any value...  

</b> </em> </i> </small> </strong> </sub> </sup>

### 57: Sql query to insert datetime in SQL Server (score [835603](https://stackoverflow.com/q/12957635) in 2018)

#### Question
I want to insert a `datetime` value into a table(SQL Server) using the sql query below  

```sql
insert into table1(approvaldate)values(18-06-12 10:34:09 AM);
```

But I get this Error msg. `Incorrect syntax near '10'.`  

I tried it with the quotes  

```sql
insert into table1(approvaldate)values('18-06-12 10:34:09 AM');
```

I get this error message `Cannot convert varchar to datetime`  

<p>Kindly help! 
Thanks.</p>

#### Answer accepted (score 203)
You will want to use the YYYYMMDD for unambiguous date determination in SQL Server.  

```sql
insert into table1(approvaldate)values('20120618 10:34:09 AM');
```

If you are married to the `dd-mm-yy hh:mm:ss xm` format, you will need to use CONVERT with the specific style.  

```sql
insert table1 (approvaldate)
       values (convert(datetime,'18-06-12 10:34:09 PM',5));
```

<strong>`5`</strong> here is the style for Italian dates.  Well, not just Italians, but that's the culture it's attributed to in <a href="http://msdn.microsoft.com/en-us/library/ms187928.aspx">Books Online</a>.  

#### Answer 2 (score 26)
A more language-independent choice for string literals is the international standard <a href="http://en.wikipedia.org/wiki/ISO_8601" rel="nofollow noreferrer">ISO 8601</a> format "YYYY-MM-DDThh:mm:ss".  I used the SQL query below to test the format, and it does indeed work in all SQL languages in <a href="http://technet.microsoft.com/en-us/library/ms190303.aspx" rel="nofollow noreferrer">sys.syslanguages</a>:  

```sql
declare @sql nvarchar(4000)

declare @LangID smallint
declare @Alias sysname

declare @MaxLangID smallint
select @MaxLangID = max(langid) from sys.syslanguages

set @LangID = 0

while @LangID <= @MaxLangID
begin

    select @Alias = alias
    from sys.syslanguages
    where langid = @LangID

    if @Alias is not null
    begin

        begin try
            set @sql = N'declare @TestLang table (langdate datetime)
    set language ''' + @alias + N''';
    insert into @TestLang (langdate)
    values (''2012-06-18T10:34:09'')'
            print 'Testing ' + @Alias

            exec sp_executesql @sql
        end try
        begin catch
            print 'Error in language ' + @Alias
            print ERROR_MESSAGE()
        end catch
    end

    select @LangID = min(langid)
    from sys.syslanguages
    where langid > @LangID
end
```

According to the <a href="http://technet.microsoft.com/en-us/library/ms180878%28v=sql.105%29.aspx#StringLiteralDateandTimeFormats" rel="nofollow noreferrer">String Literal Date and Time Formats</a> section in Microsoft TechNet, the standard ANSI Standard SQL date format "YYYY-MM-DD hh:mm:ss" is supposed to be "multi-language".  However, using the same query, the ANSI format does not work in all SQL languages.    

For example, in Danish, you will many errors like the following:  

<blockquote>
  <p>Error in language Danish
  The conversion of a varchar data type to a datetime data type resulted in an out-of-range value.</p>
</blockquote>

If you want to build a query in C# to run on SQL Server, and you need to pass a date in the ISO 8601 format, use the <a href="https://docs.microsoft.com/en-us/dotnet/standard/base-types/standard-date-and-time-format-strings" rel="nofollow noreferrer">Sortable "s" format specifier</a>:  

```sql
string.Format("select convert(datetime2, '{0:s}'", DateTime.Now);
```

#### Answer 3 (score 16)
Management studio creates scripts like:   

```sql
insert table1 (foodate) values(CAST(N'2012-06-18 10:34:09.000' AS DateTime))
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 58: How to create a table from select query result in SQL Server 2008 (score [827650](https://stackoverflow.com/q/16683758) in 2013)

#### Question
I want to create a table from select query result in SQL Server, I tried   

```sql
create table temp AS select.....
```

but I got an error   

<blockquote>
  Incorrect syntax near the keyword 'AS'  
</blockquote>

#### Answer accepted (score 313)
Use following syntax to create new table from old table in SQL server 2008  

```sql
Select * into new_table  from  old_table 
```

#### Answer 2 (score 69)
use `SELECT...INTO`  

<blockquote>
  <p><strong>The SELECT INTO statement creates a new table and populates it with
  the result set of the SELECT statement.</strong> SELECT INTO can be used to
  combine data from several tables or views into one table. It can also
  be used to create a new table that contains data selected from a
  linked server.</p>
</blockquote>

Example,  

```sql
SELECT col1, col2 INTO #a -- <<== creates temporary table
FROM   tablename
```

<ul>
<li><a href="http://msdn.microsoft.com/en-us/library/ms190750.aspx">Inserting Rows by Using SELECT INTO</a></li>
</ul>

Standard Syntax,  

```sql
SELECT  col1, ....., col@      -- <<== select as many columns as you want
        INTO [New tableName]
FROM    [Source Table Name]
```

#### Answer 3 (score 25)
<p>Please be careful,
MSSQL: `"SELECT * INTO NewTable FROM OldTable"`</p>

<p>is not always the same as 
MYSQL: `"create table temp AS select.."`</p>

<p>I think that there are occasions when this (in MSSQL)
does not guarantee that all the fields in the new table are of the same type as the old.</p>

For example :  

```sql
create table oldTable (field1 varchar(10), field2 integer, field3 float)
insert into oldTable (field1,field2,field3) values ('1', 1, 1)
select top 1 * into newTable from oldTable
```

does not always yield:  

```sql
create table newTable (field1 varchar(10), field2 integer, field3 float)
```

but may be:  

```sql
create table newTable (field1 varchar(10), field2 integer, field3 integer)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 59: How do I split a string so I can access item x? (score [817330](https://stackoverflow.com/q/2647) in 2018)

#### Question
Using SQL Server, how do I split a string so I can access item x?  

Take a string "Hello John Smith". How can I split the string by space and access the item at index 1 which should return "John"?  

#### Answer accepted (score 185)
You may find the solution in <em><a href="http://www.codeproject.com/KB/database/SQL_UDF_to_Parse_a_String.aspx" rel="noreferrer">SQL User Defined Function to Parse a Delimited String</a></em> helpful (from <a href="http://en.wikipedia.org/wiki/The_Code_Project" rel="noreferrer">The Code Project</a>).  

You can use this simple logic:  

```sql
Declare @products varchar(200) = '1|20|3|343|44|6|8765'
Declare @individual varchar(20) = null

WHILE LEN(@products) > 0
BEGIN
    IF PATINDEX('%|%', @products) > 0
    BEGIN
        SET @individual = SUBSTRING(@products,
                                    0,
                                    PATINDEX('%|%', @products))
        SELECT @individual

        SET @products = SUBSTRING(@products,
                                  LEN(@individual + '|') + 1,
                                  LEN(@products))
    END
    ELSE
    BEGIN
        SET @individual = @products
        SET @products = NULL
        SELECT @individual
    END
END
```

#### Answer 2 (score 352)
I don't believe SQL Server has a built-in split function, so other than a UDF, the only other answer I know is to hijack the PARSENAME function:  

```sql
SELECT PARSENAME(REPLACE('Hello John Smith', ' ', '.'), 2) 
```

PARSENAME takes a string and splits it on the period character.  It takes a number as its second argument, and that number specifies which segment of the string to return (working from back to front).  

```sql
SELECT PARSENAME(REPLACE('Hello John Smith', ' ', '.'), 3)  --return Hello
```

Obvious problem is when the string already contains a period.  I still think using a UDF is the best way...any other suggestions?  

#### Answer 3 (score 108)
First, create a function (using CTE, common table expression does away with the need for a temp table)   

```sql
 create function dbo.SplitString 
    (
        @str nvarchar(4000), 
        @separator char(1)
    )
    returns table
    AS
    return (
        with tokens(p, a, b) AS (
            select 
                1, 
                1, 
                charindex(@separator, @str)
            union all
            select
                p + 1, 
                b + 1, 
                charindex(@separator, @str, b + 1)
            from tokens
            where b > 0
        )
        select
            p-1 zeroBasedOccurance,
            substring(
                @str, 
                a, 
                case when b > 0 then b-a ELSE 4000 end) 
            AS s
        from tokens
      )
    GO
```

Then, use it as any table (or modify it to fit within your existing stored proc) like this.   

```sql
select s 
from dbo.SplitString('Hello John Smith', ' ')
where zeroBasedOccurance=1
```

<strong>Update</strong>  

Previous version would fail for input string longer than 4000 chars. This version takes care of the limitation:  

```sql
create function dbo.SplitString 
(
    @str nvarchar(max), 
    @separator char(1)
)
returns table
AS
return (
with tokens(p, a, b) AS (
    select 
        cast(1 as bigint), 
        cast(1 as bigint), 
        charindex(@separator, @str)
    union all
    select
        p + 1, 
        b + 1, 
        charindex(@separator, @str, b + 1)
    from tokens
    where b > 0
)
select
    p-1 ItemIndex,
    substring(
        @str, 
        a, 
        case when b > 0 then b-a ELSE LEN(@str) end) 
    AS s
from tokens
);

GO
```

Usage remains the same.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 60: Copy tables from one database to another in SQL Server (score [814936](https://stackoverflow.com/q/187770) in 2013)

#### Question
I have a database called foo and a database called bar. I have a table in foo called tblFoobar that I want to move (data and all) to database bar from database foo. What is the SQL statement to do this?  

#### Answer accepted (score 204)
On SQL Server? and on the same database server? Use three part naming.  

```sql
INSERT INTO bar..tblFoobar( *fieldlist* )
SELECT *fieldlist* FROM foo..tblFoobar
```

This just moves the data.  If you want to move the table definition (and other attributes such as permissions and indexes), you'll have to do something else.  

#### Answer 2 (score 531)
SQL Server Management Studio's "Import Data" task (right-click on the DB name, then tasks) will do most of this for you.  Run it from the database you want to copy the data into.  

If the tables don't exist it will create them for you, but you'll probably have to recreate any indexes and such.  If the tables do exist, it will append the new data by default but you can adjust that (edit mappings) so it will delete all existing data.  

I use this all the time and it works fairly well.  

#### Answer 3 (score 102)
This should work:  

```sql
SELECT * 
INTO DestinationDB..MyDestinationTable 
FROM SourceDB..MySourceTable 
```

It will <strong>not</strong> copy constaints, defaults or indexes. The table created will <strong>not</strong> have a clustered index.  

Alternatively you could:    

```sql
INSERT INTO DestinationDB..MyDestinationTable 
SELECT * FROM SourceDB..MySourceTable
```

If your destination table exists and is empty.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 61: SQL Server - SELECT FROM stored procedure (score [813645](https://stackoverflow.com/q/1492411) in 2012)

#### Question
I have a stored procedure that returns rows:  

```sql
CREATE PROCEDURE MyProc
AS
BEGIN
    SELECT * FROM MyTable
END
```

My actual procedure is a little more complicated, which is why a sproc is necessary.  

Is it possible to select the output by calling this procedure?  

Something like:  

```sql
SELECT * FROM (EXEC MyProc) AS TEMP
```

I need to use `SELECT TOP X`, `ROW_NUMBER`, and an additional `WHERE` clause to page my data, and I don't really want to pass these values as parameters.  

#### Answer accepted (score 143)
You can use a <a href="https://docs.microsoft.com/en-us/sql/relational-databases/user-defined-functions/user-defined-functions" rel="noreferrer">User-defined function</a> or a <a href="https://docs.microsoft.com/en-us/sql/relational-databases/views/views" rel="noreferrer">view</a> instead of a procedure.  

A procedure can return multiple result sets, each with its own schema. It's not suitable for using in a `SELECT` statement.  

#### Answer 2 (score 171)
You can   

<ol>
<li>create a table variable to hold the
result set from the stored proc and
then  </li>
<li>insert the output of the
    stored proc into the table variable,
    and then  </li>
<li>use the table variable
        exactly as you would any other
        table...</li>
</ol>

... sql ....  

```sql
Declare @T Table ([column definitions here])
Insert @T Exec storedProcname params 
Select * from @T Where ...
```

#### Answer 3 (score 156)
You should look at this excellent article by Erland Sommarskog:  

<ul>
<li><a href="http://www.sommarskog.se/share_data.html" rel="noreferrer">How to Share Data Between Stored Procedure</a></li>
</ul>

It basically lists all available options for your scenario.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 62: Adding an identity to an existing column (score [807332](https://stackoverflow.com/q/1049210) in 2011)

#### Question
I need to change the primary key of a table to an identity column, and there's already a number of rows in table.   

I've got a script to clean up the IDs to ensure they're sequential starting at 1, works fine on my test database.   

What's the SQL command to alter the column to have an identity property?  

#### Answer accepted (score 450)
You can't alter the existing columns for identity.  

You have 2 options,  

<ol>
<li><p>Create a new table with identity &amp; drop the existing table</p></li>
<li><p>Create a new column with identity &amp; drop the existing column</p></li>
</ol>

Approach 1. (<em>New table</em>) Here you can retain the existing data values on the newly created identity column.  

```sql
CREATE TABLE dbo.Tmp_Names
    (
      Id int NOT NULL
             IDENTITY(1, 1),
      Name varchar(50) NULL
    )
ON  [PRIMARY]
go

SET IDENTITY_INSERT dbo.Tmp_Names ON
go

IF EXISTS ( SELECT  *
            FROM    dbo.Names ) 
    INSERT  INTO dbo.Tmp_Names ( Id, Name )
            SELECT  Id,
                    Name
            FROM    dbo.Names TABLOCKX
go

SET IDENTITY_INSERT dbo.Tmp_Names OFF
go

DROP TABLE dbo.Names
go

Exec sp_rename 'Tmp_Names', 'Names'
```

Approach 2 (<em>New column</em>) You can’t retain the existing data values on the newly created identity column, The identity column will hold the sequence of number.  

```sql
Alter Table Names
Add Id_new Int Identity(1, 1)
Go

Alter Table Names Drop Column ID
Go

Exec sp_rename 'Names.Id_new', 'ID', 'Column'
```

See the following Microsoft SQL Server Forum post for more details:  

<a href="http://social.msdn.microsoft.com/forums/en-US/transactsql/thread/04d69ee6-d4f5-4f8f-a115-d89f7bcbc032" rel="noreferrer">How to alter column to identity(1,1)</a>  

#### Answer 2 (score 197)
In SQL 2005 and above, there's a trick to solve this problem without changing the table's data pages. This is important for large tables where touching every data page can take minutes or hours.  The trick also works even if the identity column is a primary key, is part of a clustered or non-clustered index, or other gotchas which can trip up the the simpler "add/remove/rename column" solution.   

Here's the trick: you can use SQL Server's <a href="https://docs.microsoft.com/en-us/sql/t-sql/statements/alter-table-transact-sql" rel="noreferrer">ALTER TABLE...SWITCH</a> statement to change the schema of a table without changing the data, meaning you can replace a table with an IDENTITY with an identical table schema, but without an IDENTITY column.  The same trick works to add IDENTITY to an existing column.  

Normally, <a href="https://docs.microsoft.com/en-us/sql/t-sql/statements/alter-table-transact-sql" rel="noreferrer">ALTER TABLE...SWITCH</a> is used to efficiently replace a full partition in a partitioned table with a new, empty partition.  But it can also be used in non-partitioned tables too.  

I've used this trick to convert, in under 5 seconds, a column of a of a 2.5 billion row table from IDENTITY to a non-IDENTITY (in order to run a multi-hour query whose query plan worked better for non-IDENTITY columns), and then restored the IDENTITY setting, again in less than 5 seconds.  

Here's a code sample of how it works.   

```sql
 CREATE TABLE Test
 (
   id int identity(1,1),
   somecolumn varchar(10)
 );

 INSERT INTO Test VALUES ('Hello');
 INSERT INTO Test VALUES ('World');

 -- copy the table. use same schema, but no identity
 CREATE TABLE Test2
 (
   id int NOT NULL,
   somecolumn varchar(10)
 );

 ALTER TABLE Test SWITCH TO Test2;

 -- drop the original (now empty) table
 DROP TABLE Test;

 -- rename new table to old table's name
 EXEC sp_rename 'Test2','Test';

 -- update the identity seed
 DBCC CHECKIDENT('Test');

 -- see same records
 SELECT * FROM Test; 
```

This is obviously more involved than the solutions in other answers, but if your table is large this can be a real life-saver.  There are some caveats:  

<ul>
<li>As far as I know, identity is the only thing you can change about your table's columns with this method. Adding/removing columns, changing nullability, etc. isn't allowed. </li>
<li>You'll need to drop foriegn keys before you do the switch and restore them after.</li>
<li>Same for WITH SCHEMABINDING functions, views, etc. </li>
<li>new table's indexes need to match exactly (same columns, same order, etc.)</li>
<li>Old and new tables need to be on the same filegroup.</li>
<li>Only works on SQL Server 2005 or later</li>
<li>I previously believed that this trick only works on the Enterprise or Developer editions of SQL Server (because partitions are only supported in Enterprise and Developer versions), but Mason G. Zhwiti in his comment below says that it also works in SQL Standard Edition too.  I assume this means that the restriction to Enterprise or Developer doesn't apply to ALTER TABLE...SWITCH.</li>
</ul>

There's a good <a href="https://technet.microsoft.com/en-us/library/ms191160.aspx" rel="noreferrer">article on TechNet</a> detailing the requirements above.  

UPDATE - <a href="https://stackoverflow.com/users/2713582/eric-wu">Eric Wu</a> had a comment below that adds important info about this solution. Copying it here to make sure it gets more attention:   

<blockquote>
  <p>There's another caveat here that is worth mentioning. Although the
  new table will happily receive data from the old table, and all the
  new rows will be inserted following a identity pattern, they will
  start at 1 and potentially break if the said column is a primary key.
  Consider running `DBCC CHECKIDENT('&lt;newTableName&gt;')` immediately after
  switching. See <a href="http://msdn.microsoft.com/en-us/library/ms176057.aspx" rel="noreferrer">msdn.microsoft.com/en-us/library/ms176057.aspx</a> for more
  info.</p>
</blockquote>

If the table is actively being extended with new rows (meaning you don't have much if any downtime between adding IDENTITY and adding new rows, then instead of `DBCC CHECKIDENT` you'll want to manually set the identity seed value in the new table schema to be larger than the largest existing ID in the table, e.g. `IDENTITY (2435457, 1)`. You might be able to include both the `ALTER TABLE...SWITCH` and the `DBCC CHECKIDENT` in a transaction (or not-- haven't tested this) but seems like setting the seed value manually will be easier and safer.   

Obviously, if no new rows are being added to the table (or they're only added occasionally, like a daily ETL process) then this race condition won't happen so `DBCC CHECKIDENT` is fine.   

#### Answer 3 (score 66)
You cannot alter a column to be an IDENTITY column. What you'll need to do is create a new column which is defined as an IDENTITY from the get-go, then drop the old column, and rename the new one to the old name.  

```sql
ALTER TABLE (yourTable) ADD NewColumn INT IDENTITY(1,1)

ALTER TABLE (yourTable) DROP COLUMN OldColumnName

EXEC sp_rename 'yourTable.NewColumn', 'OldColumnName', 'COLUMN'
```

Marc  

</b> </em> </i> </small> </strong> </sub> </sup>

### 63: How does database indexing work? (score [804940](https://stackoverflow.com/q/1108) in 2018)

#### Question
Given that indexing is so important as your data set increases in size, can someone explain how indexing works at a database-agnostic level?  

For information on queries to index a field, check out <a href="https://stackoverflow.com/questions/1156/">How do I index a database column</a>.  

#### Answer accepted (score 3385)
<strong>Why is it needed?</strong>  

When data is stored on disk-based storage devices, it is stored as blocks of data. These blocks are accessed in their entirety, making them the atomic disk access operation. Disk blocks are structured in much the same way as linked lists; both contain a section for data, a pointer to the location of the next node (or block), and both need not be stored contiguously.  

Due to the fact that a number of records can only be sorted on one field, we can state that searching on a field that isn’t sorted requires a Linear Search which requires `N/2` block accesses (on average), where `N` is the number of blocks that the table spans. If that field is a non-key field (i.e. doesn’t contain unique entries) then the entire tablespace must be searched at `N` block accesses.  

Whereas with a sorted field, a Binary Search may be used, which has `log2 N` block accesses. Also since the data is sorted given a non-key field, the rest of the table doesn’t need to be searched for duplicate values, once a higher value is found. Thus the performance increase is substantial.  

<strong>What is indexing?</strong>  

Indexing is a way of sorting a number of records on multiple fields. Creating an index on a field in a table creates another data structure which holds the field value, and a pointer to the record it relates to. This index structure is then sorted, allowing Binary Searches to be performed on it.  

The downside to indexing is that these indices require additional space on the disk since the indices are stored together in a table using the MyISAM engine, this file can quickly reach the size limits of the underlying file system if many fields within the same table are indexed.  

<strong>How does it work?</strong>  

Firstly, let’s outline a sample database table schema;   

<pre>
Field name       Data type      Size on disk
id (Primary key) Unsigned INT   4 bytes
firstName        Char(50)       50 bytes
lastName         Char(50)       50 bytes
emailAddress     Char(100)      100 bytes
</pre>

<p><strong>Note</strong>: char was used in place of varchar to allow for an accurate size on disk value. 
This sample database contains five million rows and is unindexed. The performance of several queries will now be analyzed. These are a query using the <em>id</em> (a sorted key field) and one using the <em>firstName</em> (a non-key unsorted field).</p>

<strong><em>Example 1</em></strong> - <em>sorted vs unsorted fields</em>  

Given our sample database of `r = 5,000,000` records of a fixed size giving a record length of `R = 204` bytes and they are stored in a table using the MyISAM engine which is using the default block size `B = 1,024` bytes. The blocking factor of the table would be `bfr = (B/R) = 1024/204 = 5` records per disk block. The total number of blocks required to hold the table is `N = (r/bfr) = 5000000/5 = 1,000,000` blocks.   

A linear search on the id field would require an average of `N/2 = 500,000` block accesses to find a value, given that the id field is a key field. But since the id field is also sorted, a binary search can be conducted requiring an average of `log2 1000000 = 19.93 = 20` block accesses. Instantly we can see this is a drastic improvement.  

Now the <em>firstName</em> field is neither sorted nor a key field, so a binary search is impossible, nor are the values unique, and thus the table will require searching to the end for an exact `N = 1,000,000` block accesses. It is this situation that indexing aims to correct.  

Given that an index record contains only the indexed field and a pointer to the original record, it stands to reason that it will be smaller than the multi-field record that it points to. So the index itself requires fewer disk blocks than the original table, which therefore requires fewer block accesses to iterate through. The schema for an index on the <em>firstName</em> field is outlined below;   

<pre>
Field name       Data type      Size on disk
firstName        Char(50)       50 bytes
(record pointer) Special        4 bytes
</pre>

<strong>Note</strong>: Pointers in MySQL are 2, 3, 4 or 5 bytes in length depending on the size of the table.  

<strong><em>Example 2</em></strong>  - <em>indexing</em>  

Given our sample database of `r = 5,000,000` records with an index record length of `R = 54` bytes and using the default block size `B = 1,024` bytes. The blocking factor of the index would be `bfr = (B/R) = 1024/54 = 18` records per disk block. The total number of blocks required to hold the index is `N = (r/bfr) = 5000000/18 = 277,778` blocks.  

Now a search using the <em>firstName</em> field can utilize the index to increase performance. This allows for a binary search of the index with an average of `log2 277778 = 18.08 = 19` block accesses. To find the address of the actual record, which requires a further block access to read, bringing the total to `19 + 1 = 20` block accesses, a far cry from the 1,000,000 block accesses required to find a <em>firstName</em> match in the non-indexed table.  

<strong>When should it be used?</strong>  

Given that creating an index requires additional disk space (277,778 blocks extra from the above example, a ~28% increase), and that too many indices can cause issues arising from the file systems size limits, careful thought must be used to select the correct fields to index.  

Since indices are only used to speed up the searching for a matching field within the records, it stands to reason that indexing fields used only for output would be simply a waste of disk space and processing time when doing an insert or delete operation, and thus should be avoided. Also given the nature of a binary search, the cardinality or uniqueness of the data is important. Indexing on a field with a cardinality of 2 would split the data in half, whereas a cardinality of 1,000 would return approximately 1,000 records. With such a low cardinality the effectiveness is reduced to a linear sort, and the query optimizer will avoid using the index if the cardinality is less than 30% of the record number, effectively making the index a waste of space.  

#### Answer 2 (score 232)
The first time I read this it was very helpful to me. Thank you.  

<p>Since then I gained some insight about the downside of creating indexes:
if you write into a table (`UPDATE` or `INSERT`) with one index, you have actually two writing operations in the file system. One for the table data and another one for the index data (and the resorting of it (and - if clustered - the resorting of the table data)). If table and index are located on the same hard disk this costs more time. Thus a table without an index (a heap) , would allow for quicker write operations. (if you had two indexes you would end up with three write operations, and so on)</p>

However, defining two different locations on two different hard disks for index data and table data can decrease/eliminate the problem of increased cost of time. This requires definition of additional file groups with according files on the desired hard disks and definition of table/index location as desired.  

Another problem with indexes is their fragmentation over time as data is inserted. `REORGANIZE` helps, you must write routines to have it done.  

In certain scenarios a heap is more helpful than a table with indexes,   

e.g:- If you have lots of rivalling writes but only one nightly read outside business hours for reporting.  

Also, a differentiation between clustered and non-clustered indexes is rather important.   

Helped me:- <a href="https://stackoverflow.com/questions/1251636/what-do-clustered-and-non-clustered-index-actually-mean">What do Clustered and Non clustered index actually mean?</a>  

#### Answer 3 (score 221)
Classic example <strong>"Index in Books"</strong>  

Consider a "Book" of 1000 pages, divided by 100 sections, each section with X pages.  

Simple, huh?  

Now, without an index page, to find a particular section that starts with letter "S", you have no other option than scanning through the entire book. i.e: 1000 pages  

But with an index page at the beginning, you are there. And more, to read any particular section that matters, you just need to look over the index page, again and again, every time. After finding the matching index you can efficiently jump to the section by skipping other sections.  

But then, in addition to 1000 pages, you will need another ~10 pages to display the index page, so totally 1010 pages.  

Thus, the index is a separate section that stores values of indexed column + pointer to the indexed row in a sorted order for efficient look-ups.  

Things are simple in schools, isn't it? :P  

</b> </em> </i> </small> </strong> </sub> </sup>

### 64: SQL/mysql - Select distinct/UNIQUE but return all columns? (score [797787](https://stackoverflow.com/q/6127338) in 2015)

#### Question
```sql
SELECT DISTINCT field1, field2, field3, ......   FROM table
```

I am trying to accomplish the following sql statement but I want it to return all columns is this possible? Something like:  

```sql
SELECT DISTINCT field1, * from table
```

#### Answer accepted (score 375)
You're looking for a group by:  

```sql
select *
from table
group by field1
```

Which can occasionally be written with a distinct on statement:  

```sql
select distinct on field1 *
from table
```

On most platforms, however, neither of the above will work because the behavior on the other columns is unspecified. (The first works in MySQL, if that's what you're using.)  

You could fetch the distinct fields and stick to picking a single arbitrary row each time.  

On some platforms (e.g. PostgreSQL, Oracle, T-SQL) this can be done directly using window functions:  

```sql
select *
from (
   select *,
          row_number() over (partition by field1 order by field2) as row_number
   from table
   ) as rows
where row_number = 1
```

On others (MySQL, SQLite), you'll need to write subqueries that will make you join the entire table with itself (<a href="https://stackoverflow.com/questions/6109894/how-to-efficiently-determine-changes-between-rows-using-sql/6110200#6110200">example</a>), so not recommended.  

#### Answer 2 (score 56)
From the phrasing of your question, I understand that you want to select the distinct values for a given field and for each such value to have all the other column values in the same row listed. Most DBMSs will not allow this with neither `DISTINCT` nor `GROUP BY`, because the result is not determined.  

Think of it like this: if your `field1` occurs more than once, what value of `field2` will be listed (given that you have the same value for `field1` in two rows but two distinct values of `field2` in those two rows).  

You can however use aggregate functions (explicitely for every field that you want to be shown) and using a `GROUP BY` instead of `DISTINCT`:  

```sql
SELECT field1, MAX(field2), COUNT(field3), SUM(field4), .... FROM table GROUP BY field1
```

#### Answer 3 (score 21)
If I understood your problem correctly, it's similar to one I just had. You want to be able limit the usability of DISTINCT to a specified field, rather than applying it to all the data.   

If you use GROUP BY without an aggregate function, which ever field you GROUP BY will be your DISTINCT filed.   

If you make your query:  

```sql
SELECT * from table GROUP BY field1;
```

It will show all your results based on a single instance of field1.  

For example, if you have a table with name, address and city. A single person has multiple addresses recorded, but you just want a single address for the person, you can query as follows:  

```sql
SELECT * FROM persons GROUP BY name;
```

The result will be that only one instance of that name will appear with its address, and the other one will be omitted from the resulting table. Caution: if your fileds have atomic values such as firstName, lastName you want to group by both.  

```sql
SELECT * FROM persons GROUP BY lastName, firstName;
```

because if two people have the same last name and you only group by lastName, one of those persons will be omitted from the results. You need to keep those things into consideration. Hope this helps.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 65: SQL WITH clause example (score [797102](https://stackoverflow.com/q/12552288) in 2017)

#### Question
<blockquote>
  <p><strong>Possible Duplicate:</strong><br>
  <a href="https://stackoverflow.com/questions/706972/difference-between-cte-and-subquery">Difference between CTE and SubQuery?</a>  </p>
</blockquote>



I was trying to understand how to use the `WITH` clause and the purpose of the `WITH` clause.  

All I understood was, the `WITH` clause was a replacement for normal sub-queries.  

Can anyone explain this to me with a small example in detail ?  

#### Answer 2 (score 235)
The SQL WITH clause was introduced by Oracle in the Oracle 9i release 2 database. The SQL WITH clause allows you to give a sub-query block a name (a process also called sub-query refactoring), which can be referenced in several places within the main SQL query. The name assigned to the sub-query is treated as though it was an inline view or table. The SQL WITH clause is basically a drop-in replacement to the normal sub-query.  

Syntax For The SQL WITH Clause  

The following is the syntax of the SQL WITH clause when using a single sub-query alias.  

```sql
WITH <alias_name> AS (sql_subquery_statement)
SELECT column_list FROM <alias_name>[,table_name]
[WHERE <join_condition>]
```

When using multiple sub-query aliases, the syntax is as follows.  

```sql
WITH <alias_name_A> AS (sql_subquery_statement),
<alias_name_B> AS(sql_subquery_statement_from_alias_name_A
or sql_subquery_statement )
SELECT <column_list>
FROM <alias_name_A>, <alias_name_B> [,table_names]
[WHERE <join_condition>]
```

In the syntax documentation above, the occurrences of `alias_name` is a meaningful name you would give to the sub-query after the AS clause. Each sub-query should be separated with a comma <a href="http://docs.oracle.com/cd/B19306_01/server.102/b14200/img_text/subquery_factoring_clause.htm" rel="noreferrer">Example for WITH statement</a>. The rest of the queries follow the standard formats for simple and complex SQL SELECT queries.  

For more information: <a href="http://www.brighthub.com/internet/web-development/articles/91893.aspx" rel="noreferrer">http://www.brighthub.com/internet/web-development/articles/91893.aspx</a>  

#### Answer 3 (score 84)
This has been fully answered <a href="https://stackoverflow.com/questions/324935/mysql-with-clause">here</a>.   

See <a href="http://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_10002.htm#i2161315" rel="noreferrer">Oracle's docs on SELECT</a> to see how subquery factoring works, and Mark's example:  

```sql
WITH employee AS (SELECT * FROM Employees)
SELECT * FROM employee WHERE ID < 20
UNION ALL
SELECT * FROM employee WHERE Sex = 'M'
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 66: How do I restore a dump file from mysqldump? (score [793050](https://stackoverflow.com/q/105776) in 2018)

#### Question
I was given a MySQL database file that I need to restore as a database on my Windows Server 2008 machine.  

I tried using MySQL Administrator, but I got the following error:  

<blockquote>
  <p>The selected file was generated by
  mysqldump and cannot be restored by
  this application.</p>
</blockquote>

How do I get this working?  

#### Answer accepted (score 561)
It should be as simple as running this:   

```sql
mysql -u <user> -p < db_backup.dump
```

If the dump is of a single database you may have to add a line at the top of the file:  

```sql
USE <database-name-here>;
```

If it was a dump of many databases, the use statements are already in there.  

To run these commands, open up a command prompt (in Windows) and `cd` to the directory where the `mysql.exe` executable is (you may have to look around a bit for it, it'll depend on how you installed mysql, i.e. standalone or as part of a package like WAMP).  Once you're in that directory, you should be able to just type the command as I have it above.  

#### Answer 2 (score 697)
If the database you want to restore doesn't already exist, you need to create it first.  

On the command-line, if you're in the same directory that contains the dumped file, use these commands (with appropriate substitutions):  

```sql
C:\> mysql -u root -p

mysql> create database mydb;
mysql> use mydb;
mysql> source db_backup.dump;
```

#### Answer 3 (score 232)
You simply need to run this:  

```sql
mysql -p -u[user] [database] < db_backup.dump
```

If the dump contains multiple databases you should omit the database name:  

```sql
mysql -p -u[user] < db_backup.dump
```

To run these commands, open up a command prompt (in Windows) and `cd` to the directory where the `mysql.exe` executable is (you may have to look around a bit for it, it'll depend on how you installed mysql, i.e. standalone or as part of a package like WAMP). Once you're in that directory, you should be able to just type the command.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 67: How do I use ROW_NUMBER()? (score [792545](https://stackoverflow.com/q/961007) in 2013)

#### Question
I want to use the `ROW_NUMBER()` to get...  

<ol>
<li>To get the `max(ROW_NUMBER())` --> Or i guess this would also be the count of all rows</li>
</ol>

I tried doing:  

```sql
SELECT max(ROW_NUMBER() OVER(ORDER BY UserId)) FROM Users
```

but it didn't seem to work...  

<ol start="2">
<li>To get `ROW_NUMBER()` using a given piece of information, ie. if I have a name and I want to know what row the name came from.</li>
</ol>

I assume it would be something similar to what I tried for #1  

```sql
SELECT ROW_NUMBER() OVER(ORDER BY UserId) From Users WHERE UserName='Joe'
```

but this didn't work either...  

Any Ideas?  

#### Answer 2 (score 138)
For the first question, why not just use?  

```sql
SELECT COUNT(*) FROM myTable 
```

to get the count.  

And for the second question, the primary key of the row is what should be used to identify a particular row.  Don't try and use the row number for that.  

<hr>

If you returned Row_Number() in your main query,  

```sql
SELECT ROW_NUMBER() OVER (Order by Id) AS RowNumber, Field1, Field2, Field3
FROM User
```

Then when you want to go 5 rows back then you can take the current row number and use the following query to determine the row with currentrow -5  

```sql
SELECT us.Id
FROM (SELECT ROW_NUMBER() OVER (ORDER BY id) AS Row, Id
     FROM User ) us 
WHERE Row = CurrentRow - 5   
```

#### Answer 3 (score 41)
Though I agree with others that you could use `count()` to get the total number of rows, here is how you can use the `row_count()`:  

<ol>
<li><p>To get the total no of rows:</p>

```sql
with temp as (
    select row_number() over (order by id) as rownum
    from table_name 
)
select max(rownum) from temp```</li>
<li><p>To get the row numbers where name is Matt:</p>

```sql
with temp as (
    select name, row_number() over (order by id) as rownum
    from table_name
)
select rownum from temp where name like 'Matt'```</li>
</ol>

You can further use `min(rownum)` or `max(rownum)` to get the first or last row for Matt respectively.  

These were very simple implementations of `row_number()`. You can use it for more complex grouping. Check out my response on <a href="https://stackoverflow.com/questions/968305/advanced-grouping-without-using-a-sub-query/968983#968983">Advanced grouping without using a sub query</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 68: SQL - Rounding off to 2 decimal places (score [791521](https://stackoverflow.com/q/10380197) in 2012)

#### Question
I need to convert minutes to hours, rounded off to 2 decimal places.I also need to display only up to 2 numbers after the decimal point. So if I have minutes as 650.Then hours should be 10.83  

Here's what I have so far:  

```sql
Select round(Minutes/60.0,2) from ....
```

But in this case, if my minutes is, say,630 - hours is 10.5000000. But I want it as 10.50 only(after rounding). How do I achieve this?  

#### Answer accepted (score 363)
Could you not cast your result as `numeric(x,2)`? Where `x &lt;= 38`  

```sql
select 
    round(630/60.0,2), 
    cast(round(630/60.0,2) as numeric(36,2))
```

Returns  

```sql
10.500000   10.50
```

#### Answer 2 (score 73)
As with SQL Server 2012, you can use the built-in <a href="http://msdn.microsoft.com/en-us/library/hh213505.aspx" rel="noreferrer">format function</a>:  

```sql
SELECT FORMAT(Minutes/60.0, 'N2')
```

(just for further readings...)  

#### Answer 3 (score 23)
you can use   

```sql
select cast((630/60.0) as  decimal(16,2))
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 69: SQL multiple column ordering (score [790109](https://stackoverflow.com/q/2051162) in 2015)

#### Question
I am trying to sort by multiple columns in SQL, and in different directions. `column1` would be sorted descending, and `column2` ascending.  

How can I do this?  

#### Answer accepted (score 948)
```sql
ORDER BY column1 DESC, column2
```

This sorts everything by `column1` (descending) first, and then by `column2` (ascending, which is the default) whenever the `column1` fields for two or more rows are equal.  

#### Answer 2 (score 328)
The other answers lack a concrete example, so here it goes:  

Given the following <strong>People</strong> table:  

```sql
 FirstName |  LastName   |  YearOfBirth
----------------------------------------
  Thomas   | Alva Edison |   1847
  Benjamin | Franklin    |   1706
  Thomas   | More        |   1478
  Thomas   | Jefferson   |   1826
```

If you execute the query below:  

```sql
SELECT * FROM People ORDER BY FirstName DESC, YearOfBirth ASC
```

The result set will look like this:  

```sql
 FirstName |  LastName   |  YearOfBirth
----------------------------------------
  Thomas   | More        |   1478
  Thomas   | Jefferson   |   1826
  Thomas   | Alva Edison |   1847
  Benjamin | Franklin    |   1706
```

#### Answer 3 (score 132)
```sql
SELECT  *
FROM    mytable
ORDER BY
        column1 DESC, column2 ASC
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 70: Efficiently convert rows to columns in sql server (score [785265](https://stackoverflow.com/q/15745042) in 2018)

#### Question
I'm looking for an efficient way to convert rows to columns in SQL server, I heard that PIVOT is not very fast, and I need to deal with lot of records.  

This is my example:  

```sql
   -------------------------------
   | Id | Value  | ColumnName    |
   -------------------------------
   | 1  | John   | FirstName     |
   | 2  | 2.4    | Amount        |
   | 3  | ZH1E4A | PostalCode    |
   | 4  | Fork   | LastName      |
   | 5  | 857685 | AccountNumber |
   -------------------------------
```

This is my result:  

```sql
---------------------------------------------------------------------
| FirstName  |Amount|   PostalCode   |   LastName  |  AccountNumber |
---------------------------------------------------------------------
| John       | 2.4  |   ZH1E4A       |   Fork      |  857685        |
---------------------------------------------------------------------
```

How can I build the result?  

#### Answer accepted (score 495)
There are several ways that you can transform data from multiple rows into columns.  

<h5>Using `PIVOT`</h2>

In SQL Server you can use the `PIVOT` function to transform the data from rows to columns:  

```sql
select Firstname, Amount, PostalCode, LastName, AccountNumber
from
(
  select value, columnname
  from yourtable
) d
pivot
(
  max(value)
  for columnname in (Firstname, Amount, PostalCode, LastName, AccountNumber)
) piv;
```

See <a href="https://data.stackexchange.com/stackoverflow/query/497432" rel="noreferrer">Demo</a>.  

<h5>Pivot with unknown number of `columnnames`</h3>

If you have an unknown number of `columnnames` that you want to transpose, then you can use dynamic SQL:  

```sql
DECLARE @cols AS NVARCHAR(MAX),
    @query  AS NVARCHAR(MAX)

select @cols = STUFF((SELECT ',' + QUOTENAME(ColumnName) 
                    from yourtable
                    group by ColumnName, id
                    order by id
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')

set @query = N'SELECT ' + @cols + N' from 
             (
                select value, ColumnName
                from yourtable
            ) x
            pivot 
            (
                max(value)
                for ColumnName in (' + @cols + N')
            ) p '

exec sp_executesql @query;
```

See <a href="https://data.stackexchange.com/stackoverflow/query/497433" rel="noreferrer">Demo</a>.  

<h5>Using an aggregate function</h2>

If you do not want to use the `PIVOT` function, then you can use an aggregate function with a `CASE` expression:  

```sql
select
  max(case when columnname = 'FirstName' then value end) Firstname,
  max(case when columnname = 'Amount' then value end) Amount,
  max(case when columnname = 'PostalCode' then value end) PostalCode,
  max(case when columnname = 'LastName' then value end) LastName,
  max(case when columnname = 'AccountNumber' then value end) AccountNumber
from yourtable
```

See <a href="https://data.stackexchange.com/stackoverflow/query/497434" rel="noreferrer">Demo</a>.  

<h5>Using multiple joins</h2>

This could also be completed using multiple joins, but you will need some column to associate each of the rows which you do not have in your sample data. But the basic syntax would be:  

```sql
select fn.value as FirstName,
  a.value as Amount,
  pc.value as PostalCode,
  ln.value as LastName,
  an.value as AccountNumber
from yourtable fn
left join yourtable a
  on fn.somecol = a.somecol
  and a.columnname = 'Amount'
left join yourtable pc
  on fn.somecol = pc.somecol
  and pc.columnname = 'PostalCode'
left join yourtable ln
  on fn.somecol = ln.somecol
  and ln.columnname = 'LastName'
left join yourtable an
  on fn.somecol = an.somecol
  and an.columnname = 'AccountNumber'
where fn.columnname = 'Firstname'
```

#### Answer 2 (score 9)
<p>as pivoting data is still a hot one I decided to add something form me. This is rather a method than just a single script but gives you much more possibilities. First of all There are 3 scripts you need to deploy:
1) User defined TABLE type [`ColumnActionList`] -> holds data as parameter
2) SP [`proc_PivotPrepare`] -> prepares our data
3) SP [`proc_PivotExecute`] -> execute the script</p>

```sql
    CREATE TYPE [dbo].[ColumnActionList] AS TABLE(
        [ID] [smallint] NOT NULL,
        [ColumnName] [nvarchar](128) NOT NULL,
        [Action] [nchar](1) NOT NULL
    );
GO

    CREATE PROCEDURE [dbo].[proc_PivotPrepare] 
    (
    @DB_Name        nvarchar(128),
    @TableName      nvarchar(128)
    )
    AS
    ----------------------------------------------------------------------------------------------------
    -----| Author: Bartosz
    ----------------------------------------------------------------------------------------------------
    SELECT @DB_Name = ISNULL(@DB_Name,db_name())
    DECLARE @SQL_Code nvarchar(max)

    DECLARE @MyTab TABLE (ID smallint identity(1,1), [Column_Name] nvarchar(128), [Type] nchar(1), [Set Action SQL] nvarchar(max));

    SELECT @SQL_Code        =   'SELECT [<| SQL_Code |>] = '' '' '
                                        + 'UNION ALL '
                                        + 'SELECT ''----------------------------------------------------------------------------------------------------'' '
                                        + 'UNION ALL '
                                        + 'SELECT ''-----| Declare user defined type [ID] / [ColumnName] / [PivotAction] '' '
                                        + 'UNION ALL '
                                        + 'SELECT ''----------------------------------------------------------------------------------------------------'' '
                                        + 'UNION ALL '
                                        + 'SELECT ''DECLARE @ColumnListWithActions ColumnActionList;'''
                                        + 'UNION ALL '
                                        + 'SELECT ''----------------------------------------------------------------------------------------------------'' '
                                        + 'UNION ALL '
                                        + 'SELECT ''-----| Set [PivotAction] (''''S'''' as default) to select dimentions and values '' '
                                        + 'UNION ALL '
                                        + 'SELECT ''-----|'''
                                        + 'UNION ALL '
                                        + 'SELECT ''-----| ''''S'''' = Stable column || ''''D'''' = Dimention column || ''''V'''' = Value column '' '
                                        + 'UNION ALL '
                                        + 'SELECT ''----------------------------------------------------------------------------------------------------'' '
                                        + 'UNION ALL '
                                        + 'SELECT ''INSERT INTO  @ColumnListWithActions VALUES ('' + CAST( ROW_NUMBER() OVER (ORDER BY [NAME]) as nvarchar(10)) + '', '' + '''''''' + [NAME] + ''''''''+ '', ''''S'''');'''
                                        + 'FROM [' + @DB_Name + '].sys.columns  '
                                        + 'WHERE object_id = object_id(''[' + @DB_Name + ']..[' + @TableName + ']'') '
                                        + 'UNION ALL '
                                        + 'SELECT ''----------------------------------------------------------------------------------------------------'' '
                                        + 'UNION ALL '
                                        + 'SELECT ''-----| Execute sp_PivotExecute with parameters: columns and dimentions and main table name'' '
                                        + 'UNION ALL '
                                        + 'SELECT ''----------------------------------------------------------------------------------------------------'' '
                                        + 'UNION ALL '
                                        + 'SELECT ''EXEC [dbo].[sp_PivotExecute] @ColumnListWithActions, ' + '''''' + @TableName + '''''' + ';'''
                                        + 'UNION ALL '
                                        + 'SELECT ''----------------------------------------------------------------------------------------------------'' '                            
     EXECUTE SP_EXECUTESQL @SQL_Code;

GO
CREATE PROCEDURE [dbo].[proc_PivotExecute]
(
@ColumnListWithActions  ColumnActionList ReadOnly
,@TableName                     nvarchar(128)
)
AS
--#######################################################################################################################
--###| Author: Bartosz
--#######################################################################################################################


--#######################################################################################################################
--###| Step 1 - Select our user-defined-table-variable into temp table
--#######################################################################################################################

IF OBJECT_ID('tempdb.dbo.#ColumnListWithActions', 'U') IS NOT NULL DROP TABLE #ColumnListWithActions; 
SELECT * INTO #ColumnListWithActions FROM @ColumnListWithActions;

--#######################################################################################################################
--###| Step 2 - Preparing lists of column groups as strings:
--#######################################################################################################################

DECLARE @ColumnName                     nvarchar(128)
DECLARE @Destiny                        nchar(1)

DECLARE @ListOfColumns_Stable           nvarchar(max)
DECLARE @ListOfColumns_Dimension    nvarchar(max)
DECLARE @ListOfColumns_Variable     nvarchar(max)
--############################
--###| Cursor for List of Stable Columns
--############################

DECLARE ColumnListStringCreator_S CURSOR FOR
SELECT      [ColumnName]
FROM        #ColumnListWithActions
WHERE       [Action] = 'S'
OPEN ColumnListStringCreator_S;
FETCH NEXT FROM ColumnListStringCreator_S
INTO @ColumnName
  WHILE @@FETCH_STATUS = 0

   BEGIN
        SELECT @ListOfColumns_Stable = ISNULL(@ListOfColumns_Stable, '') + ' [' + @ColumnName + '] ,';
        FETCH NEXT FROM ColumnListStringCreator_S INTO @ColumnName
   END

CLOSE ColumnListStringCreator_S;
DEALLOCATE ColumnListStringCreator_S;

--############################
--###| Cursor for List of Dimension Columns
--############################

DECLARE ColumnListStringCreator_D CURSOR FOR
SELECT      [ColumnName]
FROM        #ColumnListWithActions
WHERE       [Action] = 'D'
OPEN ColumnListStringCreator_D;
FETCH NEXT FROM ColumnListStringCreator_D
INTO @ColumnName
  WHILE @@FETCH_STATUS = 0

   BEGIN
        SELECT @ListOfColumns_Dimension = ISNULL(@ListOfColumns_Dimension, '') + ' [' + @ColumnName + '] ,';
        FETCH NEXT FROM ColumnListStringCreator_D INTO @ColumnName
   END

CLOSE ColumnListStringCreator_D;
DEALLOCATE ColumnListStringCreator_D;

--############################
--###| Cursor for List of Variable Columns
--############################

DECLARE ColumnListStringCreator_V CURSOR FOR
SELECT      [ColumnName]
FROM        #ColumnListWithActions
WHERE       [Action] = 'V'
OPEN ColumnListStringCreator_V;
FETCH NEXT FROM ColumnListStringCreator_V
INTO @ColumnName
  WHILE @@FETCH_STATUS = 0

   BEGIN
        SELECT @ListOfColumns_Variable = ISNULL(@ListOfColumns_Variable, '') + ' [' + @ColumnName + '] ,';
        FETCH NEXT FROM ColumnListStringCreator_V INTO @ColumnName
   END

CLOSE ColumnListStringCreator_V;
DEALLOCATE ColumnListStringCreator_V;

SELECT @ListOfColumns_Variable      = LEFT(@ListOfColumns_Variable, LEN(@ListOfColumns_Variable) - 1);
SELECT @ListOfColumns_Dimension = LEFT(@ListOfColumns_Dimension, LEN(@ListOfColumns_Dimension) - 1);
SELECT @ListOfColumns_Stable            = LEFT(@ListOfColumns_Stable, LEN(@ListOfColumns_Stable) - 1);

--#######################################################################################################################
--###| Step 3 - Preparing table with all possible connections between Dimension columns excluding NULLs
--#######################################################################################################################
DECLARE @DIM_TAB TABLE ([DIM_ID] smallint, [ColumnName] nvarchar(128))
INSERT INTO @DIM_TAB 
SELECT [DIM_ID] = ROW_NUMBER() OVER(ORDER BY [ColumnName]), [ColumnName] FROM #ColumnListWithActions WHERE [Action] = 'D';

DECLARE @DIM_ID smallint;
SELECT      @DIM_ID = 1;


DECLARE @SQL_Dimentions nvarchar(max);

IF OBJECT_ID('tempdb.dbo.##ALL_Dimentions', 'U') IS NOT NULL DROP TABLE ##ALL_Dimentions; 

SELECT @SQL_Dimentions      = 'SELECT ID = ROW_NUMBER() OVER (ORDER BY ' + @ListOfColumns_Dimension + '), ' + @ListOfColumns_Dimension
                                            + ' INTO ##ALL_Dimentions '
                                            + ' FROM (SELECT DISTINCT' + @ListOfColumns_Dimension + ' FROM  ' + @TableName
                                            + ' WHERE ' + (SELECT [ColumnName] FROM @DIM_TAB WHERE [DIM_ID] = @DIM_ID) + ' IS NOT NULL ';
                                            SELECT @DIM_ID = @DIM_ID + 1;
            WHILE @DIM_ID <= (SELECT MAX([DIM_ID]) FROM @DIM_TAB)
            BEGIN
            SELECT @SQL_Dimentions = @SQL_Dimentions + 'AND ' + (SELECT [ColumnName] FROM @DIM_TAB WHERE [DIM_ID] = @DIM_ID) +  ' IS NOT NULL ';
            SELECT @DIM_ID = @DIM_ID + 1;
            END

SELECT @SQL_Dimentions   = @SQL_Dimentions + ' )x';

EXECUTE SP_EXECUTESQL  @SQL_Dimentions;

--#######################################################################################################################
--###| Step 4 - Preparing table with all possible connections between Stable columns excluding NULLs
--#######################################################################################################################
DECLARE @StabPos_TAB TABLE ([StabPos_ID] smallint, [ColumnName] nvarchar(128))
INSERT INTO @StabPos_TAB 
SELECT [StabPos_ID] = ROW_NUMBER() OVER(ORDER BY [ColumnName]), [ColumnName] FROM #ColumnListWithActions WHERE [Action] = 'S';

DECLARE @StabPos_ID smallint;
SELECT      @StabPos_ID = 1;


DECLARE @SQL_MainStableColumnTable nvarchar(max);

IF OBJECT_ID('tempdb.dbo.##ALL_StableColumns', 'U') IS NOT NULL DROP TABLE ##ALL_StableColumns; 

SELECT @SQL_MainStableColumnTable       = 'SELECT ID = ROW_NUMBER() OVER (ORDER BY ' + @ListOfColumns_Stable + '), ' + @ListOfColumns_Stable
                                            + ' INTO ##ALL_StableColumns '
                                            + ' FROM (SELECT DISTINCT' + @ListOfColumns_Stable + ' FROM  ' + @TableName
                                            + ' WHERE ' + (SELECT [ColumnName] FROM @StabPos_TAB WHERE [StabPos_ID] = @StabPos_ID) + ' IS NOT NULL ';
                                            SELECT @StabPos_ID = @StabPos_ID + 1;
            WHILE @StabPos_ID <= (SELECT MAX([StabPos_ID]) FROM @StabPos_TAB)
            BEGIN
            SELECT @SQL_MainStableColumnTable = @SQL_MainStableColumnTable + 'AND ' + (SELECT [ColumnName] FROM @StabPos_TAB WHERE [StabPos_ID] = @StabPos_ID) +  ' IS NOT NULL ';
            SELECT @StabPos_ID = @StabPos_ID + 1;
            END

SELECT @SQL_MainStableColumnTable    = @SQL_MainStableColumnTable + ' )x';

EXECUTE SP_EXECUTESQL  @SQL_MainStableColumnTable;

--#######################################################################################################################
--###| Step 5 - Preparing table with all options ID
--#######################################################################################################################

DECLARE @FULL_SQL_1 NVARCHAR(MAX)
SELECT @FULL_SQL_1 = ''

DECLARE @i smallint

IF OBJECT_ID('tempdb.dbo.##FinalTab', 'U') IS NOT NULL DROP TABLE ##FinalTab; 

SELECT @FULL_SQL_1 = 'SELECT t.*, dim.[ID] '
                                    + ' INTO ##FinalTab '
                                    +   'FROM ' + @TableName + ' t '
                                    +   'JOIN ##ALL_Dimentions dim '
                                    +   'ON t.' + (SELECT [ColumnName] FROM @DIM_TAB WHERE [DIM_ID] = 1) + ' = dim.' + (SELECT [ColumnName] FROM @DIM_TAB WHERE [DIM_ID] = 1);
                                SELECT @i = 2                               
                                WHILE @i <= (SELECT MAX([DIM_ID]) FROM @DIM_TAB)
                                    BEGIN
                                    SELECT @FULL_SQL_1 = @FULL_SQL_1 + ' AND t.' + (SELECT [ColumnName] FROM @DIM_TAB WHERE [DIM_ID] = @i) + ' = dim.' + (SELECT [ColumnName] FROM @DIM_TAB WHERE [DIM_ID] = @i)
                                    SELECT @i = @i +1
                                END
EXECUTE SP_EXECUTESQL @FULL_SQL_1

--#######################################################################################################################
--###| Step 6 - Selecting final data
--#######################################################################################################################
DECLARE @STAB_TAB TABLE ([STAB_ID] smallint, [ColumnName] nvarchar(128))
INSERT INTO @STAB_TAB 
SELECT [STAB_ID] = ROW_NUMBER() OVER(ORDER BY [ColumnName]), [ColumnName]
FROM #ColumnListWithActions WHERE [Action] = 'S';

DECLARE @VAR_TAB TABLE ([VAR_ID] smallint, [ColumnName] nvarchar(128))
INSERT INTO @VAR_TAB 
SELECT [VAR_ID] = ROW_NUMBER() OVER(ORDER BY [ColumnName]), [ColumnName]
FROM #ColumnListWithActions WHERE [Action] = 'V';

DECLARE @y smallint;
DECLARE @x smallint;
DECLARE @z smallint;


DECLARE @FinalCode nvarchar(max)

SELECT @FinalCode = ' SELECT ID1.*'
                                        SELECT @y = 1
                                        WHILE @y <= (SELECT MAX([ID]) FROM ##FinalTab)
                                            BEGIN
                                                SELECT @z = 1
                                                WHILE @z <= (SELECT MAX([VAR_ID]) FROM @VAR_TAB)
                                                    BEGIN
                                                        SELECT @FinalCode = @FinalCode +    ', [ID' + CAST((@y) as varchar(10)) + '.' + (SELECT [ColumnName] FROM @VAR_TAB WHERE [VAR_ID] = @z) + '] =  ID' + CAST((@y + 1) as varchar(10)) + '.' + (SELECT [ColumnName] FROM @VAR_TAB WHERE [VAR_ID] = @z)
                                                        SELECT @z = @z + 1
                                                    END
                                                    SELECT @y = @y + 1
                                                END
        SELECT @FinalCode = @FinalCode + 
                                        ' FROM ( SELECT * FROM ##ALL_StableColumns)ID1';
                                        SELECT @y = 1
                                        WHILE @y <= (SELECT MAX([ID]) FROM ##FinalTab)
                                        BEGIN
                                            SELECT @x = 1
                                            SELECT @FinalCode = @FinalCode 
                                                                                + ' LEFT JOIN (SELECT ' +  @ListOfColumns_Stable + ' , ' + @ListOfColumns_Variable 
                                                                                + ' FROM ##FinalTab WHERE [ID] = ' 
                                                                                + CAST(@y as varchar(10)) + ' )ID' + CAST((@y + 1) as varchar(10))  
                                                                                + ' ON 1 = 1' 
                                                                                WHILE @x <= (SELECT MAX([STAB_ID]) FROM @STAB_TAB)
                                                                                BEGIN
                                                                                    SELECT @FinalCode = @FinalCode + ' AND ID1.' + (SELECT [ColumnName] FROM @STAB_TAB WHERE [STAB_ID] = @x) + ' = ID' + CAST((@y+1) as varchar(10)) + '.' + (SELECT [ColumnName] FROM @STAB_TAB WHERE [STAB_ID] = @x)
                                                                                    SELECT @x = @x +1
                                                                                END
                                            SELECT @y = @y + 1
                                        END

SELECT * FROM ##ALL_Dimentions;
EXECUTE SP_EXECUTESQL @FinalCode;
--#######################################################################################################################
```

<p>From executing the first query (by passing source DB and table name) you will get a pre-created execution query for the second SP, all you have to do is define is the column from your source:
+ Stable
+ Value (will be used to concentrate values based on that)
+ Dim (column you want to use to pivot by)</p>

Names and datatypes will be defined automatically!  

I cant recommend it for any production environments but does the job for adhoc BI requests.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 71: Best way to get identity of inserted row? (score [784594](https://stackoverflow.com/q/42648) in 2018)

#### Question
What is the best way to get `IDENTITY` of inserted row?  

I know about `@@IDENTITY` and `IDENT_CURRENT` and `SCOPE_IDENTITY` but don't understand the pros and cons attached to each.  

Can someone please explain the differences and when I should be using each?  

#### Answer accepted (score 1341)
<ul>
<li><p><a href="http://msdn.microsoft.com/en-us/library/ms187342.aspx" rel="noreferrer">`@@IDENTITY`</a> returns the last identity value generated for any table in the current session, across all scopes.  <strong>You need to be careful here</strong>, since it's across scopes.  You could get a value from a trigger, instead of your current statement.</p></li>
<li><p><a href="http://msdn.microsoft.com/en-us/library/ms190315.aspx" rel="noreferrer">`SCOPE_IDENTITY()`</a> returns the last identity value generated for any table in the current session and the current scope.  <strong>Generally what you want to use</strong>.</p></li>
<li><p><a href="http://msdn.microsoft.com/en-us/library/ms175098.aspx" rel="noreferrer">`IDENT_CURRENT('tableName')`</a> returns the last identity value generated for a specific table in any session and any scope.  This lets you specify which table you want the value from, in case the two above aren't quite what you need (<strong>very rare</strong>).  Also, as @<a href="https://stackoverflow.com/questions/42648/best-way-to-get-identity-of-inserted-row#42665">Guy Starbuck</a> mentioned, "You could use this if you want to get the current IDENTITY value for a table that you have not inserted a record into."</p></li>
<li><p>The <a href="http://msdn.microsoft.com/en-us/library/ms177564.aspx" rel="noreferrer">`OUTPUT` clause</a> of the `INSERT` statement will let you access every row that was inserted via that statement.  Since it's scoped to the specific statement, it's <strong>more straightforward</strong> than the other functions above.  However, it's a little <strong>more verbose</strong> (you'll need to insert into a table variable/temp table and then query that) and it gives results even in an error scenario where the statement is rolled back.  That said, if your query uses a parallel execution plan, this is the <strong>only guaranteed method</strong> for getting the identity (short of turning off parallelism). However, it is executed <em>before</em> triggers and cannot be used to return trigger-generated values.</p></li>
</ul>

#### Answer 2 (score 169)
I believe the safest and most accurate method of retrieving the inserted id would be  using the output clause.  

for example (taken from the following <a href="http://msdn.microsoft.com/en-us/library/ms177564.aspx" rel="noreferrer">MSDN</a> article)  

```sql
USE AdventureWorks2008R2;
GO
DECLARE @MyTableVar table( NewScrapReasonID smallint,
                           Name varchar(50),
                           ModifiedDate datetime);
INSERT Production.ScrapReason
    OUTPUT INSERTED.ScrapReasonID, INSERTED.Name, INSERTED.ModifiedDate
        INTO @MyTableVar
VALUES (N'Operator error', GETDATE());

--Display the result set of the table variable.
SELECT NewScrapReasonID, Name, ModifiedDate FROM @MyTableVar;
--Display the result set of the table.
SELECT ScrapReasonID, Name, ModifiedDate 
FROM Production.ScrapReason;
GO
```

#### Answer 3 (score 103)
I'm saying the same thing as the other guys, so everyone's correct, I'm just trying to make it more clear.  

<p>`@@IDENTITY` returns the id of the last thing that was inserted by your client's connection to the database.<br>
Most of the time this works fine, but sometimes a trigger will go and insert a new row that you don't know about, and you'll get the ID from this new row, instead of the one you want</p>

`SCOPE_IDENTITY()` solves this problem. It returns the id of the last thing that <em>you inserted</em> in the SQL code <em>you sent</em> to the database. If triggers go and create extra rows, they won't cause the wrong value to get returned. Hooray  

`IDENT_CURRENT` returns the last ID that was inserted by anyone. If some other app happens to insert another row at an unforunate time, you'll get the ID of that row instead of your one.  

If you want to play it safe, always use `SCOPE_IDENTITY()`. If you stick with `@@IDENTITY` and someone decides to add a trigger later on, all your code will break.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 72: "CASE" statement within "WHERE" clause in SQL Server 2008 (score [782209](https://stackoverflow.com/q/8785209) in 2012)

#### Question
I am working with a query which contains "CASE" statement within "WHERE" clause. But SQL Server 2008 is giving some errors while executing it. Can anyone please help me with the correct query? Here is the query:  

```sql
SELECT
    tl.storenum 'Store #', 
    co.ccnum 'FuelFirst Card #', 
    co.dtentered 'Date Entered',
    CASE st.reasonid 
        WHEN 1 THEN 'Active' 
   WHEN 2 THEN 'Not Active' 
   WHEN 0 THEN st.ccstatustypename 
   ELSE 'Unknown' 
    END 'Status',
    CASE st.ccstatustypename 
        WHEN 'Active' THEN ' ' 
   WHEN 'Not Active' THEN ' ' 
   ELSE st.ccstatustypename 
    END 'Reason',
    UPPER(REPLACE(REPLACE(co.personentered,'RT\\\\',''),'RACETRAC\\\\','')) 'Person Entered',
    co.comments 'Comments or Notes'
FROM 
    comments co
    INNER JOIN cards cc ON co.ccnum=cc.ccnum
    INNER JOIN customerinfo ci ON cc.customerinfoid=ci.customerinfoid
    INNER JOIN ccstatustype st ON st.ccstatustypeid=cc.ccstatustypeid
    INNER JOIN customerstatus cs ON cs.customerstatuscd=ci.customerstatuscd
    INNER JOIN transactionlog tl ON tl.transactionlogid=co.transactionlogid
    LEFT JOIN stores s ON s.StoreNum = tl.StoreNum
WHERE 
    CASE LEN('TestPerson')
        WHEN 0 THEN co.personentered  = co.personentered
   ELSE co.personentered LIKE '%TestPerson'
    END 
    AND cc.ccnum = CASE LEN('TestFFNum')
        WHEN 0 THEN cc.ccnum 
   ELSE 'TestFFNum' 
    END 
    AND CASE LEN('2011-01-09 11:56:29.327') 
        WHEN 0 THEN co.DTEntered = co.DTEntered 
   ELSE 
       CASE LEN('2012-01-09 11:56:29.327') 
           WHEN 0 THEN co.DTEntered >= '2011-01-09 11:56:29.327' 
      ELSE co.DTEntered BETWEEN '2011-01-09 11:56:29.327' AND '2012-01-09 11:56:29.327' 
       END 
    END
    AND tl.storenum < 699 
ORDER BY tl.StoreNum
```

#### Answer 2 (score 186)
First off, the `CASE` statement must be <em>part</em> of the expression, not the expression itself.   

In other words, you can have:  

```sql
WHERE co.DTEntered = CASE 
                          WHEN LEN('blah') = 0 
                               THEN co.DTEntered 
                          ELSE '2011-01-01' 
                     END 
```

But it won't work the way you have written them eg:  

```sql
WHERE 
    CASE LEN('TestPerson')
        WHEN 0 THEN co.personentered  = co.personentered
   ELSE co.personentered LIKE '%TestPerson'
    END 
```

You may have better luck using combined OR statements like this:  

```sql
WHERE (
        (LEN('TestPerson') = 0 
             AND co.personentered = co.personentered
        ) 
        OR 
        (LEN('TestPerson') <> 0 
             AND co.personentered LIKE '%TestPerson')
      )
```

Although, either way I'm not sure how great of a query plan you'll get. These types of shenanigans in a `WHERE` clause will often prevent the query optimizer from utilizing indexes.   

#### Answer 3 (score 14)
This should solve your problem for the time being but I must remind you it isn't a good approach :  

```sql
WHERE 
            CASE LEN('TestPerson')
                WHEN 0 THEN 
                        CASE WHEN co.personentered  = co.personentered THEN 1 ELSE 0 END
                ELSE 
                        CASE WHEN co.personentered LIKE '%TestPerson' THEN 1 ELSE 0 END
            END = 1
        AND cc.ccnum = CASE LEN('TestFFNum')
                            WHEN 0 THEN cc.ccnum 
                            ELSE 'TestFFNum' 
                       END 
        AND CASE LEN('2011-01-09 11:56:29.327') 
                WHEN 0 THEN CASE WHEN co.DTEntered = co.DTEntered THEN 1 ELSE 0 END 
                ELSE 
                    CASE LEN('2012-01-09 11:56:29.327') 
                        WHEN 0 THEN 
                            CASE WHEN co.DTEntered >= '2011-01-09 11:56:29.327' THEN 1 ELSE 0 END 
                        ELSE 
                            CASE WHEN co.DTEntered BETWEEN '2011-01-09 11:56:29.327' 
                                                        AND '2012-01-09 11:56:29.327' 
                                                     THEN 1 ELSE 0 END
                    END
            END = 1
        AND tl.storenum < 699 
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 73: How to delete duplicate rows in SQL Server? (score [779227](https://stackoverflow.com/q/18390574) in 2019)

#### Question
How can I <strong>delete duplicate rows</strong> where no `unique row id` exists?  

My table is  

```sql
col1  col2 col3 col4 col5 col6 col7
john  1    1    1    1    1    1 
john  1    1    1    1    1    1
sally 2    2    2    2    2    2
sally 2    2    2    2    2    2
```

I want to be left with the following after the duplicate removal:  

```sql
john  1    1    1    1    1    1
sally 2    2    2    2    2    2
```

I've tried a few queries but I think they depend on having a row id as I don't get the desired result. For example:  

```sql
DELETE
FROM table
WHERE col1 IN (
    SELECT id
    FROM table
    GROUP BY id
    HAVING (COUNT(col1) > 1)
)
```

#### Answer 2 (score 735)
I like CTEs and `ROW_NUMBER` as the two combined allow us to see which rows are deleted (or updated), therefore just change the `DELETE FROM CTE...` to `SELECT * FROM CTE`:  

```sql
WITH CTE AS(
   SELECT [col1], [col2], [col3], [col4], [col5], [col6], [col7],
       RN = ROW_NUMBER()OVER(PARTITION BY col1 ORDER BY col1)
   FROM dbo.Table1
)
DELETE FROM CTE WHERE RN > 1
```

<kbd><a href="http://rextester.com/ZHFH51082" rel="noreferrer"><strong>DEMO</strong></a></kbd>  (result is different; I assume that it's due to a typo on your part)  

```sql
COL1    COL2    COL3    COL4    COL5    COL6    COL7
john    1        1       1       1       1       1
sally   2        2       2       2       2       2
```

This example determines duplicates by a single column `col1` because of the `PARTITION BY col1`. If you want to include multiple columns simply add them to the `PARTITION BY`:  

```sql
ROW_NUMBER()OVER(PARTITION BY Col1, Col2, ... ORDER BY OrderColumn)
```

#### Answer 3 (score 149)
I would prefer CTE for deleting duplicate rows from sql server table  

strongly recommend to follow this article ::<a href="http://codaffection.com/sql-server-article/delete-duplicate-rows-in-sql-server/" rel="noreferrer">http://codaffection.com/sql-server-article/delete-duplicate-rows-in-sql-server/</a>  

<blockquote>
  by keeping original  
</blockquote>

```sql
WITH CTE AS
(
SELECT *,ROW_NUMBER() OVER (PARTITION BY col1,col2,col3 ORDER BY col1,col2,col3) AS RN
FROM MyTable
)

DELETE FROM CTE WHERE RN<>1
```

<blockquote>
  without keeping original  
</blockquote>

```sql
WITH CTE AS
(SELECT *,R=RANK() OVER (ORDER BY col1,col2,col3)
FROM MyTable)
 
DELETE CTE
WHERE R IN (SELECT R FROM CTE GROUP BY R HAVING COUNT(*)>1)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 74: UPDATE and REPLACE part of a string (score [777842](https://stackoverflow.com/q/17365222) in 2015)

#### Question
I've got a table with two columns, `ID` and `Value`. I want to change a part of some strings in the second column.  

Example of Table:  

```sql
ID            Value
---------------------------------
1             c:\temp\123\abc\111
2             c:\temp\123\abc\222
3             c:\temp\123\abc\333
4             c:\temp\123\abc\444
```

Now the `123\` in the `Value` string is not needed. I tried `UPDATE` and `REPLACE`:  

```sql
UPDATE dbo.xxx
SET Value = REPLACE(Value, '%123%', '')
WHERE ID <= 4
```

When I execute the script SQL Server does not report an error, but it does not update anything either. Why is that?  

#### Answer accepted (score 639)
You don't need wildcards in the `REPLACE` - it just finds the string you enter for the second argument, so the following should work:  

```sql
UPDATE dbo.xxx
SET Value = REPLACE(Value, '123\', '')
WHERE ID <=4
```

(I also added the `\` in the replace as I assume you don't need that either)  

#### Answer 2 (score 50)
Try to remove `%` chars as below  

```sql
UPDATE dbo.xxx
SET Value = REPLACE(Value, '123', '')
WHERE ID <=4
```

#### Answer 3 (score 35)
To make the query run <strong>faster</strong> in big tables where not every line needs to be updated, you can also choose to only update rows that will be modified:   

```sql
UPDATE dbo.xxx
SET Value = REPLACE(Value, '123', '')
WHERE ID <= 4
AND Value LIKE '%123%'
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 75: Convert Rows to columns using 'Pivot' in SQL Server (score [777059](https://stackoverflow.com/q/15931607) in 2019)

#### Question
I have read the stuff on MS pivot tables and I am still having problems getting this correct.  

I have a temp table that is being created, we will say that column 1 is a Store number, and column 2 is a week number and lastly column 3 is a total of some type. Also the Week numbers are dynamic, the store numbers are static.  

```sql
Store      Week     xCount
-------    ----     ------
102        1        96
101        1        138
105        1        37
109        1        59
101        2        282
102        2        212
105        2        78
109        2        97
105        3        60
102        3        123
101        3        220
109        3        87
```

I would like it to come out as a pivot table, like this:  

```sql
Store        1          2          3        4        5        6....
----- 
101        138        282        220
102         96        212        123
105         37        
109
```

Store numbers down the side and weeks across the top.  

#### Answer accepted (score 335)
If you are using SQL Server 2005+, then you can use the `PIVOT` function to transform the data from rows into columns.  

It sounds like you will need to use dynamic sql if the weeks are unknown but it is easier to see the correct code using a hard-coded version initially.  

First up, here are some quick table definitions and data for use:  

```sql
CREATE TABLE #yt 
(
  [Store] int, 
  [Week] int, 
  [xCount] int
);

INSERT INTO #yt
(
  [Store], 
  [Week], [xCount]
)
VALUES
    (102, 1, 96),
    (101, 1, 138),
    (105, 1, 37),
    (109, 1, 59),
    (101, 2, 282),
    (102, 2, 212),
    (105, 2, 78),
    (109, 2, 97),
    (105, 3, 60),
    (102, 3, 123),
    (101, 3, 220),
    (109, 3, 87);
```

If your values are known, then you will hard-code the query:  

```sql
select *
from 
(
  select store, week, xCount
  from yt
) src
pivot
(
  sum(xcount)
  for week in ([1], [2], [3])
) piv;
```

See <a href="https://data.stackexchange.com/stackoverflow/query/580181" rel="noreferrer">SQL Demo</a>  

Then if you need to generate the week number dynamically, your code will be:  

```sql
DECLARE @cols AS NVARCHAR(MAX),
    @query  AS NVARCHAR(MAX)

select @cols = STUFF((SELECT ',' + QUOTENAME(Week) 
                    from yt
                    group by Week
                    order by Week
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')

set @query = 'SELECT store,' + @cols + ' from 
             (
                select store, week, xCount
                from yt
            ) x
            pivot 
            (
                sum(xCount)
                for week in (' + @cols + ')
            ) p '

execute(@query);
```

See <a href="https://data.stackexchange.com/stackoverflow/query/580183" rel="noreferrer">SQL Demo</a>.  

The dynamic version, generates the list of `week` numbers that should be converted to columns. Both give the same result:  

```sql
| STORE |   1 |   2 |   3 |
---------------------------
|   101 | 138 | 282 | 220 |
|   102 |  96 | 212 | 123 |
|   105 |  37 |  78 |  60 |
|   109 |  59 |  97 |  87 |
```

#### Answer 2 (score 25)
This is for dynamic # of weeks.  

Full example here:<a href="http://sqlhints.com/2014/03/18/dynamic-pivot-in-sql-server/" rel="noreferrer">SQL Dynamic Pivot</a>  

```sql
DECLARE @DynamicPivotQuery AS NVARCHAR(MAX)
DECLARE @ColumnName AS NVARCHAR(MAX)

--Get distinct values of the PIVOT Column 
SELECT @ColumnName= ISNULL(@ColumnName + ',','') + QUOTENAME(Week)
FROM (SELECT DISTINCT Week FROM #StoreSales) AS Weeks

--Prepare the PIVOT query using the dynamic 
SET @DynamicPivotQuery = 
  N'SELECT Store, ' + @ColumnName + ' 
    FROM #StoreSales
    PIVOT(SUM(xCount) 
          FOR Week IN (' + @ColumnName + ')) AS PVTTable'
--Execute the Dynamic Pivot Query
EXEC sp_executesql @DynamicPivotQuery
```

#### Answer 3 (score 16)
I've achieved the same thing before by using subqueries.  So if your original table was called StoreCountsByWeek, and you had a separate table that listed the Store IDs, then it would look like this:  

```sql
SELECT StoreID, 
    Week1=(SELECT ISNULL(SUM(xCount),0) FROM StoreCountsByWeek WHERE StoreCountsByWeek.StoreID=Store.StoreID AND Week=1),
    Week2=(SELECT ISNULL(SUM(xCount),0) FROM StoreCountsByWeek WHERE StoreCountsByWeek.StoreID=Store.StoreID AND Week=2),
    Week3=(SELECT ISNULL(SUM(xCount),0) FROM StoreCountsByWeek WHERE StoreCountsByWeek.StoreID=Store.StoreID AND Week=3)
FROM Store
ORDER BY StoreID
```

One advantage to this method is that the syntax is more clear and it makes it easier to join to other tables to pull other fields into the results too.  

My anecdotal results are that running this query over a couple of thousand rows completed in less than one second, and I actually had 7 subqueries.  But as noted in the comments, it is more computationally expensive to do it this way, so be careful about using this method if you expect it to run on large amounts of data .  

</b> </em> </i> </small> </strong> </sub> </sup>

### 76: SQL query return data from multiple tables (score [775509](https://stackoverflow.com/q/12475850) in 2018)

#### Question
I would like to know the following:  

<ul>
<li>how to get data from multiple tables in my database?</li>
<li>what types of methods are there to do this?</li>
<li>what are joins and unions and how are they different from one another? </li>
<li>When should I use each one compared to the others?</li>
</ul>

I am planning to use this in my (for example - PHP) application, but don't want to run multiple queries against the database, what options do I have to get data from multiple tables in a single query?  

Note: I am writing this as I would like to be able to link to a well written guide on the numerous questions that I constantly come across in the PHP queue, so I can link to this for further detail when I post an answer.  

The answers cover off the following:  

<ol>
<li><a href="https://stackoverflow.com/questions/12475850/how-can-an-sql-query-return-data-from-multiple-tables/12475851#12475851">Part 1 - Joins and Unions</a></li>
<li><a href="https://stackoverflow.com/questions/12475850/how-can-an-sql-query-return-data-from-multiple-tables/12492267#12492267">Part 2 - Subqueries</a></li>
<li><a href="https://stackoverflow.com/questions/12475850/how-can-an-sql-query-return-data-from-multiple-tables/12508381#12508381">Part 3 - Tricks and Efficient Code</a></li>
<li><a href="https://stackoverflow.com/a/12542115/1450077">Part 4 - Subqueries in the From Clause</a></li>
<li><a href="https://stackoverflow.com/a/12586263/1450077">Part 5 - Mixed Bag of John's Tricks</a></li>
</ol>

#### Answer accepted (score 454)
<h5>Part 1 - Joins and Unions</h1>

This answer covers:  

<ol>
<li>Part 1

<ul>
<li>Joining two or more tables using an inner join (See the <a href="http://en.wikipedia.org/wiki/Join_%28SQL%29" rel="noreferrer">wikipedia entry</a> for additional info)</li>
<li>How to use a union query</li>
<li>Left and Right Outer Joins (this <a href="https://stackoverflow.com/a/4715847/1450077">stackOverflow answer</a> is excellent to describe types of joins)</li>
<li>Intersect queries (and how to reproduce them if your database doesn't support them) - this is a function of SQL-Server (<a href="https://stackoverflow.com/questions/148795/what-is-the-standard-sql-query-to-retrieve-the-intersection-of-tables">see info</a>) and part of the <a href="https://stackoverflow.com/questions/12443904/creating-query-that-returns-id-if-condition-is-matched-in-rows-from-two-tables/12455505#12455505">reason I wrote this whole thing</a> in the first place.</li>
</ul></li>
<li>Part 2

<ul>
<li>Subqueries - what they are, where they can be used and what to watch out for</li>
<li>Cartesian joins AKA - Oh, the misery!</li>
</ul></li>
</ol>

There are a number of ways to retrieve data from multiple tables in a database. In this answer, I will be using ANSI-92 join syntax. This may be different to a number of other tutorials out there which use the older ANSI-89 syntax (and if you are used to 89, may seem much less intuitive - but all I can say is to try it) as it is <em>much</em> easier to understand when the queries start getting more complex. Why use it? Is there a performance gain? The <a href="https://stackoverflow.com/questions/334201/why-isnt-sql-ansi-92-standard-better-adopted-over-ansi-89">short answer</a> is no, but it <em>is</em> easier to read once you get used to it. It is easier to read queries written by other folks using this syntax.  

I am also going to use the concept of a small caryard which has a database to keep track of what cars it has available. The owner has hired you as his IT Computer guy and expects you to be able to drop him the data that he asks for at the drop of a hat.  

I have made a number of lookup tables that will be used by the final table. This will give us a reasonable model to work from. To start off, I will be running my queries against an example database that has the following structure. I will try to think of common mistakes that are made when starting out and explain what goes wrong with them - as well as of course showing how to correct them.  

The first table is simply a color listing so that we know what colors we have in the car yard.  

```sql
mysql> create table colors(id int(3) not null auto_increment primary key, 
    -> color varchar(15), paint varchar(10));
Query OK, 0 rows affected (0.01 sec)

mysql> show columns from colors;
+-------+-------------+------+-----+---------+----------------+
| Field | Type        | Null | Key | Default | Extra          |
+-------+-------------+------+-----+---------+----------------+
| id    | int(3)      | NO   | PRI | NULL    | auto_increment |
| color | varchar(15) | YES  |     | NULL    |                |
| paint | varchar(10) | YES  |     | NULL    |                |
+-------+-------------+------+-----+---------+----------------+
3 rows in set (0.01 sec)

mysql> insert into colors (color, paint) values ('Red', 'Metallic'), 
    -> ('Green', 'Gloss'), ('Blue', 'Metallic'), 
    -> ('White' 'Gloss'), ('Black' 'Gloss');
Query OK, 5 rows affected (0.00 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> select * from colors;
+----+-------+----------+
| id | color | paint    |
+----+-------+----------+
|  1 | Red   | Metallic |
|  2 | Green | Gloss    |
|  3 | Blue  | Metallic |
|  4 | White | Gloss    |
|  5 | Black | Gloss    |
+----+-------+----------+
5 rows in set (0.00 sec)
```

The brands table identifies the different brands of the cars out caryard could possibly sell.  

```sql
mysql> create table brands (id int(3) not null auto_increment primary key, 
    -> brand varchar(15));
Query OK, 0 rows affected (0.01 sec)

mysql> show columns from brands;
+-------+-------------+------+-----+---------+----------------+
| Field | Type        | Null | Key | Default | Extra          |
+-------+-------------+------+-----+---------+----------------+
| id    | int(3)      | NO   | PRI | NULL    | auto_increment |
| brand | varchar(15) | YES  |     | NULL    |                |
+-------+-------------+------+-----+---------+----------------+
2 rows in set (0.01 sec)

mysql> insert into brands (brand) values ('Ford'), ('Toyota'), 
    -> ('Nissan'), ('Smart'), ('BMW');
Query OK, 5 rows affected (0.00 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> select * from brands;
+----+--------+
| id | brand  |
+----+--------+
|  1 | Ford   |
|  2 | Toyota |
|  3 | Nissan |
|  4 | Smart  |
|  5 | BMW    |
+----+--------+
5 rows in set (0.00 sec)
```

The model table will cover off different types of cars, it is going to be simpler for this to use different car types rather than actual car models.  

```sql
mysql> create table models (id int(3) not null auto_increment primary key, 
    -> model varchar(15));
Query OK, 0 rows affected (0.01 sec)

mysql> show columns from models;
+-------+-------------+------+-----+---------+----------------+
| Field | Type        | Null | Key | Default | Extra          |
+-------+-------------+------+-----+---------+----------------+
| id    | int(3)      | NO   | PRI | NULL    | auto_increment |
| model | varchar(15) | YES  |     | NULL    |                |
+-------+-------------+------+-----+---------+----------------+
2 rows in set (0.00 sec)

mysql> insert into models (model) values ('Sports'), ('Sedan'), ('4WD'), ('Luxury');
Query OK, 4 rows affected (0.00 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> select * from models;
+----+--------+
| id | model  |
+----+--------+
|  1 | Sports |
|  2 | Sedan  |
|  3 | 4WD    |
|  4 | Luxury |
+----+--------+
4 rows in set (0.00 sec)
```

And finally, to tie up all these other tables, the table that ties everything together. The ID field is actually the unique lot number used to identify cars.  

```sql
mysql> create table cars (id int(3) not null auto_increment primary key, 
    -> color int(3), brand int(3), model int(3));
Query OK, 0 rows affected (0.01 sec)

mysql> show columns from cars;
+-------+--------+------+-----+---------+----------------+
| Field | Type   | Null | Key | Default | Extra          |
+-------+--------+------+-----+---------+----------------+
| id    | int(3) | NO   | PRI | NULL    | auto_increment |
| color | int(3) | YES  |     | NULL    |                |
| brand | int(3) | YES  |     | NULL    |                |
| model | int(3) | YES  |     | NULL    |                |
+-------+--------+------+-----+---------+----------------+
4 rows in set (0.00 sec)

mysql> insert into cars (color, brand, model) values (1,2,1), (3,1,2), (5,3,1), 
    -> (4,4,2), (2,2,3), (3,5,4), (4,1,3), (2,2,1), (5,2,3), (4,5,1);
Query OK, 10 rows affected (0.00 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> select * from cars;
+----+-------+-------+-------+
| id | color | brand | model |
+----+-------+-------+-------+
|  1 |     1 |     2 |     1 |
|  2 |     3 |     1 |     2 |
|  3 |     5 |     3 |     1 |
|  4 |     4 |     4 |     2 |
|  5 |     2 |     2 |     3 |
|  6 |     3 |     5 |     4 |
|  7 |     4 |     1 |     3 |
|  8 |     2 |     2 |     1 |
|  9 |     5 |     2 |     3 |
| 10 |     4 |     5 |     1 |
+----+-------+-------+-------+
10 rows in set (0.00 sec)
```

This will give us enough data (I hope) to cover off the examples below of different types of joins and also give enough data to make them worthwhile.  

So getting into the grit of it, the boss wants to know <em>The IDs of all the sports cars he has</em>.  

This is a simple two table join. We have a table that identifies the model and the table with the available stock in it. As you can see, the data in the `model` column of the `cars` table relates to the `models` column of the `cars` table we have. Now, we know that the models table has an ID of `1` for `Sports` so lets write the join.  

```sql
select
    ID,
    model
from
    cars
        join models
            on model=ID
```

So this query looks good right? We have identified the two tables and contain the information we need and use a join that correctly identifies what columns to join on.  

```sql
ERROR 1052 (23000): Column 'ID' in field list is ambiguous
```

Oh noes! An error in our first query! Yes, and it is a plum. You see, the query has indeed got the right columns, but some of them exist in both tables, so the database gets confused about what actual column we mean and where. There are two solutions to solve this. The first is nice and simple, we can use `tableName.columnName` to tell the database exactly what we mean, like this:  

```sql
select
    cars.ID,
    models.model
from
    cars
        join models
            on cars.model=models.ID

+----+--------+
| ID | model  |
+----+--------+
|  1 | Sports |
|  3 | Sports |
|  8 | Sports |
| 10 | Sports |
|  2 | Sedan  |
|  4 | Sedan  |
|  5 | 4WD    |
|  7 | 4WD    |
|  9 | 4WD    |
|  6 | Luxury |
+----+--------+
10 rows in set (0.00 sec)
```

The other is probably more often used and is called table aliasing. The tables in this example have nice and short simple names, but typing out something like `KPI_DAILY_SALES_BY_DEPARTMENT` would probably get old quickly, so a simple way is to nickname the table like this:  

```sql
select
    a.ID,
    b.model
from
    cars a
        join models b
            on a.model=b.ID
```

Now, back to the request. As you can see we have the information we need, but we also have information that wasn't asked for, so we need to include a where clause in the statement to only get the Sports cars as was asked. As I prefer the table alias method rather than using the table names over and over, I will stick to it from this point onwards.  

Clearly, we need to add a where clause to our query. We can identify Sports cars either by `ID=1` or `model='Sports'`. As the ID is indexed and the primary key (and it happens to be less typing), lets use that in our query.  

```sql
select
    a.ID,
    b.model
from
    cars a
        join models b
            on a.model=b.ID
where
    b.ID=1

+----+--------+
| ID | model  |
+----+--------+
|  1 | Sports |
|  3 | Sports |
|  8 | Sports |
| 10 | Sports |
+----+--------+
4 rows in set (0.00 sec)
```

Bingo! The boss is happy. Of course, being a boss and never being happy with what he asked for, he looks at the information, then says <em>I want the colors as well</em>.  

Okay, so we have a good part of our query already written, but we need to use a third table which is colors. Now, our main information table `cars` stores the car color ID and this links back to the colors ID column. So, in a similar manner to the original, we can join a third table:  

```sql
select
    a.ID,
    b.model
from
    cars a
        join models b
            on a.model=b.ID
        join colors c
            on a.color=c.ID
where
    b.ID=1

+----+--------+
| ID | model  |
+----+--------+
|  1 | Sports |
|  3 | Sports |
|  8 | Sports |
| 10 | Sports |
+----+--------+
4 rows in set (0.00 sec)
```

Damn, although the table was correctly joined and the related columns were linked, we forgot to pull in the actual <em>information</em> from the new table that we just linked.  

```sql
select
    a.ID,
    b.model,
    c.color
from
    cars a
        join models b
            on a.model=b.ID
        join colors c
            on a.color=c.ID
where
    b.ID=1

+----+--------+-------+
| ID | model  | color |
+----+--------+-------+
|  1 | Sports | Red   |
|  8 | Sports | Green |
| 10 | Sports | White |
|  3 | Sports | Black |
+----+--------+-------+
4 rows in set (0.00 sec)
```

Right, that's the boss off our back for a moment. Now, to explain some of this in a little more detail. As you can see, the `from` clause in our statement links our main table (I often use a table that contains information rather than a lookup or dimension table. The query would work just as well with the tables all switched around, but make less sense when we come back to this query to read it in a few months time, so it is often best to try to write a query that will be nice and easy to understand - lay it out intuitively, use nice indenting so that everything is as clear as it can be. If you go on to teach others, try to instill these characteristics in their queries - especially if you will be troubleshooting them.  

It is entirely possible to keep linking more and more tables in this manner.  

```sql
select
    a.ID,
    b.model,
    c.color
from
    cars a
        join models b
            on a.model=b.ID
        join colors c
            on a.color=c.ID
        join brands d
            on a.brand=d.ID
where
    b.ID=1
```

While I forgot to include a table where we might want to join more than one column in the `join` statement, here is an example. If the `models` table had brand-specific models and therefore also had a column called `brand` which linked back to the `brands` table on the `ID` field, it could be done as this:  

```sql
select
    a.ID,
    b.model,
    c.color
from
    cars a
        join models b
            on a.model=b.ID
        join colors c
            on a.color=c.ID
        join brands d
            on a.brand=d.ID
            and b.brand=d.ID
where
    b.ID=1
```

You can see, the query above not only links the joined tables to the main `cars` table, but also specifies joins between the already joined tables. If this wasn't done, the result is called a cartesian join - which is dba speak for bad. A cartesian join is one where rows are returned because the information doesn't tell the database how to limit the results, so the query returns <em>all</em> the rows that fit the criteria.  

So, to give an example of a cartesian join, lets run the following query:  

```sql
select
    a.ID,
    b.model
from
    cars a
        join models b

+----+--------+
| ID | model  |
+----+--------+
|  1 | Sports |
|  1 | Sedan  |
|  1 | 4WD    |
|  1 | Luxury |
|  2 | Sports |
|  2 | Sedan  |
|  2 | 4WD    |
|  2 | Luxury |
|  3 | Sports |
|  3 | Sedan  |
|  3 | 4WD    |
|  3 | Luxury |
|  4 | Sports |
|  4 | Sedan  |
|  4 | 4WD    |
|  4 | Luxury |
|  5 | Sports |
|  5 | Sedan  |
|  5 | 4WD    |
|  5 | Luxury |
|  6 | Sports |
|  6 | Sedan  |
|  6 | 4WD    |
|  6 | Luxury |
|  7 | Sports |
|  7 | Sedan  |
|  7 | 4WD    |
|  7 | Luxury |
|  8 | Sports |
|  8 | Sedan  |
|  8 | 4WD    |
|  8 | Luxury |
|  9 | Sports |
|  9 | Sedan  |
|  9 | 4WD    |
|  9 | Luxury |
| 10 | Sports |
| 10 | Sedan  |
| 10 | 4WD    |
| 10 | Luxury |
+----+--------+
40 rows in set (0.00 sec)
```

Good god, that's ugly. However, as far as the database is concerned, it is <em>exactly</em> what was asked for. In the query, we asked for for the `ID` from `cars` and the `model` from `models`. However, because we didn't specify <em>how</em> to join the tables, the database has matched <em>every</em> row from the first table with <em>every</em> row from the second table.  

Okay, so the boss is back, and he wants more information again. <em>I want the same list, but also include 4WDs in it</em>.  

This however, gives us a great excuse to look at two different ways to accomplish this. We could add another condition to the where clause like this:  

```sql
select
    a.ID,
    b.model,
    c.color
from
    cars a
        join models b
            on a.model=b.ID
        join colors c
            on a.color=c.ID
        join brands d
            on a.brand=d.ID
where
    b.ID=1
    or b.ID=3
```

While the above will work perfectly well, lets look at it differently, this is a great excuse to show how a `union` query will work.  

We know that the following will return all the Sports cars:  

```sql
select
    a.ID,
    b.model,
    c.color
from
    cars a
        join models b
            on a.model=b.ID
        join colors c
            on a.color=c.ID
        join brands d
            on a.brand=d.ID
where
    b.ID=1
```

And the following would return all the 4WDs:  

```sql
select
    a.ID,
    b.model,
    c.color
from
    cars a
        join models b
            on a.model=b.ID
        join colors c
            on a.color=c.ID
        join brands d
            on a.brand=d.ID
where
    b.ID=3
```

So by adding a `union all` clause between them, the results of the second query will be appended to the results of the first query.  

```sql
select
    a.ID,
    b.model,
    c.color
from
    cars a
        join models b
            on a.model=b.ID
        join colors c
            on a.color=c.ID
        join brands d
            on a.brand=d.ID
where
    b.ID=1
union all
select
    a.ID,
    b.model,
    c.color
from
    cars a
        join models b
            on a.model=b.ID
        join colors c
            on a.color=c.ID
        join brands d
            on a.brand=d.ID
where
    b.ID=3

+----+--------+-------+
| ID | model  | color |
+----+--------+-------+
|  1 | Sports | Red   |
|  8 | Sports | Green |
| 10 | Sports | White |
|  3 | Sports | Black |
|  5 | 4WD    | Green |
|  7 | 4WD    | White |
|  9 | 4WD    | Black |
+----+--------+-------+
7 rows in set (0.00 sec)
```

As you can see, the results of the first query are returned first, followed by the results of the second query.  

In this example, it would of course have been much easier to simply use the first query, but `union` queries can be great for specific cases. They are a great way to return specific results from tables from tables that aren't easily joined together - or for that matter <em>completely</em> unrelated tables. There are a few rules to follow however.  

<ul>
<li>The column types from the first query must match the column types from every other query below.</li>
<li>The names of the columns from the first query will be used to identify the entire set of results.</li>
<li>The number of columns in each query must be the same.</li>
</ul>

Now, you might <a href="https://stackoverflow.com/questions/49925/what-is-the-difference-between-union-and-union-all">be wondering what the</a> difference is between using `union` and `union all`. A `union` query will remove duplicates, while a `union all` will not. This does mean that there is a small performance hit when using `union` over `union all` but the results may be worth it - I won't speculate on that sort of thing in this though.  

On this note, it might be worth noting some additional notes here.  

<ul>
<li>If we wanted to order the results, we can use an `order by` but you can't use the alias anymore. In the query above, appending an `order by a.ID` would result in an error - as far as the results are concerned, the column is called `ID` rather than `a.ID` - even though the same alias has been used in both queries.</li>
<li>We can only have one `order by` statement, and it must be as the last statement.</li>
</ul>

For the next examples, I am adding a few extra rows to our tables.  

<p>I have added `Holden` to the brands table.
I have also added a row into `cars` that has the `color` value of `12` - which has no reference in the colors table.</p>

Okay, the boss is back again, barking requests out - *I want a count of each brand we carry and the number of cars in it!` - Typical, we just get to an interesting section of our discussion and the boss wants more work.  

Rightyo, so the first thing we need to do is get a complete listing of possible brands.  

```sql
select
    a.brand
from
    brands a

+--------+
| brand  |
+--------+
| Ford   |
| Toyota |
| Nissan |
| Smart  |
| BMW    |
| Holden |
+--------+
6 rows in set (0.00 sec)
```

Now, when we join this to our cars table we get the following result:  

```sql
select
    a.brand
from
    brands a
        join cars b
            on a.ID=b.brand
group by
    a.brand

+--------+
| brand  |
+--------+
| BMW    |
| Ford   |
| Nissan |
| Smart  |
| Toyota |
+--------+
5 rows in set (0.00 sec)
```

Which is of course a problem - we aren't seeing any mention of the lovely `Holden` brand I added.  

This is because a join looks for matching rows in <em>both</em> tables. As there is no data in cars that is of type `Holden` it isn't returned. This is where we can use an `outer` join. This will return <em>all</em> the results from one table whether they are matched in the other table or not:  

```sql
select
    a.brand
from
    brands a
        left outer join cars b
            on a.ID=b.brand
group by
    a.brand

+--------+
| brand  |
+--------+
| BMW    |
| Ford   |
| Holden |
| Nissan |
| Smart  |
| Toyota |
+--------+
6 rows in set (0.00 sec)
```

Now that we have that, we can add a lovely aggregate function to get a count and get the boss off our backs for a moment.  

```sql
select
    a.brand,
    count(b.id) as countOfBrand
from
    brands a
        left outer join cars b
            on a.ID=b.brand
group by
    a.brand

+--------+--------------+
| brand  | countOfBrand |
+--------+--------------+
| BMW    |            2 |
| Ford   |            2 |
| Holden |            0 |
| Nissan |            1 |
| Smart  |            1 |
| Toyota |            5 |
+--------+--------------+
6 rows in set (0.00 sec)
```

And with that, away the boss skulks.  

Now, to explain this in some more detail, outer joins can be of the `left` or `right` type. The Left or Right defines which table is <em>fully</em> included. A `left outer join` will include all the rows from the table on the left, while (you guessed it) a `right outer join` brings all the results from the table on the right into the results.  

Some databases will allow a `full outer join` which will bring back results (whether matched or not) from <em>both</em> tables, but this isn't supported in all databases.  

Now, I probably figure at this point in time, you are wondering whether or not you can merge join types in a query - and the answer is yes, you absolutely can.  

```sql
select
    b.brand,
    c.color,
    count(a.id) as countOfBrand
from
    cars a
        right outer join brands b
            on b.ID=a.brand
        join colors c
            on a.color=c.ID
group by
    a.brand,
    c.color

+--------+-------+--------------+
| brand  | color | countOfBrand |
+--------+-------+--------------+
| Ford   | Blue  |            1 |
| Ford   | White |            1 |
| Toyota | Black |            1 |
| Toyota | Green |            2 |
| Toyota | Red   |            1 |
| Nissan | Black |            1 |
| Smart  | White |            1 |
| BMW    | Blue  |            1 |
| BMW    | White |            1 |
+--------+-------+--------------+
9 rows in set (0.00 sec)
```

So, why is that not the results that were expected? It is because although we have selected the outer join from cars to brands, it wasn't specified in the join to colors - so that particular join will only bring back results that match in both tables.  

Here is the query that would work to get the results that we expected:  

```sql
select
    a.brand,
    c.color,
    count(b.id) as countOfBrand
from
    brands a
        left outer join cars b
            on a.ID=b.brand
        left outer join colors c
            on b.color=c.ID
group by
    a.brand,
    c.color

+--------+-------+--------------+
| brand  | color | countOfBrand |
+--------+-------+--------------+
| BMW    | Blue  |            1 |
| BMW    | White |            1 |
| Ford   | Blue  |            1 |
| Ford   | White |            1 |
| Holden | NULL  |            0 |
| Nissan | Black |            1 |
| Smart  | White |            1 |
| Toyota | NULL  |            1 |
| Toyota | Black |            1 |
| Toyota | Green |            2 |
| Toyota | Red   |            1 |
+--------+-------+--------------+
11 rows in set (0.00 sec)
```

As we can see, we have two outer joins in the query and the results are coming through as expected.  

Now, how about those other types of joins you ask? What about Intersections?  

Well, not all databases support the `intersection` but pretty much all databases will allow you to create an intersection through a join (or a well structured where statement at the least).  

An Intersection is a type of join somewhat similar to a `union` as described above - but the difference is that it <em>only</em> returns rows of data that are identical (and I do mean identical) between the various individual queries joined by the union. Only rows that are identical in every regard will be returned.  

A simple example would be as such:  

```sql
select
    *
from
    colors
where
    ID>2
intersect
select
    *
from
    colors
where
    id<4
```

While a normal `union` query would return all the rows of the table (the first query returning anything over `ID&gt;2` and the second anything having `ID&lt;4`) which would result in a full set, an intersect query would only return the row matching `id=3` as it meets both criteria.  

Now, if your database doesn't support an `intersect` query, the above can be easily accomlished with the following query:  

```sql
select
    a.ID,
    a.color,
    a.paint
from
    colors a
        join colors b
            on a.ID=b.ID
where
    a.ID>2
    and b.ID<4

+----+-------+----------+
| ID | color | paint    |
+----+-------+----------+
|  3 | Blue  | Metallic |
+----+-------+----------+
1 row in set (0.00 sec)
```

If you wish to perform an intersection across two different tables using a database that doesn't inherently support an intersection query, you will need to create a join on <em>every column</em> of the tables.  

#### Answer 2 (score 98)
Ok, I found this post very interesting and I would like to share some of my knowledge on creating a query. Thanks for this <strong><a href="https://stackoverflow.com/users/1450077/fluffeh">Fluffeh</a></strong>. Others who may read this and may feel that I'm wrong are 101% free to edit and criticise my answer. (<em>Honestly, I feel very thankful for correcting my mistake(s).</em>)  

I'll be posting some of the frequently asked questions in `MySQL` tag.  

<hr>

<h5><strong>Trick No. 1 (<em>rows that matches to multiple conditions</em>)</strong></h1>

Given this schema  

```sql
CREATE TABLE MovieList
(
    ID INT,
    MovieName VARCHAR(25),
    CONSTRAINT ml_pk PRIMARY KEY (ID),
    CONSTRAINT ml_uq UNIQUE (MovieName)
);

INSERT INTO MovieList VALUES (1, 'American Pie');
INSERT INTO MovieList VALUES (2, 'The Notebook');
INSERT INTO MovieList VALUES (3, 'Discovery Channel: Africa');
INSERT INTO MovieList VALUES (4, 'Mr. Bean');
INSERT INTO MovieList VALUES (5, 'Expendables 2');

CREATE TABLE CategoryList
(
    MovieID INT,
    CategoryName VARCHAR(25),
    CONSTRAINT cl_uq UNIQUE(MovieID, CategoryName),
    CONSTRAINT cl_fk FOREIGN KEY (MovieID) REFERENCES MovieList(ID)
);

INSERT INTO CategoryList VALUES (1, 'Comedy');
INSERT INTO CategoryList VALUES (1, 'Romance');
INSERT INTO CategoryList VALUES (2, 'Romance');
INSERT INTO CategoryList VALUES (2, 'Drama');
INSERT INTO CategoryList VALUES (3, 'Documentary');
INSERT INTO CategoryList VALUES (4, 'Comedy');
INSERT INTO CategoryList VALUES (5, 'Comedy');
INSERT INTO CategoryList VALUES (5, 'Action');
```

<strong>QUESTION</strong>  

Find <em>all movies</em> that belong to at least <em>both</em> `Comedy` and `Romance` categories.  

<strong>Solution</strong>  

This question can be very tricky sometimes. It may seem that a query like this will be the answer:-  

```sql
SELECT  DISTINCT a.MovieName
FROM    MovieList a
        INNER JOIN CategoryList b
            ON a.ID = b.MovieID
WHERE   b.CategoryName = 'Comedy' AND
        b.CategoryName = 'Romance'
```

<h5><a href="http://sqlfiddle.com/#!2/b60cb/4" rel="noreferrer">SQLFiddle Demo</a></h2>

which is definitely very wrong because it produces <em>no result</em>. The explanation of this is that there is only one valid value of `CategoryName` on <em>each row</em>. For instance, the first condition returns <em>true</em>, the second condition is always false. Thus, by using `AND` operator, both condition should be true; otherwise, it will be false. Another query is like this,  

```sql
SELECT  DISTINCT a.MovieName
FROM    MovieList a
        INNER JOIN CategoryList b
            ON a.ID = b.MovieID
WHERE   b.CategoryName IN ('Comedy','Romance')
```

<h5><a href="http://sqlfiddle.com/#!2/b60cb/2" rel="noreferrer">SQLFiddle Demo</a></h2>

and the result is still incorrect because it matches to record that has <em>at least</em> one match on the `categoryName`. The <strong>real solution</strong> <em>would be by counting the number of record instances per movie</em>. The number of instance should match to the total number of the values supplied in the condition.  

```sql
SELECT  a.MovieName
FROM    MovieList a
        INNER JOIN CategoryList b
            ON a.ID = b.MovieID
WHERE   b.CategoryName IN ('Comedy','Romance')
GROUP BY a.MovieName
HAVING COUNT(*) = 2
```

<h5><a href="http://sqlfiddle.com/#!2/b60cb/3" rel="noreferrer">SQLFiddle Demo (the answer)</a></h2>

<ul>
<li><a href="http://www.simple-talk.com/sql/t-sql-programming/divided-we-stand-the-sql-of-relational-division/" rel="noreferrer">SQL of Relational Division</a></li>
</ul>

<hr>

<h5><strong>Trick No. 2 (<em>maximum record for each entry</em>)</strong></h1>

Given  schema,  

```sql
CREATE TABLE Software
(
    ID INT,
    SoftwareName VARCHAR(25),
    Descriptions VARCHAR(150),
    CONSTRAINT sw_pk PRIMARY KEY (ID),
    CONSTRAINT sw_uq UNIQUE (SoftwareName)  
);

INSERT INTO Software VALUES (1,'PaintMe','used for photo editing');
INSERT INTO Software VALUES (2,'World Map','contains map of different places of the world');
INSERT INTO Software VALUES (3,'Dictionary','contains description, synonym, antonym of the words');

CREATE TABLE VersionList
(
    SoftwareID INT,
    VersionNo INT,
    DateReleased DATE,
    CONSTRAINT sw_uq UNIQUE (SoftwareID, VersionNo),
    CONSTRAINT sw_fk FOREIGN KEY (SOftwareID) REFERENCES Software(ID)
);

INSERT INTO VersionList VALUES (3, 2, '2009-12-01');
INSERT INTO VersionList VALUES (3, 1, '2009-11-01');
INSERT INTO VersionList VALUES (3, 3, '2010-01-01');
INSERT INTO VersionList VALUES (2, 2, '2010-12-01');
INSERT INTO VersionList VALUES (2, 1, '2009-12-01');
INSERT INTO VersionList VALUES (1, 3, '2011-12-01');
INSERT INTO VersionList VALUES (1, 2, '2010-12-01');
INSERT INTO VersionList VALUES (1, 1, '2009-12-01');
INSERT INTO VersionList VALUES (1, 4, '2012-12-01');
```

<strong>QUESTION</strong>  

Find the latest version on each software. Display the following columns: `SoftwareName`,`Descriptions`,`LatestVersion` (<em>from VersionNo column</em>),`DateReleased`  

<strong>Solution</strong>  

Some SQL developers mistakenly use `MAX()` aggregate function. They tend to create like this,  

```sql
SELECT  a.SoftwareName, a.Descriptions,
        MAX(b.VersionNo) AS LatestVersion, b.DateReleased
FROM    Software a
        INNER JOIN VersionList b
            ON a.ID = b.SoftwareID
GROUP BY a.ID
ORDER BY a.ID
```

<h5><a href="http://sqlfiddle.com/#!2/89929/2" rel="noreferrer">SQLFiddle Demo</a></h2>

(<em>most RDBMS generates a syntax error on this because of not specifying some of the non-aggregated columns on the `group by` clause</em>) the result produces the correct `LatestVersion` on each software but obviously the `DateReleased` are incorrect. `MySQL` doesn't support `Window Functions` and `Common Table Expression` yet as some RDBMS do already. The workaround on this problem is to create a `subquery` which gets the individual maximum `versionNo` on each software and later on be joined on the other tables.  

```sql
SELECT  a.SoftwareName, a.Descriptions,
        b.LatestVersion, c.DateReleased
FROM    Software a
        INNER JOIN
        (
            SELECT  SoftwareID, MAX(VersionNO) LatestVersion
            FROM    VersionList
            GROUP BY SoftwareID
        ) b ON a.ID = b.SoftwareID
        INNER JOIN VersionList c
            ON  c.SoftwareID = b.SoftwareID AND
                c.VersionNO = b.LatestVersion
GROUP BY a.ID
ORDER BY a.ID
```

<h5><a href="http://sqlfiddle.com/#!2/89929/3" rel="noreferrer">SQLFiddle Demo (the answer)</a></h2>

<hr>

So that was it. I'll be posting another soon as I recall any other <em>FAQ</em> on `MySQL` tag. Thank you for reading this little article. I hope that you have atleast get even a little knowledge from this.  

<strong>UPDATE 1</strong>  

<hr>

<h5><strong>Trick No. 3 (<em>Finding the latest record between two IDs</em>)</strong></h1>

Given Schema  

```sql
CREATE TABLE userList
(
    ID INT,
    NAME VARCHAR(20),
    CONSTRAINT us_pk PRIMARY KEY (ID),
    CONSTRAINT us_uq UNIQUE (NAME)  
);

INSERT INTO userList VALUES (1, 'Fluffeh');
INSERT INTO userList VALUES (2, 'John Woo');
INSERT INTO userList VALUES (3, 'hims056');

CREATE TABLE CONVERSATION
(
    ID INT,
    FROM_ID INT,
    TO_ID INT,
    MESSAGE VARCHAR(250),
    DeliveryDate DATE
);

INSERT INTO CONVERSATION VALUES (1, 1, 2, 'hi john', '2012-01-01');
INSERT INTO CONVERSATION VALUES (2, 2, 1, 'hello fluff', '2012-01-02');
INSERT INTO CONVERSATION VALUES (3, 1, 3, 'hey hims', '2012-01-03');
INSERT INTO CONVERSATION VALUES (4, 1, 3, 'please reply', '2012-01-04');
INSERT INTO CONVERSATION VALUES (5, 3, 1, 'how are you?', '2012-01-05');
INSERT INTO CONVERSATION VALUES (6, 3, 2, 'sample message!', '2012-01-05');
```

<strong>QUESTION</strong>  

Find the latest conversation between two users.  

<strong>Solution</strong>  

```sql
SELECT    b.Name SenderName,
          c.Name RecipientName,
          a.Message,
          a.DeliveryDate
FROM      Conversation a
          INNER JOIN userList b
            ON a.From_ID = b.ID
          INNER JOIN userList c
            ON a.To_ID = c.ID
WHERE     (LEAST(a.FROM_ID, a.TO_ID), GREATEST(a.FROM_ID, a.TO_ID), DeliveryDate)
IN
(
    SELECT  LEAST(FROM_ID, TO_ID) minFROM,
            GREATEST(FROM_ID, TO_ID) maxTo,
            MAX(DeliveryDate) maxDate
    FROM    Conversation
    GROUP BY minFROM, maxTo
)
```

<h5><a href="http://sqlfiddle.com/#!2/b7bd1/1" rel="noreferrer">SQLFiddle Demo</a></h2>

#### Answer 3 (score 63)
<h5>Part 2 - Subqueries</h1>

Okay, now the boss has burst in again - <em>I want a list of all of our cars with the brand and a total of how many of that brand we have!</em>  

This is a great opportunity to use the next trick in our bag of SQL goodies - the subquery. If you are unfamiliar with the term, a subquery is a query that runs inside another query. There are many different ways to use them.  

For our request, lets first put a simple query together that will list each car and the brand:  

```sql
select
    a.ID,
    b.brand
from
    cars a
        join brands b
            on a.brand=b.ID
```

Now, if we wanted to simply get a count of cars sorted by brand, we could of course write this:  

```sql
select
    b.brand,
    count(a.ID) as countCars
from
    cars a
        join brands b
            on a.brand=b.ID
group by
    b.brand

+--------+-----------+
| brand  | countCars |
+--------+-----------+
| BMW    |         2 |
| Ford   |         2 |
| Nissan |         1 |
| Smart  |         1 |
| Toyota |         5 |
+--------+-----------+
```

So, we should be able to simply add in the count function to our original query right?  

```sql
select
    a.ID,
    b.brand,
    count(a.ID) as countCars
from
    cars a
        join brands b
            on a.brand=b.ID
group by
    a.ID,
    b.brand

+----+--------+-----------+
| ID | brand  | countCars |
+----+--------+-----------+
|  1 | Toyota |         1 |
|  2 | Ford   |         1 |
|  3 | Nissan |         1 |
|  4 | Smart  |         1 |
|  5 | Toyota |         1 |
|  6 | BMW    |         1 |
|  7 | Ford   |         1 |
|  8 | Toyota |         1 |
|  9 | Toyota |         1 |
| 10 | BMW    |         1 |
| 11 | Toyota |         1 |
+----+--------+-----------+
11 rows in set (0.00 sec)
```

Sadly, no, we can't do that. The reason is that when we add in the car ID (column a.ID) we have to add it into the group by - so now, when the count function works, there is only one ID matched per ID.  

This is where we can however use a subquery - in fact we can do two completely different types of subquery that will return the same results that we need for this. The first is to simply put the subquery in the `select` clause. This means each time we get a row of data, the subquery will run off, get a column of data and then pop it into our row of data.  

```sql
select
    a.ID,
    b.brand,
    (
    select
        count(c.ID)
    from
        cars c
    where
        a.brand=c.brand
    ) as countCars
from
    cars a
        join brands b
            on a.brand=b.ID

+----+--------+-----------+
| ID | brand  | countCars |
+----+--------+-----------+
|  2 | Ford   |         2 |
|  7 | Ford   |         2 |
|  1 | Toyota |         5 |
|  5 | Toyota |         5 |
|  8 | Toyota |         5 |
|  9 | Toyota |         5 |
| 11 | Toyota |         5 |
|  3 | Nissan |         1 |
|  4 | Smart  |         1 |
|  6 | BMW    |         2 |
| 10 | BMW    |         2 |
+----+--------+-----------+
11 rows in set (0.00 sec)
```

And Bam!, this would do us. If you noticed though, this sub query will have to run for each and every single row of data we return. Even in this little example, we only have five different Brands of car, but the subquery ran eleven times as we have eleven rows of data that we are returning. So, in this case, it doesn't seem like the most efficient way to write code.  

For a different approach, lets run a subquery and pretend it is a table:  

```sql
select
    a.ID,
    b.brand,
    d.countCars
from
    cars a
        join brands b
            on a.brand=b.ID
        join
            (
            select
                c.brand,
                count(c.ID) as countCars
            from
                cars c
            group by
                c.brand
            ) d
            on a.brand=d.brand

+----+--------+-----------+
| ID | brand  | countCars |
+----+--------+-----------+
|  1 | Toyota |         5 |
|  2 | Ford   |         2 |
|  3 | Nissan |         1 |
|  4 | Smart  |         1 |
|  5 | Toyota |         5 |
|  6 | BMW    |         2 |
|  7 | Ford   |         2 |
|  8 | Toyota |         5 |
|  9 | Toyota |         5 |
| 10 | BMW    |         2 |
| 11 | Toyota |         5 |
+----+--------+-----------+
11 rows in set (0.00 sec)
```

Okay, so we have the same results (ordered slightly different - it seems the database wanted to return results ordered by the first column we picked this time) - but the same right numbers.  

So, what's the difference between the two - and when should we use each type of subquery? First, lets make sure we understand how that second query works. We selected two tables in the `from` clause of our query, and then wrote a query and told the database that it was in fact a table instead - which the database is perfectly happy with. There <em>can</em> be some benefits to using this method (as well as some limitations). Foremost is that this subquery ran <em>once</em>. If our database contained a large volume of data, there could well be a massive improvement over the first method. However, as we are using this as a table, we have to bring in extra rows of data - so that they can actually be joined back to our rows of data. We also have to be sure that there are <em>enough</em> rows of data if we are going to use a simple join like in the query above. If you recall, the join will only pull back rows that have matching data on <em>both</em> sides of the join. If we aren't careful, this could result in valid data not being returned from our cars table if there wasn't a matching row in this subquery.  

Now, looking back at the first subquery, there are some limitations as well. because we are pulling data back into a single row, we can <em>ONLY</em> pull back one row of data. Subqueries used in the `select` clause of a query very often use only an aggregate function such as `sum`, `count`, `max` or another similar aggregate function. They don't <em>have</em> to, but that is often how they are written.  

So, before we move on, lets have a quick look at where else we can use a subquery. We can use it in the `where` clause - now, this example is a little contrived as in our database, there are better ways of getting the following data, but seeing as it is only for an example, lets have a look:  

```sql
select
    ID,
    brand
from
    brands
where
    brand like '%o%'

+----+--------+
| ID | brand  |
+----+--------+
|  1 | Ford   |
|  2 | Toyota |
|  6 | Holden |
+----+--------+
3 rows in set (0.00 sec)
```

This returns us a list of brand IDs and Brand names (the second column is only added to show us the brands) that contain the letter `o` in the name.  

Now, we could use the results of this query in a where clause this:  

```sql
select
    a.ID,
    b.brand
from
    cars a
        join brands b
            on a.brand=b.ID
where
    a.brand in
        (
        select
            ID
        from
            brands
        where
            brand like '%o%'
        )

+----+--------+
| ID | brand  |
+----+--------+
|  2 | Ford   |
|  7 | Ford   |
|  1 | Toyota |
|  5 | Toyota |
|  8 | Toyota |
|  9 | Toyota |
| 11 | Toyota |
+----+--------+
7 rows in set (0.00 sec)
```

As you can see, even though the subquery was returning the three brand IDs, our cars table only had entries for two of them.  

In this case, for further detail, the subquery is working as if we wrote the following code:  

```sql
select
    a.ID,
    b.brand
from
    cars a
        join brands b
            on a.brand=b.ID
where
    a.brand in (1,2,6)

+----+--------+
| ID | brand  |
+----+--------+
|  1 | Toyota |
|  2 | Ford   |
|  5 | Toyota |
|  7 | Ford   |
|  8 | Toyota |
|  9 | Toyota |
| 11 | Toyota |
+----+--------+
7 rows in set (0.00 sec)
```

Again, you can see how a subquery vs manual inputs has changed the order of the rows when returning from the database.  

While we are discussing subqueries, lets see what else we can do with a subquery:  

<ul>
<li>You can place a subquery within another subquery, and so on and so on. There is a limit which depends on your database, but short of recursive functions of some insane and maniacal programmer, most folks will never hit that limit.</li>
<li>You can place a number of subqueries into a single query, a few in the `select` clause, some in the `from` clause and a couple more in the `where` clause - just remember that each one you put in is making your query more complex and likely to take longer to execute.</li>
</ul>

If you need to write some efficient code, it can be beneficial to write the query a number of ways and see (either by timing it or by using an explain plan) which is the optimal query to get your results. The first way that works may not always be the best way of doing it.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 77: How do I set a column value to NULL in SQL Server Management Studio? (score [774030](https://stackoverflow.com/q/444657) in 2019)

#### Question
How do I clear the value from a cell and make it NULL?  

#### Answer accepted (score 186)
If you've opened a table and you want to clear an existing value to NULL, click on the value, and press <kbd>`Ctrl`</kbd>+<kbd>`0`</kbd>.  

#### Answer 2 (score 300)
I think <a href="https://stackoverflow.com/a/444658/1165522">@Zack</a> properly answered the question but just to cover all the bases:    

```sql
Update myTable set MyColumn = NULL
```

This would set the entire column to null as the Question Title asks.  

To set a specific row on a specific column to null use:  

```sql
Update myTable set MyColumn = NULL where Field = Condition.
```

This would set a specific cell to null as the inner question asks.  

#### Answer 3 (score 29)
If you are using the table interface you can type in NULL (all caps)  

otherwise you can run an update statement where you could:  

```sql
Update table set ColumnName = NULL where [Filter for record here]
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 78: How to calculate percentage with a SQL statement (score [771868](https://stackoverflow.com/q/770579) in 2013)

#### Question
I have a SQL Server table that contains users &amp; their grades. For simplicity's sake, lets just say there are 2 columns - `name` &amp; `grade`. So a typical row would be Name: "John Doe", Grade:"A".  

I'm looking for one SQL statement that will find the percentages of all possible answers. (A, B, C, etc...) Also, is there a way to do this without defining all possible answers (open text field - users could enter 'pass/fail', 'none', etc...)  

The final output I'm looking for is A: 5%, B: 15%, C: 40%, etc...  

#### Answer accepted (score 210)
I have tested the following and this does work. The answer by gordyii was close but had the multiplication of 100 in the wrong place and had some missing parenthesis.  

```sql
Select Grade, (Count(Grade)* 100 / (Select Count(*) From MyTable)) as Score
From MyTable
Group By Grade
```

#### Answer 2 (score 195)
<ol>
<li><p>The most efficient (using over()).</p>

```sql
select Grade, count(*) * 100.0 / sum(count(*)) over()
from MyTable
group by Grade
```</li>
<li><p>Universal (any SQL version).</p>

```sql
select Grade, count(*) * 100.0 / (select count(*) from MyTable)
from MyTable
group by Grade;
```</li>
<li><p>With CTE, the least efficient.</p>

```sql
with t(Grade, GradeCount) 
as 
( 
    select Grade, count(*) 
    from MyTable
    group by Grade
)
select Grade, GradeCount * 100.0/(select sum(GradeCount) from t)
from t;
```</li>
</ol>

#### Answer 3 (score 38)
Instead of using a separate CTE to get the total, you can use a window function without the "partition by" clause.  

If you are using:  

```sql
count(*)
```

to get the count for a group, you can use:  

```sql
sum(count(*)) over ()
```

to get the total count.  

For example:  

```sql
select Grade, 100. * count(*) / sum(count(*)) over ()
from table
group by Grade;
```

It tends to be faster in my experience, but I think it might internally use a temp table in some cases (I've seen "Worktable" when running with "set statistics io on").  

<p><strong>EDIT:</strong>
I'm not sure if my example query is what you are looking for, I was just illustrating how the windowing functions work.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 79: Conversion failed when converting date and/or time from character string while inserting datetime (score [771777](https://stackoverflow.com/q/14119133) in 2013)

#### Question
I was trying to create a table as follows,  

```sql
create table table1(date1 datetime,date2 datetime);
```

First I tried inserting values as below,  

```sql
insert into table1 values('21-02-2012 6:10:00 PM','01-01-2001 12:00:00 AM');
```

It has given error saying,  

<blockquote>
  <em>Cannot convert varchar to datetime</em>  
</blockquote>

Then I tried below format as one of the post suggested by our stackoverflow,  

```sql
insert into table1 values(convert(datetime,'21-02-2012 6:10:00 PM',5)
                          ,convert(datetime,'01-01-2001 12:00:00 AM',5));
```

But am still getting the error saying,  

<blockquote>
  <em>Conversion failed when converting date and/or time from character string</em>  
</blockquote>

Any suggestions?  

#### Answer accepted (score 138)
There are many formats supported by SQL Server - see the <a href="http://msdn.microsoft.com/en-us/library/ms187928.aspx" rel="noreferrer">MSDN Books Online on CAST and CONVERT</a>. Most of those formats are <strong>dependent</strong> on what settings you have - therefore, these settings might work some times - and sometimes not.  

The way to solve this is to use the (slightly adapted) <strong>ISO-8601 date format</strong> that is supported by SQL Server - this format works <strong>always</strong> - regardless of your SQL Server language and dateformat settings.  

The <a href="http://msdn.microsoft.com/en-us/library/ms180878.aspx" rel="noreferrer">ISO-8601 format</a> is supported by SQL Server comes in two flavors:  

<ul>
<li>`YYYYMMDD` for just dates (no time portion); note here: <strong>no dashes!</strong>, that's very important! `YYYY-MM-DD` is <strong>NOT</strong> independent of the dateformat settings in your SQL Server and will <strong>NOT</strong> work in all situations!</li>
</ul>

or:  

<ul>
<li>`YYYY-MM-DDTHH:MM:SS` for dates and times - note here: this format <em>has</em> dashes (but they <em>can</em> be omitted), and a fixed `T` as delimiter between the date and time portion of your `DATETIME`.</li>
</ul>

This is valid for SQL Server 2000 and newer.  

So in your concrete case - use these strings:  

```sql
insert into table1 values('2012-02-21T18:10:00', '2012-01-01T00:00:00');
```

and you should be fine (note: you need to use the international <strong>24-hour</strong> format rather than 12-hour AM/PM format for this).  

<strong>Alternatively</strong>: if you're on SQL Server <strong>2008</strong> or newer, you could also use the `DATETIME2` datatype (instead of plain `DATETIME`) and your current `INSERT` would just work without any problems! :-) `DATETIME2` is a lot better and a lot less picky on conversions - and it's the recommend date/time data types for SQL Server 2008 or newer anyway.  

```sql
SELECT
   CAST('02-21-2012 6:10:00 PM' AS DATETIME2),     -- works just fine
   CAST('01-01-2012 12:00:00 AM' AS DATETIME2)   -- works just fine  
```

Don't ask me why this whole topic is so tricky and somewhat confusing - that's just the way it is. But with the `YYYYMMDD` format, you should be fine for any version of SQL Server and for any language and dateformat setting in your SQL Server.  

#### Answer 2 (score 21)
The conversion in SQL server fails sometimes not because of the Date or Time formats used, It is Merely because you are trying to store wrong data that is not acceptable to the system.  

Example:  

`Create Table MyTable (MyDate);`  

`Insert Into MyTable(MyDate) Values ('2015-02-29');`  

The SQL server will throw the following error:  

`Conversion failed when converting date and/or time from character string.`  

The reason for this error is simply there is no such date (Feb-29) in Year (2015).  

#### Answer 3 (score 13)
Simple answer - 5 is Italian "yy" and 105 is Italian "yyyy". Therefore:  

```sql
SELECT convert(datetime,'21-02-12 6:10:00 PM',5)
```

will work correctly, but  

```sql
SELECT convert(datetime,'21-02-12 6:10:00 PM',105)
```

will give error.  

Likewise,   

```sql
SELECT convert(datetime,'21-02-2012 6:10:00 PM',5)
```

will give error, where as  

```sql
SELECT convert(datetime,'21-02-2012 6:10:00 PM',105)
```

will work.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 80: Insert into a MySQL table or update if exists (score [762170](https://stackoverflow.com/q/4205181) in 2019)

#### Question
I want to add a row to a database table, but if a row exists with the same unique key I want to update the row.  

For example,  

```sql
insert into table (id, name, age) values(1, "A", 19)
```

Let’s say the unique key is `id`, and in my database there is a row with `id = 1`. In that case I want to update that row with these values. Normally this gives an error. If I use `insert IGNORE` it will ignore the error, but it still won’t update.  

#### Answer accepted (score 1502)
Use <a href="https://dev.mysql.com/doc/en/insert-on-duplicate.html" rel="noreferrer">`INSERT ... ON DUPLICATE KEY UPDATE`</a>  

<strong>QUERY:</strong>  

```sql
INSERT INTO table (id, name, age) VALUES(1, "A", 19) ON DUPLICATE KEY UPDATE    
name="A", age=19
```

#### Answer 2 (score 228)
Check out REPLACE  

<a href="http://dev.mysql.com/doc/refman/5.0/en/replace.html" rel="noreferrer">http://dev.mysql.com/doc/refman/5.0/en/replace.html</a>  

```sql
REPLACE into table (id, name, age) values(1, "A", 19)
```

#### Answer 3 (score 38)
When using batch insert use the following syntax:  

```sql
INSERT INTO TABLE (id, name, age) VALUES (1, "A", 19), (2, "B", 17), (3, "C", 22)
ON DUPLICATE KEY UPDATE
    name = VALUES (name),
    ...
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 81: How to replace a string in a SQL Server Table Column (score [755845](https://stackoverflow.com/q/814548) in 2018)

#### Question
I have a table (`SQL Sever`) which references paths (`UNC` or otherwise), but now the path is going to change.   

In the path column, I have many records and I need to change just a portion of the path, but not the entire path. And I need to change the same string to the new one, in every record.  

How can I do this with a simple `update`?  

#### Answer accepted (score 585)
It's this easy:  

```sql
update my_table
set path = replace(path, 'oldstring', 'newstring')
```

#### Answer 2 (score 129)
```sql
UPDATE [table]
SET [column] = REPLACE([column], '/foo/', '/bar/')
```

#### Answer 3 (score 25)
I tried the above but it did not yield the correct result. The following one does:  

```sql
update table
set path = replace(path, 'oldstring', 'newstring') where path = 'oldstring'
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 82: SQL: IF clause within WHERE clause (score [754551](https://stackoverflow.com/q/87821) in 2008)

#### Question
Is it possible to use an <strong>IF</strong> clause within a <strong>WHERE</strong> clause in MS SQL?  

Example:  

```sql
WHERE
    IF IsNumeric(@OrderNumber) = 1
        OrderNumber = @OrderNumber
    ELSE
        OrderNumber LIKE '%' + @OrderNumber + '%'
```

#### Answer accepted (score 199)
<p>Use a <a href="http://msdn.microsoft.com/en-us/library/ms181765.aspx" rel="noreferrer">CASE</a> statement<br>
<strong>UPDATE:</strong> The previous syntax (as pointed out by a few people) doesn't work.  You can use CASE as follows:</p>

```sql
WHERE OrderNumber LIKE
  CASE WHEN IsNumeric(@OrderNumber) = 1 THEN 
    @OrderNumber 
  ELSE
    '%' + @OrderNumber
  END
```

Or you can use an IF statement like @<a href="https://stackoverflow.com/questions/87821/sql-if-clause-within-where-clause#87992">N. J. Reed</a> points out.  

#### Answer 2 (score 130)
You should be able to do this without any IF or CASE  

```sql
 WHERE 
   (IsNumeric(@OrderNumber) AND
      (CAST OrderNumber AS VARCHAR) = (CAST @OrderNumber AS VARCHAR)
 OR
   (NOT IsNumeric(@OrderNumber) AND
       OrderNumber LIKE ('%' + @OrderNumber))
```

Depending on the flavour of SQL you may need to tweak the casts on the order number to an INT or VARCHAR depending on whether implicit casts are supported.  

This is a very common technique in a WHERE clause. If you want to apply some "IF" logic in the WHERE clause all you need to do is add the extra condition with an boolean AND to the section where it needs to be applied.  

#### Answer 3 (score 22)
You don't need a IF statement at all.  

```sql
WHERE
    (IsNumeric(@OrderNumber) = 1 AND OrderNumber = @OrderNumber)
OR (IsNumeric(@OrderNumber) = 0 AND OrderNumber LIKE '%' + @OrderNumber + '%')
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 83: SQL error "ORA-01722: invalid number" (score [751360](https://stackoverflow.com/q/12549029) in 2018)

#### Question
<p>A very easy one for someone, 
The following insert is giving me the</p>

<blockquote>
  ORA-01722: invalid number  
</blockquote>

why?  

```sql
INSERT INTO CUSTOMER VALUES (1,'MALADY','Claire','27 Smith St Caulfield','0419 853 694');
INSERT INTO CUSTOMER VALUES (2,'GIBSON','Jake','27 Smith St Caulfield','0415 713 598');
INSERT INTO CUSTOMER VALUES (3,'LUU','Barry','5  Jones St Malvern','0413 591 341');
INSERT INTO CUSTOMER VALUES (4,'JONES','Michael','7  Smith St Caulfield','0419 853 694');
INSERT INTO CUSTOMER VALUES (5,'MALADY','Betty','27 Smith St Knox','0418 418 347');
```

#### Answer 2 (score 113)
An ORA-01722 error occurs when an attempt is made to convert a character string into a number, and the string cannot be converted into a number.  

Without seeing your table definition, it looks like you're trying to convert the numeric sequence at the end of your values list to a number, and the spaces that delimit it are throwing this error.  But based on the information you've given us, it could be happening on any field (other than the first one).  

#### Answer 3 (score 23)
Suppose telephone number is defined as `NUMBER` then the blanks cannot be converted into a number:  

```sql
create table telephone_number (tel_number number);
insert into telephone_number values ('0419 853 694');
```

The above gives you a   

<blockquote>
  ORA-01722: invalid number  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 84: How to avoid the "divide by zero" error in SQL? (score [744505](https://stackoverflow.com/q/861778) in 2018)

#### Question
I have this error message:  

<blockquote>
  Msg 8134, Level 16, State 1, Line 1 Divide by zero error encountered.  
</blockquote>

What is the best way to write SQL code so that I will never see this error message again?  

I could do either of the following:  

<ul>
<li>Add a where clause so that my divisor is never zero</li>
</ul>

Or  

<ul>
<li>I could add a case statement, so that there is a special treatment for zero. </li>
</ul>

Is the best way to use a `NULLIF` clause?    

Is there better way, or how can this be enforced?  

#### Answer accepted (score 586)
In order to avoid a "Division by zero" error we have programmed it like this:  

```sql
Select Case when divisor=0 then null
Else dividend / divisor
End ,,,
```

But here is a much nicer way of doing it:  

```sql
Select dividend / NULLIF(divisor, 0) ...
```

Now the only problem is to remember the NullIf bit, if I use the "/" key.  

#### Answer 2 (score 165)
In case you want to return zero, in case a zero devision would happen, you can use:  

```sql
SELECT COALESCE(dividend / NULLIF(divisor,0), 0) FROM sometable
```

For every divisor that is zero, you will get a zero in the result set.  

#### Answer 3 (score 63)
<h5>This seemed to be the best fix for my situation when trying to address dividing by zero, which does happen in my data.</h2>

Suppose you want to calculate the male–female ratios for various school clubs, but you discover that the following query fails and issues a divide-by-zero error when it tries to calculate ratio for the Lord of the Rings Club, which has no women:   

```sql
SELECT club_id, males, females, males/females AS ratio
  FROM school_clubs;
```

You can use the function `NULLIF` to avoid division by zero. `NULLIF` compares two expressions and returns null if they are equal or the first expression otherwise.   

Rewrite the query as:   

```sql
SELECT club_id, males, females, males/NULLIF(females, 0) AS ratio
  FROM school_clubs;
```

Any number divided by `NULL` gives `NULL`, and no error is generated.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 85: Select statement to find duplicates on certain fields (score [743636](https://stackoverflow.com/q/4434118) in 2014)

#### Question
Can you help me with SQL statements to find duplicates on multiple fields?  

For example, in pseudo code:  

```sql
select count(field1,field2,field3) 
from table 
where the combination of field1, field2, field3 occurs multiple times
```

and from the above statement <em>if there are multiple occurrences</em> I would like to select <em>every record except the first one</em>.  

#### Answer accepted (score 834)
To get the list of fields for which there are multiple records, you can use..  

```sql
select field1,field2,field3, count(*)
  from table_name
  group by field1,field2,field3
  having count(*) > 1
```

Check this link for more information on how to delete the rows.  

<a href="http://support.microsoft.com/kb/139444" rel="noreferrer">http://support.microsoft.com/kb/139444</a>  

Edit : As the other users mentioned, there should be a criterion for deciding how you define "first rows" before you use the approach in the link above. Based on that you'll need to use an order by clause and a sub query if needed. If you can post some sample data, it would really help.  

#### Answer 2 (score 42)
You mention "the first one", so I assume that you have some kind of ordering on your data. Let's assume that your data is ordered by some field `ID`.  

This SQL should get you the duplicate entries except for the first one. It basically selects all rows for which another row with (a) the same fields and (b) a lower ID exists. Performance won't be great, but it might solve your problem.  

```sql
SELECT A.ID, A.field1, A.field2, A.field3
  FROM myTable A
 WHERE EXISTS (SELECT B.ID
                 FROM myTable B
                WHERE B.field1 = A.field1
                  AND B.field2 = A.field2
                  AND B.field3 = A.field3
                  AND B.ID < A.ID)
```

#### Answer 3 (score 17)
This is a fun solution with SQL Server 2005 that I like.  I'm going to assume that by "for every record except for the first one", you mean that there is another "id" column that we can use to identify which row is "first".  

```sql
SELECT id
    , field1
    , field2
    , field3
FROM
(
    SELECT id
        , field1
        , field2
        , field3
        , RANK() OVER (PARTITION BY field1, field2, field3 ORDER BY id ASC) AS [rank]
    FROM table_name
) a
WHERE [rank] > 1
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 86: Case in Select Statement (score [742394](https://stackoverflow.com/q/14189216) in 2013)

#### Question
I have an SQL statement that has a `CASE` from `SELECT` and I just can't get it right. Can you guys show me an example of `CASE` where the cases are the conditions and the results are from the cases. For example:  

```sql
     Select xxx, yyy
     case : desc case when bbb then 'blackberry';
     when sss then 'samsung';
     end 
     from (select ???? .....
```

where the results show   

```sql
 name                         age       handphone
xxx1                         yyy1      blackberry
xxx2                         yyy2      blackberry
```

#### Answer 2 (score 186)
The MSDN is a good reference for these type of questions regarding syntax and usage.  This is from the Transact SQL Reference - CASE page.    

<a href="http://msdn.microsoft.com/en-us/library/ms181765.aspx" rel="noreferrer">http://msdn.microsoft.com/en-us/library/ms181765.aspx</a>  

```sql
USE AdventureWorks2012;
GO
SELECT   ProductNumber, Name, "Price Range" = 
  CASE 
     WHEN ListPrice =  0 THEN 'Mfg item - not for resale'
     WHEN ListPrice < 50 THEN 'Under $50'
     WHEN ListPrice >= 50 and ListPrice < 250 THEN 'Under $250'
     WHEN ListPrice >= 250 and ListPrice < 1000 THEN 'Under $1000'
     ELSE 'Over $1000'
  END
FROM Production.Product
ORDER BY ProductNumber ;
GO
```

Another good site you may want to check out if you're using SQL Server is <a href="http://sqlservercentral.com" rel="noreferrer">SQL Server Central</a>.  This has a large variety of resources available for whatever area of SQL Server you would like to learn.  

#### Answer 3 (score 77)
I think these could be helpful for you .  

<strong>Using a `SELECT` statement with a simple `CASE` expression</strong>  

Within a `SELECT` statement, a simple `CASE` expression allows for only an equality check; no other comparisons are made. The following example uses the `CASE` expression to change the display of product line categories to make them more understandable.  

```sql
USE AdventureWorks2012;
GO
SELECT   ProductNumber, Category =
      CASE ProductLine
         WHEN 'R' THEN 'Road'
         WHEN 'M' THEN 'Mountain'
         WHEN 'T' THEN 'Touring'
         WHEN 'S' THEN 'Other sale items'
         ELSE 'Not for sale'
      END,
   Name
FROM Production.Product
ORDER BY ProductNumber;
GO
```

<strong>Using a `SELECT` statement with a searched `CASE` expression</strong>  

Within a `SELECT` statement, the searched `CASE` expression allows for values to be replaced in the result set based on comparison values. The following example displays the list price as a text comment based on the price range for a product.  

```sql
USE AdventureWorks2012;
GO
SELECT   ProductNumber, Name, "Price Range" = 
      CASE 
         WHEN ListPrice =  0 THEN 'Mfg item - not for resale'
         WHEN ListPrice < 50 THEN 'Under $50'
         WHEN ListPrice >= 50 and ListPrice < 250 THEN 'Under $250'
         WHEN ListPrice >= 250 and ListPrice < 1000 THEN 'Under $1000'
         ELSE 'Over $1000'
      END
FROM Production.Product
ORDER BY ProductNumber ;
GO
```

<strong>Using `CASE` in an `ORDER BY` clause</strong>  

The following examples uses the `CASE` expression in an `ORDER BY` clause to determine the sort order of the rows based on a given column value. In the first example, the value in the SalariedFlag column of the HumanResources.Employee table is evaluated. Employees that have the SalariedFlag set to 1 are returned in order by the BusinessEntityID in descending order. Employees that have the SalariedFlag set to 0 are returned in order by the BusinessEntityID in ascending order. In the second example, the result set is ordered by the column TerritoryName when the column CountryRegionName is equal to 'United States' and by CountryRegionName for all other rows.  

```sql
SELECT BusinessEntityID, SalariedFlag
FROM HumanResources.Employee
ORDER BY CASE SalariedFlag WHEN 1 THEN BusinessEntityID END DESC
        ,CASE WHEN SalariedFlag = 0 THEN BusinessEntityID END;
GO


SELECT BusinessEntityID, LastName, TerritoryName, CountryRegionName
FROM Sales.vSalesPerson
WHERE TerritoryName IS NOT NULL
ORDER BY CASE CountryRegionName WHEN 'United States' THEN TerritoryName
         ELSE CountryRegionName END;
```

<strong>Using `CASE` in an `UPDATE` statement</strong>  

The following example uses the `CASE` expression in an `UPDATE` statement to determine the value that is set for the column VacationHours for employees with SalariedFlag set to 0. When subtracting 10 hours from VacationHours results in a negative value, VacationHours is increased by 40 hours; otherwise, VacationHours is increased by 20 hours. The `OUTPUT` clause is used to display the before and after vacation values.  

```sql
USE AdventureWorks2012;
GO
UPDATE HumanResources.Employee
SET VacationHours = 
    ( CASE
         WHEN ((VacationHours - 10.00) < 0) THEN VacationHours + 40
         ELSE (VacationHours + 20.00)
       END
    )
OUTPUT Deleted.BusinessEntityID, Deleted.VacationHours AS BeforeValue, 
       Inserted.VacationHours AS AfterValue
WHERE SalariedFlag = 0; 
```

<strong>Using `CASE` in a `HAVING` clause</strong>  

The following example uses the `CASE` expression in a `HAVING` clause to restrict the rows returned by the `SELECT` statement. The statement returns the the maximum hourly rate for each job title in the HumanResources.Employee table. The `HAVING` clause restricts the titles to those that are held by men with a maximum pay rate greater than 40 dollars or women with a maximum pay rate greater than 42 dollars.  

```sql
USE AdventureWorks2012;
GO
SELECT JobTitle, MAX(ph1.Rate)AS MaximumRate
FROM HumanResources.Employee AS e
JOIN HumanResources.EmployeePayHistory AS ph1 ON e.BusinessEntityID = ph1.BusinessEntityID
GROUP BY JobTitle
HAVING (MAX(CASE WHEN Gender = 'M' 
        THEN ph1.Rate 
        ELSE NULL END) > 40.00
     OR MAX(CASE WHEN Gender  = 'F' 
        THEN ph1.Rate  
        ELSE NULL END) > 42.00)
ORDER BY MaximumRate DESC;
```

For more details description of these example visit the <a href="https://docs.microsoft.com/en-us/sql/t-sql/language-elements/case-transact-sql" rel="noreferrer">source</a>.  

Also visit <a href="https://docs.oracle.com/cd/B19306_01/appdev.102/b14261/case_statement.htm" rel="noreferrer">here</a> and <a href="https://www.techonthenet.com/sql_server/functions/case.php" rel="noreferrer">here</a> for some examples with great details.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 87: SQL Server SELECT INTO @variable? (score [742086](https://stackoverflow.com/q/4823880) in 2011)

#### Question
I have the following code in one of my Sql (2008) Stored Procs which executes perfectly fine:  

```sql
    CREATE PROCEDURE [dbo].[Item_AddItem]
        @CustomerId uniqueidentifier,
        @Description nvarchar(100),
        @Type int,
        @Username nvarchar(100),
    AS
    BEGIN

        DECLARE @TopRelatedItemId uniqueidentifier;
        SET @TopRelatedItemId = 
        (
           SELECT top(1) RelatedItemId 
           FROM RelatedItems 
           WHERE CustomerId = @CustomerId
        ) 

        DECLARE @TempItem TABLE
        (
            ItemId uniqueidentifier,
            CustomerId uniqueidentifier,
            Description nvarchar(100),
            Type int,
            Username nvarchar(100),
            TimeStamp datetime
        );

        INSERT INTO Item
        OUTPUT INSERTED.* INTO @TempItem
        SELECT NEWID(), @CustomerId, @Description, @Type, @Username, GETDATE()

        SELECT
            ItemId,
            CustomerId,
            @TopRelatedItemId,
            Description,
            Type,
            Username,
            TimeStamp
        FROM
            @TempItem
END
GO
```

<strong>So the question for you guys is is there a possibility to do something along the lines of:</strong>  

```sql
DECLARE @TempCustomer TABLE
(
   CustomerId uniqueidentifier,
   FirstName nvarchar(100),
   LastName nvarchar(100),
   Email nvarchar(100)
);
SELECT 
    CustomerId, 
    FirstName, 
    LastName, 
    Email 
INTO 
    @TempCustomer 
FROM 
    Customer
WHERE 
    CustomerId = @CustomerId
```

So that I could reuse this data from memory in other following statements? SQL Server throws a fit with the above statement, however i don't want to have to create separate variables and initialize each one of them via a separate SELECT statement against the same table.... UGH!!!  

Any suggestions on how to achieve something along the lines without multiple queries against the same table?  

#### Answer accepted (score 195)
You cannot SELECT .. INTO .. a TABLE VARIABLE. The best you can do is create it first, then insert into it.  Your 2nd snippet has to be  

```sql
DECLARE @TempCustomer TABLE
(
   CustomerId uniqueidentifier,
   FirstName nvarchar(100),
   LastName nvarchar(100),
   Email nvarchar(100)
);
INSERT INTO 
    @TempCustomer 
SELECT 
    CustomerId, 
    FirstName, 
    LastName, 
    Email 
FROM 
    Customer
WHERE 
    CustomerId = @CustomerId
```

#### Answer 2 (score 472)
If you wanted to simply assign some variables for later use, you can do them in one shot with something along these lines:  

```sql
declare @var1 int,@var2 int,@var3 int;

select 
    @var1 = field1,
    @var2 = field2,
    @var3 = field3
from
    table
where
    condition
```

If that's the type of thing you're after  

#### Answer 3 (score 30)
you can do this:  

```sql
SELECT 
    CustomerId, 
    FirstName, 
    LastName, 
    Email
INTO #tempCustomer 
FROM 
    Customer
WHERE 
    CustomerId = @CustomerId
```

then later  

```sql
SELECT CustomerId FROM #tempCustomer
```

you doesn't need to declare the structure of   #tempCustomer  

</b> </em> </i> </small> </strong> </sub> </sup>

### 88: Inserting data into a temporary table (score [737037](https://stackoverflow.com/q/11778952) in )

#### Question
After having created a temporary table and declaring the data types like so;  

```sql
 CREATE TABLE #TempTable(
 ID int,
 Date datetime,
 Name char(20))
```

How do I then insert the relevant data which is already held on a physical table within the database?  

#### Answer accepted (score 227)
```sql
INSERT INTO #TempTable (ID, Date, Name) 
SELECT id, date, name 
FROM physical_table
```

#### Answer 2 (score 83)
To insert all data from all columns, just use this:  

```sql
SELECT * INTO #TempTable
FROM OriginalTable
```

Don't forget to `DROP` the temporary table after you have finished with it and <em>before</em> you try creating it again:  

```sql
DROP TABLE #TempTable
```

#### Answer 3 (score 72)
```sql
SELECT  ID , Date , Name into #temp from [TableName]
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 89: How do I do multiple CASE WHEN conditions using SQL Server 2008? (score [736058](https://stackoverflow.com/q/14630984) in 2017)

#### Question
What I'm trying to do is use more than one CASE WHEN condition for the same column.  

Here is my code for the query:  

```sql
   SELECT   Url='',
            p.ArtNo,
            p.[Description],
            p.Specification,
            CASE 
            WHEN 1 = 1 or 1 = 1 
               THEN 1 
               ELSE 0 
            END as Qty,
            p.NetPrice,
            [Status] = 0
      FROM  Product p (NOLOCK)
```

However, what I want to do is use more then one WHEN for the same column "qty".  

As in the following code:  

```sql
IF
// CODE
ELSE IF
// CODE
ELSE IF
// CODE
ELSE
// CODE
```

#### Answer accepted (score 337)
There are <a href="https://docs.microsoft.com/en-in/sql/t-sql/language-elements/case-transact-sql" rel="noreferrer">two formats of case expression</a>. You can do `CASE` with many `WHEN` as;  

```sql
CASE  WHEN Col1 = 1 OR Col3 = 1  THEN 1 
      WHEN Col1 = 2 THEN 2
      ...
      ELSE 0 END as Qty
```

<em>Or</em> a Simple `CASE` expression  

```sql
CASE Col1 WHEN 1 THEN 11 WHEN 2 THEN 21 ELSE 13 END
```

<em>Or</em> `CASE` <em>within</em> `CASE` as;  

```sql
CASE  WHEN Col1 < 2 THEN  
                    CASE Col2 WHEN 'X' THEN 10 ELSE 11 END
      WHEN Col1 = 2 THEN 2
      ...
      ELSE 0 END as Qty
```

#### Answer 2 (score 11)
Just use this one, You have to use more when they are classes.   

```sql
SELECT   Url='',
         p.ArtNo,
         p.[Description],
         p.Specification,
         CASE 
         WHEN 1 = 1 or 1 = 1 
            THEN 1 
         WHEN 2 = 2
             THEN 2
         WHEN 3 = 3
              THEN 3
          ELSE 0 
        END as Qty,
        p.NetPrice,
        [Status] = 0
  FROM  Product p (NOLOCK)
```

#### Answer 3 (score 3)
You can use below example of case when with multiple conditions.  

```sql
SELECT
  id,stud_name,
  CASE
    WHEN marks <= 40 THEN 'Bad'
    WHEN (marks >= 40 AND
      marks <= 100) THEN 'good'
    ELSE 'best'
  END AS Grade
FROM Result
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 90: Write a number with two decimal places SQL server (score [733058](https://stackoverflow.com/q/441600) in 2013)

#### Question
How do you write a number with two decimal places for sql server?  

#### Answer 2 (score 191)
try this  

```sql
SELECT CONVERT(DECIMAL(10,2),YOURCOLUMN)
```

#### Answer 3 (score 61)
Use `Str()` Function. It takes three arguments(the number, the number total characters to display, and the number of decimal places to display  

```sql
  Select Str(12345.6789, 12, 3)
```

displays:  '   12345.679'  ( 3 spaces, 5 digits 12345, a decimal point, and three decimal digits (679). - it rounds if it has to truncate, (unless the integer part is too large for the total size, in which case asterisks are displayed instead.)  

for a Total of 12 characters, with 3 to the right of decimal point.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 91: Remove all spaces from a string in SQL Server (score [729620](https://stackoverflow.com/q/10432086) in 2018)

#### Question
What is the best way to remove all spaces from a string in SQL Server 2008?  

`LTRIM(RTRIM('  a b '))` would remove all spaces at the right and left of the string, but I also need to remove the space in the middle.  

#### Answer accepted (score 348)
Simply replace it;  

```sql
SELECT REPLACE(fld_or_variable, ' ', '')
```

<p><strong>Edit:</strong>
Just to clarify; its a global replace, there is no need to `trim()` or worry about multiple spaces for either `char` or `varchar`:</p>

```sql
create table #t (
    c char(8),
    v varchar(8))

insert #t (c, v) values 
    ('a a'    , 'a a'    ),
    ('a a  '  , 'a a  '  ),
    ('  a a'  , '  a a'  ),
    ('  a a  ', '  a a  ')

select
    '"' + c + '"' [IN], '"' + replace(c, ' ', '') + '"' [OUT]
from #t  
union all select
    '"' + v + '"', '"' + replace(v, ' ', '') + '"'
from #t 
```

<strong>Result</strong>  

```sql
IN             OUT
===================
"a a     "     "aa"
"a a     "     "aa"
"  a a   "     "aa"
"  a a   "     "aa"
"a a"          "aa"
"a a  "        "aa"
"  a a"        "aa"
"  a a  "      "aa"
```

#### Answer 2 (score 33)
I would use a REPLACE  

```sql
select REPLACE (' Hello , How Are You ?', ' ', '' )
```

<a href="http://msdn.microsoft.com/en-us/library/ms186862.aspx">REPLACE</a>  

#### Answer 3 (score 23)
If it is an update on a table all you have to do is run this update multiple times until it is affecting 0 rows.  

```sql
update tableName
set colName = REPLACE(LTRIM(RTRIM(colName)), '  ', ' ')
where colName like '%  %'
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 92: error, string or binary data would be truncated when trying to insert (score [726384](https://stackoverflow.com/q/5591473) in 2017)

#### Question
I am running data.bat file with the following lines:  

```sql
Rem Tis batch file will populate tables

cd\program files\Microsoft SQL Server\MSSQL
osql -U sa -P Password -d MyBusiness -i c:\data.sql
```

The contents of the data.sql file is:  

```sql
   insert Customers
            (CustomerID, CompanyName, Phone)
             Values('101','Southwinds','19126602729')
```

There are 8 more similar lines for adding records.  

When I run this with `start` > `run` > `cmd` > `c:\data.bat`, I get this error message:  

```sql
1>2>3>4>5>....<1 row affected>
Msg 8152, Level 16, State 4, Server SP1001, Line 1
string or binary data would be truncated.

<1 row affected>

<1 row affected>

<1 row affected>

<1 row affected>

<1 row affected>

<1 row affected>
```

Also, I am a newbie obviously, but what do `Level #`, and `state #` mean, and how do I look up error messages such as the one above: 8152?  

#### Answer accepted (score 577)
From <a href="http://www.tek-tips.com/viewthread.cfm?qid=1042136" rel="noreferrer">@gmmastros's answer</a>  

Whenever you see the message....  

```sql
string or binary data would be truncated 
```

Think to yourself... The field is NOT big enough to hold my data.  

Check the table structure for the customers table.  I think you'll find that the length of one or more fields is NOT big enough to hold the data you are trying to insert.  For example, if the Phone field is a varchar(8) field, and you try to put 11 characters in to it, you will get this error.   

#### Answer 2 (score 21)
<p>I had this issue although data length was shorter than the field length.
It turned out that the problem was having another log table (for audit trail), filled by a trigger on the main table, where the column size also had to be changed.</p>

#### Answer 3 (score 18)
In one of the `INSERT` statements you are attempting to insert a too long string into a string (`varchar` or `nvarchar`) column.  

If it's not obvious which `INSERT` is the offender by a mere look at the script, you could count the `&lt;1 row affected&gt;` lines that occur <em>before</em> the error message. The obtained number plus one gives you the statement number. In your case it seems to be the second INSERT that produces the error.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 93: How to select all records from one table that do not exist in another table? (score [725294](https://stackoverflow.com/q/2686254) in 2013)

#### Question
<blockquote>
  <p>table1 (id, name)<br>
  table2 (id, name)</p>
</blockquote>

Query:  

```sql
SELECT name   
FROM table2  
-- that are not in table1 already
```

#### Answer accepted (score 753)
```sql
SELECT t1.name
FROM table1 t1
LEFT JOIN table2 t2 ON t2.name = t1.name
WHERE t2.name IS NULL
```

<strong>Q</strong>: What is happening here?  

<strong>A</strong>: Conceptually, we select all rows from `table1` and for each row we attempt to find a row in `table2` with the same value for the `name` column. If there is no such row, we just leave the `table2` portion of our result empty for that row. Then we constrain our selection by picking only those rows in the result where the matching row does not exist. Finally, We ignore all fields from our result except for the `name` column (the one we are sure that exists, from `table1`).  

While it may not be the most performant method possible in all cases, it should work in basically every database engine ever that attempts to implement <a href="https://en.wikipedia.org/wiki/SQL-92" rel="noreferrer">ANSI 92 SQL</a>  

#### Answer 2 (score 214)
You can either do  

```sql
SELECT name
FROM table2
WHERE name NOT IN
    (SELECT name 
     FROM table1)
```

or  

```sql
SELECT name 
FROM table2 
WHERE NOT EXISTS 
    (SELECT * 
     FROM table1 
     WHERE table1.name = table2.name)
```

<hr>

See <a href="https://stackoverflow.com/questions/2246772/whats-the-difference-between-not-exists-vs-not-in-vs-left-join-where-is-null">this question</a> for 3 techniques to accomplish this  

#### Answer 3 (score 69)
I don't have enough rep points to vote up the 2nd answer. But I have to disagree with the comments on the top answer. The second answer:  

```sql
SELECT name
FROM table2
WHERE name NOT IN
    (SELECT name 
     FROM table1)
```

Is FAR more efficient in practice. I don't know why, but I'm running it against 800k+ records and the difference is tremendous with the advantage given to the 2nd answer posted above. Just my $0.02  

</b> </em> </i> </small> </strong> </sub> </sup>

### 94: MySQL query String contains (score [721783](https://stackoverflow.com/q/2602252) in 2017)

#### Question
I've been trying to figure out how I can make a query with MySQL that checks if the value (string `$haystack` ) in a certain column contains certain data (string `$needle`), like this:  

```sql
mysql_query("
SELECT *
FROM `table`
WHERE `column`.contains('{$needle}')
");
```

In PHP, the function is called `substr($haystack, $needle)`, so maybe:  

```sql
WHERE substr(`column`, '{$needle}')=1
```

#### Answer accepted (score 396)
Quite simple actually:  

```sql
mysql_query("
SELECT *
FROM `table`
WHERE `column` LIKE '%{$needle}%'
");
```

The `%` is a wildcard for any character. Do note that this can get slow on very large datasets so if your database grows you'll need to use fulltext indices.  

#### Answer 2 (score 132)
Use:  

```sql
SELECT *
  FROM `table`
 WHERE INSTR(`column`, '{$needle}') > 0
```

Reference:  

<ul>
<li><a href="http://dev.mysql.com/doc/refman/5.0/en/string-functions.html#function_instr" rel="noreferrer">INSTR</a></li>
</ul>

#### Answer 3 (score 50)
```sql
WHERE `column` LIKE '%$needle%'
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 95: Oracle SELECT TOP 10 records (score [720286](https://stackoverflow.com/q/2498035) in 2017)

#### Question
I have an big problem with an SQL Statement in Oracle. I want to select the TOP 10 Records ordered by STORAGE_DB which aren't in a list from an other select statement.  

This one works fine for all records:  

```sql
SELECT DISTINCT 
  APP_ID, 
  NAME, 
  STORAGE_GB, 
  HISTORY_CREATED, 
  TO_CHAR(HISTORY_DATE, 'DD.MM.YYYY') AS HISTORY_DATE  
  FROM HISTORY WHERE 
      STORAGE_GB IS NOT NULL AND 
        APP_ID NOT IN (SELECT APP_ID
                       FROM HISTORY
                        WHERE TO_CHAR(HISTORY_DATE, 'DD.MM.YYYY') = '06.02.2009') 
```

But when I am adding   

```sql
AND ROWNUM <= 10
ORDER BY STORAGE_GB DESC
```

I'm getting some kind of "random" Records. I think because the limit takes in place before the order.  

Does someone has an good solution? The other problem: This query is realy slow (10k+ records)  

#### Answer accepted (score 173)
You'll need to put your current query in subquery as below :  

```sql
SELECT * FROM (
  SELECT DISTINCT 
  APP_ID, 
  NAME, 
  STORAGE_GB, 
  HISTORY_CREATED, 
  TO_CHAR(HISTORY_DATE, 'DD.MM.YYYY') AS HISTORY_DATE  
  FROM HISTORY WHERE 
    STORAGE_GB IS NOT NULL AND 
      APP_ID NOT IN (SELECT APP_ID FROM HISTORY WHERE TO_CHAR(HISTORY_DATE, 'DD.MM.YYYY') ='06.02.2009')
  ORDER BY STORAGE_GB DESC )
WHERE ROWNUM <= 10
```

<p>Oracle applies <a href="http://www.adp-gmbh.ch/ora/sql/rownum.html" rel="noreferrer">rownum</a> to the result after it has been returned.<br> You need to filter the result after it has been returned, so a subquery is required. You can also use <a href="http://www.adp-gmbh.ch/ora/sql/analytical/rank.html" rel="noreferrer">RANK()</a> function to get Top-N results.
<br><br>
For performance try using `NOT EXISTS` in place of `NOT IN`. See <a href="http://www.4tm.com.ar/4tmsite/wordpress/?p=25" rel="noreferrer">this</a> for more.</p>

#### Answer 2 (score 31)
If you are using Oracle 12c, use:   

<blockquote>
  FETCH NEXT <strong><em>N</em></strong> ROWS ONLY  
</blockquote>

```sql
SELECT DISTINCT 
  APP_ID, 
  NAME, 
  STORAGE_GB, 
  HISTORY_CREATED, 
  TO_CHAR(HISTORY_DATE, 'DD.MM.YYYY') AS HISTORY_DATE  
  FROM HISTORY WHERE 
    STORAGE_GB IS NOT NULL AND 
      APP_ID NOT IN (SELECT APP_ID FROM HISTORY WHERE TO_CHAR(HISTORY_DATE, 'DD.MM.YYYY') ='06.02.2009')
  ORDER BY STORAGE_GB DESC
FETCH NEXT 10 ROWS ONLY
```

More info: <a href="http://docs.oracle.com/javadb/10.5.3.0/ref/rrefsqljoffsetfetch.html" rel="noreferrer">http://docs.oracle.com/javadb/10.5.3.0/ref/rrefsqljoffsetfetch.html</a>  

#### Answer 3 (score 22)
With regards to the poor performance there are any number of things it could be, and it really ought to be a separate question.  However, there is one obvious thing that could be a problem:    

```sql
WHERE TO_CHAR(HISTORY_DATE, 'DD.MM.YYYY') = '06.02.2009') 
```

If HISTORY_DATE really is a date column and if it has an index then this rewrite will perform better:  

```sql
WHERE HISTORY_DATE = TO_DATE ('06.02.2009', 'DD.MM.YYYY')  
```

This is because a datatype conversion disables the use of a B-Tree index.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 96: Pad a string with leading zeros so it's 3 characters long in SQL Server 2008 (score [718842](https://stackoverflow.com/q/16760900) in 2015)

#### Question
I have a string that is up to 3 characters long when it's first created in SQL Server 2008 R2.  

I would like to pad it with leading zeros, so if its original value was '1' then the new value would be '001'. Or if its original value was '23' the new value is '023'. Or if its original value is '124' then new value is the same as original value.  

I am using SQL Server 2008 R2. How would I do this using T-SQL?  

#### Answer accepted (score 613)
If the field is already a string, this will work  

```sql
 SELECT RIGHT('000'+ISNULL(field,''),3)
```

If you want nulls to show as '000'  

It might be an integer -- then you would want   

```sql
 SELECT RIGHT('000'+CAST(field AS VARCHAR(3)),3)
```

<blockquote>
  As required by the question this answer only works if the length &lt;= 3, if you want something larger you need to change the string constant and the two integer constants to the width needed.  eg `'0000' and VARCHAR(4)),4`  
</blockquote>

#### Answer 2 (score 122)
Although the question was for SQL Server 2008 R2, in case someone is reading this with version 2012 and above, since then it became much easier by the use of <a href="https://msdn.microsoft.com/en-us/library/hh213505.aspx" rel="noreferrer">FORMAT</a>.  

You can either pass a <a href="https://docs.microsoft.com/en-us/dotnet/standard/base-types/standard-numeric-format-strings" rel="noreferrer">standard numeric format string</a> or a <a href="https://docs.microsoft.com/en-us/dotnet/standard/base-types/custom-numeric-format-strings" rel="noreferrer">custom numeric format string</a> as the format argument (thank <a href="https://stackoverflow.com/users/1548895/vadim-ovchinnikov">Vadim Ovchinnikov</a> for this hint).  

For this question for example a code like  

```sql
DECLARE @myInt INT = 1;
-- One way using a standard numeric format string
PRINT FORMAT(@myInt,'D3');
-- Other way using a custom numeric format string
PRINT FORMAT(@myInt,'00#');
```

outputs  

```sql
001
001
```

#### Answer 3 (score 101)
<strong>The safe method:</strong>  

```sql
SELECT REPLACE(STR(n,3),' ','0')
```

This has the advantage of returning the string `'***'` for n &lt; 0 or n > 999, which is a nice and obvious indicator of out-of-bounds input. The other methods listed here will fail silently by truncating the input to a 3-character substring.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 97: Best approach to remove time part of datetime in SQL Server (score [715443](https://stackoverflow.com/q/1177449) in 2011)

#### Question
Which method provides the best performance when removing the time portion from a datetime field in SQL Server?  

```sql
a) select DATEADD(dd, DATEDIFF(dd, 0, getdate()), 0)
```

or  

```sql
b) select cast(convert(char(11), getdate(), 113) as datetime)
```

The second method does send a few more bytes either way but that might not be as important as the speed of the conversion.  

Both also appear to be very fast, but there might be a difference in speed when dealing with hundreds-of-thousands or more rows?  

Also, is it possible that there are even better methods to get rid of the time portion of a datetime in SQL?  

#### Answer accepted (score 536)
Strictly, method `a` is the least resource intensive:  

```sql
a) select DATEADD(dd, DATEDIFF(dd, 0, getdate()), 0)
```

Proven less CPU intensive for same total duration a million rows by some one with way too much time on their hands: <a href="https://stackoverflow.com/questions/133081/most-efficient-way-in-sql-server-to-get-date-from-datetime">Most efficient way in SQL Server to get date from date+time?</a>  

I saw a similar test elsewhere with similar results too.  

I prefer the DATEADD/DATEDIFF because:  

<ul>
<li>varchar is subject to language/dateformat issues<br>
Example: <a href="https://stackoverflow.com/q/3596663/27535">Why is my CASE expression non-deterministic?</a></li>
<li>float relies on internal storage</li>
<li>it extends to work out first day of month, tomorrow etc by changing "0" base</li>
</ul>

<strong>Edit, Oct 2011</strong>  

For SQL Server 2008+, you can CAST to `date`. Or just use `date` so no time to remove.  

<strong>Edit, Jan 2012</strong>  

A worked example of how flexible this is: <a href="https://stackoverflow.com/questions/8722022/need-to-calculate-by-rounded-time-or-date-figure-in-sql-server/8723311#8723311">Need to calculate by rounded time or date figure in sql server</a>  

<strong>Edit, May 2012</strong>  

Do not use this in WHERE clauses and the like without thinking: adding a function or CAST to a column invalidates index usage. See number 2 here: <a href="http://www.simple-talk.com/sql/t-sql-programming/ten-common-sql-programming-mistakes/" rel="noreferrer">http://www.simple-talk.com/sql/t-sql-programming/ten-common-sql-programming-mistakes/</a>  

Now, this does have an example of later SQL Server optimiser versions managing CAST to date correctly, but <em>generally</em> it will be a bad idea ...  

<strong>Edit, Sep 2018, for datetime2</strong>  

```sql
DECLARE @datetime2value datetime2 = '02180912 11:45' --this is deliberately within datetime2, year 0218
DECLARE @datetime2epoch datetime2 = '19000101'

select DATEADD(dd, DATEDIFF(dd, @datetime2epoch, @datetime2value), @datetime2epoch)
```

#### Answer 2 (score 62)
In SQL Server 2008, you can use:  

```sql
CONVERT(DATE, getdate(), 101)
```

#### Answer 3 (score 45)
Of-course this is an old thread but to make it complete.  

From SQL 2008 you can use DATE datatype so you can simply do:  

```sql
SELECT CONVERT(DATE,GETDATE())
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 98: The multi-part identifier could not be bound (score [713638](https://stackoverflow.com/q/7314134) in 2016)

#### Question
<p>I've seen similar errors on SO, but I don't find a solution for my problem.
I have a SQL query like:</p>

```sql
SELECT DISTINCT
        a.maxa ,
        b.mahuyen ,
        a.tenxa ,
        b.tenhuyen ,
        ISNULL(dkcd.tong, 0) AS tongdkcd
FROM    phuongxa a ,
        quanhuyen b
        LEFT OUTER JOIN ( SELECT    maxa ,
                                    COUNT(*) AS tong
                          FROM      khaosat
                          WHERE     CONVERT(DATETIME, ngaylap, 103) BETWEEN 'Sep 1 2011'
                                                              AND
                                                              'Sep 5 2011'
                          GROUP BY  maxa
                        ) AS dkcd ON dkcd.maxa = a.maxa
WHERE   a.maxa <> '99'
        AND LEFT(a.maxa, 2) = b.mahuyen
ORDER BY maxa;
```

<p>When I execute this query, the error result is:
<strong>The multi-part identifier "a.maxa" could not be bound.</strong> Why?
<br>
P/s: if i divide the query into 2 individual query, it run ok.</p>

```sql
SELECT DISTINCT
        a.maxa ,
        b.mahuyen ,
        a.tenxa ,
        b.tenhuyen
FROM    phuongxa a ,
        quanhuyen b
WHERE   a.maxa <> '99'
        AND LEFT(a.maxa, 2) = b.mahuyen
ORDER BY maxa;
```

and  

```sql
SELECT  maxa ,
        COUNT(*) AS tong
FROM    khaosat
WHERE   CONVERT(DATETIME, ngaylap, 103) BETWEEN 'Sep 1 2011'
                                        AND     'Sep 5 2011'
GROUP BY maxa;
```

#### Answer accepted (score 209)
You are mixing implicit joins with explicit joins. That is allowed, but you need to be aware of how to do that properly.  

The thing is, explicit joins (the ones that are implemented using the `JOIN` keyword) take precedence over implicit ones (the 'comma' joins, where the join condition is specified in the `WHERE` clause).  

Here's an outline of your query:  

```sql
SELECT
  …
FROM a, b LEFT JOIN dkcd ON …
WHERE …
```

You are probably expecting it to behave like this:  

```sql
SELECT
  …
FROM (a, b) LEFT JOIN dkcd ON …
WHERE …
```

that is, the combination of tables `a` and `b` is joined with the table `dkcd`. In fact, what's happening is  

```sql
SELECT
  …
FROM a, (b LEFT JOIN dkcd ON …)
WHERE …
```

that is, as you may already have understood, `dkcd` is joined specifically against `b` and only `b`, then the result of the join is combined with `a` and filtered further with the `WHERE` clause. In this case, any reference to `a` in the `ON` clause is invalid, `a` is unknown at that point. That is why you are getting the error message.  

If I were you, I would probably try to rewrite this query, and one possible solution might be:  

```sql
SELECT DISTINCT
  a.maxa,
  b.mahuyen,
  a.tenxa,
  b.tenhuyen,
  ISNULL(dkcd.tong, 0) AS tongdkcd
FROM phuongxa a
  INNER JOIN quanhuyen b ON LEFT(a.maxa, 2) = b.mahuyen
  LEFT OUTER JOIN (
    SELECT
      maxa,
      COUNT(*) AS tong
    FROM khaosat
    WHERE CONVERT(datetime, ngaylap, 103) BETWEEN 'Sep 1 2011' AND 'Sep 5 2011'
    GROUP BY maxa
  ) AS dkcd ON dkcd.maxa = a.maxa
WHERE a.maxa <> '99'
ORDER BY a.maxa
```

Here the tables `a` and `b` are joined first, then the result is joined to `dkcd`. Basically, this is the same query as yours, only using a different syntax for one of the joins, which makes a great difference: the reference `a.maxa` in the `dkcd`'s join condition is now absolutely valid.  

As @Aaron Bertrand has correctly noted, you should probably qualify `maxa` with a specific alias, probably `a`, in the `ORDER BY` clause.  

#### Answer 2 (score 37)
Sometimes this error occurs when you use your schema (dbo) in your query in a wrong way.  

for example if you write:  

```sql
select dbo.prd.name
from dbo.product prd
```

you will get the error.  

In this situations change it to:  

```sql
select prd.name
from dbo.product prd
```

#### Answer 3 (score 10)
if you have given alies name change that to actual name   

for example  

```sql
SELECT  
    A.name,A.date
  FROM [LoginInfo].[dbo].[TableA] as A
   join 
  [LoginInfo].[dbo].[TableA] as B 
  on  [LoginInfo].[dbo].[TableA].name=[LoginInfo].[dbo].[TableB].name;
```

change that to   

```sql
SELECT  
    A.name,A.date
  FROM [LoginInfo].[dbo].[TableA] as A
   join 
  [LoginInfo].[dbo].[TableA] as B 
  on  A.name=B.name;
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 99: Get month and year from a datetime in SQL Server 2005 (score [711888](https://stackoverflow.com/q/45535) in 2017)

#### Question
I need the month+year from the datetime in SQL Server like 'Jan 2008'. I'm grouping the query by month, year. I've searched and found functions like datepart, convert, etc., but none of them seem useful for this. Am I missing something here? Is there a function for this?  

#### Answer accepted (score 72)
If you mean you want them back as a string, in that format;  

```sql
SELECT 
  CONVERT(CHAR(4), date_of_birth, 100) + CONVERT(CHAR(4), date_of_birth, 120) 
FROM customers
```

<a href="http://msdn.microsoft.com/en-us/library/ms187928.aspx" rel="noreferrer">Here are the other format options</a>  

#### Answer 2 (score 168)
```sql
select 
datepart(month,getdate()) -- integer (1,2,3...)
,datepart(year,getdate()) -- integer
,datename(month,getdate()) -- string ('September',...)
```

#### Answer 3 (score 40)
Beginning with SQL Server 2012, you can use:  

```sql
SELECT FORMAT(@date, 'yyyyMM')
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 100: How do I list all the columns in a table? (score [710519](https://stackoverflow.com/q/1580450) in )

#### Question
For the various popular database systems, how do you list all the columns in a table?  

#### Answer 2 (score 239)
For MySQL, use:  

```sql
DESCRIBE name_of_table;
```

This also works for Oracle as long as you are using SQL*Plus, or Oracle's SQL Developer.  

#### Answer 3 (score 111)
For Oracle (PL/SQL)  

```sql
SELECT column_name
FROM user_tab_cols
WHERE table_name = 'myTableName'
```

For MySQL  

```sql
SHOW COLUMNS FROM table_name
```

</section>

