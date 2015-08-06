//
//  GameScene.swift
//  GameProjectWeek1
//
//  Created by Casey Millstein on 8/5/15.
//  Copyright (c) 2015 Casey Millstein. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var blueTank = SKSpriteNode(imageNamed: "blueTank1.png")
    var Timer = NSTimer()
    var backgroundImage = SKSpriteNode(imageNamed: "metalBackground.png")
    
    
    override func didMoveToView(view: SKView) {
       
    blueTank.size = CGSize(width: 100, height: 100)
    blueTank.position = CGPoint(x: frame.width/2, y: frame.height/2)
    blueTank.zPosition = 1.0
        
    self.addChild(blueTank)
    
        
        
    Timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("MakeEnemiesAppear"), userInfo: nil, repeats: true)
        
        
    self.addChild(backgroundImage)
        backgroundImage.position = CGPointMake(self.size.width/2, self.size.height/2)
        
        
    
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
           var bullet = SKSpriteNode(imageNamed: "bullet.png")
            bullet.position = blueTank.position
            bullet.size = CGSize(width: 25, height: 25)
            bullet.physicsBody = SKPhysicsBody(circleOfRadius: bullet.size.width/2)
            bullet.physicsBody?.affectedByGravity = false
            
            
            self.addChild(bullet)
        
        
        
            var xCoord = CGFloat(location.x - blueTank.position.x)
            var yCoord = CGFloat(location.y - blueTank.position.y)
            
            
            
            let magnitude = sqrt(xCoord * xCoord + yCoord * yCoord)
            xCoord /= magnitude
            yCoord /= magnitude
            
            let vector = CGVector(dx: 13.0 * xCoord, dy: 13.0 * yCoord)
            
            bullet.physicsBody?.applyImpulse(vector)
            
            
        
        }
    }
    
    func MakeEnemiesAppear(){
        
        let enemy = SKSpriteNode(imageNamed: "enemy.png")
        
        
        let random = arc4random() % 4
        switch random {
        case 0:
            enemy.position.x = 0
            var yPosition = arc4random_uniform(UInt32(frame.size.height))
            enemy.position.y = CGFloat(yPosition)
            
            self.addChild(enemy)
            break
        case 1:
            enemy.position.y = 0
            var xPosition = arc4random_uniform(UInt32(frame.size.width))
            enemy.position.x = CGFloat(xPosition)
            
            self.addChild(enemy)
            
            break
        case 2:
            enemy.position.y = frame.size.height
            var xPosition = arc4random_uniform(UInt32(frame.size.width))
            enemy.position.y = CGFloat(xPosition)
            
            self.addChild(enemy)
            
            break
        case 3:
            enemy.position.x = frame.size.width
            var yPosition = arc4random_uniform(UInt32(frame.size.height))
            enemy.position.y = CGFloat(yPosition)
            
            self.addChild(enemy)
            
            break
        default:
            break
        }
        
        enemy.runAction(SKAction.moveTo(blueTank.position, duration: 5.0))
        
    }
    
    
    
    
    
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
