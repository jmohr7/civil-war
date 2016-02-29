//
//  PhysicsCategory.swift
//  civil-war
//
//  Created by Joseph Mohr on 1/31/16.
//  Copyright © 2016 Mohr. All rights reserved.
//

struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let Villain   : UInt32 = 0b1
    static let Projectile: UInt32 = 0b10
    static let Duck      : UInt32 = 0b100
    static let Edge      : UInt32 = 0b1000
    static let Goal      : UInt32 = 0b10000
    static let Football  : UInt32 = 0b100000
    static let PAT       : UInt32 = 0b1000000
    static let Uprights  : UInt32 = 0b10000000
}