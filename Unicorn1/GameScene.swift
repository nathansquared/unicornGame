//
//  GameScene.swift
//  Unicorn1
//
//  Created by Nathan Wong on 5/9/16.
//  Copyright (c) 2016 Nathan Wong. All rights reserved.
//

import SpriteKit
import CoreMotion


struct PhysicsCategory {
    
    static let Unicorn : UInt32 = 0x1 << 1
    static let Ground : UInt32 = 0x1 << 2
    static let Cloud : UInt32 = 0x1 << 3
    
}


class GameScene: SKScene {
    
    //Adding CoreMotion
    let manger = CMMotionManager()
    
    
    var Ground = SKSpriteNode()
    var Unicorn = SKSpriteNode()
    var tapLocation = CGPoint(x: 0, y: 0)
    
    override func didMoveToView(view: SKView) {
     
        //Starting accelerometer
        manger.startAccelerometerUpdates()
        manger.accelerometerUpdateInterval = 0.1
        manger.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()) {
            (data, error) in
            
        }
        
        
        Ground = SKSpriteNode(imageNamed: "ground")
        Ground.setScale(0.5)
        Ground.position = CGPoint(x: self.frame.width / 2, y: 0 + Ground.frame.height / 4.5)
        self.addChild(Ground)
        
        Ground.physicsBody = SKPhysicsBody(rectangleOfSize: Ground.size)
        Ground.physicsBody?.categoryBitMask = PhysicsCategory.Ground
        Ground.physicsBody?.collisionBitMask = PhysicsCategory.Unicorn
        Ground.physicsBody?.contactTestBitMask = PhysicsCategory.Unicorn
        Ground.physicsBody?.affectedByGravity = false
        Ground.physicsBody?.dynamic = false
        Ground.zPosition = 3
        
        Unicorn = SKSpriteNode(imageNamed: "Unicorn1")
        Unicorn.size = CGSize(width: 90, height: 105)
        Unicorn.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        self.addChild(Unicorn)
        
        Unicorn.physicsBody = SKPhysicsBody(circleOfRadius: Unicorn.frame.height / 2)
        Unicorn.physicsBody?.categoryBitMask = PhysicsCategory.Unicorn
        Unicorn.physicsBody?.collisionBitMask = PhysicsCategory.Ground | PhysicsCategory.Cloud
        Unicorn.physicsBody?.contactTestBitMask = PhysicsCategory.Ground | PhysicsCategory.Cloud
        Unicorn.physicsBody?.allowsRotation = false
        Unicorn.physicsBody?.affectedByGravity = true
        Unicorn.physicsBody?.dynamic = true
        Unicorn.zPosition = 2
        
        createClouds()
        
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        let touch : UITouch = touches.first! as UITouch
        tapLocation = touch.locationInView(self.view)
        
        Unicorn.physicsBody?.velocity = CGVectorMake(0, 0)
        Unicorn.physicsBody?.applyImpulse(CGVectorMake((tapLocation.x - self.frame.width/5)/12, 150))
        
        
    
    }
    
 
    
    func createClouds() {
        
        let cloudPair = SKNode()
        
        let leftCloud = SKSpriteNode(imageNamed: "CloudLeft")
        let rightCloud = SKSpriteNode(imageNamed: "CloudRight")
        
        leftCloud.position = CGPoint(x: self.frame.width / 2 - 150, y: self.frame.height / 2 - 50)
        rightCloud.position = CGPoint(x: self.frame.width / 2 + 150, y: self.frame.height / 2 + 50)
        
        leftCloud.setScale(0.07)
        rightCloud.setScale(0.07)
        
        leftCloud.physicsBody = SKPhysicsBody(rectangleOfSize: rightCloud.size)
        leftCloud.physicsBody?.categoryBitMask = PhysicsCategory.Cloud
        leftCloud.physicsBody?.collisionBitMask = PhysicsCategory.Unicorn
        leftCloud.physicsBody?.contactTestBitMask = PhysicsCategory.Unicorn
        leftCloud.physicsBody?.dynamic = false
        leftCloud.physicsBody?.affectedByGravity = false
        
        rightCloud.physicsBody = SKPhysicsBody(rectangleOfSize: leftCloud.size)
        rightCloud.physicsBody?.categoryBitMask = PhysicsCategory.Cloud
        rightCloud.physicsBody?.collisionBitMask = PhysicsCategory.Unicorn
        rightCloud.physicsBody?.contactTestBitMask = PhysicsCategory.Unicorn
        rightCloud.physicsBody?.dynamic = false
        rightCloud.physicsBody?.affectedByGravity = false
        
        
        cloudPair.addChild(leftCloud)
        cloudPair.addChild(rightCloud)
        
        cloudPair.zPosition = 1
        
        self.addChild(cloudPair)
        
    }
    
    

    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
