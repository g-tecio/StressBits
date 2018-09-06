//
//  GameScene.swift
//  StressBits
//
//  Created by Alejandro Solis on 8/28/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        
        return self[index]
    }
}


extension Array {
    /// Returns an array containing this sequence shuffled
    var shuffled: Array {
        var elements = self
        return elements.shuffle()
    }
    /// Shuffles this sequence in place
    @discardableResult
    mutating func shuffle() -> Array {
        let count = self.count
        indices.lazy.dropLast().forEach {
            swapAt($0, Int(arc4random_uniform(UInt32(count - $0))) + $0)
        }
        return self
    }
    var chooseOne: Element { return self[Int(arc4random_uniform(UInt32(count)))] }
    func choose(_ n: Int) -> Array { return Array(shuffled.prefix(n)) }
}



import SpriteKit
import GameplayKit
import AVFoundation
import AudioToolbox
import Device_swift
import Firebase
struct ColliderType {
    
    static let circle_blue: UInt32 = 1
    static let circle_blue_container: UInt32 = 2
    
    static let circle_dblue: UInt32 = 1
    static let circle_dblue_container: UInt32 = 2
    
    static let circle_green: UInt32 = 1
    static let circle_green_container: UInt32 = 2
    
    static let circle_red: UInt32 = 1
    static let circle_red_container: UInt32 = 2
    
    static let circle_yellow: UInt32 = 1
    static let circle_yellow_container: UInt32 = 2
    
    
    static let hexagone_blue: UInt32 = 1
    static let hexagone_blue_container: UInt32 = 2
    
    static let hexagone_dblue: UInt32 = 1
    static let hexagone_dblue_container: UInt32 = 2
    
    static let hexagone_green: UInt32 = 1
    static let hexagone_green_container: UInt32 = 2
    
    static let hexagone_red: UInt32 = 1
    static let hexagone_red_container: UInt32 = 2
    
    static let hexagone_yellow: UInt32 = 1
    static let hexagone_yellow_container: UInt32 = 2
    
    
    static let square_blue: UInt32 = 1
    static let square_blue_container: UInt32 = 2
    
    static let square_dblue: UInt32 = 1
    static let square_dblue_container: UInt32 = 2
    
    static let square_green: UInt32 = 1
    static let square_green_container: UInt32 = 2
    
    static let square_red: UInt32 = 1
    static let square_red_container: UInt32 = 2
    
    static let square_yellow: UInt32 = 1
    static let square_yellow_container: UInt32 = 2
    
    
    static let star_blue: UInt32 = 1
    static let star_blue_container: UInt32 = 2
    
    static let star_dblue: UInt32 = 1
    static let star_dblue_container: UInt32 = 2
    
    static let star_green: UInt32 = 1
    static let star_green_container: UInt32 = 2
    
    static let star_red: UInt32 = 1
    static let star_red_container: UInt32 = 2
    
    static let star_yellow: UInt32 = 1
    static let star_yellow_container: UInt32 = 2
    
    
    static let triangle_blue: UInt32 = 1
    static let triangle_blue_container: UInt32 = 2
    
    static let triangle_dblue: UInt32 = 1
    
    static let triangle_dblue_container: UInt32 = 2
    
    static let triangle_green: UInt32 = 1
    static let triangle_green_container: UInt32 = 2
    
    static let triangle_red: UInt32 = 1
    static let triangle_red_container: UInt32 = 2
    
