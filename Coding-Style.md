---
title: Coding style
category: Computing
wiki_css: Css/color_dark_solarized.css, Css/layout_toc.css
header-includes: <script type="text/javascript" src="Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---


## From So
<section class="level2">

### How do you tell someone they're writing bad code


Introduce questions to make them realise that what they are doing is wrong. For example, ask these sort of questions:

1. Why did you decide to make that a global variable?

2. Why did you give it that name?

3. That's interesting. I usually do mine this way because [Insert reason why you are better]

4. Does that way work? I usually [Insert how you would make them look silly]

I think the ideal way of going about this is subtly asking them why they code a certain way. You may find that they believe that there are benefits to other methods. Unless I knew the reason for their coding style was due to misinformation I would never judge my way as better without good reason. The best way to go about this is to just ask them why they chose that way; be sure to sound interested in their reasoning, because that is what you need to attack, not their ability.

A coding standard will definitely help, but if it were the answer to every software project then we'd all be sipping cocktails on our private islands in paradise. In reality, we're all prone to problems and software projects still have a low success rate. I think the problem would mostly stem from individual ability rather than a problem with convention, which is why I'd suggest working through the problems as a group when a problem rears its ugly head.

Most importantly, __do NOT immediately assume that your way is better__. In reality, it probably is, but we're dealing with another person's opinion and to them there is only one solution. Never say that your way is the better way of doing it unless you want them to see you as a smug loser.

The goal is not for you to teach your team how to code better. It's to establish a culture of learning in your team. Where each person looks to the others for help in becoming a better programmer.

__Globals:__ Do you think we'll ever want to have more than one of these? Do you think we will want to control access to this?

__Mutable state:__ Do you think we'll want to manipulate this from another thread?

__long functions:__ My brain isn't big enough to hold all of this at once. How can we make smaller pieces that I can handle?

__bad names:__ I get confused easily enough when reading clear code; when names are misleading, there's no hope for me.

__If the coder feel attacked -> Game Over: You (both) Lose__

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

* Exiting early allows you to pop stuff off your limited mental stack
* The same way, `break` is allowed only at top of loop (clause)
* Better separation of corner cases from the main method logic
* Another big problem arises when the logic of such code becomes long enough to not fit the screen vertically. At some point you may even forget that it’s there, which would completely break your picture

Probably the most documented case is the guard clause, also known as assert or precondition. The idea is that when you have something to assert in the beginning of a method — do this using a fast return.


```java
public void SomeFunction(bool someCondition)
{
    if (someCondition)
    {
        // Do Something
    }
}
```
```javascript
 
public void SomeFunction(bool someCondition)
{
    if (!someCondition)
        return;

    // Do Something
}
```

### No return in the middle

* a return or throw in the middle of the method is not so easily detected at the first sight
* it requires you to consider that under some circumstances, the main logic of this method will not be executed completely
* every time you’ll have to decide: should you put the new code before or after this return?

```java
public void executeTimer( String timerId ) {
  logger.debug( "Executing timer with ID {}", timerId );  TimerEntity timerEntity = timerRepository.find( timerId );  logger.debug( "Found TimerEntity {} for timer ID {}", timerEntity, timerId );  if( timerEntity == null )
    return;  Timer timer = Timer.fromEntity( timerEntity );
  timersInvoker.execute( timer );
}
```
```java
public void executeTimer( String timerId ) {
  logger.debug( "Executing timer with ID {}", timerId );  TimerEntity timerEntity = timerRepository.find( timerId );  logger.debug( "Found TimerEntity {} for timer ID {}", timerEntity, timerId );  executeTimer( timerEntity );
}
private void executeTimer( TimerEntity timerEntity ) {
  if( timerEntity == null )
    return;  Timer timer = Timer.fromEntity( timerEntity );
  timersInvoker.execute( timer );
}
```


### Anti if

#### Boolean parameters to duplicate method

```java
public void example() {
    FileUtils.createFile("name.txt", "file contents", false);
    FileUtils.createFile("name_temp.txt", "file contents", true);
}

public class FileUtils {
    public static void createFile(String name, String contents, boolean temporary) {
        if(temporary) {
            // save temp file
        } else {
            // save permanent file
        }
    }
}
```
```java
public void example() {
    FileUtils.createFile("name.txt", "file contents");
    FileUtils.createTemporaryFile("name_temp.txt", "file contents");
}

public class FileUtils {
    public static void createFile(String name, String contents) {
        // save permanent file
    }

    public static void createTemporaryFile(String name, String contents) {
        // save temp file
    }
}
```

