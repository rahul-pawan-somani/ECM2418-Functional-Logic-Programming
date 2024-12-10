import Data.List (nub, intersect)
import qualified Data.Set as Set
import Data.Set (Set, fromList)

main :: IO ()
main
    = print ( filter selector2 generator2 )

digits :: Int -> [Int]
digits 0 = [0]
digits n = reverse (digits' n)
  where
    digits' 0 = []
    digits' x = (x `mod` 10) : digits' (x `div` 10)

uniqueSquareAges :: [Int]
uniqueSquareAges = [age | age <- [10..31],
    let ds = digits (age * age),
    length ds == 3 && length (nub ds) == 3]

generator2 :: [(Int, Int, Int, Int, Int, Int, Int, Int)]
generator2 = [(a1, a2, a3, a4, a5, a6, a7, a8) |
    a1 <- uniqueSquareAges,
    a2 <- uniqueSquareAges, a2 /= a1,
    a3 <- uniqueSquareAges, a3 `notElem` [a1, a2],
    a4 <- uniqueSquareAges, a4 `notElem` [a1, a2, a3],
    a5 <- uniqueSquareAges, a5 `notElem` [a1, a2, a3, a4],
    a6 <- uniqueSquareAges, a6 `notElem` [a1, a2, a3, a4, a5],
    a7 <- uniqueSquareAges, a7 `notElem` [a1, a2, a3, a4, a5, a6],
    a8 <- uniqueSquareAges, a8 `notElem` [a1, a2, a3, a4, a5, a6, a7],
    a4 == minimum [a1, a2, a3, a4, a5, a6, a7, a8]]

nameSets :: [(String, Set Char)]
nameSets = [("alan", fromList "alan"), ("cary", fromList "cary"), ("james", fromList "james"),
            ("lucy", fromList "lucy"), ("nick", fromList "nick"), ("ricky", fromList "ricky"),
            ("steve", fromList "steve"), ("victor", fromList "victor")]

getCharSet :: String -> Set Char
getCharSet name = case lookup name nameSets of
    Just s -> s
    Nothing -> fromList ""

selector2 :: (Int, Int, Int, Int, Int, Int, Int, Int) -> Bool
selector2 (a1, a2, a3, a4, a5, a6, a7, a8) = 
    all checkPairs [
      (a1, "alan", a2, "cary"), (a1, "alan", a3, "james"), (a1, "alan", a4, "lucy"),
      (a1, "alan", a5, "nick"), (a1, "alan", a6, "ricky"), (a1, "alan", a7, "steve"),
      (a1, "alan", a8, "victor"), (a2, "cary", a3, "james"), (a2, "cary", a4, "lucy"),
      (a2, "cary", a5, "nick"), (a2, "cary", a6, "ricky"), (a2, "cary", a7, "steve"),
      (a2, "cary", a8, "victor"), (a3, "james", a4, "lucy"), (a3, "james", a5, "nick"),
      (a3, "james", a6, "ricky"), (a3, "james", a7, "steve"), (a3, "james", a8, "victor"),
      (a4, "lucy", a5, "nick"), (a4, "lucy", a6, "ricky"), (a4, "lucy", a7, "steve"),
      (a4, "lucy", a8, "victor"), (a5, "nick", a6, "ricky"), (a5, "nick", a7, "steve"),
      (a5, "nick", a8, "victor"), (a6, "ricky", a7, "steve"), (a6, "ricky", a8, "victor"),
      (a7, "steve", a8, "victor")]
  where
    checkPairs (age1, name1, age2, name2) =
        let digits1 = digits (age1 * age1)
            digits2 = digits (age2 * age2)
            commonDigits = not (Set.null (fromList digits1 `Set.intersection` fromList digits2))
            commonLetters = not (Set.null (getCharSet name1 `Set.intersection` getCharSet name2))
        in commonDigits == commonLetters
