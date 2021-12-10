module Day3 where

import Control.Monad
import Data.Bool
import Data.List
import Data.Ord
import Numeric


filename :: FilePath
filename = "input.txt"

main :: IO ()
main = do
  content <- readFile filename
  putStrLn $ show $ part2 $ lines content

binToDec :: String -> Integer
binToDec = fst . head . readBin

mostCommonElems :: (Ord a) => [[a]] -> [a]
mostCommonElems = map
                  (head . maximumBy (comparing length) . group . sort)
                  . transpose

bnotOfStr :: String -> String
bnotOfStr = map (\bit -> bool '0' '1' (bit == '0'))

iterateMatch :: Eq a => ([[a]] -> [a]) -> [[a]] -> [a]
iterateMatch crit = head
                     . snd
                     . until ((== 1) . length . snd) f
                     . (,) 0
  where f (n, xs) = (n + 1, filter (((crit xs !! n) ==) . (!! n)) xs)

part1 :: [String] -> String
part1 = show . liftM2 (*) binToDec (binToDec . bnotOfStr) . mostCommonElems

part2 :: [String] -> String
part2 xs = show $ binToDec (iterateMatch mostCommonElems xs)
           * binToDec (iterateMatch (bnotOfStr . mostCommonElems) xs)

