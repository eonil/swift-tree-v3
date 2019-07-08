//
//  AnyTree.swift
//  TreeV3
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public struct AnyTree<T>: Tree {
    private let implPath: Path
    private let implPathAtIn: (Index,Path) -> Path
    private let implSequenceIn: (Path) -> SubSequence

    public typealias Path = Any
    public typealias SubSequence = AnyTreeSubSequence<T>
    public init<X>(_ x:X) where
    X:Tree,
    X.SubSequence.Element == T {
        typealias I = X.SubSequence.Index
        func makeIndex(_ i:I) -> Index {
            return Index(
                impl: i,
                implEqualWith: { j in i == j as! I },
                implLessThan: { j in i < j as! I })
        }
        implPath = x.path
        implPathAtIn = { i,p in return x.path(at: i.impl as! I, in: p as! X.Path) }
        implSequenceIn = { p in
            let s = x.contents(in: p as! X.Path)
            func get(_ i:Index) -> T {
                let i1 = i.impl as! I
                return s[i1]
            }
            return SubSequence(
                implSubscript: get,
                implIndexAfter: { i in makeIndex(s.index(after: i.impl as! I)) },
                startIndex: makeIndex(s.startIndex),
                endIndex: makeIndex(s.endIndex))
        }
    }
    public var path: Path {
        return implPath
    }
    public func path(at i:Index, in p:Path) -> Path {
        return implPathAtIn(i,p)
    }
    public func contents(in p:Path) -> AnyTreeSubSequence<T> {
        return implSequenceIn(p)
    }
    public struct Index: Comparable {
        let impl: Any
        let implEqualWith: (Any) -> Bool
        let implLessThan: (Any) -> Bool
        public static func == (_ a:Index, _ b:Index) -> Bool {
            return a.implEqualWith(b.impl)
        }
        public static func < (_ a:Index, _ b:Index) -> Bool {
            return a.implLessThan(b.impl)
        }
    }

}
public struct AnyTreeSubSequence<T>: Collection {
    let implSubscript: (Index) -> T
    let implIndexAfter: (Index) -> Index
    public typealias Index = AnyTree<T>.Index
    public typealias Element = T
    public let startIndex: Index
    public let endIndex: Index
    public func index(after i: Index) -> Index {
        return implIndexAfter(i)
    }
    public subscript(_ i:Index) -> Element {
        return implSubscript(i)
    }
}
