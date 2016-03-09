//
//  GameScene.swift
//  civil-war
//
//  Created by Joseph Mohr on 1/30/16.
//  Copyright (c) 2016 Mohr. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    let puddles = SKSpriteNode(imageNamed: "Puddles")
    let noBallSkin = SKTexture(imageNamed: "Puddles")
    let hasBallSkin = SKTexture(imageNamed: "Puddles-Ball")
    var footballSpawned = false
    var puddlesHasFootball = false
    var score = 0
    
    override func didMoveToView(view: SKView) {
        
        // Initialize physics
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        physicsBody?.categoryBitMask = PhysicsCategory.Edge
        physicsBody?.contactTestBitMask = PhysicsCategory.Duck
        
        // Add Goal Line
        let goalLine = SKNode()
        goalLine.physicsBody = SKPhysicsBody(edgeFromPoint: CGPoint(x: self.frame.width * 0.9, y: self.frame.size.height), toPoint: CGPoint(x: self.frame.width * 0.9, y: 0.0))
        goalLine.physicsBody?.categoryBitMask = PhysicsCategory.Goal
        goalLine.physicsBody?.contactTestBitMask = PhysicsCategory.Duck
        goalLine.physicsBody?.collisionBitMask = PhysicsCategory.None

        // Setup Puddles physics
        puddles.physicsBody = SKPhysicsBody(rectangleOfSize: puddles.size)
        puddles.physicsBody?.dynamic = true
        puddles.physicsBody?.categoryBitMask = PhysicsCategory.Duck
        puddles.physicsBody?.contactTestBitMask = PhysicsCategory.Villain
        puddles.physicsBody?.collisionBitMask = PhysicsCategory.None
        puddles.physicsBody?.usesPreciseCollisionDetection = true
        
        // Add Background
        let bg = SKSpriteNode(imageNamed: "Autzen")
        bg.size = self.size
        bg.position = CGPointMake(size.width * 0.5, size.height * 0.5)
        bg.zPosition = -1.0
        self.addChild(bg)
        
        // Initialize Puddles
        puddles.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        self.addChild(puddles)
        self.addChild(goalLine)
        
        // Repeating action to add villains
        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock(addBeaver),
                SKAction.runBlock(addFootball),
                SKAction.waitForDuration(1.0)
                ])
            ))
        
        // Add swipe recognizers to view
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "swipedRight:")
        swipeRight.direction = .Right
        view.addGestureRecognizer(swipeRight)
        let swipeDown = UISwipeGestureRecognizer(target: self, action: "swipedDown:")
        swipeDown.direction = .Down
        view.addGestureRecognizer(swipeDown)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "swipedLeft:")
        swipeLeft.direction = .Left
        view.addGestureRecognizer(swipeLeft)
        let swipeUp = UISwipeGestureRecognizer(target: self, action: "swipedUp:")
        swipeUp.direction = .Up
        view.addGestureRecognizer(swipeUp)
    }
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    func randomCGFloat() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func randomCGFloat(min min: CGFloat, max: CGFloat) -> CGFloat {
        return randomCGFloat() * (max - min) + min
    }
    
    func addBeaver() {
        
        // Create beaver sprite
        let villain = SKSpriteNode(imageNamed: "Beaver")
        
        // Determine random height to spawn the villain
        let actualY = randomCGFloat(min: villain.size.height/2, max: size.height - villain.size.height/2)
        
        // start beaver on far right at a random height
        villain.position = CGPoint(x: size.width + villain.size.width/2, y: actualY)
        
        // Add the beaver to the scene
        addChild(villain)
        
        // Determine speed of the beaver
        let actualDuration = randomCGFloat(min: CGFloat(2.0), max: CGFloat(4.0))
        
        // Create the actions
        let actionMove = SKAction.moveTo(CGPoint(x: -villain.size.width/2, y: actualY), duration: NSTimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        villain.runAction(SKAction.sequence([actionMove, actionMoveDone]))
        
        // Setup villain physics
        villain.physicsBody = SKPhysicsBody(rectangleOfSize: villain.size)
        villain.physicsBody?.dynamic = true
        villain.physicsBody?.categoryBitMask = PhysicsCategory.Villain
        villain.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile
        villain.physicsBody?.collisionBitMask = PhysicsCategory.None
    }
    func addFootball(){
        if !footballSpawned{
            if random()%100 >= 90 {
                // Create beaver sprite
                let football🏈 = SKSpriteNode(imageNamed: "Football")
                
                // Determine random height to spawn the villain
                let actualY = randomCGFloat(min: football🏈.size.height/2, max: size.height - football🏈.size.height/2)
                let actualX = randomCGFloat(min: football🏈.size.width/2, max: size.width * 0.4 - football🏈.size.width/2)
                // start beaver on far right at a random height
                football🏈.position = CGPoint(x: actualX, y: actualY)
                
                // Add the beaver to the scene
                addChild(football🏈)
                
                // Setup football physics
                football🏈.physicsBody = SKPhysicsBody(rectangleOfSize: football🏈.size)
                football🏈.physicsBody?.dynamic = true
                football🏈.physicsBody?.categoryBitMask = PhysicsCategory.Football
                football🏈.physicsBody?.contactTestBitMask = PhysicsCategory.Duck
                football🏈.physicsBody?.collisionBitMask = PhysicsCategory.None

                footballSpawned = true
            }
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        // Choose one of the touches to work with
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.locationInNode(self)
        
        // Get initial position, determine offset, draw projectile
        let projectile = SKSpriteNode(imageNamed: "Projectile")
        projectile.position = puddles.position
        let offset = touchLocation - projectile.position
        addChild(projectile)
        
        // Get the direction and target point off screen in that direction
        let direction = offset.normalized()
        let shootAmount = direction * 1000
        let realDest = shootAmount + projectile.position
        
        // Create the actions
        let actionMove = SKAction.moveTo(realDest, duration: 2.0)
        let actionMoveDone = SKAction.removeFromParent()
        
        // Create the physics
        projectile.runAction(SKAction.sequence([actionMove, actionMoveDone]))
        projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width/2)
        projectile.physicsBody?.dynamic = true
        projectile.physicsBody?.categoryBitMask = PhysicsCategory.Projectile
        projectile.physicsBody?.contactTestBitMask = PhysicsCategory.Villain
        projectile.physicsBody?.collisionBitMask = PhysicsCategory.None
        projectile.physicsBody?.usesPreciseCollisionDetection = true
    }
    func projectileDidCollideWithVillain(projectile: SKSpriteNode?, villain: SKSpriteNode?) {
        projectile?.removeFromParent()
        villain?.removeFromParent()
    }
    func beaverDidCollideWithPuddles(){
        let loseAction = SKAction.runBlock() {
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            let gameOverScene = GameOverScene(size: self.size, score: self.score)
            self.view?.presentScene(gameOverScene, transition: reveal)
        }
        self.runAction(loseAction)
    }
    func puddlesDidCollideWithEdge(){
        puddles.removeActionForKey("MoveAction")
    }
    func puddlesDidCollideWithFootball(football: SKSpriteNode){
        puddlesHasFootball = true
        puddles.texture = hasBallSkin
        football.removeFromParent()
    }
    func puddlesDidCollideWithGoalLine(){
        if(puddlesHasFootball){
            puddlesHasFootball = false
            footballSpawned = false
            score = score + 6
            puddles.texture = noBallSkin
            puddles.runAction(SKAction.moveTo(CGPoint(x: size.width * 0.1, y: size.height * 0.5), duration: 0.0))
            runAction(SKAction.playSoundFileNamed("oregonfight.mp3", waitForCompletion: false))
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & PhysicsCategory.Villain != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Projectile != 0)) {
                projectileDidCollideWithVillain(secondBody.node as? SKSpriteNode, villain: firstBody.node as? SKSpriteNode)
        }
        else if ((firstBody.categoryBitMask & PhysicsCategory.Villain != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Duck != 0)) {
                beaverDidCollideWithPuddles()
        }
        else if ((firstBody.categoryBitMask & PhysicsCategory.Duck != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Edge != 0)) {
                puddlesDidCollideWithEdge()
        }
        else if ((firstBody.categoryBitMask & PhysicsCategory.Duck != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Goal != 0)) {
                puddlesDidCollideWithGoalLine()
        }
        else if ((firstBody.categoryBitMask & PhysicsCategory.Duck != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Football != 0)) {
                puddlesDidCollideWithFootball(secondBody.node as! SKSpriteNode)
        }
    }
    
    // Swipe Handlers
    func swipedRight(sender:UISwipeGestureRecognizer){
        puddles.removeActionForKey("MoveAction")
        if(puddles.position.x < self.frame.width - puddles.size.width*0.5 - 10.0){
            let moveRightAction = SKAction.moveByX(50.0, y: 0.0, duration: 1.0)
            puddles.runAction(SKAction.repeatActionForever(moveRightAction), withKey: "MoveAction")
        }
    }
    func swipedDown(sender:UISwipeGestureRecognizer){
        puddles.removeActionForKey("MoveAction")
        if(puddles.position.y > puddles.size.height*0.5 + 10.0){
            let moveDownAction = SKAction.moveByX(0.0, y: -50.0, duration: 1.0)
            puddles.runAction(SKAction.repeatActionForever(moveDownAction), withKey: "MoveAction")
        }
    }
    func swipedLeft(sender:UISwipeGestureRecognizer){
        puddles.removeActionForKey("MoveAction")
        if(puddles.position.x > puddles.size.width*0.5 + 10.0){
            let moveLeftAction = SKAction.moveByX(-50.0, y: 0.0, duration: 1.0)
            puddles.runAction(SKAction.repeatActionForever(moveLeftAction), withKey: "MoveAction")
        }
    }
    func swipedUp(sender:UISwipeGestureRecognizer){
        puddles.removeActionForKey("MoveAction")
        if(puddles.position.y < self.frame.height - puddles.size.height*0.5 - 10.0){
            let moveUpAction = SKAction.moveByX(0.0, y: 50.0, duration: 1.0)
            puddles.runAction(SKAction.repeatActionForever(moveUpAction), withKey: "MoveAction")
        }
    }
}
