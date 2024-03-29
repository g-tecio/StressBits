//
//  GameOverScene.swift
//  StressBits
//
//  Created by Alejandro Solis on 8/28/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    
    var background = SKSpriteNode()
    var sadFace = SKSpriteNode()
    var bin = SKSpriteNode()
    var timerBase = SKSpriteNode()
    var timerNeedle = SKSpriteNode()
    var blackScreen = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        self.scaleMode = SKSceneScaleMode.fill
        
        //SAD FACE
        sadFace = SKSpriteNode(imageNamed: "SadFace")
        sadFace.zPosition = 5

        self.addChild(sadFace)
        

        
        background = SKSpriteNode(imageNamed: "Background")
        background.size = CGSize(width: (frame.size.width),  height: frame.size.height)
        background.position = CGPoint(x: (frame.size.width/2), y: frame.size.height/2)
        
        self.addChild(background)
        
        timerBase = SKSpriteNode(imageNamed: "Timer_Base")
        timerBase.zPosition = 4
        timerBase.size = CGSize(width:(timerBase.size.width)*(self.size.width/timerBase.size.width)/(11.42/1.8),  height: timerBase.size.height * (self.size.height/timerBase.size.height)/(6.42/1.8))
        timerBase.position = CGPoint(x: self.frame.size.width / 1.120, y: self.frame.size.height / 1.3)
        self.addChild(timerBase)
        
        //Timer Neddle
        timerNeedle = SKSpriteNode(imageNamed: "Timer_Needle")
        timerNeedle.zPosition = 5
        //timerNeedle.zRotation = CGFloat(Double.pi / 4)
        timerNeedle.size = CGSize(width:(timerNeedle.size.width)*(self.size.width/timerNeedle.size.width)/(11.42/1.3),  height: timerNeedle.size.height * (self.size.height/timerNeedle.size.height)/(6.42/1.3))
        timerNeedle.position = CGPoint(x: self.frame.size.width / 1.120, y: self.frame.size.height / 1.3)
        self.addChild(timerNeedle)
        
        //BIN
        bin = SKSpriteNode(imageNamed: "Full_Container")
        bin.zPosition = 1
        bin.size = CGSize(width:(bin.size.width)*(self.size.width/bin.size.width)/(11.42/2.3),  height: bin.size.height * (self.size.height/bin.size.height)/(6.42/3.2))
        bin.position = CGPoint(x: self.frame.size.width / 1.140, y: self.frame.size.height / 3.5)
        self.addChild(bin)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
    
            sadFace.size = CGSize(width:(sadFace.size.width)*(self.size.width/sadFace.size.width)/(9/6),  height: sadFace.size.height * (self.size.height/sadFace.size.height)/(6.42/4))
            sadFace.position = CGPoint(x: self.frame.size.width / 2.52, y: self.frame.size.height / 2)
            
            timerBase.size = CGSize(width:(timerBase.size.width)*(self.size.width/timerBase.size.width)/(9/1.8),  height: timerBase.size.height * (self.size.height/timerBase.size.height)/(6.42/1.8))
            timerBase.position = CGPoint(x: self.frame.size.width / 1.130, y: self.frame.size.height / 1.3)
            
            timerNeedle.size = CGSize(width:(timerNeedle.size.width)*(self.size.width/timerNeedle.size.width)/(9/1.3),  height: timerNeedle.size.height * (self.size.height/timerNeedle.size.height)/(6.42/1.3))
            timerNeedle.position = CGPoint(x: self.frame.size.width / 1.130, y: self.frame.size.height / 1.3)
            self.scaleMode = SKSceneScaleMode.fill
            
        }else{
         
            sadFace.size = CGSize(width:(sadFace.size.width)*(self.size.width/sadFace.size.width)/(11.42/6),  height: sadFace.size.height * (self.size.height/sadFace.size.height)/(6.42/4))
            sadFace.position = CGPoint(x: self.frame.size.width / 2.6, y: self.frame.size.width / 3.5)
            
            timerBase.size = CGSize(width:(timerBase.size.width)*(self.size.width/timerBase.size.width)/(11.42/1.8),  height: timerBase.size.height * (self.size.height/timerBase.size.height)/(6.42/1.8))
            timerBase.position = CGPoint(x: self.frame.size.width / 1.120, y: self.frame.size.height / 1.3)
            
            timerNeedle.size = CGSize(width:(timerNeedle.size.width)*(self.size.width/timerNeedle.size.width)/(11.42/1.3),  height: timerNeedle.size.height * (self.size.height/timerNeedle.size.height)/(6.42/1.3))
            timerNeedle.position = CGPoint(x: self.frame.size.width / 1.120, y: self.frame.size.height / 1.3)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let transition = SKTransition.fade(with: UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.0), duration: 0.2)
        
        let gameOver = SKScene(fileNamed: "GameScene") as! GameScene
        gameOver.scaleMode = SKSceneScaleMode.fill
        self.view!.presentScene(gameOver, transition: transition)
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
}
