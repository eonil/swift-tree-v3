//
//  TreeCollection.swift
//  Tree
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

/// A collection that organizes internal elements in tree-shape.
///
/// - Note:
///     This is designed as a flat interface to access tree structure.
///     Therefore different type with `Tree` and `Branch` that are designed to
///     build free-form, pointer-based tree datastructures quickly.
///     An implementation can conform both of `TreeCollection` and `Tree`
///     for convenience in both of storage and access.
///
public protocol Tree {
    associatedtype Element
    associatedtype Path: RandomAccessCollection, ExpressibleByArrayLiteral where
        Path.Index == Int,
        Path.Element: Comparable,
        Path.SubSequence == Path

    func startIndex(in p:Path) -> Path.Element
    func endIndex(in p:Path) -> Path.Element
    func index(after i:Path.Element, in p:Path) -> Path.Element
    subscript(_ i:Path.Element, in p:Path) -> Element { get }
}
public protocol MutableTree: Tree {
    subscript(_ i:Path.Element, in p:Path) -> Element { get set }
}
public protocol RangeReplaceableTree: Tree {
    mutating func replaceSubrange<C>(_ r:Range<Path.Element>, with es:C, in p:Path) where
    C:Collection,
    C.Element == Element
}
