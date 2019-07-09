//
//  Branch.sorted.swift
//  TreeV3Util
//
//  Created by Henry on 2019/07/09.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension Branch {
    func sorted(by isSorted: (Value,Value) -> Bool) -> ArrayBranch<Value> {
        return ArrayBranch(sorting: self, isSorted)
    }
}

private extension ArrayBranch {
    init<X>(sorting x:X, _ isSorted: (Value,Value) -> Bool) where
    X:Branch,
    X.Value == Value {
        value = x.value
        branches = x.branches
            .map({ ArrayBranch(sorting: $0, isSorted) })
            .sorted(by: { a,b in isSorted(a.value, b.value)})
    }
}
