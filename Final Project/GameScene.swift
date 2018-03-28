//
//  GameScene.swift
//  Final Project
//
//  Created by Josh Fairbanks  on 2018-03-21.
//  Copyright © 2018 Josh Fairbanks . All rights reserved.
//





import SpriteKit
import GameplayKit

class GameScene: SKScene {
  
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var SHAPE_SIZE = 70
    let PADDING = 20
    var PADDING_TOP = -600
  
  
    var displayWidth: Double = 0.0
    var displayHeight: Double = 0.0
    
    override func sceneDidLoad() {
      
        let displaySize: CGRect = UIScreen.main.bounds
        displayWidth = Double(displaySize.width)
        displayHeight = Double(displaySize.height)
        self.lastUpdateTime = 0
      
      
      
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
      
      drawGameRound(level: 9)
      
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
     
      print("x: \(pos.x) y: \(pos.y)")
    }
    
    func touchMoved(toPoint pos : CGPoint) {
     
    }
    
    func touchUp(atPoint pos : CGPoint) {
      
    }
  
  func makeCircleInPosition(location: CGPoint){
    
    let Circle = SKShapeNode(circleOfRadius: CGFloat(SHAPE_SIZE) ) // Size of Circle = Radius setting.
    Circle.position = location
    Circle.name = "defaultCircle"
    Circle.strokeColor = SKColor.green
    Circle.glowWidth = 4.0
    Circle.fillColor = SKColor.orange
    self.addChild(Circle)
    

    let length: CGFloat = CGFloat(50)
    

    var points = [CGPoint(x:length, y:-length / 2.0),
                  CGPoint(x:-length, y:-length / 2.0),
                  CGPoint(x: 0.0, y: length),
                  CGPoint(x:length, y:-length / 2.0)]
    

    let Triangle = SKShapeNode(points: &points, count: points.count)

    Triangle.fillColor = UIColor.yellow

    Triangle.position = location

    self.addChild(Triangle)
    
    var custom_points = [location,
                         CGPoint(x: Int(location.x) + randInt(l:-50,u:50), y: Int(location.y) + randInt(l:-50,u:50)),
                         CGPoint(x: Int(location.x) + randInt(l:-50,u:50), y: Int(location.y) + randInt(l:-50,u:50)),
                         CGPoint(x: Int(location.x) + randInt(l:-50,u:50), y: Int(location.y) + randInt(l:-50,u:50)),
                         location]
  
    let splineShapeNode = SKShapeNode(splinePoints: &custom_points,
                                      count: custom_points.count)
    
    splineShapeNode.fillColor = UIColor.black
    
    self.addChild(splineShapeNode)
    
    
  }
  
  func randInt(l: Int,u: Int) -> Int {
    //10, 30
    return GKRandomSource.sharedRandom().nextInt(upperBound: u-l) + l
  }
  
  func drawGameRound(level: Int){
    
    
    var rows = 0;
    var columns = 0;
    
    if level <= 3 {
      rows = 3
      columns = 3
      PADDING_TOP = -200
    } else if level <= 6 {
      rows = 5
      columns = 3
      PADDING_TOP = -300
    }else if level <= 9 {
      rows = 5
      columns = 4
      PADDING_TOP = -400
    }else if level >= 10 {
      rows = 6
      columns = 4
      PADDING_TOP = -600
    }

    var ySpace = -280
    var drawIndex:Int = -300
     for col in 1...columns {
      
      for row in 1...4{
     
      
        
        let xSpace = drawIndex
        
        print("Row: \(row) y: \(ySpace) x: \(xSpace)")
        makeCircleInPosition(location: CGPoint(x: xSpace, y: (ySpace)))
        drawIndex += 200
        
        
      }
      ySpace += 200
      drawIndex = -300;
    }

    
  }
  /*
  func convert(point: CGPoint)->CGPoint {
    return self.view!.convert(CGPoint(x: point.x, y:self.view!.frame.height-point.y), to:self)
  }*/
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       /* if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }*/
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
