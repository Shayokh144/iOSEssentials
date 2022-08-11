# Ruby
- **file extension:** *.rb*
- **installation:** preinstalled in Mac
- **check version:** *ruby -v*
- **run code from terminal:** *ruby file_name*

## puts
- equivalent to **print(..)** of C++
- *puts 4+5* -> will print -> 9
- *puts 'hello ruby'* -> will print -> hello ruby

## gets
- equivalent to **cin** of C++
```ruby
puts 'write your name'
name = gets
puts 'your name is: ' + name

```

## Conditions and Loop
```ruby
number = 11
divisor = 2
isPrime = true
while divisor <= number / 2
    if number % divisor == 0
        isPrime = false
        break
    end
    divisor += 1
end
if isPrime == true
    puts number.to_s+' is prime'
else
    puts number.to_s+' is not prime'
end

```
outputs:
```
11 is prime
```

## Array & Iterator
- Array indexing starts at 0, as in C or Java. A negative index is assumed relative to the end of the array --- that is, an index of -1 indicates the last element of the array, -2 is the next to last element in the array, and so on.
- Ruby arrays can hold objects such as String, Integer, Fixnum, Hash, Symbol, even other Array objects. Ruby arrays are not as rigid as arrays in other languages. Ruby arrays grow automatically while adding elements to them

```ruby
names = ['Ada', 'Belle', 'Chris']
names.each do |name|
    puts name
end

```
outputs:
```
Ada
Belle
Chris
```

## Function

```ruby
def getSquare number
    number * number
end
puts getSquare 4

def getArea (width, height, type)
    if type == "squre" || type == "rectangle"
        return width * height
    end
    return (width * height) / 2
end
puts getSquare 4
puts getArea 5, 4, "triangle"
```
outputs:
```
16
10
```
## [Blocks](https://www.tutorialspoint.com/ruby/ruby_blocks.htm)
- A block consists of chunks of code.
- You assign a name to a block.
- The code in the block is always enclosed within braces ({}).
- A block is always invoked from a function with the same name as that of the block. This means that if you have a block with the name test, then you use the function test to invoke this block.
- You invoke a block by using the <span style="color:orange;">**yield**</span> statement.
- Every Ruby source file can declare blocks of code to be run as the file is being loaded (the **BEGIN** blocks) and after the program has finished executing (the **END** blocks)

```ruby
BEGIN { 
# BEGIN block code 
   puts "BEGIN code block"
} 

END { 
# END block code 
   puts "END code block"
}
# MAIN block code 
puts "MAIN code block"

def test
   yield 5
   puts "You are in the method test"
   yield 100
end
test {|i| puts "You are in the block #{i}"}
```
output
```
BEGIN code block
MAIN code block
You are in the block 5
You are in the method test
You are in the block 100
END code block
```

## Variables and Class
- Global variables begin with $
- Instance variables begin with @
- Class variables begin with @@
- Local variables begin with a lowercase letter or _
- Constants begin with an uppercase letter

```ruby
$global_variable = 10
 class Customer
    @@no_of_customers = 0
    def print_global()
        puts "Global variable in class is #$global_variable"
    end
    def initialize(id, name, addr)
       # init method
       @cust_id = id
       @cust_name = name
       @cust_addr = addr
    end
    def display_instance_Variables()
       puts "Customer id instance_Variable value =  #@cust_id"
       puts "Customer name instance_Variable value = #@cust_name"
       puts "Customer address instance_Variable value = #@cust_addr"
    end
    def total_no_of_customers()
        @@no_of_customers += 1
        puts "Total number of customers from Class variable #@@no_of_customers"
     end
 end
 # Create Objects
cust1 = Customer.new("1", "John", "Wisdom Apartments, Ludhiya")
cust2 = Customer.new("2", "Poul", "New Empire road, Khandala")

# Call Methods
cust1.total_no_of_customers()
cust2.total_no_of_customers()
cust1.display_instance_Variables()
cust1.print_global()
```
output
```
Total number of customers from Class variable 1
Total number of customers from Class variable 2
Customer id instance_Variable value =  1
Customer name instance_Variable value = John
Customer address instance_Variable value = Wisdom Apartments, Ludhiya
Global variable in class is 10
```

## Ruby-Gem
- third party libraries are called ***gem*** in ruby
- ***gem install library_name*** - will install a library
- ***gem uninstall library_name*** - will uninstall a library
- ***gem list*** - will show all installed libraries

### Bundler
-  Bundler  is a ruby tool to install gem's with their other dependency with a single command
- Bundler is gem itself
- ***gem install buldler*** - will install bundler 

### Gemfile
- gem dependency list or spec needs to be in a file called `Gemfile`
- gem file contains the list of dependencies
- after creating `Gemfile` need to run ***`bundle install`***, this will install all dependencies





























