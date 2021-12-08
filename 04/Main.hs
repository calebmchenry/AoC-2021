import System.IO

splitOnComma :: String -> [String]
splitOnComma s = case dropWhile (==',') s of
  "" -> []
  s' -> w : splitOnComma s''
    where (w, s'') = break (==',') s'

hasRowBingo :: [[Int]] -> Bool
hasRowBingo = any (all isMarked)

hasColBingo :: [[Int]] -> Bool
hasColBingo b = any (all isMarked) cols
  where
    cols = map (\c -> map (!! c) b) [0..4]

hasBingo :: [[Int]] -> Bool
hasBingo b = hasRowBingo b || hasColBingo b

mark :: [[Int]] -> Int -> [[Int]]
mark b n= map (map (\v -> if v == n then -1 else v)) b

isMarked :: Int -> Bool
isMarked = (== -1)

playBingo :: [[[Int]]] -> [Int] -> [([[Int]], Int)]
playBingo bs [] = []
playBingo bs ns = winningBoards ++ playBingo losingBoards (drop 1 ns)
  where
    updatedBoards = map (\b -> mark b (head ns)) bs
    winningBoards = map (\b -> (b, head ns)) $ filter hasBingo updatedBoards
    losingBoards = filter (not . hasBingo) updatedBoards

score :: [[Int]] -> Int -> Int
score b n = n * sum (map (sum . filter (not . isMarked)) b)

part1 :: [([[Int]], Int)] -> Int
part1 rs = score winningBoard n
  where
    (winningBoard, n) = head rs

part2 :: [([[Int]], Int)] -> Int
part2 rs = score losingBoard n
  where
    (losingBoard, n) = last rs

groupBoards :: [String] -> [String]
groupBoards [] = []
groupBoards ls = (str ++ "\n") : groupBoards nextLines
  where
    str = foldl (\a b -> a ++ "\n" ++ b) "" $ takeWhile (/= "") ls
    nextLines = drop 1 $ dropWhile (/= "") ls

inputs :: String -> ([Int], [[[Int]]])
inputs content = (numbers, boards)
  where
    ls = lines content
    numbers = map read $ splitOnComma $ head ls
    boards =  map (map (map read . words). filter (/= "") . lines) $ groupBoards $ drop 2 ls

main :: IO ()
main = do
  handle <- openFile "input.txt" ReadMode
  contents <- hGetContents handle
  let (ns,bs) = inputs contents
  let rs = playBingo bs ns
  print $ part1 rs
  print $ part2 rs
  hClose handle
