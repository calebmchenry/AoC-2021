import System.IO  

part1 :: String -> Int
part1 contents = length $ filter (<0) $ zipWith (-) ns (tail ns)
  where
    ns = map read $ lines contents

windows n xs = if length xs < n then [] else (take n xs) : windows n (tail xs)

part2 :: String -> Int
part2 contents = length $ filter (<0) $ zipWith (-) ys (tail ys)
  where
    xs = map read $ lines contents
    ys = map sum $ filter ((>0) . length) $ windows 3 xs

main = do  
        handle <- openFile "input.txt" ReadMode
        contents <- hGetContents handle
        print $ part2 contents
        hClose handle