#### Switch to polymorphism

```java
public class Bird {

    private enum Species {
        EUROPEAN, AFRICAN, NORWEGIAN_BLUE;
    }

    private boolean isNailed;
    private Species type;

    public double getSpeed() {
        switch (type) {
            case EUROPEAN:
                return getBaseSpeed();
            case AFRICAN:
                return getBaseSpeed() - getLoadFactor();
            case NORWEGIAN_BLUE:
                return isNailed ? 0 : getBaseSpeed();
            default:
                return 0;
        }
    }

    private double getLoadFactor() {
        return 3;
    }

    private double getBaseSpeed() {
        return 10;
    }
}
```
```java
public abstract class Bird {

    public abstract double getSpeed();

    protected double getLoadFactor() {
        return 3;
    }

    protected double getBaseSpeed() {
        return 10;
    }
}

public class EuropeanBird extends Bird {
    public double getSpeed() {
        return getBaseSpeed();
    }
}

public class AfricanBird extends Bird {
    public double getSpeed() {
        return getBaseSpeed() - getLoadFactor();
    }
}

public class NorwegianBird extends Bird {
    private boolean isNailed;

    public double getSpeed() {
        return isNailed ? 0 : getBaseSpeed();
    }
}
```

#### Small conditional actions to method

You’ll probably notice this further, when each time you invoke the method you need to add this if-statement because the business logic says so

```java
if( timer.getMode() != TimerMode.DRAFT )
  timer.validate();
```
```java
public void validate() {
  if( mode == TimerMode.DRAFT )
    return;
  
  // validation logic
}
timer.validate();
```

#### NullObject/Optional over null passing

* Avoid null object: prefer `""` or `[]`

Tolerance: It’s necessary to be defensive at the outer parts of your codebase, but being defensive inside your codebase probably means the code that you are writing is offensive. Don’t write offensive code.

Solution: Use a NullObject or Optional type instead of ever passing a null. An empty collection is a great alternative.

```java
public void example() {
    sumOf(null);
}

private int sumOf(List<Integer> numbers) {
    if(numbers == null) {
        return 0;
    }

    return numbers.stream().mapToInt(i -> i).sum();
}
```
```java
public void example() {
    sumOf(new ArrayList<>());
}

private int sumOf(List<Integer> numbers) {
    return numbers.stream().mapToInt(i -> i).sum();
}
```

#### Inline statements into expressions
```java
public boolean horrible(boolean foo, boolean bar, boolean baz) {
    if (foo) {
        if (bar) {
            return true;
        }
    }

    if (baz) {
        return true;
    } else {
        return false;
    }
}
```
To
```java
public boolean horrible(boolean foo, boolean bar, boolean baz) {
    return foo && bar || baz;
}
```

</section>

## Refactoring Catalog

<section class="level2">


### Combine function into class

__Problem:__ Functions are always taking the same parameters

```javascript
function base(aReading) {...}
function taxableCharge(aReading) {...}
function calculateBaseCharge(aReading) {...}
```
```javascript

class Reading {
  base() {...}
  taxableCharge() {...}
  calculateBaseCharge() {...}
}
```


### Consolidate Conditional Expression


```javascript
if (anEmployee.seniority < 2) return 0;
if (anEmployee.monthsDisabled > 12) return 0;
if (anEmployee.isPartTime) return 0;
```
```javascript

if (isNotEligableForDisability()) return 0;

function isNotEligableForDisability() {
  return ((anEmployee.seniority < 2)
          || (anEmployee.monthsDisabled > 12)
          || (anEmployee.isPartTime));
}
```


### Decompose Conditional

__Problem:__ tired of seen deeply nested long statements

```javascript
if (!aDate.isBefore(plan.summerStart) && !aDate.isAfter(plan.summerEnd))
  charge = quantity * plan.summerRate;
else
  charge = quantity * plan.regularRate + plan.regularServiceCharge;
```
```javascript

if (summer())
  charge = summerCharge();
else
  charge = regularCharge();
```


