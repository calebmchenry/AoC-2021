import System.IO

splitOnComma :: String -> [String]
splitOnComma s = case dropWhile (==',') s of
  "" -> []
  s' -> w : splitOnComma s''
    where (w, s'') = break (==',') s'

cost :: [Int] -> Int -> Int
cost ns p = sum $ map (abs . (p -)) ns


part1 :: [Int] -> Int
part1 ns = foldl min maxBound $ map (cost ns) [minPosition..maxPosition]
  where
    maxPosition = foldl max 0 ns
    minPosition = foldl min maxPosition ns

main = do
  handle <- openFile "input.txt" ReadMode
  contents <- hGetContents handle
  let ns = map read $ splitOnComma contents
  print $ part1 ns
  hClose handle
