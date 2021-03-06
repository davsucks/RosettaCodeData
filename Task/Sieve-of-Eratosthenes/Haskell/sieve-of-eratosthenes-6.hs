primes :: [Int]
primes = 2 : _Y ((3 :) . gaps 5 . _U . map(\p-> [p*p, p*p+2*p..]))

gaps k s@(x:xs) | k < x     = k : gaps (k+2) s    -- ~= ([k,k+2..] \\ s), when
                | otherwise =     gaps (k+2) xs   --  k<=x && null(s \\ [k,k+2..])

_U ((x:xs):t) = x : (union xs . _U . pairs) t     -- ~= nub . sort . concat
  where
    pairs (xs:ys:t) = union xs ys : pairs t
