//
//  Branch.default.swift
//  Tree
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension Collection where
Element: Branch,
Element.Branches.Index == Index,
Element.Branches.SubSequence == SubSequence {
    func startIndex<P>(in p:P) -> Index where P:Collection, P.Element == Index {
        switch p.isEmpty {
        case true:  return startIndex
        case false: return self[p.first!].branches.startIndex(in: p.dropFirst())
        }
    }
    func endIndex<P>(in p:P) -> Index where P:Collection, P.Element == Index {
        switch p.isEmpty {
        case true:  return endIndex
        case false: return self[p.first!].branches.endIndex(in: p.dropFirst())
        }
    }
    func index<P>(after i:Index, in p:P) -> Index where P:Collection, P.Element == Index {
        switch p.isEmpty {
        case true:  return index(after: i)
        case false: return self[p.first!].branches.index(after: i)
        }
    }
    subscript<P>(_ i:Index, in p:P) -> Element where P:Collection, P.Element == Index {
        switch p.isEmpty {
        case true:  return self[i]
        case false: return self[p.first!].branches[i, in: p.dropFirst()]
        }
    }
    subscript<P>(_ r:Range<Index>, in p:P) -> SubSequence where P:Collection, P.Element == Index {
        switch p.isEmpty {
        case true:  return self[r]
        case false: return self[p.first!].branches[r, in: p.dropFirst()]
        }
    }
    func sequence<P>(in p:P) -> SubSequence where P:Collection, P.Element == Index {
        switch p.isEmpty {
        case true:  return self[startIndex...]
        case false: return self[p.first!].branches.sequence(in: p.dropFirst())
        }
    }
}

public extension Collection where
Self: RandomAccessCollection,
Element: RandomAccessBranch,
Element.Branches.Index == Index,
Element.Branches.SubSequence == SubSequence {
    func index<P>(before i:Index, in p:P) -> Index where P:Collection, P.Element == Index {
        switch p.isEmpty {
        case true:  return index(before: i)
        case false: return self[p.first!].branches.index(before: i)
        }
    }
    func index<P>(_ i:Index, offsetBy d:Int, in p:P) -> Index where P:Collection, P.Element == Index {
        switch p.isEmpty {
        case true:  return index(i, offsetBy: d)
        case false: return self[p.first!].branches.index(i, offsetBy: d, in: p.dropFirst())
        }
    }
    func distance<P>(from a: Index, to b: Index, in p:P) -> Int where P:Collection, P.Element == Index {
        switch p.isEmpty {
        case true:  return distance(from: a, to: b)
        case false: return self[p.first!].branches.distance(from: a, to: b, in: p.dropFirst())
        }
    }
}

public extension Collection where
Self: MutableCollection & RangeReplaceableCollection,
Element: MutableBranch & RangeReplaceableBranch,
Element.Branches.Index == Index,
Element.Branches.SubSequence == SubSequence {
    subscript<P>(_ i:Index, in p:P) -> Element where P:Collection, P.Element == Index {
        get {
            switch p.count {
            case 0:     return self[i]
            default:    return self[p.first!].branches[i, in: p.dropFirst()]
            }
        }
        set(x) {
            switch p.count {
            case 0:     self[i] = x
            default:    self[p.first!].branches[i, in: p.dropFirst()] = x
            }
        }
    }
    mutating func replaceSubrange<C,P>(_ r:Range<Index>, with es:C, in p:P) where
    C:Collection,
    C.Element == Iterator.Element,
    P:Collection,
    P.Element == Index {
        switch p.isEmpty {
        case true:  replaceSubrange(r, with: es)
        case false: self[p.first!].branches.replaceSubrange(r, with: es, in: p.dropFirst())
        }
    }
    subscript<P>(_ r:Range<Index>, in p:P) -> SubSequence where P:Collection, P.Element == Index {
        get {
            switch p.count {
            case 0:     return self[r]
            default:    return self[p.first!].branches[r, in: p.dropFirst()]
            }
        }
        set(x) {
            switch p.count {
            case 0:     self[r] = x
            default:    self[p.first!].branches[r, in: p.dropFirst()] = x
            }
        }
    }
    mutating func replaceSubrange<P>(_ r:Range<Index>, with es:SubSequence, in p:P) where
    P:Collection,
    P.Element == Index {
        switch p.isEmpty {
        case true:  replaceSubrange(r, with: es)
        case false: self[p.first!].branches.replaceSubrange(r, with: es, in: p.dropFirst())
        }
    }
}
