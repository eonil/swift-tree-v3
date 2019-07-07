//
//  BranchTree.default.swift
//  Tree
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension BranchTree {
    func startIndex(in p:Path) -> Path.Element { return branches.startIndex(in: p) }
    func endIndex(in p:Path) -> Path.Element { return branches.endIndex(in: p) }
    func index(after i:Path.Element, in p:Path) -> Path.Element {
        return branches.index(after: i, in: p)
    }
    func index(before i:Path.Element, in p:Path) -> Path.Element {
        return branches.index(before: i, in: p)
    }
    func index(_ i: Path.Element, offsetBy d: Int, in p: Path) -> Path.Element {
        return branches.index(i, offsetBy: d, in: p)
    }
    subscript(_ i:Path.Element, in p:Path) -> Element {
        get { return branches[i, in: p].value }
    }
//    subscript(_ r:Range<Path.Element>, in p:Path) -> ArraySlice<Self> {
//        get { return branches[r, in: p] }
//    }
//    func subsequence(_ r: Range<Path.Element>, in p: Path) -> SubSequence {
//        return
//    }
    func subsequence(_ r:Range<Path.Element>, in p:Path) -> BranchTreeSlice<Branches.Element> {
        return BranchTreeSlice<Branches.Element>(base: branches[r, in: p])
    }
}
public extension BranchTree where Self: MutableBranchTree & RangeReplaceableBranchTree {
    subscript(_ i:Path.Element, in p:Path) -> Element {
        get { return branches[i, in: p].value }
        set(x) { branches[i, in: p].value = x }
    }
//    subscript(_ r:Range<Path.Element>, in p:Path) -> BranchTreeSlice<Self> {
//        get { return BranchTreeSlice(sequence: branches[r, in: p]) }
//        set(x) { branches[r, in: p] = x.sequence }
//    }
    mutating func replaceSubrange<C>(_ r:Range<Path.Element>, with es: C, in p:Path) where
    C:Collection,
    C.Element == Element {
        let x = Branches.Element.Branches()
        branches.replaceSubrange(r, with: es.map({ Branches.Element(value: $0, branches: x) }), in: p)
    }
}
