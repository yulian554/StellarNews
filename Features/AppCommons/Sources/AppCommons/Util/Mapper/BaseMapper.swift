//
//  BaseMapper.swift
//
//
//  Created by Yulian Hincapie on 17/04/25.
//

import Foundation

open class BaseMapper<T, U> {
    
    public init() {}
    
    open func from(data: U) -> T {
        return (T.self as? T)!
    }
    
    open func to(data: T) -> U {
        return (U.self as? U)!
    }
}
