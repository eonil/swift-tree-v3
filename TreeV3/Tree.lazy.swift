//
//  Tree.lazy.swift
//  TreeV3
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension Tree {
    var lazy: LazyTree<Self> {
        return LazyTree<Self>(base: self)
    }
}

public struct LazyTree<Base> {
    let base: Base
    public func map<X>(_ mfx: @escaping (Base.SubSequence.Element) -> X) -> LazyMapTree<Base,X> {
        return LazyMapTree<Base,X>(base: base, map: mfx)
    }
}

public struct LazyMapTree<Base,X>: Tree where
Base: Tree {
    let base: Base
    let map: (Base.SubSequence.Element) -> X
    public var path: Base.Path {
        return base.path
    }
    public func path(at i:Base.SubSequence.Index, in p:Base.Path) -> Base.Path {
        return base.path(at: i, in: p)
    }
    public func sequence(in p:Base.Path) -> LazyMapCollection<Base.SubSequence,X> {
        return base.sequence(in: p).lazy.map(map)
    }
}
