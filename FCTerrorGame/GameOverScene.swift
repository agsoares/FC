//
//  GameOverScene.swift
//  MadnessDaze
//
//  Created by Adriano Soares on 03/09/15.
//  Copyright (c) 2015 Paulo Ricardo Ramos da Rosa. All rights reserved.
//

import SpriteKit



class GameOverScene: SKScene {
    var manager = GameManager.sharedInstance;
    var state = GameState.sharedInstance;
    
    var background = SKSpriteNode()
    var tryAgain = SKSpriteNode()
    var backToMenu = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        manager.enemiesCreated = false;
        //var tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("retry"))
        //self.view?.addGestureRecognizer(tapRecognizer);
        
        
        //self.runAction(SKAction.playSoundFileNamed("scream2.mp3", waitForCompletion: false))
        
        
        self.background = SKSpriteNode(imageNamed: "gameOver")
        self.background.position = CGPoint(x: frame.midX, y: frame.midY)
        self.background.xScale -= 0.5
        self.background.yScale -= 0.65
        
        addChild(background)
        
        self.tryAgain = SKSpriteNode(imageNamed: "restart")
        self.tryAgain.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        self.tryAgain.name = "tryAgain"
        addChild(tryAgain)
        
        self.backToMenu = SKSpriteNode(imageNamed: "exit")
        self.backToMenu.position = CGPoint(x: self.tryAgain.position.x, y: self.tryAgain.position.y/2.5)
        self.backToMenu.name = "backToMenu"
        addChild(backToMenu)
        
    }
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches
        let location = touch.first!.locationInNode(self)
        let node = self.nodeAtPoint(location)
        
        if (node.name == "restart"){
            print("restart")
            self.retry()
        }else if (node.name == "exit"){
            print("exit")
            self.mainMenu()
        }
    }
    



    func mainMenu () {
        
    }
    
    func retry () {
        let transition = SKTransition.fadeWithDuration(0)
        self.state.room = 0
        self.manager.playerPosition = 0
        self.state.rotation = 1
        
        let scene = GameScene(size: self.size)
        
        if let recognizers = self.view?.gestureRecognizers {
            for recognizer in recognizers {
                self.view?.removeGestureRecognizer(recognizer )
            }
        }
        
        self.view?.presentScene(scene, transition: transition)
    
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
