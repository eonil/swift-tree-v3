////
////  Tree.branch.swift
////  TreeV3
////
////  Created by Henry on 2019/07/07.
////  Copyright © 2019 Eonil. All rights reserved.
////
//
//import Foundation
//
//extension Tree where
//SubSequence: RandomAccessCollection,
//Path: TreeV3.Path,
//Path.Element == SubSequence.Index {
//    var branches: SubtreeBranches<Self> {
//        let p = path
//        let s = sequence(in: p)
//        return SubtreeBranches(base: self, location: p, sequence: s)
//    }
//}
//struct Subtree<Base>: Branch where
//Base: Tree,
//Base.SubSequence: RandomAccessCollection,
//Base.Path: TreeV3.Path,
//Base.Path.Element == Base.SubSequence.Index {
//    let base: Base
//    let location: Base.Path
//    var value: Base.SubSequence.Element {
//        let p = location
//        return base[p.last!, in: p.dropLast()]
//    }
//    var branches: SubtreeBranches<Base> {
//        let p = location
//        let s = base.sequence(in: p)
//        return SubtreeBranches<Base>(base: base, location: p, sequence: s)
//    }
//}
//struct SubtreeBranches<Base>: RandomAccessCollection where
//Base: Tree,
//Base.SubSequence: RandomAccessCollection,
//Base.Path: TreeV3.Path,
//Base.Path.Element == Base.SubSequence.Index {
//    let base: Base
//    let location: Base.Path
//    let sequence: Base.SubSequence
//    typealias Index = Base.SubSequence.Index
//    var startIndex: Index { return sequence.startIndex }
//    var endIndex: Index { return sequence.endIndex }
//    func index(after i:Index) -> Index { return sequence.index(after: i) }
//    func index(before i:Index) -> Index { return sequence.index(before: i) }
//    subscript(_ i: Index) -> Subtree<Base> {
//        return Subtree<Base>(base: base, location: base.path)
//    }
//}
