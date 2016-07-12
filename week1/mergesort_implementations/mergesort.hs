Splitting in half in the middle like the normal merge sort does would be inefficient on the singly-linked lists used in Haskell (since you would have to do one pass just to determine the length, and then another half-pass to do the splitting). Instead, the algorithm here splits the list in half in a different way -- by alternately assigning elements to one list and the other. That way we (lazily) construct both sublists in parallel as we traverse the original list. Unfortunately, under this way of splitting we cannot do a stable sort.

merge []         ys                   = ys
merge xs         []                   = xs
merge xs@(x:xt) ys@(y:yt) | x <= y    = x : merge xt ys
                          | otherwise = y : merge xs yt
 
split (x:y:zs) = let (xs,ys) = split zs in (x:xs,y:ys)
split [x]      = ([x],[])
split []       = ([],[])
 
mergeSort []  = []
mergeSort [x] = [x]
mergeSort xs  = let (as,bs) = split xs
                in merge (mergeSort as) (mergeSort bs)
Alternatively, we can use bottom-up mergesort. This starts with lots of tiny sorted lists, and repeatedly merges pairs of them, building a larger and larger sorted list

mergePairs (sorted1 : sorted2 : sorteds) = merge sorted1 sorted2 : mergePairs sorteds
mergePairs sorteds = sorteds
 
mergeSortBottomUp list = mergeAll (map (\x -> [x]) list)
 
mergeAll [sorted] = sorted
mergeAll sorteds = mergeAll (mergePairs sorteds)
The standard library's sort function in GHC takes a similar approach to the bottom-up code, the differece being that, instead of starting with lists of size one, which are sorted by default, it detects runs in original list and uses those:

sort = sortBy compare
sortBy cmp = mergeAll . sequences
  where
    sequences (a:b:xs)
      | a `cmp` b == GT = descending b [a]  xs
      | otherwise       = ascending  b (a:) xs
    sequences xs = [xs]
 
    descending a as (b:bs)
      | a `cmp` b == GT = descending b (a:as) bs
    descending a as bs  = (a:as): sequences bs
 
    ascending a as (b:bs)
      | a `cmp` b /= GT = ascending b (\ys -> as (a:ys)) bs
    ascending a as bs   = as [a]: sequences bs
In this code, mergeAll, mergePairs, and merge are as above, except using the specialized cmp function in merge.
