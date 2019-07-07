//
//  TreeV3Test.swift
//  TreeV3Test
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import XCTest
@testable import TreeV3

class TreeV3Test: XCTestCase {
    func testBasics() {
        var a = ArrayBranchTree<Int>()
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
        XCTAssertEqual(Array(a.sequence(in: [3])), [999_999])
        XCTAssertEqual(Array(a.sequence(in: [3,0])), [999_999_999])
        XCTAssertEqual(Array(a.sequence(in: [3,0,0])), [999_999_999_999])
    }
    func testDFS() {
        var a = ArrayBranchTree<Int>()
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
            let s = a.sequence(in: p)
            return Array(s)
        }
        XCTAssertEqual(Array(Array(a.paths.dfs).map(findSequence(at:))), [
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
        XCTAssertEqual(Array(Array(a.paths.dfs.dropFirst()).map(findElement(at:))), [
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
    func testMap() {
        var a = ArrayBranchTree<Int>()
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
            let s = b.sequence(in: p)
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
}
