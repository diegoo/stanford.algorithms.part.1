#!/usr/bin/python

from heapq import merge
 
def merge_sort(m):
    print("sorting", len(m), "elements:",m)
    if len(m) <= 1:
        print("done",m)
        return m
 
    middle = len(m) // 2
    left = m[:middle]
    right = m[middle:]
    print("splitting in", len(left), "and", len(right), "sublists:",left,right)
    
    left = merge_sort(left)
    right = merge_sort(right)
    print("left:",left,"right:",right)

    merged = list(merge(left, right))
    print("merged:", merged)
    return merged 

out = merge_sort([1,7,5,4,6,8,2,3])
print(out)
