//
//  GameViewController.swift
//  StressBits
//
//  Created by Alejandro Solis on 8/28/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//



import UIKit
import SpriteKit
import GameplayKit
import Lottie

class GameViewController: UIViewController {
    var value:Double = 1.0
    var timerIntro = Timer()
    var intro = LOTAnimationView()
    let deviceType = UIDevice.current.deviceType
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if deviceType == .iPad || deviceType == .iPad2 || deviceType == .iPadMini ||  UIDevice.current.userInterfaceIdiom == .phone {
            print("iPad")
            intro = LOTAnimationView(name: "Intro")
            
        }else{
            print("not iPad")
            intro = LOTAnimationView(name: "Intro_IPad")
        }
        
        
        intro.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        intro.contentMode = .scaleToFill
        self.view.isUserInteractionEnabled = false
        self.view.addSubview(intro)
        intro.play{ (finished) in
            
            self.timerIntro = Timer.scheduledTimer(timeInterval: 0.04, target: self, selector: #selector(self.timerClock), userInfo: nil, repeats: true)
            
            
        }
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            //view.ignoresSiblingOrder = true
            //view.showsFPS = false
            //view.showsNodeCount = false
            //view.showsPhysics = true
        }
    }
    
    
    
    
    @objc func timerClock() {
        
        value = value - 0.1
        intro.alpha = CGFloat(value)
        
        // print("ALPHA", value)
        if self.value < 0.1 {
            //  print("INVALIDAR", self.value)
            self.timerIntro.invalidate()
            self.view.isUserInteractionEnabled = true
            intro.cacheEnable = false
        }
        
        
    }
    
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .landscape
            
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
                return .landscape
            }
        
    else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}
