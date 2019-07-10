//
//  Branch.lazy.swift
//  TreeV3Util
//
//  Created by Henry on 2019/07/09.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension Branch {
    var lazy: Lazy<Self> {
        return Lazy(base: self)
    }
}

public struct Lazy<Base> where Base: Branch {
    let base: Base
    public func map<X>(_ mfx: @escaping (Base.Value) -> X) -> LazyMapBranch<Base,X> {
        return LazyMapBranch<Base,X>(base: base, map: mfx)
    }
}

public struct LazyMapBranch<Base,X>: Branch where Base: Branch {
    let base: Base
    let map: (Base.Value) -> X
    public var value: X { return map(base.value) }
    public var branches: LazyMapCollection<Base.Branches,LazyMapBranch> {
        let mfx = map
        return base.branches.lazy.map({ $0.lazy.map(mfx) })
    }
}