    static let triangle_yellow: UInt32 = 1
    static let triangle_yellow_container: UInt32 = 2
    
}



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var containerSprite: [ContainerSprite] = []
    var bgSoundPlayer:AVAudioPlayer?
    
    var positionContainer = 0
    var timerBase = SKSpriteNode()
    var timerNeedle = SKSpriteNode()
    var bin = SKSpriteNode()
    var binEmpty = SKSpriteNode()
    var happyFace = SKSpriteNode()
    var sadFace = SKSpriteNode()
    var contacto = SKPhysicsContact()
    var circle_blue = SKSpriteNode()
    var circle_dblue = SKSpriteNode()
    var circle_green = SKSpriteNode()
    var circle_red = SKSpriteNode()
    var circle_yellow = SKSpriteNode()
    private var hand = SKSpriteNode()
    private var handMovingFrames: [SKTexture] = []
    var triangle_blue = SKSpriteNode()
    var triangle_dblue = SKSpriteNode()
    var triangle_green = SKSpriteNode()
    var triangle_red = SKSpriteNode()
    var triangle_yellow = SKSpriteNode()
    var clicked:Bool = false
    var start:Bool = false
    var flag = false
    var star_blue = SKSpriteNode()
    var star_dblue = SKSpriteNode()
    var star_green = SKSpriteNode()
    var star_red = SKSpriteNode()
    var star_yellow = SKSpriteNode()
    
    var square_blue = SKSpriteNode()
    var square_dblue = SKSpriteNode()
    var square_green = SKSpriteNode()
    var square_red = SKSpriteNode()
    var square_yellow = SKSpriteNode()
    
    var hexagone_blue = SKSpriteNode()
    var hexagone_dblue = SKSpriteNode()
    var hexagone_green = SKSpriteNode()
    var hexagone_red = SKSpriteNode()
    var hexagone_yellow = SKSpriteNode()
    var background = SKSpriteNode()
    
    var stars:SKEmitterNode!
     var dot = SKSpriteNode()
    var arraySprites: [SKSpriteNode] = [SKSpriteNode]()
    
    
    var myRandomItem: SKSpriteNode = SKSpriteNode()
    var index = 0
    var indexContainer = 0
    var containerFull: [Int] = []
    var figure_name: String?
    var firstBody = SKPhysicsBody()
    var secondBody = SKPhysicsBody()
    
    var firstBodyHexa = SKPhysicsBody()
    var secondBodyHexa = SKPhysicsBody()
    
    var isFingerOnRandomItem =  false
    
    let deviceType = UIDevice.current.deviceType
    
    override func didMove(to view: SKView) {
        

        
        self.physicsWorld.contactDelegate = self
        self.scaleMode = SKSceneScaleMode.fill
        
        let fileURL:URL = Bundle.main.url(forResource: "timer", withExtension: "wav")!
        //basically, try to initialize the bgSoundPlayer with the contents of the URL
        do {
            bgSoundPlayer = try AVAudioPlayer(contentsOf: fileURL)
        } catch _{
            bgSoundPlayer = nil
            
        }
        
        bgSoundPlayer!.volume = 0.75 //set the volume anywhere from 0 to 1
        bgSoundPlayer!.numberOfLoops = -1 // -1 makes the player loop forever
        bgSoundPlayer!.prepareToPlay() //prepare for playback by preloading its buffers.
        
        background = SKSpriteNode(imageNamed: "Background")
        background.size = CGSize(width: (frame.size.width),  height: frame.size.height)
        background.position = CGPoint(x: (frame.size.width/2), y: frame.size.height/2)
        
        self.addChild(background)
        

        
        
        //Timer
        timerBase = SKSpriteNode(imageNamed: "Timer_Base")
        timerBase.zPosition = 4

        self.addChild(timerBase)
        
        //Timer Neddle
        timerNeedle = SKSpriteNode(imageNamed: "Timer_Needle")
        timerNeedle.zPosition = 5
        //timerNeedle.zRotation = CGFloat(Double.pi / 4)

        self.addChild(timerNeedle)
        

        
        
        //BIN
        bin = SKSpriteNode(imageNamed: "Container_Empty")
        bin.zPosition = 1
        bin.size = CGSize(width:(bin.size.width)*(self.size.width/bin.size.width)/(11.42/2.3),  height: bin.size.height * (self.size.height/bin.size.height)/(6.42/3.2))
        bin.position = CGPoint(x: self.frame.size.width / 1.140, y: self.frame.size.height / 3.5)
        self.addChild(bin)
        
        
       
        if deviceType == .iPad || deviceType == .iPad2 || deviceType == .iPadMini ||  UIDevice.current.userInterfaceIdiom == .phone {
       
            timerBase.size = CGSize(width:(timerBase.size.width)*(self.size.width/timerBase.size.width)/(11.42/1.8),  height: timerBase.size.height * (self.size.height/timerBase.size.height)/(6.42/1.8))
            timerBase.position = CGPoint(x: self.frame.size.width / 1.120, y: self.frame.size.height / 1.3)
            
            timerNeedle.size = CGSize(width:(timerNeedle.size.width)*(self.size.width/timerNeedle.size.width)/(11.42/1.3),  height: timerNeedle.size.height * (self.size.height/timerNeedle.size.height)/(6.42/1.3))
            timerNeedle.position = CGPoint(x: self.frame.size.width / 1.120, y: self.frame.size.height / 1.3)
        }else {
            
            timerBase.size = CGSize(width:(timerBase.size.width)*(self.size.width/timerBase.size.width)/(9/1.8),  height: timerBase.size.height * (self.size.height/timerBase.size.height)/(6.42/1.8))
            timerBase.position = CGPoint(x: self.frame.size.width / 1.130, y: self.frame.size.height / 1.3)
            
            //  timerNeedle.size = CGSize(width: 100, height: 80)
            timerNeedle.size = CGSize(width:(timerNeedle.size.width)*(self.size.width/timerNeedle.size.width)/(9/1.3),  height: timerNeedle.size.height * (self.size.height/timerNeedle.size.height)/(6.42/1.3))
            timerNeedle.position = CGPoint(x: self.frame.size.width / 1.130, y: self.frame.size.height / 1.3)
            
        }
        if !clicked{
            timerBase.run(SKAction.repeatForever(blinkingAnimation()),withKey: "blink")
            timerNeedle.run(SKAction.repeatForever(blinkingAnimation()), withKey:"blink")
        }
       
        
        dot = SKSpriteNode(imageNamed: "dot")
        dot.name = "dot"
        dot.zPosition = 1
        //dot.position = CGPoint(x: self.frame.size.width / 1.140, y: self.frame.size.height / 2.4)
        dot.size = CGSize(width: 2, height: 2)
        self.addChild(dot)
        //TRIANGULETES
        triangle_blue = SKSpriteNode(imageNamed: "FIgure_Triangle_Blue")
        triangle_blue.name = "Container_Triangle_Blue"
        triangle_blue.zPosition = 6
        triangle_blue.size = CGSize(width: 30, height: 33)
        triangle_blue.position = CGPoint(x: self.frame.size.width / 1.140, y: self.frame.size.height / 2.4)
        triangle_blue.physicsBody = SKPhysicsBody(rectangleOf: dot.frame.size)
        triangle_blue.physicsBody?.affectedByGravity = false
        triangle_blue.physicsBody?.isDynamic = false
        triangle_blue.physicsBody?.categoryBitMask = ColliderType.triangle_blue
        triangle_blue.physicsBody!.collisionBitMask = 0
        triangle_blue.physicsBody?.collisionBitMask = ColliderType.triangle_blue_container
        triangle_blue.physicsBody?.contactTestBitMask = ColliderType.triangle_blue_container
        self.addChild(triangle_blue)
        
        triangle_dblue = SKSpriteNode(imageNamed: "Figure_Triangle_DBlue")
        triangle_dblue.name = "Container_Triangle_DBlue"
        triangle_dblue.zPosition = 6
        triangle_dblue.size = CGSize(width: 30, height: 33)
        triangle_dblue.position = CGPoint(x: self.frame.size.width / 1.220, y: self.frame.size.height / 3.8)
        
        triangle_dblue.physicsBody = SKPhysicsBody(rectangleOf: dot.frame.size)
        triangle_dblue.physicsBody?.affectedByGravity = false
        triangle_dblue.physicsBody?.isDynamic = false
        triangle_dblue.physicsBody?.categoryBitMask = ColliderType.triangle_dblue
        triangle_dblue.physicsBody!.collisionBitMask = 0
        triangle_dblue.physicsBody?.collisionBitMask = ColliderType.triangle_dblue_container
        triangle_dblue.physicsBody?.contactTestBitMask = ColliderType.triangle_dblue_container
        self.addChild(triangle_dblue)
        
        triangle_green = SKSpriteNode(imageNamed: "FIgure_Triangle_Green")
        triangle_green.name = "Container_Triangle_Green"
        triangle_green.zPosition = 6
        triangle_green.size = CGSize(width: 30, height: 33)
        triangle_green.position = CGPoint(x: self.frame.size.width / 1.100, y: self.frame.size.height / 7.0)
        triangle_green.physicsBody = SKPhysicsBody(rectangleOf: dot.frame.size)
        triangle_green.physicsBody?.affectedByGravity = false
        triangle_green.physicsBody?.isDynamic = false
        triangle_green.physicsBody?.categoryBitMask = ColliderType.triangle_green
        triangle_green.physicsBody!.collisionBitMask = 0
        triangle_green.physicsBody?.collisionBitMask = ColliderType.triangle_green_container
        triangle_green.physicsBody?.contactTestBitMask = ColliderType.triangle_green_container
        self.addChild(triangle_green)
        
        triangle_red = SKSpriteNode(imageNamed: "FIgure_Triangle_Red")
        triangle_red.name = "Container_Triangle_Red"
        triangle_red.zPosition = 6
        triangle_red.size = CGSize(width: 30, height: 33)
        triangle_red.position = CGPoint(x: self.frame.size.width / 1.140, y: self.frame.size.height / 4.5)
        triangle_red.physicsBody = SKPhysicsBody(rectangleOf: dot.frame.size)
        triangle_red.physicsBody?.affectedByGravity = false
        triangle_red.physicsBody?.isDynamic = false
        triangle_red.physicsBody?.categoryBitMask = ColliderType.triangle_red
        triangle_red.physicsBody!.collisionBitMask = 0
        triangle_red.physicsBody?.collisionBitMask = ColliderType.triangle_red_container
        triangle_red.physicsBody?.contactTestBitMask = ColliderType.triangle_red_container
        self.addChild(triangle_red)
        
        triangle_yellow = SKSpriteNode(imageNamed: "FIgure_Triangle_Yellow")
        triangle_yellow.name = "Container_Triangle_Yellow"
        triangle_yellow.zPosition = 6
        triangle_yellow.size = CGSize(width: 30, height: 33)
        triangle_yellow.position = CGPoint(x: self.frame.size.width / 1.140, y: self.frame.size.height / 6.5)
        triangle_yellow.physicsBody = SKPhysicsBody(rectangleOf: dot.frame.size)
        triangle_yellow.physicsBody?.affectedByGravity = false
        triangle_yellow.physicsBody?.isDynamic = false
        triangle_yellow.physicsBody?.categoryBitMask = ColliderType.triangle_yellow
        triangle_yellow.physicsBody!.collisionBitMask = 0
        triangle_yellow.physicsBody?.collisionBitMask = ColliderType.triangle_yellow_container
        triangle_yellow.physicsBody?.contactTestBitMask = ColliderType.triangle_yellow_container
        self.addChild(triangle_yellow)
        
        
        //ESTRELLINES
        star_blue = SKSpriteNode(imageNamed: "FIgure_Star_Blue")
        star_blue.name = "Container_Star_Blue"
        star_blue.zPosition = 6
        star_blue.size = CGSize(width: 30, height: 33)
        star_blue.position = CGPoint(x: self.frame.size.width / 1.170, y: self.frame.size.height / 5.2)
        star_blue.physicsBody = SKPhysicsBody(rectangleOf: dot.frame.size)
        star_blue.physicsBody?.affectedByGravity = false
        star_blue.physicsBody?.isDynamic = false
        star_blue.physicsBody?.categoryBitMask = ColliderType.star_blue
        star_blue.physicsBody!.collisionBitMask = 0
        star_blue.physicsBody?.collisionBitMask = ColliderType.star_blue_container
        star_blue.physicsBody?.contactTestBitMask = ColliderType.star_blue_container
        self.addChild(star_blue)
        
        
        star_dblue = SKSpriteNode(imageNamed: "FIgure_Star_DBlue")
        star_dblue.name = "Container_Star_DBlue"
        star_dblue.zPosition = 6
        star_dblue.size = CGSize(width: 30, height: 33)
        star_dblue.position = CGPoint(x: self.frame.size.width / 1.140, y: self.frame.size.height / 2.8)
        star_dblue.physicsBody = SKPhysicsBody(rectangleOf: dot.frame.size)
        star_dblue.physicsBody?.affectedByGravity = false
        star_dblue.physicsBody?.isDynamic = false
        star_dblue.physicsBody?.categoryBitMask = ColliderType.star_dblue
        star_dblue.physicsBody!.collisionBitMask = 0
        star_dblue.physicsBody?.collisionBitMask = ColliderType.star_dblue_container
        star_dblue.physicsBody?.contactTestBitMask = ColliderType.star_dblue_container
        self.addChild(star_dblue)
        
        star_green = SKSpriteNode(imageNamed: "FIgure_Star_Green")
        star_green.name = "Container_Star_Green"
        star_green.zPosition = 6
        star_green.size = CGSize(width: 30, height: 33)
        star_green.position = CGPoint(x: self.frame.size.width / 1.160, y: self.frame.size.height / 7.2)
        star_green.physicsBody = SKPhysicsBody(rectangleOf: dot.frame.size)
        star_green.physicsBody?.affectedByGravity = false
        star_green.physicsBody?.isDynamic = false
        star_green.physicsBody?.categoryBitMask = ColliderType.star_green
        star_green.physicsBody!.collisionBitMask = 0
        star_green.physicsBody?.collisionBitMask = ColliderType.star_green_container
        star_green.physicsBody?.contactTestBitMask = ColliderType.star_green_container
        self.addChild(star_green)
        
        star_red = SKSpriteNode(imageNamed: "FIgure_Star_Red")
        star_red.name = "Container_Star_Red"
        star_red.zPosition = 6
        star_red.size = CGSize(width: 30, height: 33)
        star_red.position = CGPoint(x: self.frame.size.width / 1.100, y: self.frame.size.height / 4.5)
        star_red.physicsBody = SKPhysicsBody(rectangleOf: dot.frame.size)
        star_red.physicsBody?.affectedByGravity = false
        star_red.physicsBody?.isDynamic = false
        star_red.physicsBody?.categoryBitMask = ColliderType.star_red
        star_red.physicsBody!.collisionBitMask = 0
        star_red.physicsBody?.collisionBitMask = ColliderType.star_red_container
        star_red.physicsBody?.contactTestBitMask = ColliderType.star_red_container
        self.addChild(star_red)
        
        star_yellow = SKSpriteNode(imageNamed: "FIgure_Star_Yellow")
        star_yellow.name = "Container_Star_Yellow"
        star_yellow.zPosition = 6
        star_yellow.size = CGSize(width: 30, height: 33)
        star_yellow.position = CGPoint(x: self.frame.size.width / 1.180, y: self.frame.size.height / 2.5)
        star_yellow.physicsBody = SKPhysicsBody(rectangleOf: dot.frame.size)
        star_yellow.physicsBody?.affectedByGravity = false
        star_yellow.physicsBody?.isDynamic = false
        star_yellow.physicsBody?.categoryBitMask = ColliderType.star_yellow
        star_yellow.physicsBody!.collisionBitMask = 0
        star_yellow.physicsBody?.collisionBitMask = ColliderType.star_yellow_container
        star_yellow.physicsBody?.contactTestBitMask = ColliderType.star_yellow_container
        self.addChild(star_yellow)
        
        //SQUARES
        square_blue = SKSpriteNode(imageNamed: "FIgure_Square_Blue")
        square_blue.name = "Container_Square_Blue"
        square_blue.zPosition = 6
        square_blue.size = CGSize(width: 30, height: 30)
        square_blue.position = CGPoint(x: self.frame.size.width / 1.140, y: self.frame.size.height / 3.8)
        square_blue.physicsBody = SKPhysicsBody(rectangleOf: dot.frame.size)
        square_blue.physicsBody?.affectedByGravity = false
        square_blue.physicsBody?.isDynamic = false
        square_blue.physicsBody?.categoryBitMask = ColliderType.square_blue
        square_blue.physicsBody!.collisionBitMask = 0
        square_blue.physicsBody?.collisionBitMask = ColliderType.square_blue_container
        square_blue.physicsBody?.contactTestBitMask = ColliderType.square_blue_container
        self.addChild(square_blue)
        
        
        square_dblue = SKSpriteNode(imageNamed: "FIgure_Square_DBlue")
        square_dblue.name = "Container_Square_DBlue"
        square_dblue.zPosition = 6
        square_dblue.size = CGSize(width: 30, height: 30)
        square_dblue.position = CGPoint(x: self.frame.size.width / 1.200, y: self.frame.size.height / 5.5)
        square_dblue.physicsBody = SKPhysicsBody(rectangleOf: dot.frame.size)
        square_dblue.physicsBody?.affectedByGravity = false
        square_dblue.physicsBody?.isDynamic = false
        square_dblue.physicsBody?.categoryBitMask = ColliderType.square_dblue
        square_dblue.physicsBody!.collisionBitMask = 0
        square_dblue.physicsBody?.collisionBitMask = ColliderType.square_dblue_container
        square_dblue.physicsBody?.contactTestBitMask = ColliderType.square_dblue_container
        self.addChild(square_dblue)
        
        square_green = SKSpriteNode(imageNamed: "FIgure_Square_Green")
        square_green.name = "Container_Square_Green"
        square_green.zPosition = 6
        square_green.size = CGSize(width: 30, height: 30)
        square_green.position = CGPoint(x: self.frame.size.width / 1.090, y: self.frame.size.height / 2.5)
        square_green.physicsBody = SKPhysicsBody(rectangleOf: dot.frame.size)
        square_green.physicsBody?.affectedByGravity = false
        square_green.physicsBody?.isDynamic = false
        square_green.physicsBody?.categoryBitMask = ColliderType.square_green
        square_green.physicsBody!.collisionBitMask = 0
        square_green.physicsBody?.collisionBitMask = ColliderType.square_green_container
        square_green.physicsBody?.contactTestBitMask = ColliderType.square_green_container
        self.addChild(square_green)
        
        square_red = SKSpriteNode(imageNamed: "FIgure_Square_Red")
        square_red.name = "Container_Square_Red"
        square_red.zPosition = 6
        square_red.size = CGSize(width: 30, height: 30)
        square_red.position = CGPoint(x: self.frame.size.width / 1.210, y: self.frame.size.height / 2.8)
        square_red.physicsBody = SKPhysicsBody(rectangleOf: dot.frame.size)
        square_red.physicsBody?.affectedByGravity = false
        square_red.physicsBody?.isDynamic = false
        square_red.physicsBody?.categoryBitMask = ColliderType.square_red
        square_red.physicsBody!.collisionBitMask = 0
        square_red.physicsBody?.collisionBitMask = ColliderType.square_red_container
        square_red.physicsBody?.contactTestBitMask = ColliderType.square_red_container
        self.addChild(square_red)
        
        square_yellow = SKSpriteNode(imageNamed: "FIgure_Square_Yellow")
        square_yellow.name = "Container_Square_Yellow"
        square_yellow.zPosition = 6
        square_yellow.size = CGSize(width: 30, height: 30)
        square_yellow.position = CGPoint(x: self.frame.size.width / 1.140, y: self.frame.size.height / 3.5)
        square_yellow.physicsBody = SKPhysicsBody(rectangleOf: dot.frame.size)
        square_yellow.physicsBody?.affectedByGravity = false
        square_yellow.physicsBody?.isDynamic = false
        square_yellow.physicsBody?.categoryBitMask = ColliderType.square_yellow
        square_yellow.physicsBody!.collisionBitMask = 0
        square_yellow.physicsBody?.collisionBitMask = ColliderType.square_yellow_container
        square_yellow.physicsBody?.contactTestBitMask = ColliderType.square_yellow_container
        self.addChild(square_yellow)
        
        
        
        
        //HEXAGONES
        hexagone_blue = SKSpriteNode(imageNamed: "FIgure_Hexagone_Blue")
        hexagone_blue.name = "Container_Hexagone_Blue"
        hexagone_blue.zPosition = 6
        hexagone_blue.size = CGSize(width: 30, height: 33)
        hexagone_blue.position = CGPoint(x: self.frame.size.width / 1.140, y: self.frame.size.height / 3.8)
        hexagone_blue.physicsBody = SKPhysicsBody(rectangleOf: dot.frame.size)
        hexagone_blue.physicsBody?.affectedByGravity = false
        hexagone_blue.physicsBody?.isDynamic = false
        hexagone_blue.physicsBody?.categoryBitMask = ColliderType.hexagone_blue
        hexagone_blue.physicsBody!.collisionBitMask = 0
        hexagone_blue.physicsBody?.collisionBitMask = ColliderType.hexagone_blue_container
        hexagone_blue.physicsBody?.contactTestBitMask = ColliderType.hexagone_blue_container
        self.addChild(hexagone_blue)
        
        hexagone_dblue = SKSpriteNode(imageNamed: "FIgure_Hexagone_DBlue")
        hexagone_dblue.name = "Container_Hexagone_DBlue"
        hexagone_dblue.zPosition = 6
        hexagone_dblue.size = CGSize(width: 30, height: 33)
        hexagone_dblue.position = CGPoint(x: self.frame.size.width / 1.130, y: self.frame.size.height / 4.5)
        hexagone_dblue.physicsBody = SKPhysicsBody(rectangleOf: dot.frame.size)
        hexagone_dblue.physicsBody?.affectedByGravity = false
        hexagone_dblue.physicsBody?.isDynamic = false
        hexagone_dblue.physicsBody?.categoryBitMask = ColliderType.hexagone_dblue
        hexagone_dblue.physicsBody!.collisionBitMask = 0
        hexagone_dblue.physicsBody?.collisionBitMask = ColliderType.hexagone_dblue_container
        hexagone_dblue.physicsBody?.contactTestBitMask = ColliderType.hexagone_dblue_container
        self.addChild(hexagone_dblue)
        
        hexagone_green = SKSpriteNode(imageNamed: "FIgure_Hexagone_Green")
        hexagone_green.name = "Container_Hexagone_Green"
        hexagone_green.zPosition = 6
        hexagone_green.size = CGSize(width: 30, height: 33)
        hexagone_green.position = CGPoint(x: self.frame.size.width / 1.210, y: self.frame.size.height / 3.8)
        hexagone_green.physicsBody = SKPhysicsBody(rectangleOf: dot.frame.size)
        hexagone_green.physicsBody?.affectedByGravity = false
        hexagone_green.physicsBody?.isDynamic = false
        hexagone_green.physicsBody?.categoryBitMask = ColliderType.hexagone_green
        hexagone_green.physicsBody!.collisionBitMask = 0
        hexagone_green.physicsBody?.collisionBitMask = ColliderType.hexagone_green_container
        hexagone_green.physicsBody?.contactTestBitMask = ColliderType.hexagone_green_container
        self.addChild(hexagone_green)
        
        hexagone_red = SKSpriteNode(imageNamed: "FIgure_Hexagone_Red")
        hexagone_red.name = "Container_Hexagone_Red"
        hexagone_red.zPosition = 6
        hexagone_red.size = CGSize(width: 30, height: 33)
        hexagone_red.position = CGPoint(x: self.frame.size.width / 1.140, y: self.frame.size.height / 7.0)
        hexagone_red.physicsBody = SKPhysicsBody(rectangleOf: dot.frame.size)
        hexagone_red.physicsBody?.affectedByGravity = false
        hexagone_red.physicsBody?.isDynamic = false
        hexagone_red.physicsBody?.categoryBitMask = ColliderType.hexagone_red
        hexagone_red.physicsBody!.collisionBitMask = 0
        hexagone_red.physicsBody?.collisionBitMask = ColliderType.hexagone_red_container
        hexagone_red.physicsBody?.contactTestBitMask = ColliderType.hexagone_red_container
        self.addChild(hexagone_red)
        
        hexagone_yellow = SKSpriteNode(imageNamed: "FIgure_Hexagone_Yellow")
        hexagone_yellow.name = "Container_Hexagone_Yellow"
        hexagone_yellow.zPosition = 6
        hexagone_yellow.size = CGSize(width: 30, height: 33)
        hexagone_yellow.position = CGPoint(x: self.frame.size.width / 1.140, y: self.frame.size.height / 5.5)
        hexagone_yellow.physicsBody = SKPhysicsBody(rectangleOf: dot.frame.size)
        hexagone_yellow.physicsBody?.affectedByGravity = false
        hexagone_yellow.physicsBody?.isDynamic = false
        hexagone_yellow.physicsBody?.categoryBitMask = ColliderType.hexagone_yellow
        hexagone_yellow.physicsBody!.collisionBitMask = 0
        hexagone_yellow.physicsBody?.collisionBitMask = ColliderType.hexagone_yellow_container
        hexagone_yellow.physicsBody?.contactTestBitMask = ColliderType.hexagone_yellow_container
        self.addChild(hexagone_yellow)
        
        
        // CIRCLES
        circle_blue.name = "Container_Circle_Blue"
        circle_blue.texture = SKTexture(imageNamed: "FIgure_Circle_Blue")
        circle_blue.zPosition = 6
        circle_blue.size = CGSize(width: 30, height: 33)
        circle_blue.position = CGPoint(x: self.frame.size.width / 1.110, y: self.frame.size.height / 2.8)
        //PhysicBody for the square 1
        
        circle_blue.physicsBody = SKPhysicsBody(rectangleOf: dot.frame.size)
        circle_blue.physicsBody?.affectedByGravity = false
        circle_blue.physicsBody?.isDynamic = false
        circle_blue.physicsBody?.categoryBitMask = ColliderType.circle_blue
        circle_blue.physicsBody!.collisionBitMask = 0
        circle_blue.physicsBody?.collisionBitMask = ColliderType.circle_blue_container
        circle_blue.physicsBody?.contactTestBitMask = ColliderType.circle_blue_container
        self.addChild(circle_blue)
        
        circle_dblue.name = "Container_Circle_DBlue"
        circle_dblue.texture = SKTexture(imageNamed: "FIgure_Circle_DBlue")
        circle_dblue.zPosition = 6
        //circle_dblue.anchorPoint.y = -0.7
        circle_dblue.size = CGSize(width: 30, height: 33)
        circle_dblue.position = CGPoint(x: self.frame.size.width / 1.080, y: self.frame.size.height / 3.5)
        //PhysicBody for the square 1
        
        circle_dblue.physicsBody = SKPhysicsBody(rectangleOf: dot.frame.size)
        circle_dblue.physicsBody?.affectedByGravity = false
        circle_dblue.physicsBody?.isDynamic = false
        circle_dblue.physicsBody?.categoryBitMask = ColliderType.circle_dblue
        circle_dblue.physicsBody!.collisionBitMask = 0
        circle_dblue.physicsBody?.collisionBitMask = ColliderType.circle_dblue_container
        circle_dblue.physicsBody?.contactTestBitMask = ColliderType.circle_dblue_container
        self.addChild(circle_dblue)
        
        circle_green.name = "Container_Circle_Green"
        circle_green.texture = SKTexture(imageNamed: "FIgure_Circle_Green")
        circle_green.zPosition = 6
        //circle_dblue.anchorPoint.y = -0.7
        circle_green.size = CGSize(width: 30, height: 33)
        circle_green.position = CGPoint(x: self.frame.size.width / 1.180, y: self.frame.size.height / 2.3)
        //PhysicBody for the square 1
        
        circle_green.physicsBody = SKPhysicsBody(rectangleOf: dot.frame.size)
        circle_green.physicsBody?.affectedByGravity = false
        circle_green.physicsBody?.isDynamic = false
        circle_green.physicsBody?.categoryBitMask = ColliderType.circle_green
        circle_green.physicsBody!.collisionBitMask = 0
        circle_green.physicsBody?.collisionBitMask = ColliderType.circle_green_container
        circle_green.physicsBody?.contactTestBitMask = ColliderType.circle_green_container
        self.addChild(circle_green)
        
        circle_red.name = "Container_Circle_Red"
        circle_red.texture = SKTexture(imageNamed: "FIgure_Circle_Red")
        circle_red.zPosition = 6
        //circle_dblue.anchorPoint.y = -0.7
        circle_red.size = CGSize(width: 30, height: 33)
        circle_red.position = CGPoint(x: self.frame.size.width / 1.140, y: self.frame.size.height / 7.2)
        //PhysicBody for the square 1
        
        circle_red.physicsBody = SKPhysicsBody(rectangleOf: dot.frame.size)
        circle_red.physicsBody?.affectedByGravity = false
        circle_red.physicsBody?.isDynamic = false
        circle_red.physicsBody?.categoryBitMask = ColliderType.circle_red
        circle_red.physicsBody!.collisionBitMask = 0
        circle_red.physicsBody?.collisionBitMask = ColliderType.circle_red_container
        circle_red.physicsBody?.contactTestBitMask = ColliderType.circle_red_container
        self.addChild(circle_red)
        
        circle_yellow.name = "Container_Circle_Yellow"
        circle_yellow.texture = SKTexture(imageNamed: "FIgure_Circle_Yellow")
        circle_yellow.zPosition = 6
        //circle_dblue.anchorPoint.y = -0.7
        circle_yellow.size = CGSize(width: 30, height: 33)
        circle_yellow.position = CGPoint(x: self.frame.size.width / 1.088, y: self.frame.size.height / 5.5)
        //PhysicBody for the square 1
        
        circle_yellow.physicsBody = SKPhysicsBody(rectangleOf: dot.frame.size)
        circle_yellow.physicsBody?.affectedByGravity = false
        circle_yellow.physicsBody?.isDynamic = false
        circle_yellow.physicsBody?.categoryBitMask = ColliderType.circle_yellow
        circle_yellow.physicsBody!.collisionBitMask = 0
        circle_yellow.physicsBody?.collisionBitMask = ColliderType.circle_yellow_container
        circle_yellow.physicsBody?.contactTestBitMask = ColliderType.circle_yellow_container
        self.addChild(circle_yellow)
        
        if deviceType == .iPad || deviceType == .iPad2 || deviceType == .iPadMini  || deviceType == .iPadMini   || UIDevice.current.userInterfaceIdiom == .phone {
            
            triangle_blue.size = CGSize(width:(triangle_blue.size.width)*(self.size.width/triangle_blue.size.width)/(11.42/0.54),  height: triangle_blue.size.height * (self.size.height/triangle_blue.size.height)/(6.42/0.6))
            
            triangle_dblue.size = triangle_blue.size
            triangle_green.size = triangle_blue.size
            triangle_red.size = triangle_blue.size
            triangle_yellow.size = triangle_blue.size
            
            circle_yellow.size = triangle_blue.size
            circle_blue.size = triangle_blue.size
            circle_dblue.size = triangle_blue.size
            circle_green.size = triangle_blue.size
            circle_red.size = triangle_blue.size
            
            star_blue.size = triangle_blue.size
            star_dblue.size = triangle_blue.size
            star_green.size = triangle_blue.size
            star_red.size = triangle_blue.size
            star_yellow.size = triangle_blue.size
            
             hexagone_blue.size = triangle_blue.size
            hexagone_dblue.size = triangle_blue.size
            hexagone_green.size = triangle_blue.size
            hexagone_red.size = triangle_blue.size
            hexagone_yellow.size = triangle_blue.size
            
            
            square_blue.size = CGSize(width:(triangle_blue.size.width)*(self.size.width/triangle_blue.size.width)/(11.42/0.55),  height: triangle_blue.size.height * (self.size.height/triangle_blue.size.height)/(6.42/0.55))
            square_dblue.size = square_blue.size
            square_green.size = square_blue.size
            square_red.size = square_blue.size
            square_yellow.size = square_blue.size
           
            
        }else{
            
            triangle_blue.size =  CGSize(width:(triangle_blue.size.width)*(self.size.width/triangle_blue.size.width)/(9/0.45),  height: triangle_blue.size.height * (self.size.height/triangle_blue.size.height)/(6.42/0.48))
            
            triangle_dblue.size = triangle_blue.size
            triangle_green.size = triangle_blue.size
            triangle_red.size = triangle_blue.size
            triangle_yellow.size = triangle_blue.size
            
            circle_yellow.size = triangle_blue.size
            circle_blue.size = triangle_blue.size
            circle_dblue.size = triangle_blue.size
            circle_green.size = triangle_blue.size
            circle_red.size = triangle_blue.size
            
            star_blue.size = triangle_blue.size
            star_dblue.size = triangle_blue.size
            star_green.size = triangle_blue.size
            star_red.size = triangle_blue.size
            star_yellow.size = triangle_blue.size
            
            hexagone_blue.size = triangle_blue.size
            hexagone_dblue.size = triangle_blue.size
            hexagone_green.size = triangle_blue.size
            hexagone_red.size = triangle_blue.size
            hexagone_yellow.size = triangle_blue.size
            
            
            square_blue.size = CGSize(width:(triangle_blue.size.width)*(self.size.width/triangle_blue.size.width)/(9/0.48),  height: triangle_blue.size.height * (self.size.height/triangle_blue.size.height)/(6.42/0.48))
            square_dblue.size = square_blue.size
            square_green.size = square_blue.size
            square_red.size = square_blue.size
            square_yellow.size = square_blue.size
        
        }
        
        arraySprites = [triangle_blue,triangle_dblue,triangle_green,triangle_red,triangle_yellow,
                        star_blue,star_dblue,star_green,star_red,star_yellow,square_blue,square_dblue,square_green,
                        square_red,square_yellow,hexagone_blue,hexagone_dblue,hexagone_green,hexagone_red,
                        hexagone_yellow,circle_blue,circle_dblue,circle_green,circle_red,circle_yellow]
        self.view?.isMultipleTouchEnabled = false;
        var arrayOne: [Int] = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]
        var arrayTwo: [Int] = []
        var upperLimit: UInt32 = 25
        var randomlyGeneratedNumber: Int = 0
        var indice = 0
        var numeroRandom: Int = 0
        
        for _ in 1...25{
            randomlyGeneratedNumber = Int(arc4random_uniform(upperLimit))
            arrayTwo.append(arrayOne[randomlyGeneratedNumber])
            arrayOne.remove(at: randomlyGeneratedNumber)
            upperLimit -= 1
            
        }
        
        
        for row in 0...4{
            
            for col in 0...4{
                numeroRandom = arrayTwo[indice]
               
                containerSprite.append(ContainerSprite.init(numContainer: numeroRandom, row: row ,col: col ,inThisScene: self))
                indice += 1
                
            }
        }
        for container in 0...24{
            self.addChild(containerSprite[container].block)
        }
        
       
    }
    
   
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        
        
        if contact.bodyA.node?.name == myRandomItem.name{
            firstBody = contact.bodyA
            secondBody = contact.bodyB
            print("FIRST BODY",firstBody.node?.name)
            print("SECOND BODY",secondBody.node?.name)
        }else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
            print("NO SE ARMO FIRST BODY",firstBody.node?.name)
            print("NO SE ARMO SECOND BODY",secondBody.node?.name)
        }
        
        
      
        
    }
    
    func Checar(){
        
        
        figure_name = myRandomItem.name
    
        
        if figure_name == firstBody.node?.name && secondBody.node?.name == figure_name {
            positionContainer = containerSprite.index(where: { $0.block.name == secondBody.node?.name })!
            stars = SKEmitterNode(fileNamed: "stars")
            stars.name = "ESTRELLITA"
            self.addChild(stars)
            stars.position = containerSprite[positionContainer].block.position
            stars.zPosition = 8
            
            
            self.run(SKAction.wait(forDuration: 2)) {
                self.stars.removeFromParent()
            }
            
            self.run(SKAction.playSoundFileNamed("pieceFit.wav", waitForCompletion: false))
            switch figure_name{
                
            case "Container_Circle_Blue":
                
                stars.particleTexture = SKTexture(imageNamed: "Circle_Blue1")
                containerSprite[positionContainer].block.texture = SKTexture(imageNamed:"Circle_Blue_Filled")
           
                circle_blue.isHidden = true
                circle_blue.physicsBody = nil
                
            case "Container_Circle_DBlue":
                stars.particleTexture = SKTexture(imageNamed: "Circle_Blue2")
                containerSprite[positionContainer].block.texture = SKTexture(imageNamed:"Circle_DBlue_Filled")
                circle_dblue.isHidden = true
                circle_dblue.physicsBody = nil
                
            case "Container_Circle_Green":
                stars.particleTexture = SKTexture(imageNamed: "Circle_Green")
                containerSprite[positionContainer].block.texture = SKTexture(imageNamed:"Circle_Green_Filled")
                circle_green.isHidden = true
                circle_green.physicsBody = nil
                
            case "Container_Circle_Red":
                
                stars.particleTexture = SKTexture(imageNamed: "Circle_Red")
                containerSprite[positionContainer].block.texture = SKTexture(imageNamed:"Circle_Red_Filled")
                circle_red.isHidden = true
                circle_red.physicsBody = nil
                
            case "Container_Circle_Yellow":
               
                stars.particleTexture = SKTexture(imageNamed: "Circle_Yellow")
                containerSprite[positionContainer].block.texture = SKTexture(imageNamed:"Circle_Yellow_Filled")
                circle_yellow.isHidden = true
                circle_yellow.physicsBody = nil
                
            case "Container_Square_Blue":
               
                 stars.particleTexture = SKTexture(imageNamed: "Square_Blue1")
                containerSprite[positionContainer].block.texture = SKTexture(imageNamed:"Square_Blue_Filled")
                square_blue.isHidden = true
                square_blue.physicsBody = nil
                
            case "Container_Square_DBlue":
               
                 stars.particleTexture = SKTexture(imageNamed: "Square_Blue2")
                containerSprite[positionContainer].block.texture =
                    SKTexture(imageNamed:"Square_DBlue_Filled")
                square_dblue.isHidden = true
                square_dblue.physicsBody = nil
                
            case "Container_Square_Green":
                
                 stars.particleTexture = SKTexture(imageNamed: "Square_Green")
                containerSprite[positionContainer].block.texture = SKTexture(imageNamed:"Square_Green_Filled")
                square_green.isHidden = true
                square_green.physicsBody = nil
                
            case "Container_Square_Red":
               
                 stars.particleTexture = SKTexture(imageNamed: "Square_Red")
                containerSprite[positionContainer].block.texture = SKTexture(imageNamed:"Square_Red_Filled")
                square_red.isHidden = true
                square_red.physicsBody = nil
                
            case "Container_Square_Yellow":
               
                 stars.particleTexture = SKTexture(imageNamed: "Square_Yellow")
                containerSprite[positionContainer].block.texture = SKTexture(imageNamed:"Square_Yellow_Filled")
                square_yellow.isHidden = true
                square_yellow.physicsBody = nil
                
            case "Container_Triangle_Blue":
               
                stars.particleTexture = SKTexture(imageNamed: "Triangle_Blue1")
                containerSprite[positionContainer].block.texture = SKTexture(imageNamed:"Triangle_Blue_Filled")
                triangle_blue.isHidden = true
                triangle_blue.physicsBody = nil
                
            case "Container_Triangle_DBlue":
             
                stars.particleTexture = SKTexture(imageNamed: "Triangle_Blue2")
                containerSprite[positionContainer].block.texture = SKTexture(imageNamed:"Triangle_DBlue_Filled")
                triangle_dblue.isHidden = true
                triangle_dblue.physicsBody = nil
                
            case "Container_Triangle_Green":
          
                stars.particleTexture = SKTexture(imageNamed: "Triangle_Green")
                containerSprite[positionContainer].block.texture = SKTexture(imageNamed:"Triangle_Green_Filled")
                triangle_green.isHidden = true
                triangle_green.physicsBody = nil
                
            case "Container_Triangle_Red":
         
                stars.particleTexture = SKTexture(imageNamed: "Triangle_Red")
                containerSprite[positionContainer].block.texture = SKTexture(imageNamed:"Triangle_Red_Filled")
                triangle_red.isHidden = true
                triangle_red.physicsBody = nil
                
            case "Container_Triangle_Yellow":
                
                stars.particleTexture = SKTexture(imageNamed: "Triangle_Yellow")
                containerSprite[positionContainer].block.texture = SKTexture(imageNamed:"Triangle_Yellow_Filled")
                triangle_yellow.isHidden = true
                triangle_yellow.physicsBody = nil
                
            case "Container_Hexagone_Blue":
              
                stars.particleTexture = SKTexture(imageNamed: "Hexa_Blue1")
                containerSprite[positionContainer].block.texture = SKTexture(imageNamed:"Hexagone_Blue_Filled")
                hexagone_blue.isHidden = true
                hexagone_blue.physicsBody = nil
                
            case "Container_Hexagone_DBlue":
                
                stars.particleTexture = SKTexture(imageNamed: "Hexa_Blue2")
                containerSprite[positionContainer].block.texture = SKTexture(imageNamed:"Hexagone_DBlue_Filled")
                hexagone_dblue.isHidden = true
                hexagone_dblue.physicsBody = nil
                
            case "Container_Hexagone_Green":
                
                stars.particleTexture = SKTexture(imageNamed: "Hexa_Green")
                containerSprite[positionContainer].block.texture = SKTexture(imageNamed:"Hexagone_Green_Filled")
                hexagone_green.isHidden = true
                hexagone_green.physicsBody = nil
                
            case "Container_Hexagone_Red":
               
                stars.particleTexture = SKTexture(imageNamed: "Hexa_Red")
                containerSprite[positionContainer].block.texture = SKTexture(imageNamed:"Hexagone_Red_Filled")
                hexagone_red.isHidden = true
                hexagone_red.physicsBody = nil
                
            case "Container_Hexagone_Yellow":
         
                stars.particleTexture = SKTexture(imageNamed: "Hexa_Yellow")
                containerSprite[positionContainer].block.texture = SKTexture(imageNamed:"Hexagone_Yellow_Filled")
                hexagone_yellow.isHidden = true
                hexagone_yellow.physicsBody = nil
                
            case "Container_Star_Blue":
              
                stars.particleTexture = SKTexture(imageNamed: "Star_Blue1")
                containerSprite[positionContainer].block.texture = SKTexture(imageNamed:"Star_Blue_Filled")
                star_blue.isHidden = true
                star_blue.physicsBody = nil
                
            case "Container_Star_DBlue":
              
                stars.particleTexture = SKTexture(imageNamed: "Star_Blue2")
                containerSprite[positionContainer].block.texture = SKTexture(imageNamed:"Star_DBlue_Filled")
                star_dblue.isHidden = true
                star_dblue.physicsBody = nil
                
            case "Container_Star_Green":
              
                stars.particleTexture = SKTexture(imageNamed: "Star_Green")
                containerSprite[positionContainer].block.texture = SKTexture(imageNamed:"Star_Green_Filled")
                star_green.isHidden = true
                star_green.physicsBody = nil
                
            case "Container_Star_Red":
            
                stars.particleTexture = SKTexture(imageNamed: "Star_Red")
                containerSprite[positionContainer].block.texture = SKTexture(imageNamed:"Star_Red_Filled")
                star_red.isHidden = true
                star_red.physicsBody = nil
                
            case "Container_Star_Yellow":
               
                stars.particleTexture = SKTexture(imageNamed: "Star_Yellow")
                containerSprite[positionContainer].block.texture = SKTexture(imageNamed:"Star_Yellow_Filled")
                star_yellow.isHidden = true
                star_yellow.physicsBody = nil
                
            default:
                return
            }
            arraySprites.remove(at: index)
        }else{
            
            if !clicked{
                
            }else{
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                self.run(SKAction.playSoundFileNamed("pieceDontFit.wav", waitForCompletion: false))
                switch figure_name{
                    
                case "Container_Circle_Blue":
                    circle_blue.position = CGPoint(x: self.frame.size.width / 1.110, y: self.frame.size.height / 2.8)
                    circle_blue.zPosition = 6
                    
                case "Container_Circle_DBlue":
                   circle_dblue.position = CGPoint(x: self.frame.size.width / 1.080, y: self.frame.size.height / 3.5)
                    circle_dblue.zPosition = 6
                    
                case "Container_Circle_Green":
                    circle_green.position = CGPoint(x: self.frame.size.width / 1.180, y: self.frame.size.height / 2.3)
                    circle_green.zPosition = 6
                    
                case "Container_Circle_Red":
                    circle_red.position = CGPoint(x: self.frame.size.width / 1.140, y: self.frame.size.height / 7.2)
                    circle_red.zPosition = 6
                    
                case "Container_Circle_Yellow":
                    circle_yellow.position = CGPoint(x: self.frame.size.width / 1.088, y: self.frame.size.height / 5.5)
                    circle_yellow.zPosition = 6
                    
                case "Container_Square_Blue":
                    square_blue.position = CGPoint(x: self.frame.size.width / 1.140, y: self.frame.size.height / 3.8)
                    square_blue.zPosition = 6
                    
                case "Container_Square_DBlue":
                     square_dblue.position = CGPoint(x: self.frame.size.width / 1.200, y: self.frame.size.height / 5.5)
                    square_dblue.zPosition = 6
                    
                case "Container_Square_Green":
                    square_green.position = CGPoint(x: self.frame.size.width / 1.090, y: self.frame.size.height / 2.5)
                    square_green.zPosition = 6
                    
                case "Container_Square_Red":
                    square_red.position = CGPoint(x: self.frame.size.width / 1.210, y: self.frame.size.height / 2.8)
                    square_red.zPosition = 6
                    
                case "Container_Square_Yellow":
                    square_yellow.position = CGPoint(x: self.frame.size.width / 1.140, y: self.frame.size.height / 3.5)
                    square_yellow.zPosition = 6
                    
                case "Container_Triangle_Blue":
                   triangle_blue.position = CGPoint(x: self.frame.size.width / 1.140, y: self.frame.size.height / 2.4)
                    triangle_blue.zPosition = 6
                    
                case "Container_Triangle_DBlue":
                    triangle_dblue.position = CGPoint(x: self.frame.size.width / 1.220, y: self.frame.size.height / 3.8)
                    triangle_dblue.zPosition = 6
                    
                case "Container_Triangle_Green":
                    triangle_green.position = CGPoint(x: self.frame.size.width / 1.100, y: self.frame.size.height / 7.0)
                    triangle_green.zPosition = 6
                    
                case "Container_Triangle_Red":
                    triangle_red.position = CGPoint(x: self.frame.size.width / 1.140, y: self.frame.size.height / 4.5)
                    triangle_red.zPosition = 6
                    
                case "Container_Triangle_Yellow":
                    
                    triangle_yellow.position = CGPoint(x: self.frame.size.width / 1.140, y: self.frame.size.height / 6.5)
                    triangle_yellow.zPosition = 6
                    
                case "Container_Hexagone_Blue":
                    hexagone_blue.position = CGPoint(x: self.frame.size.width / 1.140, y: self.frame.size.height / 3.8)
                    hexagone_blue.zPosition = 6
                    
                case "Container_Hexagone_DBlue":
                    hexagone_dblue.position = CGPoint(x: self.frame.size.width / 1.130, y: self.frame.size.height / 4.5)
                    hexagone_dblue.zPosition = 6
                    
                case "Container_Hexagone_Green":
                    hexagone_green.position = CGPoint(x: self.frame.size.width / 1.210, y: self.frame.size.height / 3.8)
                    hexagone_green.zPosition = 6
                    
                case "Container_Hexagone_Red":
                     hexagone_red.position = CGPoint(x: self.frame.size.width / 1.140, y: self.frame.size.height / 7.0)
                    hexagone_red.zPosition = 6
                    
                case "Container_Hexagone_Yellow":
                    hexagone_yellow.position = CGPoint(x: self.frame.size.width / 1.140, y: self.frame.size.height / 5.5)
                    hexagone_yellow.zPosition = 6
                    
                case "Container_Star_Blue":
                    star_blue.position = CGPoint(x: self.frame.size.width / 1.170, y: self.frame.size.height / 5.2)
                    star_blue.zPosition = 6
                    
                case "Container_Star_DBlue":
                    star_dblue.position = CGPoint(x: self.frame.size.width / 1.140, y: self.frame.size.height / 2.8)
                    star_dblue.zPosition = 6
                case "Container_Star_Green":
                    star_green.position = CGPoint(x: self.frame.size.width / 1.160, y: self.frame.size.height / 9.5)
                    star_green.zPosition = 6
                case "Container_Star_Red":
                    star_red.position = CGPoint(x: self.frame.size.width / 1.100, y: self.frame.size.height / 4.5)
                    star_red.zPosition = 6
                case "Container_Star_Yellow":
                    star_yellow.position = CGPoint(x: self.frame.size.width / 1.180, y: self.frame.size.height / 2.5)
                    star_yellow.zPosition = 6
                default:
                    return
                }
            }
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
      
        myRandomItem = arraySprites.chooseOne
        myRandomItem.zPosition = 9
        index = arraySprites.index(of: myRandomItem)!
        
       
        
        
        tickingSound().duration = 60
        
        
        for touch in touches {
            let location = touch.location(in: self)
            if timerNeedle.frame.contains(location) {
               
                if clicked == false {
                    startGame()
                }
                clicked = true
                timerBase.alpha = 1.0
                timerBase.removeAction(forKey: "blink")
                timerNeedle.alpha = 1.0
                timerNeedle.removeAction(forKey: "blink")
                isUserInteractionEnabled = true
                bgSoundPlayer!.play() //actually play
                start = true
            }
        }
      
            
        if start == true{
            for touch in touches {
                let location = touch.location(in: self)
                if bin.frame.contains(location) {
                   
                    
                    myRandomItem.frame.contains(location)
                    myRandomItem.position.x = location.x
                    myRandomItem.position.y = location.y
                    myRandomItem.isHidden = false
                    myRandomItem.run(tickingAnimation(), withKey: "wiggle")
                    isFingerOnRandomItem = true
                    let action = SKAction.moveBy(x: 0, y: 40, duration: 0.2)
                    myRandomItem.run(action, completion: {})
                }
                
                
            }
            
        
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    
        
        if isFingerOnRandomItem {
            let touch = touches.first
            let touchLocation = touch!.location(in: self)
            let previousLocation = touch!.previousLocation(in: self)
            
            var myRandomItemX = myRandomItem.position.x + (touchLocation.x - previousLocation.x)
            var myRandomItemY = myRandomItem.position.y + (touchLocation.y - previousLocation.y)
            
            myRandomItemX = max(myRandomItemX, myRandomItem.size.width/2)
            myRandomItemX = min(myRandomItemX, size.width - myRandomItem.size.width/2)
            
            myRandomItemY = max(myRandomItemY, myRandomItem.size.width/2)
            myRandomItemY = min(myRandomItemY, size.width - myRandomItem.size.width/2)
            
            myRandomItem.position = CGPoint(x: myRandomItemX, y: myRandomItemY)
        }
        
        
    }
    func tickingAnimation() -> SKAction{
        let duration = 0.2
        let fadeOut = SKAction.rotate(toAngle: 0.09, duration: duration)
        let fadeIn = SKAction.rotate(toAngle: -0.09, duration: duration)
        let blink = SKAction.sequence([fadeOut, fadeIn])
        
        return SKAction.repeatForever(blink)
    }
    
    
    func startGame(){
        Analytics.logEvent("NewGame", parameters: nil)
       
        let action = SKAction.rotate(byAngle: -6.3, duration: 90)
        
        timerNeedle.run(action, completion: {
             Analytics.logEvent("GameOver", parameters: nil)
            self.bgSoundPlayer!.stop()
           
            self.start = false
            
            let transition = SKTransition.fade(with: UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.0), duration: 4.2)
            
            

            let gameOver = SKScene(fileNamed: "GameOverScene") as! GameOverScene
            gameOver.scaleMode = SKSceneScaleMode.fill
            self.run(self.youLoseSound(),completion: {

                self.view!.presentScene(gameOver, transition: transition)
            })
            
        })
    }
    
    func tickingSound() -> SKAction {
        return SKAction.repeat(SKAction.playSoundFileNamed("timer.wav", waitForCompletion: false), count: 1)
    }
    func youLoseSound() -> SKAction {
        return SKAction.repeat(SKAction.playSoundFileNamed("lose.mp3", waitForCompletion: false), count: 1)
    }
    
    
    func youWinSound() -> SKAction {
        return SKAction.repeat(SKAction.playSoundFileNamed("kidsCheering.mp3", waitForCompletion: false), count: 1)
    }
    

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        Checar()
       
        if arraySprites.count == 0{
            self.bgSoundPlayer!.stop()
            binEmpty.isHidden = false
            let transition = SKTransition.fade(with: UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.0), duration: 4.0)
            
            let Winning = SKScene(fileNamed: "WinningScene") as! SKScene
            
            Winning.scaleMode = SKSceneScaleMode.fill
            self.run(self.youWinSound(),completion: {
                self.view!.presentScene(Winning, transition: transition)
            })
            
        }
    
        isFingerOnRandomItem = false
        
        myRandomItem.removeAction(forKey: "wiggle")
        
    }
    func blinkingAnimation() -> SKAction{
        let duration = 0.5
        let fadeOut = SKAction.fadeAlpha(to: 0.8, duration: duration)
        let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: duration)
        let blink = SKAction.sequence([fadeOut, fadeIn])
        flag=false
        return SKAction.repeat(blink, count: 4)
    }
    
    
}
    

