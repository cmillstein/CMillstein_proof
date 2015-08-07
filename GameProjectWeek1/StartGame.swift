//
//  StartGame.swift
//  GameProjectWeek1
//
//  Created by Casey Millstein on 8/6/15.
//  Copyright (c) 2015 Casey Millstein. All rights reserved.
//

import Foundation
import SpriteKit

class StartGame : SKScene {
    
    var chooseBlue : UIButton!
    
    override func didMoveToView(view: SKView) {
        self.view?.backgroundColor = UIColor.darkGrayColor()
        
       
        chooseBlue = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width/3, height: 30))
        chooseBlue.center = CGPoint(x: view.frame.width/2, y: view.frame.size.width/1.5)
        chooseBlue.setTitle("Blue Tank", forState: UIControlState.Normal)
        chooseBlue.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        chooseBlue.addTarget(self, action: Selector("PlayAsBlue"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view?.addSubview(chooseBlue)
        
        
    }
    
    func PlayAsBlue(){
        view?.presentScene(GameScene(), transition: SKTransition.flipHorizontalWithDuration(0.3))
        chooseBlue.removeFromSuperview()
    }
    
}
