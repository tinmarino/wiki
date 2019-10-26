-- Send me here: https://data.stackexchange.com/stackoverflow/query/new

SELECT TOP 100
-- Meta
p.Id                 AS "id",
min(p.Title)         AS "title",
min(p.ViewCount)     AS "view",

-- Question
min(p.Body)          AS "question",
min(p.Score)         AS "score_q",
min(p.LastEditDate)  AS "date_q",

-- Answsers
min(a.Body)          AS "answer1",
min(a.Score)         AS "score1",
min(a.LastEditDate)  AS "date2",

min(b.Body)          AS "answer2",
min(b.Score)         AS "score2",
min(b.LastEditDate)  AS "date2",

min(c.Body)          AS "answer3",
min(c.Score)         AS "score3",
min(c.LastEditDate)  AS "date3"



FROM Posts p

-- Join Accepted answer
left outer JOIN Posts a ON p.AcceptedAnswerId = a.Id

-- Join best not a
left outer JOIN Posts b
    ON p.Id = b.ParentId 
    AND (a.Id is null or b.Id is null or  b.Id != a.Id)
AND b.Score =
(
    select max(n.Score) as maxscore
    from Posts n
    where n.ParentId = p.Id
        AND (a.Id is null or n.Id != a.Id)
)

-- Join best not a not b
left outer JOIN Posts c ON 
	p.Id = c.ParentId
    AND (a.Id is null or c.Id is null or  a.Id != c.Id)
    AND (b.Id is null or c.Id is null or  b.Id != c.Id)
    AND c.Score =
(
   select max(n.Score) as maxscore
   from Posts n 
   where n.ParentId = p.Id
        AND (a.Id is null or n.Id != a.Id)
        AND (b.Id is null or n.Id != b.Id)
)

-- Get tags
inner join posttags pt on pt.postid = p.id
inner join tags t on pt.tagid = t.id

WHERE 
t.tagname in ('python')  -- tag
AND p.PostTypeId = 1   -- select questions
-- AND p.Score > 1000  -- if slow (java, js)


GROUP BY p.ID, p.ViewCount

ORDER BY p.ViewCount DESC
