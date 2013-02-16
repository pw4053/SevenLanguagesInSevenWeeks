#! /usr/bin/env io

# #########################################################
# fibanacci sequence - loop
Calculator := Object clone
Calculator fib := method (nth,
      if ((nth == 1  or  nth == 2), return 1) 

      sum := 0
      num1 := 1
      num2 := 1

      for (i, 3, nth,
         sum = num1 + num2
         num2 = num1
         num1 = sum
      )
      return sum
)

for (x, 1, 10, Calculator fib(x) println)

# #########################################################
# fibanacci sequence - recursion
Calculator := Object clone
Calculator fib := method (nth,
      if ((nth == 1  or  nth == 2), return 1) 

      fibRecursion := method ( nth, idx, num2, num1, 
          if ( nth == idx, return num2 + num1 )
          return fibRecursion ( nth, idx + 1, num1, num2 + num1 ) 
      )

      return fibRecursion ( nth, 3, 1, 1 )
)

for (y, 1, 10, Calculator fib(y) println)


# #########################################################
# change / to return 0 if the denominator is zero

# trick - do not loose the original division operator
coreDivision := Number getSlot("/")

Number / := method (denominator, if ( denominator == 0, 0, self coreDivision( denominator)))

4 / 0 println
4 / 2 println

# #########################################################
# add all the numbers in a 2 dimensional array

ss := list(list(2,2),list(3,3),list(4,4))
sum := 0
ss flatten foreach(v, sum = sum + v)
sum println


# #########################################################
# add a slot myAverage to a list that computes the average of numbers in the list

list(list(2,2),list(3,3),list(4,4)) flatten average println

List myAverage := method( 
   if ( self size() == 0, return 0 )
   return self sum() / self size()
)

list(list(2,2),list(3,3),list(4,4)) flatten myAverage println
# list(2,3,4,"error") myAverage println

# #########################################################
# write a prototye for a 2 dimensional list

Multi := List clone()
Multi dim := method(xDim, yDim,

    xDim repeat ( 
       nest := list()
       yDim repeat ( 
          nest append(0)
       )
       self append(nest)
    )

    return self
)

Multi set := method(x,y,value,
    self at(y) atPut(x,value)
)

Multi get := method(x,y,
    self at(y) return at(x)
)



matrix := Multi clone() dim( 5, 3 );
matrix println
matrix set(2,2,3)
matrix println
# matrix set(4,4,5)   # exception   nil atPut

matrix get(2,2) println

# #########################################################
# transpose the list

Multi transpose := method (
    xDim := self size();
    yDim := self at(0) size();

    newMatrix := Multi clone() dim(yDim, xDim)
newMatrix println
xDim print; "," print; yDim println
    for (x, 0, xDim - 1,
        for (y, 0, yDim - 1,
x print; "," print; y print; "," print; self get(x,y) println
              newMatrix set(y, x, self get(x, y))
        )
    )
    return newMatrix
)

before := Multi clone() dim(3,2)
before set(1,0,2)
"before" println
before println
after := before transpose
"after" println
after println

