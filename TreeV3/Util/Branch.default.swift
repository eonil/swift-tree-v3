//
//  Branch.default.swift
//  Tree
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension Branch {
    subscript<P>(_ p:P) -> Self where P:Collection, P.Element == Branches.Index {
        switch p.isEmpty {
        case true:  return self
        case false: return branches[p.first!][p.dropFirst()]
        }
    }
}
public extension Branch where Self: MutableBranch & RangeReplaceableBranch {
    /// Gets branch at path.
    subscript<P>(_ p:P) -> Self where P:Collection, P.Element == Branches.Index {
        get {
            switch p.isEmpty {
            case true:  return self
            case false: return branches[p.first!][p.dropFirst()]
            }
        }
        set(x) {
            switch p.isEmpty {
            case true:  self = x
            case false: branches[p.first!][p.dropFirst()] = x
            }
        }
    }
}

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
    func contents<P>(in p:P) -> SubSequence where P:Collection, P.Element == Index {
        switch p.isEmpty {
        case true:  return self[startIndex...]
        case false: return self[p.first!].branches.contents(in: p.dropFirst())
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

//public extension Collection where
////Element: Branch {
//Element: Branch,
//Element.Branches == Self {
//    /// Gets branches (branch collection) at path.
//    subscript<P>(_ p:P) -> Self where P:Collection, P.Element == Index {
////        switch p.isEmpty {
////        case true:  return self
////        case false: return self[p.first!].branches[p.dropFirst()]
////        }
//        get {
//            fatalError()
//            self.first
//        }
//    }
//}

//public extension Collection where
//Element: Branch,
//Element.Branches.Index == Index {
//    subscript<P>(_ p:P) -> Element where P:Collection, P.Element == Index {
//        precondition(!p.isEmpty)
//        return self[p.first!].branches[p.dropFirst()]
//    }
//}
//public extension Collection where
//Self: MutableCollection & RangeReplaceableCollection,
//Element: MutableBranch & RangeReplaceableBranch,
//Element.Branches.Index == Index {
//    subscript<P>(_ p:P) -> Element where P:Collection, P.Element == Index {
//        get {
//            precondition(!p.isEmpty)
//            return self[p.first!].branches[p.dropFirst()]
//        }
//        set(x) {
//            precondition(!p.isEmpty)
//            self[p.first!].branches[p.dropFirst()] = x
//        }
//    }
//}

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

// MARK: DFS
public extension Collection where
Element: Branch,
Element.Branches.Index == Index,
Element.Branches.SubSequence == SubSequence {
    /// Iterates all branches in DFS order.
    var dfs: AnySequence<Element> {
        return AnySequence(lazy.map({ $0.dfs }).joined())
    }
}
