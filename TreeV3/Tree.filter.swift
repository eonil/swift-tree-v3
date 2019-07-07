//
//  Tree.filter.swift
//  TreeV3
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension Tree {
    func filter(_ isIncluded: (SubSequence.Element) -> Bool) -> ArrayBranchTree<SubSequence.Element> {
        return ArrayBranchTree<SubSequence.Element>(self, isIncluded: isIncluded)
    }
}

private extension ArrayBranchTree {
    init<X>(_ x:X, isIncluded: (X.SubSequence.Element) -> Bool) where
    X:Tree,
    X.SubSequence.Element == Element {
        let p = x.path
        let s = x.sequence(in: p)
        for i in s.indices {
            let e = s[i]
            if isIncluded(e) {
                let a = ArrayBranch(x, at: i, in: p, isIncluded: isIncluded)
                branches.append(a)
            }
        }
    }
}

private extension ArrayBranch {
    init<X>(_ x:X, at i:X.SubSequence.Index, in p:X.Path, isIncluded: (X.SubSequence.Element) -> Bool) where
    X:Tree,
    X.SubSequence.Element == Element {
        let e = x[i, in: p]
        value = e
        branches = []
        let p1 = x.path(at: i, in: p)
        let s1 = x.sequence(in: p1)
        for i1 in s1.indices {
            let e1 = s1[i1]
            if isIncluded(e1) {
                let a1 = ArrayBranch(x, at: i1, in: p1, isIncluded: isIncluded)
                branches.append(a1)
            }
        }
    }
}
