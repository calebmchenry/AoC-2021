import System.IO  

numberOfIncreases :: [Int] -> Int
numberOfIncreases = length . filter (<0) . diffs
  where
    diffs ns = zipWith (-) ns (tail ns)

part1 :: [Int] -> Int
part1 = numberOfIncreases

part2 :: [Int] -> Int
part2 = numberOfIncreases . windowSums
  where
    windows n xs = if length xs < n then [] else (take n xs) : windows n (tail xs)
    windowSums = map sum . filter ((>0) . length) . windows 3

main = do  
        handle <- openFile "input.txt" ReadMode
        contents <- hGetContents handle
        let ns = map read $ lines contents
        print $ part1 ns
        print $ part2 ns
        hClose handle
