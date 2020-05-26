
x, y, z = 10, 20, 30  # parralel asignment

# HackerRank

```ruby
print self  # OUTPUT: main (if not in main exe)

# Variadic argument
def full_name(*rest)
    return rest.join(' ')
end

# Argument Hash
def fetch_file(uri, options)
    if options.has_key?(:proxy)
        # do something
    end
end

# Argument Optional
def foo(x, str: "foo", num: 424242)
  [x, str, num]
end
foo(13) #=> [13, 'foo', 424242]
foo(13, str: 'bar') #=> [13, 'bar', 424242]

# Argument optional hash
def foo(str: "foo", num: 424242, **options)
  [str, num, options]
end
foo #=> ['foo', 424242, {}]
foo(check: true) # => ['foo', 424242, {check: true}]






```


### Temperature conversion

```ruby
# My
def convert_temp(cel, input_scale:, output_scale: 'celsius')
    if input_scale.downcase == 'kelvin'
        cel = cel - 273.15
    elsif input_scale.downcase == 'fahrenheit'
        cel = (cel - 32) / (9/5)
    end
    
    if output_scale == 'kelvin'
        return cel + 273.15;
    elsif output_scale == 'fahrenheit'
        return (cel * 9/5) + 32
    else
        return cel
    end
end

# Their
def convert_temp(temp, input_scale:, output_scale: 'Celsius')
    case input_scale.downcase
    when 'fahrenheit'
        return output_scale == 'kelvin' ? 
        ((temp - 32) / 1.8) + 273.15 : (temp - 32) / 1.8
    when 'celsius'
        return output_scale == 'kelvin' ? 
        temp + 273.15 : (temp * 1.8) + 32
    when 'kelvin'
        return output_scale == 'celsius' ? 
        temp - 273.15 : (temp - 273.15) * 1.8
    end
end
```

### Block

```ruby
def factorial (n)
  yield (1..n).reduce(:*)
end

n = gets.to_i
factorial(n) do |result|
    puts result
end
```

### Proc

```ruby
def square_of_sum (my_array, proc_square, proc_sum)
    sum = proc_sum.call(my_array)
    proc_square.call(sum)
end

proc_square_number = proc {|num| num ** 2}
proc_sum_array     = proc {|arr| arr.reduce(0, :+)}
my_array = gets.split().map(&:to_i)

puts square_of_sum(my_array, proc_square_number, proc_sum_array)
```

### Lambda

Lambdas can be used as arguments to higher-order functions. They can also be used to construct the result of a higher-order function that needs to return a function.

* No argument:
```ruby
def area (l, b)
   -> { l * b } 
end

x = 10.0; y = 20.0

area_rectangle = area(x, y).call
area_triangle = 0.5 * area(x, y).()

puts area_rectangle     #200.0
puts area_triangle      #100.0
```

* With argument:
```ruby
area = ->(a, b) { a * b }

x = 10.0; y = 20.0

area_rectangle = area.(x, y)
area_triangle = 0.5 * area.call(x, y)

puts area_rectangle     #200.0
puts area_triangle      #100.0    
```

```ruby
# Write a lambda which takes an integer and square it
square      = ->(i) { i ** 2}

# Write a lambda which takes an integer and increment it by 1
plus_one    = ->(i) { i+1 }

# Write a lambda which takes an integer and multiply it by 2
into_2      = ->(i) { i * 2 } 

# Write a lambda which takes two integers and adds them
adder       = ->(i,j) { i+j } 

# Write a lambda which takes a hash and returns an array of hash values
values_only = ->(h) { h.values } 


input_number_1 = gets.to_i
input_number_2 = gets.to_i
input_hash = eval(gets)

a = square.(input_number_1); b = plus_one.(input_number_2);c = into_2.(input_number_1); 
d = adder.(input_number_1, input_number_2);e = values_only.(input_hash)

p a; p b; p c; p d; p e
```
