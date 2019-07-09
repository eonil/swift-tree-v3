//
//  Branch.collection.treefication.swift
//  TreeV3
//
//  Created by Henry on 2019/07/08.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension Collection where Element: Branch {
    func treefied() -> ArrayTree<Element.Value> {
        var a = ArrayTree<Element.Value>()
        a.branches = map(ArrayBranch.init(converting:))
        return a
    }
}

