//
//  Branch.filter.swift
//  TreeV3Util
//
//  Created by Henry on 2019/07/09.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension Branch {
    func filter(_ isIncluded: (Value) -> Bool) -> ArrayBranch<Value>? {
        return ArrayBranch<Value>(filtering: self, isIncluded)
    }
}

private extension ArrayBranch {
    init?<X>(filtering x:X, _ isIncluded: (Value) -> Bool) where
    X:Branch,
    X.Value == Value {
        guard isIncluded(x.value) else { return nil }
        value = x.value
        branches = x.branches.compactMap({ $0.filter(isIncluded) })
    }
}
