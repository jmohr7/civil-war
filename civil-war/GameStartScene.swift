//
//  GameStartScene.swift
//  civil-war
//
//  Created by Joseph Mohr on 2/19/16.
//  Copyright © 2016 Mohr. All rights reserved.
//

import Foundation
import SpriteKit

class GameStartScene: SKScene {
    
    override init(size: CGSize) {
        
        super.init(size: size)
        
        // Set background
        let bg = SKSpriteNode(imageNamed: "Autzen")
        bg.size = self.size
        bg.position = CGPointMake(size.width * 0.5, size.height * 0.5)
        bg.zPosition = -1.0
        bg.alpha = 0.4
        self.addChild(bg)
        
        // Set Message
        let message =   "Civil War"
        let label = SKLabelNode(fontNamed: "Copperplate-Bold")
        label.text = message
        label.fontSize = 70
        label.fontColor = SKColor(colorLiteralRed: 0.992, green: 0.879, blue: 0.137, alpha: 1)
        label.position = CGPoint(x: size.width/2, y: size.height*0.75)
        addChild(label)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Set transition animation
        runAction(SKAction.runBlock() {
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            let scene = GameScene(size: self.size)
            self.view?.presentScene(scene, transition:reveal)
            })
    }
}
