//
//  BranchTree.default.swift
//  Tree
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension BranchTree {
    func startIndex(in p:Path) -> SubSequence.Index { return branches.startIndex(in: p) }
    func endIndex(in p:Path) -> SubSequence.Index { return branches.endIndex(in: p) }
    func index(after i:SubSequence.Index, in p:Path) -> SubSequence.Index {
        return branches.index(after: i, in: p)
    }
    func index(before i:SubSequence.Index, in p:Path) -> SubSequence.Index {
        return branches.index(before: i, in: p)
    }
    func index(_ i:SubSequence.Index, offsetBy d:Int, in p:Path) -> SubSequence.Index {
        return branches.index(i, offsetBy: d, in: p)
    }
    func distance(from a:SubSequence.Index, to b:SubSequence.Index, in p:Path) -> Int {
        return branches.distance(from: a, to: b, in: p)
    }
//    // These lines causes compiler crash.
//    // Therefore disabled.
//    subscript(_ i:SubSequence.Index, in p:Path) -> SubSequence.Element {
//        get { return branches[i, in: p].value }
//    }
    
    var path: Path { return [] }
    func path(at i:SubSequence.Index, in p:Path) -> Path {
        return p.appending(i)
    }
    func sequence(in p:Path) -> BranchTreeSlice<Branches.Element> {
        return BranchTreeSlice(base: branches.sequence(in: p))
    }
    func subsequence(_ r:Range<SubSequence.Index>, in p:Path) -> BranchTreeSlice<Branches.Element> {
        return BranchTreeSlice<Branches.Element>(base: branches[r, in: p])
    }
}
public extension BranchTree where Self: MutableBranchTree & RangeReplaceableBranchTree {
//    subscript(_ i:SubSequence.Index, in p:Path) -> SubSequence.Element {
//        get { return branches[i, in: p].value }
//        set(x) { branches[i, in: p].value = x }
//    }
//    subscript(_ r:Range<SubSequence.Index>, in p:Path) -> BranchTreeSlice<Self> {
//        get { return BranchTreeSlice(sequence: branches[r, in: p]) }
//        set(x) { branches[r, in: p] = x.sequence }
//    }
    mutating func replaceSubrange<C>(_ r:Range<SubSequence.Index>, with es: C, in p:Path) where
    C:Collection,
    C.Element == SubSequence.Element {
        let x = Branches.Element.Branches()
        branches.replaceSubrange(r, with: es.map({ Branches.Element(value: $0, branches: x) }), in: p)
    }
}
