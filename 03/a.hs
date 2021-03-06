type Map = (Integer, Integer, [(Integer, Integer)])

main :: IO ()
main = interact $ show . solve 3 1 . input

input :: String -> Map
input s = go s [] 0 0
  where
    go [] _ _ _ = error "Unexpected end of input!"
    go (c:cs) ps x y | c == '.'  = go cs ps (x+1) y
                     | c == '#'  = go cs ((x,y):ps) (x+1) y
                     | c == '\n' = if null cs then (x,y,ps) else go cs ps 0 (y+1)
                     | otherwise = error "Ich raste aus!"

solve :: Integer -> Integer -> Map -> Integer
solve r d (maxX, maxY, trees) = go 0 0
  where
    go x y | y > maxY           = 0
           | (x,y) `elem` trees = 1 + go (mod (x+r) maxX) (y+d)
           | otherwise          = go (mod (x+r) maxX) (y+d)
