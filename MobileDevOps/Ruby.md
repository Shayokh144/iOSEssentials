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