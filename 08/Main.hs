import System.IO

splitOnPipe :: String -> [String]
splitOnPipe s = case dropWhile (=='|') s of
  "" -> []
  s' -> w : splitOnPipe s''
    where (w, s'') = break (=='|') s'

part1 :: String -> Int
part1 content = length $ filter (`elem` uniqueLengths) $ map length signals
  where
    signals = (>>= words) $ map (last . splitOnPipe) $ lines content
    uniqueLengths = [2, 4, 3, 7]

main = do
  handle <- openFile "input.txt" ReadMode
  contents <- hGetContents handle
  print $ part1 contents
  hClose handle
