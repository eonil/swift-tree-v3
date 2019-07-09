//
//  BranchTree.default.swift
//  TreeV3Util
//
//  Created by Henry on 2019/07/09.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension BranchTree where Path: ExpressibleByArrayLiteral {
    var path: Path { return [] }
}

public extension BranchTree where
Path: RangeReplaceableCollection,
Path.Element == SubSequence.Index {
    var path: Path { return Path() }
    func path(at i: SubSequence.Index, in p: Path) -> Path {
        var q = p
        q.append(i)
        return q
    }
}
public extension BranchTree where
Path == IndexPath,
SubSequence.Index == Int {
    var path: Path { return Path() }
    func path(at i: SubSequence.Index, in p: Path) -> Path { return p.appending(i) }
}

public extension BranchTree where
Path: Collection,
Path.Element == SubSequence.Index {
    func contents(in p:Path) -> BranchSlice<Branches.Element> {
        return BranchSlice<Branches.Element>(base: branches.contents(in: p))
    }
}

public extension BranchTree where
Path: Collection,
Path.Element == SubSequence.Index {
    subscript(_ p:Path) -> SubSequence.Element {
        get {
            precondition(!p.isEmpty)
            let a = branches[p.first!]
            let b = a[p.dropFirst()]
            return b.value
        }
    }
}

public extension BranchReplaceableTree where
Self: RecursiveBranches,
Branches: BranchCollection {
    /// Gets element at composited path. (parent path + element index)
    ///
    /// Path `[]` means top-pevel (root) position,
    /// and there's no element at root because `Tree` is
    /// tree of collections. You need to append element index at least.
    subscript<P>(_ p:P) -> SubSequence.Element where
    P:Collection,
    P.Element == Branches.Index {
        get {
            precondition(!p.isEmpty)
            return branches[p.first!][p.dropFirst()].value
        }
        set(x) {
            precondition(!p.isEmpty)
            branches[p.first!][p.dropFirst()].value = x
        }
    }
    /// Replaces elements in a node.
    ///
    /// - Note:
    ///     This method is now allowed to modify descendant topology.
    ///     Modifying elements at same node is allowed.
    ///     If operation need to remove any existing child,
    ///     call to this method will fail. (crash)
    ///
    ///     Therefore, one of these cases are allowed.
    ///     - Number of inserted elements matches with removed.
    ///     - Elements to be removed have no child.
    ///
    /// - Note:
    ///     This is an optimized variant.
    mutating func replaceSubrange<C,P>(_ r:Range<SubSequence.Index>, with es:C, in p:P) where
    C:Collection,
    C.Element == SubSequence.Element,
    P:Collection,
    P.Element == Branches.Index {
        let bs = branches[in: p]
        let bs1 = bs[r]
        if bs1.count == es.count {
            /// Replace branch values in-place.
            /// DO NOT replace branches that potentially have
            /// some children.
            var bs2 = bs
            for (d,e) in es.enumerated() {
                let i = bs2.index(r.lowerBound, offsetBy: d)
                var b = bs2[i]
                b.value = e
                bs2[i].value = e
            }
            branches[in: p] = bs2
        }
        else {
            /// Ensure no children in the range.
            precondition(bs1.lazy.map({$0.branches.isEmpty}).reduce(true, { $0 && $1 }))
            /// Replace branches.
            let x = Branches.Element.Branches()
            branches.replaceSubrange(r, with: es.map({ Branches.Element(value: $0, branches: x) }), in: p)
        }
    }
//    mutating func replaceBranches<C,P>(_ r: Range<Branches.Index>, with bs:C, in p:P) where
//    C:Collection,
//    C.Element == Branches.Element,
//    P:Collection,
//    P.Element == Branches.Index {
//        switch p.isEmpty {
//        case true:  branches.replaceSubrange(r, with: bs)
//        case false: branches[p.first!, in: p.dropFirst()].branches.replaceSubrange(r, with: bs)
//        }
//    }
//    mutating func insert<C,P>(contentsOf bs:C, at i:Branches.Index, in p:P) where
//    C:Collection,
//    C.Element == Branches.Element,
//    P:Collection,
//    P.Element == Branches.Index {
//        replaceSubrange(i..<i, with: bs, in: p)
//    }
//    mutating func removeSubrange(_ r:Range<Branches.Index>, in p:Path) {
//        replaceSubrange(r, with: EmptyCollection(), in: p)
//    }
}

