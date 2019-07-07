//
//  Tree.paths.swift
//  TreeV3
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension Tree {
    var paths: TreePaths<Self> {
        return TreePaths<Self>(base: self)
    }
}

public struct TreePaths<Base> where Base: Tree {
    let base: Base
    public var dfs: TreePathDFSSequence<Base> {
        return TreePathDFSSequence<Base>(base: base)
    }
}

public struct TreePathDFSSequence<Base>: Sequence where Base: Tree {
    let base: Base
    public func makeIterator() -> TreePathDFSIterator<Base> {
        /// Root is a collection. Therefore, no value at root.
        let n = TreeNode<Base>(
            base: base,
            location: [],
            startIndex: base.startIndex(in: []),
            endIndex: base.endIndex(in: []))
        return TreePathDFSIterator<Base>(base: base, reversedStack: Array(n.lazy.reversed()))
    }
}

public struct TreePathDFSIterator<Base>: IteratorProtocol where Base: Tree {
    typealias Index = Base.Path.Element
    typealias Path = Base.Path
    let base: Base
    fileprivate private(set) var reversedStack = [TreeNode<Base>]()
    public mutating func next() -> Base.Path? {
        guard !reversedStack.isEmpty else { return nil }
        let x = reversedStack.removeLast()
        reversedStack.append(contentsOf: x.lazy.reversed())
        return x.location
    }
}

private struct TreeNode<Base>: Collection where Base: Tree {
    let base: Base
    let location: Base.Path
    let startIndex: Base.Path.Element
    let endIndex: Base.Path.Element
    func index(after i: Base.Path.Element) -> Base.Path.Element {
        return base.index(after: i, in: location)
    }
    subscript(_ i:Base.Path.Element) -> TreeNode {
        let p = location.appending(i)
        let n = TreeNode(
            base: base,
            location: p,
            startIndex: base.startIndex(in: p),
            endIndex: base.endIndex(in: p))
        return n
    }
}
