import System.IO

splitOnComma :: String -> [String]
splitOnComma s = case dropWhile (==',') s of
                      "" -> []
                      s' -> w : splitOnComma s''
                            where (w, s'') = break (==',') s'

reproduce :: [Int] -> [Int]
reproduce [zeros, ones, twos, threes, fours, fives, sixes, sevens, eights] = [ones, twos, threes, fours, fives, sixes, sevens + zeros, eights, zeros]
reproduce a = a 

part1 :: [Int] -> Int -> Int
part1 fs 0 = sum fs
part1 fs n = part1 (reproduce fs) (n - 1)

group :: [Int] ->  Int -> [Int]
group [zeros, ones, twos, threes, fours, fives, sixes, sevens, eights] f = case f of
  0 -> [zeros + 1, ones, twos, threes, fours, fives, sixes, sevens, eights]
  1 -> [zeros, ones + 1, twos, threes, fours, fives, sixes, sevens, eights]
  2 -> [zeros, ones, twos + 1, threes, fours, fives, sixes, sevens, eights]
  3 -> [zeros, ones, twos, threes + 1, fours, fives, sixes, sevens, eights]
  4 -> [zeros, ones, twos, threes, fours + 1, fives, sixes, sevens, eights]
  5 -> [zeros, ones, twos, threes, fours, fives + 1, sixes, sevens, eights]
  6 -> [zeros, ones, twos, threes, fours, fives, sixes + 1, sevens, eights]
  7 -> [zeros, ones, twos, threes, fours, fives, sixes, sevens + 1, eights]
  8 -> [zeros, ones, twos, threes, fours, fives, sixes, sevens, eights + 1]
  _ -> []
group _ f = []

main = do
  handle <- openFile "input.txt" ReadMode
  contents <- hGetContents handle
  let ns = map read $ splitOnComma contents
  let fs = foldl group (replicate 9 0) ns 
  print $ part1 fs 80
  print $ part1 fs 256 
  hClose handle
