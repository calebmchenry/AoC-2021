import System.IO
import qualified Data.Map as Map
import Control.Monad ( join )

chunk :: Int -> [a] -> [[a]]
chunk _ [] = []
chunk n xs = take n xs : chunk n (drop n xs)

applyInsert :: Map.Map String String -> String -> Maybe String
applyInsert m s = fmap (\s' -> f ++ s' ++ l) middle
  where
      middle =  Map.lookup s m 
      f = [head s]
      l = [last s]

step :: Map.Map String String -> Maybe String -> Int -> Maybe String
step _ template 0 = template
step map template n = step map template' (n-1)
    where
        template' =  fmap (\ss -> foldl (++) "" ss ) $ join $ (sequenceA . fmap (applyInsert map)) <$> (chunk 2) <$> template 

parseInsert :: String -> (String, String)
parseInsert = (\(k:_:v:__) -> (k, v)) . words

parseInput :: String -> (String, Map.Map String String)
parseInput input = (template, m)
    where
        (template:_:inserts) = lines input
        m = Map.fromList $ fmap (parseInsert) inserts

minMax :: String ->  (Int, Int)
minMax polymer = (min, max)
    where
        counts = Map.toList .Map.fromListWith (+) $ fmap (\c -> (c, 1)) polymer
        min = minimum $ fmap snd counts
        max = maximum $ fmap snd counts

part1 :: String -> Map.Map String String -> Int
part1 template m = most * least
    where
        polymer = step m (Just template) 10
        result = fmap minMax polymer
        (most, least) = case result of
            Just (x, y) -> (x, y)
            Nothing -> (0, 0)

main = do
  handle <- openFile "sample.txt" ReadMode
  contents <- hGetContents handle
  let (template,m) = parseInput contents
  print $ m
  print $ part1 template m
  hClose handle
