////
////  AnyRandomAccessTree.swift
////  TreeV3Util
////
////  Created by Henry on 2019/07/08.
////  Copyright © 2019 Eonil. All rights reserved.
////
//
//import Foundation
//
///// - Note:
/////     I can't use `Swift.AnyRandomAccessCollection`
/////     because I need path resolution using index, and there's
/////     no way to get original index value from `Swift.AnyIndex`.
//public struct AnyRandomAccessTree<T>: RandomAccessTree {
//    private let implPath: Path
//    private let implPathAtIn: (Index,Path) -> Path
//    private let implSequenceIn: (Path) -> SubSequence
//
//    public typealias Path = Any
//    public typealias SubSequence = AnyRandomAccessTreeSubSequence<T>
//    public init<X>(_ x:X) where
//    X:RandomAccessTree,
//    X.SubSequence.Element == T {
//        typealias I = X.SubSequence.Index
//        func makeIndex(_ i:I) -> Index {
//            return Index(
//                impl: i,
//                implEqualWith: { j in i == j as! I },
//                implLessThan: { j in i < j as! I })
//        }
//        implPath = x.path
//        implPathAtIn = { i,p in return x.path(at: i.impl as! I, in: p as! X.Path) }
//        implSequenceIn = { p in
//            let s = x.contents(in: p as! X.Path)
//            func get(_ i:Index) -> T {
//                let i1 = i.impl as! I
//                return s[i1]
//            }
//            return SubSequence(
//                implSubscript: get,
//                implIndexAfter: { i in makeIndex(s.index(after: i.impl as! I)) },
//                implIndexBefore: { i in makeIndex(s.index(before: i.impl as! I)) },
//                implIndexOffset: { i,d in makeIndex(s.index(i.impl as! I, offsetBy: d)) },
//                implDistanceFromTo: { a,b in s.distance(from: a.impl as! I, to: b.impl as! I) },
//                startIndex: makeIndex(s.startIndex),
//                endIndex: makeIndex(s.endIndex))
//        }
//    }
//    public var path: Path {
//        return implPath
//    }
//    public func path(at i:Index, in p:Path) -> Path {
//        return implPathAtIn(i,p)
//    }
//    public func contents(in p:Path) -> AnyRandomAccessTreeSubSequence<T> {
//        return implSequenceIn(p)
//    }
//    public struct Index: Comparable {
//        let impl: Any
//        let implEqualWith: (Any) -> Bool
//        let implLessThan: (Any) -> Bool
//        public static func == (_ a:Index, _ b:Index) -> Bool {
//            return a.implEqualWith(b.impl)
//        }
//        public static func < (_ a:Index, _ b:Index) -> Bool {
//            return a.implLessThan(b.impl)
//        }
//    }
//
//}
//public struct AnyRandomAccessTreeSubSequence<T>: RandomAccessCollection {
//    let implSubscript: (Index) -> T
//    let implIndexAfter: (Index) -> Index
//    let implIndexBefore: (Index) -> Index
//    let implIndexOffset: (Index,Int) -> Index
//    let implDistanceFromTo: (Index,Index) -> Int
//    public typealias Index = AnyRandomAccessTree<T>.Index
//    public typealias Element = T
//    public let startIndex: Index
//    public let endIndex: Index
//    public func index(after i: Index) -> Index { return implIndexAfter(i) }
//    public func index(before i: Index) -> Index { return implIndexBefore(i) }
//    public func index(_ i:Index, offsetBy d:Int) -> Index { return implIndexOffset(i,d) }
//    public func distance(from a:Index, to b:Index) -> Int { return implDistanceFromTo(a,b) }
//    public subscript(_ i:Index) -> Element { return implSubscript(i) }
//}
