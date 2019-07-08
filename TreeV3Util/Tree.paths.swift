//
//  Tree.paths.swift
//  TreeV3
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension Tree {
    /// Provides iteration over paths to "collection nodes".
    ///
    /// Sequence Iteration
    /// ------------------
    /// **PATHS DO NOT POINT ELEMENTS**.
    ///
    /// Please note that there's no concept of "path-to-element"
    /// in `Tree`. `Tree` is tree of "collection"s, and a "node"
    /// is a "collection". For example, if you have `IndexPath`
    /// as your path, `[]` means root collection, not an element.
    /// `[0]` means first child collection, and not its element.
    /// You always need to use indices in the collection to locate
    /// element in a node.
    ///
    /// Element Iteration
    /// -----------------
    /// You can get elements at paths easily like this.
    ///
    ///     let e = a[p.last!, in: p.dropLast()]
    ///
    /// Note that elements in this order is not in DFS.
    /// You need to use `Tree.dfs` to get element iteration
    /// in DFS order. Also don't forget dropping first element
    /// in iteration which is `[]`, that doesn't have element.
    ///
    var paths: TreePaths<Self> {
        return TreePaths<Self>(base: self)
    }
}

public struct TreePaths<Base> where Base: Tree {
    let base: Base
}



// MARK: DFS
public extension TreePaths {
    var dfs: AnySequence<Base.Path> {
        let s = TreePathDFSSequence(base: base)
        return AnySequence(s)
    }
}

private struct TreePathDFSSequence<Base>: Sequence where Base: Tree {
    let base: Base
    public func makeIterator() -> TreePathDFSIterator<Base> {
        /// Root is a collection. Therefore, no value at root.
        let s = base.contents(in: base.path)
        let n = TreeNode<Base>(
            base: base,
            location: base.path,
            sequence: s)
        return TreePathDFSIterator<Base>(base: base, reversedStack: [n])
    }
}

private struct TreePathDFSIterator<Base>: IteratorProtocol where Base: Tree {
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
        let s = base.contents(in: p)
        let n = TreeNode(
            base: base,
            location: p,
            sequence: s)
        return n
    }
}
