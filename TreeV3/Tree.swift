//
//  TreeCollection.swift
//  Tree
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

/// An interface to access elements in a tree.
///
/// - Note:
///     This is designed as a flat interface to access tree structure.
///     Therefore different with `Branch` that is designed to
///     build free-form, pointer-based tree datastructures quickly.
///     Combination of two protocols produces `BranchTree`.
///
public protocol Tree {
    associatedtype Element
    associatedtype SubSequence
    associatedtype Path: TreeV3.Path

    func startIndex(in p:Path) -> Path.Element
    func endIndex(in p:Path) -> Path.Element
    func index(after i:Path.Element, in p:Path) -> Path.Element
    func index(before i:Path.Element, in p:Path) -> Path.Element
    func index(_ i:Path.Element, offsetBy d:Int, in p:Path) -> Path.Element
    func distance(from a:Path.Element, to b:Path.Element, in p:Path) -> Int
    subscript(_ i:Path.Element, in p:Path) -> Element { get }

    /// Gets all elements at location.
    func sequence(in p:Path) -> SubSequence
    /// This was designed to be a `subscript`, but having `subscript` form
    /// makes compiler goes crazy. Swift compiler fails on every features that are not
    /// on Rust.
    func subsequence(_ r:Range<Path.Element>, in p:Path) -> SubSequence
}
public protocol MutableTree: Tree {
    subscript(_ i:Path.Element, in p:Path) -> Element { get set }
//    subscript(_ r:Range<Path.Element>, in p:Path) -> SubSequence { get set }
}
public protocol RangeReplaceableTree: Tree {
    mutating func replaceSubrange<C>(_ r:Range<Path.Element>, with es:C, in p:Path) where
    C:Collection,
    C.Element == Element
}
