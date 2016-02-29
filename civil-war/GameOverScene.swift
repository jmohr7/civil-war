//
//  GameOverScene.swift
//  civil-war
//
//  Created by Joseph Mohr on 2/1/16.
//  Copyright © 2016 Mohr. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    init(size: CGSize, score:Int) {
        
        super.init(size: size)
        
        // Set background
        backgroundColor = SKColor(colorLiteralRed: 0.07, green: 0.277, blue: 0.203, alpha: 0)
        
        // Set Message
        let message =   "Score: \(score) \(score > 20 ? "😃" : "😵")"
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = message
        label.fontSize = 40
        label.fontColor = SKColor(colorLiteralRed: 0.992, green: 0.879, blue: 0.137, alpha: 1)
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(label)
        
        // Set transition animation
        runAction(SKAction.sequence([
            SKAction.waitForDuration(3.0),
            SKAction.runBlock() {
                let reveal = SKTransition.flipHorizontalWithDuration(0.5)
                let scene = GameScene(size: size)
                self.view?.presentScene(scene, transition:reveal)
            }
            ]))
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}