#!/usr/bin/python

from heapq import merge

def chunks(l):
    if len(l) == 2: 
        return ([l[0]],[],[l[1]])
    size = len(l) // 3
    return (l[:size], l[size:(size * 2)], l[size * 2:])

def merge_sort(m):
    print("sorting", len(m), "elements:",m)
    if len(m) <= 1:
        print("done",m)
        return m

    left,middle,right = chunks(m)

    print("splitting in", len(left), len(middle), len(right), "sublists:",left,middle,right)
    
    left = merge_sort(left)
    middle = merge_sort(middle)
    right = merge_sort(right)
    print("left:",left,"middle:",middle,"right:",right)

    merged = list(merge(left, middle, right))
    print("merged:", merged)
    return merged 

out = merge_sort([1,7,5,4,6,8,2,3])
print(out)
