TreeV3
======
Eonil, 2019.

A set of types to manipulate tree-like data.

What's This and Why Do I Need It?
-----------------------------------------
This is a set of interfaces and implementations of "tree-of-colletions".
ToC is something like this.
        
              [9,5,6]
              /  |  \
             /   |   \
      [3,7,5]    []   [6,2]
      /  |  \         /   \
     []  []  []      /     \
                    [4]    []
                     |
                    []

Each node stores multiple elements, and each element have one branch.
Top-level


Getting Started
-------------------






`Tree` vs. `Branch`
---------------------
Trees are base model for core features 
and branches are complementary for details.

Trees design choices.
- Minimal flat interface.
- Element-oriented location, access and iteration.
- Access like Swift standard collections.
- Focus on contents -- elements rather than structure.
- Therefore, iteration provides stored elements (contents).
- You can access branches if needed.

Branches design choices.
- Feature-rich hierarchical interface.
- Branch-oriented location, access and iteration.
- Access more native tree-ish way.
- Focus on structures -- branches and navigations rather than contents.
- Therefore, iteration provide branch substructures. (structures) 
- You can get value of branch.
- You can access sub-branches explicitly
- You can access trees if needed.

Both interfaces are convertible to each other.
Both probides read-only views in each other.
- Trees are collection of branches. (`Tree.branches`)
- Branch collection is a tree (`Collection.treefied() where Element: Branch`)

A type also can conform both protocols. In that case, it simply become
`BranchTree`. Default concrete type `ArrayTree` conforms both protocols
and provides mutations in both models.

`Tree` also serves a container role for central storage design. 
In that case, `Collection` conformance or extra members can be added to `Tree`.  



Iteration Cheat Sheet
-------------------------
All elements iteration in DFS order.
- `Tree.dfs`.

All paths iteration in DFS order. Paths define location to collections, 
therefore can also be considered as locations to elements except first
path that points top-level collection (or root) with no stored value.
Use these sequences to get all paths in target container.
- `Tree.paths.dfs`.
- `Tree.paths.dfs(at:,in:)`.

* Branches don't have concept of paths by default, 
  therefore do not provide paths iteration.

All branches iteration in DFS order.
- `Tree.branches.dfs`.
- `Branch.dfs`.
- `Branch.branches.dfs`.

If you need special iterations you can do it by compositing existing iterators. 
In this given example, `a` is a DFS ordered sequence to branches. 
`b` is a sequence of element groups of each branches.
`c` is flatten sequence of `b` to iterate all elements in its order.

    let a = tree1.branches.dfs
    let b = a.lazy.map({ $0.branches.lazy.map({ $0.value }) })
    let c = b.joined()



Map/Filter/Sort
-------------------
`Tree` provides `map`, `filter` and `sorted` function that produces `ArranBranchTree`
with result.
There's a lazy variant for `map`. There's no lazy variant for `filter` and `sorted` 
as I couldn't find a nice way to make it lazily in lower cost.




Utility Constraint Protocols
---------------------------------
When you write a generic constraints, don't forget these two protocols.
- `BranchCollection`.
- `RecursiveBranches`.

For example, if you write a function that accepts generic tree and want to
navigate the tree freely, constrain type like this.

    func fx1<X>(_ someTree:X) where
    X:BranchTree & RecursiveBranches,
    X.Branches: BranchCollection {
        let rootBranches = someTree.branches[in: []]
        print(rootBranches)
    }






License & Credits
---------------------
This library is licensed under "MIT License".
Copyright (C) 2019 Eonil, Hoon H.. All rights reserved.
