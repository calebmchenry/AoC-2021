import System.IO
import Data.List (isPrefixOf)

mostCommon :: [String] -> String
mostCommon bits = if numOfOnes >= numOfZeros then "1" else "0"
  where
    numOfOnes = length $ filter (== "1") bits
    numOfZeros = length $ filter (== "0") bits

leastCommon :: [String] -> String
leastCommon bits = if mostCommon bits == "0" then "1" else "0"

leastCommonAtPosition index bs = leastCommon (map (getIndex index) bs)

oxygen :: [String] -> String -> String
oxygen [] _ = ""
oxygen bs p = if (== 1) $ length matches then head matches else oxygen matches prefix
  where
    index = length p
    getIndex = drop index . take (index + 1)
    prefix = p ++ mostCommon (map getIndex bs)
    matches = filter (isPrefixOf prefix ) bs

binaryToDigit :: Integral i => i -> i
binaryToDigit 0 = 0
binaryToDigit i = 2 * binaryToDigit (div i 10) + mod i 10

getIndex :: Int -> [a] -> [a]
getIndex index = drop index . take (index + 1)

c02 :: [String] -> String -> String
c02 [] _ = ""
c02 bs p = if (== 1) $ length matches then head matches else c02 matches prefix
  where
    index = length p
    prefix = p ++ leastCommon (map (getIndex index) bs)
    matches = filter (isPrefixOf prefix ) bs

part2 :: [String] -> Int
part2 binaries = o * c
  where 
    o = binaryToDigit $ read $ oxygen binaries ""
    c = binaryToDigit $ read $ c02 binaries ""

main :: IO ()
main = do
  handle <- openFile "input.txt" ReadMode
  contents <- hGetContents handle
  let ls = lines contents
  -- print $ part1 ls 
  print $ oxygen ls ""
  print $ c02 ls ""
  print $ part2 ls
  hClose handle