### Encapsulate Record -> Data class


```javascript
organization = {name: "Acme Gooseberries", country: "GB"};
```
```javascript

class Organization {
  constructor(data) {
    this._name = data.name;
    this._country = data.country;
  }
  get name()    {return this._name;}
  set name(arg) {this._name = arg;}
  get country()    {return this._country;}
  set country(arg) {this._country = arg;}
}
```

The caller is happyer


### Extract Class

When can you divide on class in two ? Here:

```javascript
class Person {
  get officeAreaCode() {return this._officeAreaCode;}
  get officeNumber()   {return this._officeNumber;}
```
```javascript

class Person {
  get officeAreaCode() {return this._telephoneNumber.areaCode;}
  get officeNumber()   {return this._telephoneNumber.number;}
}
class TelephoneNumber {
  get areaCode() {return this._areaCode;}
  get number()   {return this._number;}
}
```


### Extract Function

```javascript
function printOwing(invoice) {
  printBanner();
  let outstanding  = calculateOutstanding();

  //print details
  console.log(`name: ${invoice.customer}`);
  console.log(`amount: ${outstanding}`);  
}
```
```javascript

function printOwing(invoice) {
  printBanner();
  let outstanding  = calculateOutstanding();
  printDetails(outstanding);

  function printDetails(outstanding) {
    console.log(`name: ${invoice.customer}`);
    console.log(`amount: ${outstanding}`);
  }
}
```


### Extract Superclass

Heritance is made to mutualize varaibles / functions

```javascript
class Department {
  get totalAnnualCost() {...}
  get name() {...}
  get headCount() {...}
}

class Employee {
  get annualCost() {...}
  get name() {...}
  get id() {...}
}
```
```javascript

class Party {
  get name() {...}
  get annualCost() {...}
}

class Department extends Party {
  get annualCost() {...}
  get headCount() {...}
}

class Employee extends Party {
  get annualCost() {...}
  get id() {...}
}
```


### Extract Variable

__Problem:__ Long declaration line

```javascript
return order.quantity * order.itemPrice -
  Math.max(0, order.quantity - 500) * order.itemPrice * 0.05 +
  Math.min(order.quantity * order.itemPrice * 0.1, 100);
```
```javascript

const basePrice = order.quantity * order.itemPrice;
const quantityDiscount = Math.max(0, order.quantity - 500) * order.itemPrice * 0.05;
const shipping = Math.min(basePrice * 0.1, 100);
return basePrice - quantityDiscount + shipping;
```


### Hide Delegate

inverse of Remove Middle Man

```javascript
manager = aPerson.department.manager;
```
```javascript

manager = aPerson.manager;

class Person {
  get manager() {return this.department.manager;}
```


### Inline

Inverse of extract


### Introduction Assertion

```javascript
if (this.discountRate)
  base = base - (this.discountRate * base);
```
```javascript

assert(this.discountRate >= 0);
if (this.discountRate)
  base = base - (this.discountRate * base);
```


### Introduce Parameter Object

```javascript
function amountInvoiced(startDate, endDate) {...}
function amountReceived(startDate, endDate) {...}
function amountOverdue(startDate, endDate) {...}
```
```javascript

function amountInvoiced(aDateRange) {...}
function amountReceived(aDateRange) {...}
function amountOverdue(aDateRange) {...}
```


### Introduce Special Case

As class

```javascript
if (aCustomer === "unknown") customerName = "occupant";
```
```javascript

class UnknownCustomer {
    get name() {return "occupant";}
```


### Move Statements into Function

__Problem:__ Caller always sanitize/concat in/out of function call

```javascript
result.push(`<p>title: ${person.photo.title}</p>`);
result.concat(photoData(person.photo));

function photoData(aPhoto) {
  return [
    `<p>location: ${aPhoto.location}</p>`,
    `<p>date: ${aPhoto.date.toDateString()}</p>`,
  ];
}
```
```javascript

result.concat(photoData(person.photo));

function photoData(aPhoto) {
  return [
    `<p>title: ${aPhoto.title}</p>`,
    `<p>location: ${aPhoto.location}</p>`,
    `<p>date: ${aPhoto.date.toDateString()}</p>`,
  ];
}
```


### Parametrize Function

Opposite of something (remove parameters)

