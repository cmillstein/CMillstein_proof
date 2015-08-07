//
//  GameOverScene.swift
//  GameProjectWeek1
//
//  Created by Casey Millstein on 8/6/15.
//  Copyright (c) 2015 Casey Millstein. All rights reserved.
//


import SpriteKit
import Foundation



class GameOverScene : SKScene {
    
    
    var replay : UIButton!
    
    
    override func didMoveToView(view: SKView) {
        scene?.backgroundColor = UIColor.whiteColor()
        
        
        
        
        
        replay = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width/3, height: 30))
        replay.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.width / 7)
        replay.setTitle("Replay", forState: UIControlState.Normal)
        replay.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        
        replay.addTarget(self, action: Selector("Restart"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view?.addSubview(replay)
    }
    
    
    func Restart(){
        self.view?.presentScene(GameScene(), transition: SKTransition.crossFadeWithDuration(0.3))
        replay.removeFromSuperview()
        
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
}