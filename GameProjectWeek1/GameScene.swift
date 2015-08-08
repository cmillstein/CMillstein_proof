//
//  GameScene.swift
//  GameProjectWeek1
//
//  Created by Casey Millstein on 8/5/15.
//  Copyright (c) 2015 Casey Millstein. All rights reserved.
//

import SpriteKit
import AVFoundation




//Creating physics structures

struct WorkingPhysics {
    static let enemy : UInt32 = 0x1 << 0
    static let bullet : UInt32 = 0x1 << 1
    static let bluePlayer : UInt32 = 0x1 >> 2
    
}


class GameScene: SKScene, SKPhysicsContactDelegate{
    
    var blueTank = SKSpriteNode(imageNamed: "blueTank1.png")
    var Timer = NSTimer()
    var backgroundImage = SKSpriteNode(imageNamed: "Metalbackground.png")
    
    
    
    override func didMoveToView(view: SKView) {
        
        //Setting up physics for world
        
        self.physicsWorld.contactDelegate = self
       
    blueTank.size = CGSize(width: 100, height: 100)
    blueTank.position = CGPoint(x: frame.width/2, y: frame.height/5)
        //zPosition showing tank
    blueTank.zPosition = 1.0
        blueTank.name = "blueTank"
        
        blueTank.physicsBody = SKPhysicsBody(rectangleOfSize: blueTank.size)
        blueTank.physicsBody?.categoryBitMask = WorkingPhysics.bluePlayer
        blueTank.physicsBody?.affectedByGravity = false
        blueTank.physicsBody?.contactTestBitMask = WorkingPhysics.enemy
        blueTank.physicsBody?.dynamic = false
        
    self.addChild(blueTank)
    
        
        
    Timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("MakeEnemiesAppear"), userInfo: nil, repeats: true)
        
        
    self.addChild(backgroundImage)
    backgroundImage.position = CGPointMake(self.size.width/2, self.size.height/2)
        
        
    
    }
    

    
    //Connecting the contact between enemies, bullets, and tank
    func didBeginContact(contact: SKPhysicsContact) {
        let bodyOne = contact.bodyA.node as! SKSpriteNode
        let bodyTwo = contact.bodyB.node as! SKSpriteNode
        
        
        
        if ((bodyOne.name == "enemy") && (bodyTwo.name == "bullet")){
            
            bulletCollision(bodyOne, bullet: bodyTwo)

            
        }
        if ((bodyOne.name == "bullet") && (bodyTwo.name == "enemy")){
            
            
            bulletCollision(bodyTwo, bullet: bodyOne)
            
        }
        
        else if ((bodyOne.name == "blueTank") && (bodyTwo.name == "enemy")){
            
            collisionWithTank(bodyOne, blueTank: bodyTwo)
            //bodyTwo.runAction(SKAction.playSoundFileNamed("Explosion2.m4a", waitForCompletion: false))
        }
        
        
        
        
        
        
    }
    //Bullet Collision
    func bulletCollision(enemy: SKSpriteNode, bullet: SKSpriteNode){
        bullet.removeFromParent()
        enemy.removeFromParent()
        
    }
    
    //Collision With Tank
    func collisionWithTank(enemy: SKSpriteNode, blueTank: SKSpriteNode){
        enemy.removeFromParent()
        blueTank.removeFromParent()
        
        let gameOverSceneShow = SKTransition.flipHorizontalWithDuration(0.5)
        let showScene = GameOverScene(size: self.size)
        self.view?.presentScene(showScene, transition: gameOverSceneShow)
        
    }
    
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            //creating bullet
           var bullet = SKSpriteNode(imageNamed: "bullet.png")
            bullet.position = blueTank.position
            bullet.size = CGSize(width: 25, height: 25)
            bullet.physicsBody = SKPhysicsBody(circleOfRadius: bullet.size.width/2)
            
            
            
            
        
        
        
            var xCoord = CGFloat(location.x - blueTank.position.x)
            var yCoord = CGFloat(location.y - blueTank.position.y)
            
            //Creating bullet physics
            bullet.physicsBody?.categoryBitMask = WorkingPhysics.bullet
            bullet.physicsBody?.collisionBitMask = WorkingPhysics.enemy
            bullet.physicsBody?.contactTestBitMask = WorkingPhysics.enemy
            bullet.name = "bullet"
            bullet.physicsBody?.dynamic = true
            bullet.physicsBody?.affectedByGravity = false
            bullet.runAction(SKAction.playSoundFileNamed("tankShoot.mp3", waitForCompletion: false))
            
            
            let magnitude = sqrt(xCoord * xCoord + yCoord * yCoord)
            xCoord /= magnitude
            yCoord /= magnitude

            self.addChild(bullet)
            
            let vector = CGVector(dx: 13.0 * xCoord, dy: 13.0 * yCoord)
            
            bullet.physicsBody?.applyImpulse(vector)
            
            

            
            
           
        
        }
    }
    
    
    //CREATE ENEMIES
    
    func MakeEnemiesAppear(){
        
        
        var enemy = SKSpriteNode(imageNamed: "enemy.png")
        
        var minimum = self.size.width / 8
        var maximum = self.size.width - 20
        var spawn = UInt32(maximum - minimum)
        enemy.position = CGPointMake(CGFloat(arc4random_uniform(spawn)), self.size.height)
        
        let action = SKAction.moveToY(-50, duration: 2.5)
        let actionStop = SKAction.removeFromParent()
        enemy.runAction(SKAction.sequence([action, actionStop]))
        enemy.runAction(SKAction.repeatActionForever(action))
        
        
        
        
        enemy.physicsBody = SKPhysicsBody(rectangleOfSize: enemy.size)
        enemy.physicsBody?.categoryBitMask = WorkingPhysics.enemy
        enemy.physicsBody?.contactTestBitMask = WorkingPhysics.bullet
        enemy.physicsBody?.collisionBitMask = WorkingPhysics.bullet
        enemy.physicsBody?.affectedByGravity = false
        enemy.name = "enemy"
        enemy.runAction(SKAction.playSoundFileNamed("enemyDrop.mp3", waitForCompletion: false))

        self.addChild(enemy)

        
        
        
    }
    
    
    
    
    
    
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
