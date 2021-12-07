import System.IO

splitOnComma :: String -> [String]
splitOnComma s = case dropWhile (==',') s of
  "" -> []
  s' -> w : splitOnComma s''
    where (w, s'') = break (==',') s'

unitsToFuel :: Int -> Int
unitsToFuel n = sum [1..n] 

cost1 :: [Int] -> Int -> Int
cost1 ns p = sum $ map (abs . (p -)) ns

cost2 :: [Int] -> Int -> Int
cost2 ns p = sum $ map (unitsToFuel . abs . (p -)) ns

part1 :: [Int] -> Int
part1 ns = foldl min maxBound $ map (cost1 ns) [minPosition..maxPosition]
  where
    maxPosition = foldl max 0 ns
    minPosition = foldl min maxPosition ns

part2 :: [Int] -> Int
part2 ns = foldl min maxBound $ map (cost2 ns) [minPosition..maxPosition]
  where
    maxPosition = foldl max 0 ns
    minPosition = foldl min maxPosition ns

main = do
  handle <- openFile "input.txt" ReadMode
  contents <- hGetContents handle
  let ns = map read $ splitOnComma contents
  print $ part1 ns
  print $ part2 ns
  hClose handle
