//
//  BranchTree.default.swift
//  TreeV3Util
//
//  Created by Henry on 2019/07/09.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension BranchTree where Path: ExpressibleByArrayLiteral {
    var path: Path { [] }
}

public extension BranchTree where
Path: RangeReplaceableCollection,
Path.Element == SubSequence.Index {
    var path: Path { Path() }
    func path(at i: SubSequence.Index, in p: Path) -> Path {
        var q = p
        q.append(i)
        return q
    }
}

public extension BranchTree where
Path: Collection,
Path.Element == SubSequence.Index {
    func contents(in p:Path) -> BranchSlice<Branches.Element> {
        return BranchSlice<Branches.Element>(base: branches.contents(in: p))
    }
}

public extension Tree where
Self: BranchTree & BranchReplaceableTree,
Path: Collection,
Path.Element == SubSequence.Index {
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
}

public extension Tree where
Self: BranchTree & BranchReplaceableTree,
Path: Collection,
Path.Element == SubSequence.Index {
    mutating func replaceSubrange<C>(_ r: Range<Branches.Index>, with bs: C, in p: Path) where
    C:Collection,
    C.Element == Branches.Element {
        switch p.isEmpty {
        case true:  branches.replaceSubrange(r, with: bs)
        case false: branches[p.first!, in: p.dropFirst()].branches.replaceSubrange(r, with: bs)
        }
    }
    mutating func insert<C>(contentsOf bs:C, at i:Branches.Index, in p:Path) where
    C:Collection,
    C.Element == Branches.Element {
        replaceSubrange(i..<i, with: bs, in: p)
    }
    mutating func removeSubrange(_ r:Range<Branches.Index>, in p:Path) {
        replaceSubrange(r, with: EmptyCollection(), in: p)
    }
}
