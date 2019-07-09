//
//  BranchTree.default.swift
//  Tree
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension BranchTree {
    var path: Path { return [] }
    func path(at i:SubSequence.Index, in p:Path) -> Path {
        return p.appending(i)
    }
    func contents(in p:Path) -> BranchTreeSlice<Branches.Element> {
        return BranchTreeSlice(base: branches.contents(in: p))
    }
}
public extension BranchTree where Self: MutableBranchTree & RangeReplaceableBranchTree {
    mutating func replaceSubrange<C>(_ r:Range<SubSequence.Index>, with es: C, in p:Path) where
    C:Collection,
    C.Element == SubSequence.Element {
        // Ensure no children in the range.
        let xes = contents(in: p)
        var i = r.lowerBound
        while i < r.upperBound {
            let cp = path(at: i, in: p)
            let xces = contents(in: cp)
            precondition(xces.isEmpty)
            i = xes.index(after: i)
        }
        // Perform mutation.
        let x = Branches.Element.Branches()
        branches.replaceSubrange(r, with: es.map({ Branches.Element(value: $0, branches: x) }), in: p)
    }
    mutating func replaceSubrange<C>(_ r: Range<Branches.Index>, with bs: C, in p: Path) where
    C:Collection,
    C.Element == Branches.Element {
        switch p.isEmpty {
        case true:  branches.replaceSubrange(r, with: bs)
        case false: branches[p.first!, in: p.dropFirst()].branches.replaceSubrange(r, with: bs)
        }
    }

    /// Disabled due to stupid compiler crash only in Xcode 11 Beta.
    /// Works well on command-line.
//    mutating func insert<C>(contentsOf bs:C, at i:Branches.Index, in p:Path) where
//    C:Collection,
//    C.Element == Branches.Element {
//        replaceSubrange(i..<i, with: bs, in: p)
//    }
//    mutating func removeSubrange(_ r:Range<Branches.Index>, in p:Path) {
//        replaceSubrange(r, with: EmptyCollection(), in: p)
//    }
}









// MARK: Element at Path in Tree

/// If a tree is built with pointer-based composition of `Branch`es (e.g. `ArrayBranchTree`),
/// it'a natural to have `Path`s consist of `SubSequence.Index`.
/// If the tree conforms `Collection`, it's also natural to use the `Path` as its `Index`.
/// In that case, more default implementations can be provided.
public extension Collection where
Self: BranchTree,
Index == Path {
    subscript(_ p:Index) -> Element {
        precondition(!p.isEmpty)
        return branches[p.first!].branches[p.dropFirst()].value
    }
}
public extension Collection where
Self: MutableBranchTree,
Self: RangeReplaceableBranchTree,
Index == Path {
    subscript(_ p:Index) -> Element {
        get {
            precondition(!p.isEmpty)
            return branches[p.first!].branches[p.dropFirst()].value
        }
        set(x) {
            precondition(!p.isEmpty)
            branches[p.first!].branches[p.dropFirst()].value = x
        }
    }
}



// MARK: Branch at Path in Branch.branches
public extension Collection where
Element: Branch,
Element.Branches.Index == Index {
    subscript<P>(_ p:P) -> Element where P:Collection, P.Element == Index {
        precondition(!p.isEmpty)
        return self[p.first!].branches[p.dropFirst()]
    }
}
public extension Collection where
Self: MutableCollection,
Self: RangeReplaceableCollection,
Element: MutableBranch,
Element: RangeReplaceableBranch,
Element.Branches.Index == Index {
    subscript<P>(_ p:P) -> Element where P:Collection, P.Element == Index {
        get {
            precondition(!p.isEmpty)
            return self[p.first!].branches[p.dropFirst()]
        }
        set(x) {
            precondition(!p.isEmpty)
            self[p.first!].branches[p.dropFirst()] = x
        }
    }
}



// MARK: Branch at Path in Branch
public extension Branch {
    subscript<P>(_ p:P) -> Self where P:Collection, P.Element == Branches.Index {
        switch p.isEmpty {
        case true:  return self
        case false: return branches[p]
        }
    }
}
public extension Branch where Self: MutableBranch & RangeReplaceableBranch {
    subscript<P>(_ p:P) -> Self where P:Collection, P.Element == Branches.Index {
        get {
            switch p.isEmpty {
            case true:  return self
            case false: return branches[p]
            }
        }
        set(x) {
            switch p.isEmpty {
            case true:  self = x
            case false: branches[p] = x
            }
        }
    }
}






