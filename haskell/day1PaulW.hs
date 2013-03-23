-- Haskell wiki
-- http://www.haskell.org/haskellwiki/Introduction

-- Haskell online group supporting your compiler of choice
-- http://www.haskell.org/ghc/

-- ----------------------------------------------------------------
-- How many different ways can you find to write allEven
   allEven :: [Integer] -> [Integer]
   allEven [] = []
   allEven (h:t) = if even h then h:allEven t else allEven t

   allEven2 list = filter even list

   allEven3 = foldr(\h t -> if even h then h:t else t) []

-- allEven [1,2,3,4,5,6]
-- allEven2 [1,2,3,4,5,6]
-- allEven3 [1,2,3,4,5,6]

-- ----------------------------------------------------------------
-- Write a function that takes a list and returns the same list in reverse
   allReverse :: [a] -> [a]
   allReverse list = reverse list

   allReverse2 [] = []
   allReverse2 (list) = last(list) : allReverse (init list)

   allReverse3 [] = []
   allReverse3 (h:t) = allReverse2 t ++ [h]

-- allReverse [9,8,7,6,5,4,3,2,1]
-- allReverse2 [9,8,7,6,5,4,3,2,1]
-- allReverse3 [9,8,7,6,5,4,3,2,1]

-- ----------------------------------------------------------------
-- Write a function that builds two-tuples with all possible combinations
-- of two of the colors black, white, blue, yellow, and red. Note that you
-- should include only one of (black, blue) and (blue, black).

   getColours :: [String] -> [(String, String)]
   getColours colours = [(a,b) | a <- colours, b <- colours, a < b]

-- getColours ["black","white","blue","yellow","red"]


-- ----------------------------------------------------------------
-- Write a list comprehension to build a childhood multiplication table.
-- The table would be a list of three-tuples where the first two are integers
-- from 1-12 and the third is the product of the first two.

   myMultiTable :: (Integer,Integer) -> [(Integer,Integer,Integer)]
   myMultiTable (start,end) = [(x,y,x*y) | x <- [start..end], y <- [start..end]]

-- myMultiTable (2,4)
-- myMultiTable (1,12)


-- ----------------------------------------------------------------
-- Solve the map-coloring problem

-- let colours = ["red", "green", "blue"]
-- [(alabama, mississippi, georgia, tennessee, florida) |
--   alabama <- colours,
--   mississippi <- colours,
--   georgia <- colours,
--   tennessee <- colours,
--   florida <- colours,
--    mississippi /= tennessee,
--   mississippi /= alabama,
--   alabama /= tennessee,
--   alabama /= georgia,
--   alabama /= florida,
--   georgia /= florida,
--   georgia /= tennessee]

