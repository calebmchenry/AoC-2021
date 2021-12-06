import System.IO

splitOnComma :: String -> [String]
splitOnComma s = case dropWhile (==',') s of
  "" -> []
  s' -> w : splitOnComma s''
    where (w, s'') = break (==',') s'

reproduce :: [Int] -> [Int]
reproduce [zeros, ones, twos, threes, fours, fives, sixes, sevens, eights] = [ones, twos, threes, fours, fives, sixes, sevens + zeros, eights, zeros]
reproduce a = a

modifyElementAt :: (a -> a) -> [a] -> Int -> [a]
modifyElementAt f xs n  = take n xs ++ [f (xs!!n)] ++ drop (n + 1) xs

part1 :: [Int] -> Int -> Int
part1 fs 0 = sum fs
part1 fs n = part1 (reproduce fs) (n - 1)

main = do
  handle <- openFile "input.txt" ReadMode
  contents <- hGetContents handle
  let ns = map read $ splitOnComma contents
  let fs = foldl (modifyElementAt (1 +)) (replicate 9 0) ns
  print $ part1 fs 80
  print $ part1 fs 256
  hClose handle
