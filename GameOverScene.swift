//
//  GameOverScene.swift
//  GameProjectWeek1
//
//  Created by Casey Millstein on 8/6/15.
//  Copyright (c) 2015 Casey Millstein. All rights reserved.
//

import Foundation
import SpriteKit





class GameOverScene : SKScene {
    
    
    var replay : UIButton!
    
    
    override func didMoveToView(view: SKView) {
        scene?.backgroundColor = UIColor.darkGrayColor()
        
        
        
        replay = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width/3, height: 30))
        replay.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.width / 1)
        replay.setTitle("Replay", forState: UIControlState.Normal)
        replay.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        
        replay.addTarget(self, action: Selector("ReplayGame"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view?.addSubview(replay)
    }
    
    
    func ReplayGame(){
        //NSLog("Hello")
        self.view?.presentScene(GameScene(), transition: SKTransition.flipHorizontalWithDuration(0.3))
        replay.removeFromSuperview()
        
}



}
