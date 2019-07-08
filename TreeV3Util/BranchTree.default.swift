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
        let es = contents(in: p)
        var i = r.lowerBound
        while i < r.upperBound {
            let cp = path(at: i, in: p)
            let ces = contents(in: cp)
            precondition(ces.isEmpty)
            i = es.index(after: i)
        }
        // Perform mutation.
        let x = Branches.Element.Branches()
        branches.replaceSubrange(r, with: es.map({ Branches.Element(value: $0, branches: x) }), in: p)
    }
}


/// If a tree is built with pointer-based composition of `Branch`es (e.g. `ArrayBranchTree`),
/// it'a natural to have `Path`s consist of `SubSequence.Index`.
/// If the tree conforms `Collection`, it's also natural to use the `Path` as its `Index`.
/// In that case, more default implementations can be provided.
extension BranchTree where
Self: Collection,
Path.Element == SubSequence.Index,
Index == Path,
Element == SubSequence.Element {
//    public subscript(_ i:Path) -> Element {
//        <#code#>
//    }
}
