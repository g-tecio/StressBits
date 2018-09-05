//
//  Board.swift
//  StressBits
//
//  Created by Alejandro Solis on 8/28/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit

class ContainerSprite{
    let block : SKSpriteNode!
    let deviceType = UIDevice.current.deviceType
    
    var containers = ["Container_Circle_Blue","Container_Hexagone_Blue","Container_Square_Blue","Container_Star_Blue","Container_Triangle_Blue",
                      "Container_Circle_DBlue","Container_Hexagone_DBlue","Container_Square_DBlue","Container_Star_DBlue","Container_Triangle_DBlue",
                      "Container_Circle_Green","Container_Hexagone_Green","Container_Square_Green","Container_Star_Green","Container_Triangle_Green",
                      "Container_Circle_Red","Container_Hexagone_Red","Container_Square_Red","Container_Star_Red","Container_Triangle_Red",
                      "Container_Circle_Yellow","Container_Hexagone_Yellow","Container_Square_Yellow","Container_Star_Yellow","Container_Triangle_Yellow"]
    
    
    init (numContainer: Int, row: Int, col: Int , inThisScene: GameScene) {
        
        block = SKSpriteNode(imageNamed: containers[numContainer])
        
        let numberOfBlocks = 12.5
        let blockScale = 1
        
        // Resizing depending to screen size
        
        let blockOriginalSize = block.size
        
        let blockWidth = block.size.width / 3.8
        let totalBlocksWidth = blockWidth * CGFloat(numberOfBlocks)
   
         if deviceType == .iPad || deviceType == .iPad2 || deviceType == .iPadMini ||  UIDevice.current.userInterfaceIdiom == .phone  {
       
            block.size = CGSize(width:(block.size.width * (inThisScene.size.width / block.size.width ) * (9.49/100)) , height: ((block.size.width * (inThisScene.size.width / block.size.width ) * (9.49/100)) ))
            
            block.position = CGPoint(
                /// Offset value px from the border             Size between bricks             brick col
                x: ((inThisScene.size.width * 18.5/100) + (block.size.width * (112.5/100)) * CGFloat(col))
                /// Offset value px from the top     Size between bricks leaving room for row6      brick row
                ,y: (inThisScene.size.height * 84.75/100) - ((block.size.height * (103.125/100) ) * CGFloat(row)))
        }else{
        
            
            block.size = CGSize(width:(block.size.width * (inThisScene.size.width / block.size.width ) * (11.8/100)) , height: ((block.size.width * (inThisScene.size.width / block.size.width ) * (9.49/100)) ))
            
            block.position = CGPoint(
                /// Offset value px from the border             Size between bricks             brick col
                x: ((inThisScene.size.width * 13.2/100) + (block.size.width * (112.5/100)) * CGFloat(col))
                /// Offset value px from the top     Size between bricks leaving room for row6      brick row
                ,y: (inThisScene.size.height * 84.75/100) - ((block.size.height * (103.125/100) ) * CGFloat(row)))
            
        }
       
        
        

        

        
        block.physicsBody = SKPhysicsBody(rectangleOf: block.frame.size)
        block.physicsBody!.collisionBitMask = 0
        block.physicsBody?.affectedByGravity = false
        block.zPosition = 5
        block.physicsBody?.categoryBitMask = ColliderType.triangle_blue_container
        // block.physicsBody?.categoryBitMask = ColliderType.hexagone_green_container
        block.name = containers[numContainer]
        block.setScale(CGFloat (blockScale))
        
    }
}
