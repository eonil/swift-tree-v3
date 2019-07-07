//
//  Tree.dfs.swift
//  TreeV3
//
//  Created by Henry on 2019/07/08.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension Tree where SubSequence: RandomAccessCollection {
    /// Iterates all elements in tree in DFS order.
    /// If you want to iterate `Path`s, use `paths.dfs` instead of.
    var dfs: AnySequence<SubSequence.Element> {
        let s = sequence(in: path)
        let ss = s.indices.map({ Subtree(base: self, location: path, index: $0).dfs })
        return AnySequence(ss.lazy.joined().map({$0.value}))
    }
}

public struct TreePathDFSSequence<Base>: Sequence where Base: Tree {
    let base: Base
    public func makeIterator() -> TreePathDFSIterator<Base> {
        /// Root is a collection. Therefore, no value at root.
        let s = base.sequence(in: base.path)
        let n = TreeNode<Base>(
            base: base,
            location: base.path,
            sequence: s)
        return TreePathDFSIterator<Base>(base: base, reversedStack: [n])
    }
}

public struct TreePathDFSIterator<Base>: IteratorProtocol where Base: Tree {
    typealias Index = Base.SubSequence.Index
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
    let sequence: Base.SubSequence
    var startIndex: Base.SubSequence.Index { return sequence.startIndex }
    var endIndex: Base.SubSequence.Index { return sequence.endIndex }
    func index(after i: Base.SubSequence.Index) -> Base.SubSequence.Index {
        return base.index(after: i, in: location)
    }
    subscript(_ i:Base.SubSequence.Index) -> TreeNode {
        let p = base.path(at: i, in: location)
        let s = base.sequence(in: p)
        let n = TreeNode(
            base: base,
            location: p,
            sequence: s)
        return n
    }
}
