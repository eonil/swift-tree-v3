//
//  BranchTree.default.swift
//  Tree
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension BranchTree {
    func startIndex(in p:Path) -> Path.Element { return branches.startIndex(in: p) }
    func endIndex(in p:Path) -> Path.Element { return branches.endIndex(in: p) }
    func index(after i:Path.Element, in p:Path) -> Path.Element { return branches.index(after: i, in: p) }
    subscript(_ i:Path.Element, in p:Path) -> Element {
        get { return branches[i, in: p].value }
    }
}
public extension BranchTree where Self: MutableBranchTree & RangeReplaceableBranchTree {
    subscript(_ i:Path.Element, in p:Path) -> Element {
        get { return branches[i, in: p].value }
        set(x) { branches[i, in: p].value = x }
    }
    mutating func replaceSubrange<C>(_ r:Range<Path.Element>, with es: C, in p:Path) where C: Collection, Self.Element == C.Element {
        let x = Branches.Element.Branches()
        branches.replaceSubrange(r, with: es.map({ Branches.Element(value: $0, branches: x) }), in: p)
    }
}
