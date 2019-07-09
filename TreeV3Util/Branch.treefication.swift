//
//  Branch.collection.treefication.swift
//  TreeV3
//
//  Created by Henry on 2019/07/08.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension Collection where Element: Branch {
    func treefied() -> ArrayBranchTree<Element.Value> {
        var a = ArrayBranchTree<Element.Value>()
        a.branches = map(ArrayBranch.init(converting:))
        return a
    }
}

