//
//  Branch.default.swift
//  Tree
//
//  Created by Henry on 2019/07/07.
//  Copyright © 2019 Eonil. All rights reserved.
//

import Foundation

public extension RandomAccessCollection where
Element: Branch,
Element.Branches.Index == Index,
Element.Branches.SubSequence == SubSequence {
    func startIndex<P>(in p:P) -> Index where P:Collection, P.Element == Index {
        switch p.count {
        case 0:     return startIndex
        default:    return self[p.first!].branches.startIndex(in: p.dropFirst())
        }
    }
    func endIndex<P>(in p:P) -> Index where P:Collection, P.Element == Index {
        switch p.count {
        case 0:     return startIndex
        default:    return self[p.first!].branches.endIndex(in: p.dropFirst())
        }
    }
    func index<P>(after i:Index, in p:P) -> Index where P:Collection, P.Element == Index {
        switch p.count {
        case 0:     return index(after: i)
        default:    return self[p.first!].branches.index(after: i)
        }
    }
    func index<P>(before i:Index, in p:P) -> Index where P:Collection, P.Element == Index {
        switch p.count {
        case 0:     return index(before: i)
        default:    return self[p.first!].branches.index(before: i)
        }
    }
    func index<P>(_ i:Index, offsetBy d:Int, in p:P) -> Index where P:Collection, P.Element == Index {
        switch p.count {
        case 0:     return index(i, offsetBy: d)
        default:    return self[p.first!].branches.index(i, offsetBy: d, in: p.dropFirst())
        }
    }
    subscript<P>(_ i:Index, in p:P) -> Element where P:Collection, P.Element == Index {
        switch p.count {
        case 0:     return self[i]
        default:    return self[p.first!].branches[i, in: p.dropFirst()]
        }
    }
    subscript<P>(_ r:Range<Index>, in p:P) -> SubSequence where P:Collection, P.Element == Index {
        switch p.count {
        case 0:     return self[r]
        default:    return self[p.first!].branches[r, in: p.dropFirst()]
        }
    }
}

public extension RandomAccessCollection where
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
