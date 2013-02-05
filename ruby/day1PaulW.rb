puts "Hello World"

puts "Hello, Ruby".index("Ruby")

x = 1
while x < 10
   puts "Paul W"
   x = x + 1
end

x = 1
while x <= 10
   puts "This is sentence number #{x}"
   x = x + 1
end


puts "Guess a number between 0 and 9.  you get 3 chances."
randomNumber = rand(10)
guessChance = 1
userGuess = -99
while userGuess != randomNumber  &&  guessChance <= 3
   puts "Guess no #{guessChance} ..."
   userGuess = gets
   userGuess = userGuess.to_i

   if userGuess == randomNumber 
      puts "bingo!!!!!!"
   end

   guessChance = guessChance + 1
end
puts "random number was #{randomNumber}" if userGuess != randomNumber


