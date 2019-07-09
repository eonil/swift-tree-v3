//
//  Tree.sorted.swift
//  TreeV3
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension Tree {
    func sorted(by isSorted:(SubSequence.Element,SubSequence.Element) -> Bool) -> ArrayBranchTree<SubSequence.Element> {
        let bs = branches
            .map({ $0.sorted(by: isSorted) })
            .sorted(by: { a,b in isSorted(a.value, b.value)})
        return ArrayBranchTree(branches: bs)
//        var a = ArrayBranchTree<SubSequence.Element>()
//        a.append(contentsOf: self, in: path, isSorted: isSorted)
//        return a
    }
}

//private extension ArrayBranchTree {
//    mutating func append<X>(contentsOf x:X, in p:X.Path, isSorted: IsSorted<Element>) where
//    X:Tree,
//    X.SubSequence.Element == Element {
//        let s = x.contents(in: p)
//        let q = s.indices.sorted(by: { a,b in isSorted(s[a],s[b]) })
//        for i in q {
//            let e = s[i]
//            var a = ArrayBranch<Element>(value: e)
//            let cp = x.path(at: i, in: p)
//            a.append(contentsOf: x, in: cp, isSorted: isSorted)
//            branches.append(a)
//        }
//    }
//}
//
//private extension ArrayBranch {
//    mutating func append<X>(contentsOf x:X, in p:X.Path, isSorted: IsSorted<Element>) where
//    X:Tree,
//    X.SubSequence.Element == Element {
//        let s = x.contents(in: p)
//        let q = s.indices.sorted(by: { a,b in isSorted(s[a],s[b]) })
//        for i in q {
//            let e = s[i]
//            var a = ArrayBranch<Element>(value: e)
//            let cp = x.path(at: i, in: p)
//            a.append(contentsOf: x, in: cp, isSorted: isSorted)
//            branches.append(a)
//        }
//    }
//}
//
//private typealias IsSorted<X> = (X,X) -> Bool
//
