### Function complexity

1. Deeply nested control structures: e.g. for-loops 3 levels deep or even just 2 levels deep with nested if-statements that have complex conditions.
2. Too many state-defining parameters: By state-defining parameter, I mean a function parameter that guarantees a particular execution path through the function. Get too many of these type of parameters and you have a combinatorial explosion of execution paths (this usually happens in tandem with #1).
3. Logic that is duplicated in other methods: poor code re-use is a huge contributor to monolithic procedural code. A lot of such logic duplication can be very subtle, but once re-factored, the end result can be a far more elegant design.
4. Excessive inter-class coupling: this lack of proper encapsulation results in functions being concerned with intimate characteristics of other classes, hence lengthening them.
5. Unnecessary overhead: Comments that point out the obvious, deeply nested classes, superfluous getters and setters for private nested class variables, and unusually long function/variable names can all create syntactic noise within related functions that will ultimately increase their length.
6. Your massive developer-grade display isn't big enough to display it: Actually, displays of today are big enough that a function that is anywhere close to its height is probably way too long. But, if it is larger, this is a smoking gun that something is wrong.
7. You can't immediately determine the function's purpose: Furthermore, once you actually do determine its purpose, if you can't summarize this purpose in a single sentence or happen to have a tremendous headache, this should be a clue.

In conclusion, monolithic functions can have far-reaching consequences and are often a symptom of major design deficiencies. Whenever I encounter code that is an absolute joy to read, it's elegance is immediately apparent. And guess what: the functions are often very short in length.

### Constructor should have maximum 3 arguments

* Single responsability principle

The ideal number of arguments for a function is zero (niladic). Next comes one (monadic) followed closely by two (dyadic). Three arguments (triadic) should be avoided where possible. More than three (polyadic) requires very special justification—and then shouldn't be used anyway.

Imagine the difficulty of writing all the test cases to ensure that all various combinations of arguments work properly.

If more, consider creating a factory

```java
public class Customer {
    private final String firstName;
    private final String surname;
    private final String ssn;

    Customer(CustomerBuilder builder) {
        if (builder.firstName == null) throw new NullPointerException("firstName");
        if (builder.surname == null) throw new NullPointerException("surname");
        if (builder.ssn == null) throw new NullPointerException("ssn");
        this.firstName = builder.firstName;
        this.surname = builder.surname;
        this.ssn = builder.ssn;
    }

    public String getFirstName() { return firstName;  }
    public String getSurname() { return surname; }
    public String getSsn() { return ssn; }    
}


public class Client {
    public void doSomething() {
        Customer customer = customer()
            .withSurname("Smith")
            .withFirstName("Fred")
            .withSsn("123XS1")
            .build();
    }
}

```

### Null a freed pointer (and uninitialised)


Setting unused pointers to NULL is a defensive style, protecting against dangling pointer bugs. If a dangling pointer is accessed after it is freed, you may read or overwrite random memory. If a null pointer is accessed, you get an immediate crash on most systems, telling you right away what the error is.

For local variables, it may be a little bit pointless if it is "obvious" that the pointer isn't accessed anymore after being freed, so this style is more appropriate for member data and global variables. Even for local variables, it may be a good approach if the function continues after the memory is released.

To complete the style, you should also initialize pointers to NULL before they get assigned a true pointer value.

### Replace Nested Conditional with Guard Clauses

Exiting early allows you to pop stuff off your limited mental stack. :
```
public void SomeFunction(bool someCondition)
{
    if (someCondition)
    {
        // Do Something
    }
}

public void SomeFunction(bool someCondition)
{
    if (!someCondition)
        return;

    // Do Something
}