```javascript
function tenPercentRaise(aPerson) {
  aPerson.salary = aPerson.salary.multiply(1.1);
}
function fivePercentRaise(aPerson) {
  aPerson.salary = aPerson.salary.multiply(1.05);
}
```
```javascript

function raise(aPerson, factor) {
  aPerson.salary = aPerson.salary.multiply(1 + factor);
}
```


### Preserve Whole Object

In function call

```javascript
const low = aRoom.daysTempRange.low;
const high = aRoom.daysTempRange.high;
if (aPlan.withinRange(low, high))
```
```javascript

if (aPlan.withinRange(aRoom.daysTempRange))
```


### Pull Up Constructor Body

Works with fields / methods

```javascript
class Party {...}

class Employee extends Party {
  constructor(name, id, monthlyCost) {
    super();
    this._id = id;
    this._name = name;
    this._monthlyCost = monthlyCost;
  }
}
```
```javascript

class Party {
  constructor(name){
    this._name = name;
  }
}

class Employee extends Party {
  constructor(name, id, monthlyCost) {
    super(name);
    this._id = id;
    this._monthlyCost = monthlyCost;
  }
}
```


### Change Value to Reference

```javascript
let customer = new Customer(customerData);
```
```javascript

let customer = customerRepository.get(customerData.id);
```


### Remove Flag Argument

```javascript
function setDimension(name, value) {
  if (name === "height") {
    this._height = value;
    return;
  }
  if (name === "width") {
    this._width = value;
    return;
  }
}
```
```javascript

function setHeight(value) {this._height = value;}
function setWidth (value) {this._width = value;}
```


### Remove Middle Man

```javascript
manager = aPerson.manager;

class Person {
  get manager() {return this.department.manager;}
```
```javascript

manager = aPerson.department.manager;
```


### Replace Conditional with Polymorphism

```javascript
switch (bird.type) {
  case 'EuropeanSwallow':
    return "average";
  case 'AfricanSwallow':
    return (bird.numberOfCoconuts > 2) ? "tired" : "average";
  case 'NorwegianBlueParrot':
    return (bird.voltage > 100) ? "scorched" : "beautiful";
  default:
    return "unknown";
```
```javascript

class EuropeanSwallow {
  get plumage() {
    return "average";
  }
class AfricanSwallow {
  get plumage() {
     return (this.numberOfCoconuts > 2) ? "tired" : "average";
  }
class NorwegianBlueParrot {
  get plumage() {
     return (this.voltage > 100) ? "scorched" : "beautiful";
  }
```


### Replace Constructor with Factory Function

```javascript
leadEngineer = new Employee(document.leadEngineer, 'E');
```
```javascript

leadEngineer = createEngineer(document.leadEngineer);
```


### Replace Control Flag with Break

```javascript
for (const p of people) {
  if (! found) {
    if ( p === "Don") {
      sendAlert();
      found = true;
    }
```
```javascript

for (const p of people) {
  if ( p === "Don") {
    sendAlert();
    break;
  }
```


### Replace Exception with Precheck

Also called `Clause`

```javascript
double getValueForPeriod (int periodNumber) {
  try {
    return values[periodNumber];
  } catch (ArrayIndexOutOfBoundsException e) {
    return 0;
  }
}
```
```javascript

double getValueForPeriod (int periodNumber) {
  return (periodNumber >= values.length) ? 0 : values[periodNumber];
}
```


### Replace Inline Code with Function Call

```javascript
let appliesToMass = false;
for(const s of states) {
  if (s === "MA") appliesToMass = true;
}
```
```javascript

appliesToMass = states.includes("MA");
```


### Replace Loop with Pipeline

__Keywords:__ Streams, Functional progamming

```javascript
const names = [];
for (const i of input) {
  if (i.job === "programmer")
    names.push(i.name);
}
```
```javascript

  const names = input
    .filter(i => i.job === "programmer")
    .map(i => i.name)
  ;
```


### Replace Magic Literal

With constants

```javascript
function potentialEnergy(mass, height) {
  return mass * 9.81 * height;
}
```
```javascript

const STANDARD_GRAVITY = 9.81;
function potentialEnergy(mass, height) {
  return mass * STANDARD_GRAVITY * height;
}
```


### Replace Parameter with Query

That is why it is better to pass the full object

