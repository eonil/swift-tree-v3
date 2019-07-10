//
//  BranchTree.convert.swift
//  TreeV3Util
//
//  Created by Henry on 2019/07/10.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension BranchTree where
Self: BranchReplaceableTree {
    init<X>(converting x:X) where X:BranchTree, X.Branches.Element.Value == Branches.Element.Value {
        self = Self()
        branches = Branches(x.branches.lazy.map(Branches.Element.init(converting:)))
    }
}
