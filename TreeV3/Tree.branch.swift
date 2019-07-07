//
//  Tree.branch.swift
//  TreeV3
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

extension Tree where
SubSequence: RandomAccessCollection {
    /// Internally available.
    var subtrees: Subtree<Self>.Branches {
        let p = path
        let s = sequence(in: p)
        return Subtree<Self>.Branches(base: self, location: p, sequence: s)
    }
}
