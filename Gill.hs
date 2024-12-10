import Data.List (nub, permutations, subsequences)


main :: IO ()
main
    = print ( filter selector1 generator1 )

number :: [Int] -> Int
number = foldl (\acc x -> acc * 10 + x) 0

allUnique :: [Int] -> Bool
allUnique xs = length (nub xs) == length xs

combinationsOfNine :: [[Int]]
combinationsOfNine = filter ((==9) . length) (subsequences [0..9])

generator1 :: [([Int], [Int], [Int])]
generator1 = [(take 3 p, take 3 (drop 3 p), take 3 (drop 6 p)) |
                comb <- combinationsOfNine,
                p <- permutations comb,
                allUnique p]

isPrime :: Int -> Bool
isPrime n
    | n < 2     = False
    | n == 2    = True
    | even n    = False
    | otherwise = all (\x -> n `mod` x /= 0) [3,5..floor . sqrt $ fromIntegral n]

sumIsOdd :: [Int] -> Bool
sumIsOdd digits = odd (sum digits)

selector1 :: ([Int], [Int], [Int]) -> Bool
selector1 (s1, s2, s3) =
    let n1 = number s1
        n2 = number s2
        n3 = number s3
        diff1 = n2 - n1
        diff2 = n3 - n2
    in isPrime n1 && isPrime n2 && isPrime n3 &&
        diff1 == diff2 &&
        sumIsOdd s1 && sumIsOdd s2 && sumIsOdd s3