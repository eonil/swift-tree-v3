//
//  TreeV3UtilTest.swift
//  TreeV3UtilTest
//
//  Created by Henry on 2019/07/08.
//  Copyright © 2019 Eonil. All rights reserved.
//

import XCTest
@testable import TreeV3Util

class TreeV3UtilTest: XCTestCase {
    func testBasics() {
        var a = ArrayTree<Int>()
        a.append(111, in: [])
        a.insert(333, at: 1, in: [])
        a.insert(222, at: 1, in: [])
        XCTAssertEqual(a.isEmpty(in: []), false)
        XCTAssertEqual(a.startIndex(in: []), 0)
        XCTAssertEqual(a.endIndex(in: []), 3)
        XCTAssertEqual(a.count(in: []), 3)
        XCTAssertEqual(a.branches.count, 3)
        XCTAssertEqual(a[0,in: []], 111)
        XCTAssertEqual(a[1,in: []], 222)
        XCTAssertEqual(a[2,in: []], 333)
        XCTAssertEqual(Array(a.branches.map({ $0.value })), [111, 222, 333])

        a.append(222_111, in: [1])
        a.append(contentsOf: [222_222, 222_333], in: [1])
        XCTAssertEqual(a.count(in: [1]), 3)
        XCTAssertEqual(a[0,in: [1]], 222_111)
        XCTAssertEqual(a[1,in: [1]], 222_222)
        XCTAssertEqual(a[2,in: [1]], 222_333)
        XCTAssertEqual(Array(a.branches[1].branches.map({ $0.value })), [222_111, 222_222, 222_333])

        a.append(999, in: [])
        a.append(999_999, in: [3])
        a.append(999_999_999, in: [3,0])
        a.append(999_999_999_999, in: [3,0,0])
        XCTAssertEqual(Array(a.branches[0, in: [3,0]].branches.map({ $0.value })), [999_999_999_999])
        XCTAssertEqual(a.count(in: [3]), 1)
        XCTAssertEqual(a.count(in: [3,0]), 1)
        XCTAssertEqual(a.count(in: [3,0,0]), 1)
        XCTAssertEqual(Array(a.contents(in: [3])), [999_999])
        XCTAssertEqual(Array(a.contents(in: [3,0])), [999_999_999])
        XCTAssertEqual(Array(a.contents(in: [3,0,0])), [999_999_999_999])
    }
    func testDFS() {
        var a = ArrayTree<Int>()
        a.append(111, in: [])
        a.insert(333, at: 1, in: [])
        a.insert(222, at: 1, in: [])
        a.append(222_111, in: [1])
        a.append(contentsOf: [222_222, 222_333], in: [1])
        a.append(999, in: [])
        a.append(999_999, in: [3])
        a.append(999_999_999, in: [3,0])
        a.append(999_999_999_999, in: [3,0,0])
        XCTAssertEqual(Array(a.paths.dfs), [
            [],
            [0],
            [1],
            [1,0],
            [1,1],
            [1,2],
            [2],
            [3],
            [3,0],
            [3,0,0],
            [3,0,0,0],
            ])
        func findSequence(at p:IndexPath) -> [Int] {
            let s = a.contents(in: p)
            return Array(s)
        }
        XCTAssertEqual(Array(a.paths.dfs).map(findSequence(at:)), [
            [111, 222, 333, 999],           // children of []
            [],                             // children of [0]
            [222_111, 222_222, 222_333],    // children of [1]
            [],                             // children of [1,0]
            [],                             // children of [1,1]
            [],                             // children of [1,2]
            [],                             // children of [2] (333)
            [999_999],                      // children of [3] (999)
            [999_999_999],                  // children of [3,0]
            [999_999_999_999],              // children of [3,0,0]
            []                              // children of [3,0,0,0]

            ])
        func findElement(at p:IndexPath) -> Int {
            precondition(!p.isEmpty)
            let e = a[p.last!, in: p.dropLast()]
            return e
        }
        XCTAssertEqual(Array(a.paths.dfs.dropFirst()).map(findElement(at:)), [
            111,
            222,
            222_111,
            222_222,
            222_333,
            333,
            999,
            999_999,
            999_999_999,
            999_999_999_999,
            ])
        XCTAssertEqual(Array(a.dfs), [
            111,
            222,
            222_111,
            222_222,
            222_333,
            333,
            999,
            999_999,
            999_999_999,
            999_999_999_999,
            ])
        XCTAssertEqual(Array(a.paths.dfs.dropFirst()).map(findElement(at:)), Array(a.dfs))
    }
    func testMap() {
        var a = ArrayTree<Int>()
        a.append(111, in: [])
        a.insert(333, at: 1, in: [])
        a.insert(222, at: 1, in: [])
        a.append(222_111, in: [1])
        a.append(contentsOf: [222_222, 222_333], in: [1])
        a.append(999, in: [])
        a.append(999_999, in: [3])
        a.append(999_999_999, in: [3,0])
        a.append(999_999_999_999, in: [3,0,0])
        let b = a.map({"\($0)"})
        XCTAssertEqual(Array(b.paths.dfs), [
            [],
            [0],
            [1],
            [1,0],
            [1,1],
            [1,2],
            [2],
            [3],
            [3,0],
            [3,0,0],
            [3,0,0,0],
            ])
        func findSequence(at p:IndexPath) -> [String] {
            let s = b.contents(in: p)
            return Array(s)
        }
        XCTAssertEqual(Array(Array(b.paths.dfs).map(findSequence(at:))), [
            ["111", "222", "333", "999"],   // children of []
            [],                             // children of [0]
            ["222111", "222222", "222333"], // children of [1]
            [],                             // children of [1,0]
            [],                             // children of [1,1]
            [],                             // children of [1,2]
            [],                             // children of [2] (333)
            ["999999"],                    // children of [3] (999)
            ["999999999"],                // children of [3,0]
            ["999999999999"],            // children of [3,0,0]
            []                              // children of [3,0,0,0]
            ])
    }
    func testLazyMap() {
        var a = ArrayTree<Int>()
        a.append(111, in: [])
        a.insert(333, at: 1, in: [])
        a.insert(222, at: 1, in: [])
        a.append(222_111, in: [1])
        a.append(contentsOf: [222_222, 222_333], in: [1])
        a.append(999, in: [])
        a.append(999_999, in: [3])
        a.append(999_999_999, in: [3,0])
        a.append(999_999_999_999, in: [3,0,0])
        let b = a.lazy.map({"\($0)"})
        XCTAssertEqual(Array(b.paths.dfs), [
            [],
            [0],
            [1],
            [1,0],
            [1,1],
            [1,2],
            [2],
            [3],
            [3,0],
            [3,0,0],
            [3,0,0,0],
            ])
        func findSequence(at p:IndexPath) -> [String] {
            let s = b.contents(in: p)
            return Array(s)
        }
        XCTAssertEqual(Array(Array(b.paths.dfs).map(findSequence(at:))), [
            ["111", "222", "333", "999"],   // children of []
            [],                             // children of [0]
            ["222111", "222222", "222333"], // children of [1]
            [],                             // children of [1,0]
            [],                             // children of [1,1]
            [],                             // children of [1,2]
            [],                             // children of [2] (333)
            ["999999"],                    // children of [3] (999)
            ["999999999"],                // children of [3,0]
            ["999999999999"],            // children of [3,0,0]
            []                              // children of [3,0,0,0]
            ])
    }
    func testFilter() {
        var a = ArrayTree<Int>()
        a.append(111, in: [])
        a.insert(333, at: 1, in: [])
        a.insert(222, at: 1, in: [])
        a.append(222_111, in: [1])
        a.append(contentsOf: [222_222, 222_333], in: [1])
        a.append(999, in: [])
        a.append(999_999, in: [3])
        a.append(999_999_999, in: [3,0])
        a.append(999_999_999_999, in: [3,0,0])
        let b = a.filter({ $0 % 2 == 0 })
        XCTAssertEqual(Array(b.paths.dfs), [
            [],
            [0],
            [0,0],
            ])
        func findSequence(at p:IndexPath) -> [Int] {
            let s = b.contents(in: p)
            return Array(s)
        }
        XCTAssertEqual(Array(Array(b.paths.dfs).map(findSequence(at:))), [
            [222],                          // children of []
            [222_222],                      // children of [0]
            [],                             // children of [0,0]
            ])
    }
    func testSort() {
        var a = ArrayTree<Int>()
        a.append(111, in: [])
        a.insert(333, at: 1, in: [])
        a.insert(222, at: 1, in: [])
        a.append(222_111, in: [1])
        a.append(contentsOf: [222_222, 222_333], in: [1])
        a.append(999, in: [])
        a.append(999_999, in: [3])
        a.append(999_999_999, in: [3,0])
        a.append(999_999_999_999, in: [3,0,0])
        let b = a.sorted(by: { a,b in a > b })
        XCTAssertEqual(Array(b.paths.dfs), [
            [],
            [0],
            [0,0],
            [0,0,0],
            [0,0,0,0],
            [1],
            [2],
            [2,0],
            [2,1],
            [2,2],
            [3],
            ])
        func findSequence(at p:IndexPath) -> [Int] {
            let s = b.contents(in: p)
            return Array(s)
        }
        XCTAssertEqual(Array(Array(b.paths.dfs).map(findSequence(at:))), [
            [999, 333, 222, 111],           // children of []
            [999_999],                      // children of [0] (999)
            [999_999_999],                  // children of [0,0]
            [999_999_999_999],              // children of [0,0,0]
            [],                             // children of [0,0,0,0]
            [],                             // children of [1]
            [222_333, 222_222, 222_111],    // children of [2]
            [],                             // children of [2,0]
            [],                             // children of [2,1]
            [],                             // children of [2,2]
            [],                             // children of [3] (111)
            ])
        func findElement(at p:IndexPath) -> Int {
            precondition(!p.isEmpty)
            let e = b[p.last!, in: p.dropLast()]
            return e
        }
        XCTAssertEqual(Array(Array(b.paths.dfs.dropFirst()).map(findElement(at:))), [
            999,
            999_999,
            999_999_999,
            999_999_999_999,
            333,
            222,
            222_333,
            222_222,
            222_111,
            111,
            ])
    }
    func testConverting() {
        var a = ArrayTree<Int>()
        a.append(111, in: [])
        a.insert(333, at: 1, in: [])
        a.insert(222, at: 1, in: [])
        a.append(222_111, in: [1])
        a.append(contentsOf: [222_222, 222_333], in: [1])
        a.append(999, in: [])
        a.append(999_999, in: [3])
        a.append(999_999_999, in: [3,0])
        a.append(999_999_999_999, in: [3,0,0])
        let b = ArrayTree(converting: a)
        func findSequence(at p:IndexPath) -> [Int] {
            let s = b.contents(in: p)
            return Array(s)
        }
        XCTAssertEqual(Array(b.paths.dfs).map(findSequence(at:)), [
            [111, 222, 333, 999],           // children of []
            [],                             // children of [0]
            [222_111, 222_222, 222_333],    // children of [1]
            [],                             // children of [1,0]
            [],                             // children of [1,1]
            [],                             // children of [1,2]
            [],                             // children of [2] (333)
            [999_999],                      // children of [3] (999)
            [999_999_999],                  // children of [3,0]
            [999_999_999_999],              // children of [3,0,0]
            []                              // children of [3,0,0,0]

            ])
        print(Array(b.paths.dfs))
        func findElement(at p:IndexPath) -> Int {
            precondition(!p.isEmpty)
            let e = b[p.last!, in: p.dropLast()]
            return e
        }
        XCTAssertEqual(Array(b.paths.dfs.dropFirst()).map(findElement(at:)), [
            111,
            222,
            222_111,
            222_222,
            222_333,
            333,
            999,
            999_999,
            999_999_999,
            999_999_999_999,
            ])
    }
//    func testAnyTree() {
//        var a = ArrayTree<Int>()
//        a.append(111, in: [])
//        a.insert(333, at: 1, in: [])
//        a.insert(222, at: 1, in: [])
//        a.append(222_111, in: [1])
//        a.append(contentsOf: [222_222, 222_333], in: [1])
//        a.append(999, in: [])
//        a.append(999_999, in: [3])
//        a.append(999_999_999, in: [3,0])
//        a.append(999_999_999_999, in: [3,0,0])
//        let b = AnyTree(a)
//        func findSequence(at p:AnyTree<Int>.Path) -> [Int] {
//            let s = b.contents(in: p)
//            return Array(s)
//        }
//        XCTAssertEqual(Array(Array(b.paths.dfs).map(findSequence(at:))), [
//            [111, 222, 333, 999],           // children of []
//            [],                             // children of [0]
//            [222_111, 222_222, 222_333],    // children of [1]
//            [],                             // children of [1,0]
//            [],                             // children of [1,1]
//            [],                             // children of [1,2]
//            [],                             // children of [2] (333)
//            [999_999],                      // children of [3] (999)
//            [999_999_999],                  // children of [3,0]
//            [999_999_999_999],              // children of [3,0,0]
//            []                              // children of [3,0,0,0]
//            ])
////        func findElement(at p:AnyTree<Int>.Path) -> Int {
////            b.sequence(in: <#T##Any#>)
////            let e = b[p.last!, in: p.dropLast()]
////            return e
////        }
////        XCTAssertEqual(Array(Array(b.paths.dfs.dropFirst()).map(findElement(at:))), [
////            111,
////            222,
////            222_111,
////            222_222,
////            222_333,
////            333,
////            999,
////            999_999,
////            999_999_999,
////            999_999_999_999,
////            ])
//    }
    func testRecusiveBranches() {
        /// This is static check for `Tree.Branches == Tree.Branches.Element.Branches`.
        /// It works if it's been compiled.
        var a = ArrayTree<Int>()
        a.append(111, in: [])
        a.append(222, in: [0])
        let x = a.branches[in: []]
        let y = a.branches[in: [0]]
        XCTAssertEqual(x[0].value, 111)
        XCTAssertEqual(y[0].value, 222)
    }
    func testInsertAtIn() {
        var a = ArrayTree<Int>()
        a.insert(111, at: 0, in: [])
        XCTAssertEqual(a.count(in: []), 1)
        XCTAssertEqual(a[[0]], 111)
    }
    func testReplaceSubrange() {
        var a = ArrayTree<Int>()
        a.insert(contentsOf: [11,22,33], at: 0, in: [])
        a[[1]] = 99
        XCTAssertEqual(Array(a.branches.map({ $0.value })), [11,99,33])
        a.replaceSubrange(1..<2, with: [88], in: [])
        XCTAssertEqual(Array(a.branches.map({ $0.value })), [11,88,33])
    }
}


