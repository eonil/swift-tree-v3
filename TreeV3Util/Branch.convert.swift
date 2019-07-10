//
//  Branch.convert.swift
//  TreeV3Util
//
//  Created by Henry on 2019/07/10.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension Branch where
Self: MutableBranch & RangeReplaceableBranch {
    init<X>(converting x:X) where X:Branch, X.Value == Value {
        let v = x.value
        let bs = Branches(x.branches.lazy.map(Self.init(converting:)))
        self = Self(value: v, branches: bs)
    }
}
