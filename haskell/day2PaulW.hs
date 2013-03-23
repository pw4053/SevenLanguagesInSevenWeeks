-- -----------------------------------------------
-- Write a sort that takes a list and returns a sorted list.
   import Data.List

   mySort :: (Ord a) => [a] -> [a]
   mySort list = sortBy (\h t -> if (h < t) then LT else GT) list

-- mySort [3,5,4,1,9,0]

-- -----------------------------------------------
-- Write a sort that takes a list and a function that compares its
-- two arguments and then returns a sorted list.


   mySort2 :: (Ord a) => (a -> a -> Ordering) -> [a] -> [a]
   mySort2 comparator list = sortBy comparator list

-- mySort2 (\h t -> if (h < t) then LT else GT) [3,5,4,1,9,0]

-- -----------------------------------------------
-- Write a Haskell function to convert a string to a number. The string
-- should be in the form of "$2,345,678.99" and can possibly have leading
-- zeros.

   myConv :: String -> Float
   myConv str = 
    read $ dropWhile (=='0') $ filter (/=',') $ filter (/='$') str

-- myConv "$2,345,678.99"
-- myConv "$00002,345,678.99"
-- myConv "$00$002,345,678.99"



-- -----------------------------------------------
-- Write a function that takes an argument x and returns a lazy sequence
-- that has every third number, starting with x. Then write a function
-- that includes every fifth number, beginning with y. COmbine these
-- functions through composition to return every eithth number, beginning
-- with x+y.

   i3 x = [x, (x+3) ..]
   i5 y = [y, (y+5) ..]
   i8 x y = (zipWith (+) (i3 x) (i5 y)) 

-- take 10 $ i8 0 1

-- -----------------------------------------------
-- Use a partially applied function to define a function that will return
-- half of a number and another that will append \n to the end of any string.