```javascript
availableVacation(anEmployee, anEmployee.grade);

function availableVacation(anEmployee, grade) {
  // calculate vacation...
```
```javascript

availableVacation(anEmployee)

function availableVacation(anEmployee) {
  const grade = anEmployee.grade;
  // calculate vacation...
```


### Replace Temp with Query

```javascript
const basePrice = this._quantity * this._itemPrice;
if (basePrice > 1000)
  return basePrice * 0.95;
else
  return basePrice * 0.98;
```
```javascript

get basePrice() {this._quantity * this._itemPrice;}

...

if (this.basePrice > 1000)
  return this.basePrice * 0.95;
else
  return this.basePrice * 0.98;
```


### Replace Type Code with Subclasses

```javascript
function createEmployee(name, type) {
  return new Employee(name, type);
}
```
```javascript

function createEmployee(name, type) {
  switch (type) {
    case "engineer": return new Engineer(name);
    case "salesman": return new Salesman(name);
    case "manager":  return new Manager (name);
  }
```


### Return Modified Value

Of input

```javascript
let totalAscent = 0;
calculateAscent();

function calculateAscent() {
  for (let i = 1; i < points.length; i++) {
    const verticalChange = points[i].elevation - points[i-1].elevation;
    totalAscent += (verticalChange > 0) ? verticalChange : 0;
  }
}
```
```javascript

const totalAscent = calculateAscent();

function calculateAscent() {
  let result = 0;
  for (let i = 1; i < points.length; i++) {
    const verticalChange = points[i].elevation - points[i-1].elevation;
    result += (verticalChange > 0) ? verticalChange : 0;
  }
  return result;
}
```


### Separate Query from Modifier

```javascript
function getTotalOutstandingAndSendBill() {
  const result = customer.invoices.reduce((total, each) => each.amount + total, 0);
  sendBill();
  return result;
}
```
```javascript

function totalOutstanding() {
  return customer.invoices.reduce((total, each) => each.amount + total, 0);  
}
function sendBill() {
  emailGateway.send(formatBill(customer));
}
```


### Slide statement

Together, far from call

aliases Consolidate Duplicate Conditional Fragments

```javascript
const pricingPlan = retrievePricingPlan();
const order = retreiveOrder();
let charge;
const chargePerUnit = pricingPlan.unit;
```
```javascript

const pricingPlan = retrievePricingPlan();
const chargePerUnit = pricingPlan.unit;
const order = retreiveOrder();
let charge;
```


### Split Loop

Work with the ass little nesting level as possible -> return from loop early

```javascript
let averageAge = 0;
let totalSalary = 0;
for (const p of people) {
  averageAge += p.age;
  totalSalary += p.salary;
}
averageAge = averageAge / people.length;
```
```javascript

let totalSalary = 0;
for (const p of people) {
  totalSalary += p.salary;
}

let averageAge = 0;
for (const p of people) {
  averageAge += p.age;
}
averageAge = averageAge / people.length;
```


### Split Phase

```javascript
const orderData = orderString.split(/\s+/);
const productPrice = priceList[orderData[0].split("-")[1]];
const orderPrice = parseInt(orderData[1]) * productPrice;
```
```javascript

const orderRecord = parseOrder(order);
const orderPrice = price(orderRecord, priceList);

function parseOrder(aString) {
  const values =  aString.split(/\s+/);
  return ({
    productID: values[0].split("-")[1],
    quantity: parseInt(values[1]),
  });
}
function price(order, priceList) {
  return order.quantity * priceList[order.productID];
}
```


### Split Variable

```javascript
let temp = 2 * (height + width);
console.log(temp);
temp = height * width;
console.log(temp);
```
```javascript

const perimeter = 2 * (height + width);
console.log(perimeter);
const area = height * width;
console.log(area);
```


### Substitute Algorithm

```javascript
function foundPerson(people) {
  for(let i = 0; i < people.length; i++) {
    if (people[i] === "Don") {
      return "Don";
    }
    if (people[i] === "John") {
      return "John";
    }
    if (people[i] === "Kent") {
      return "Kent";
    }
  }
  return "";
}
```
```javascript

function foundPerson(people) {
  const candidates = ["Don", "John", "Kent"];
  return people.find(p => candidates.includes(p)) || '';
}

```


</section>
