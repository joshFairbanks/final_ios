//
//  GameScene.swift
//  Final Project
//
//  Created by Josh Fairbanks  on 2018-03-21.
//  Copyright © 2018 Josh Fairbanks . All rights reserved.
//





import SpriteKit
import GameplayKit

enum Shape{
    case TRIANGLE
    case SQUARE
    case CIRCLE
    case STAR
    case RECTANGLE
    case NIL
}

class GameScene: SKScene {
  
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var correctShape: ShapeObj
    var SHAPE_SIZE = 70
    let PADDING = 20
    var PADDING_TOP = -600
    var correctShapeIndex = 0
  
  
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
      
      drawGameRound(level: 11)
      
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
     
      print("x: \(pos.x) y: \(pos.y)")
    }
    
    func touchMoved(toPoint pos : CGPoint) {
     
    }
    
    func touchUp(atPoint pos : CGPoint) {
      
    }
  
    func makeShapeInPosition(location: CGPoint, size: Int, correct: Bool){
        
     
        for i in 1...correctShape.shapeCount {
            var isOuter = true
            var currentShape = correctShape.outerShape
            var currentSize = SHAPE_SIZE
            var currentColor = correctShape.outerShapeFill
            if(i > 1){
                isOuter = false
                currentShape = correctShape.innerShape
                currentSize -= 20
            }
            switch(currentShape){
            case .CIRCLE:
                makeCircleInPosition(circleLocation: location, circleSize: currentSize, fill: <#T##UIColor#>, stroke: <#T##UIColor#>)
            default:
                print("makeShapeInPosition out of bounds")
                
            }
        }
    
    
    
    
        
    let length: CGFloat = CGFloat(size-20)
    

    var points = [CGPoint(x:length, y:-length / 2.0),
                  CGPoint(x:-length, y:-length / 2.0),
                  CGPoint(x: 0.0, y: length),
                  CGPoint(x:length, y:-length / 2.0)]
    

    let Triangle = SKShapeNode(points: &points, count: points.count)

    Triangle.fillColor = UIColor.yellow

    Triangle.position = location

    self.addChild(Triangle)
        
        if(correct){
            print("correct")
        }
    
    
    
  }
    
    
    
    
    func makeCircleInPosition(circleLocation: CGPoint, circleSize: Int, fill: UIColor, stroke: UIColor){
        let Circle = SKShapeNode(circleOfRadius: CGFloat(circleSize) ) // Size of Circle = Radius setting.
        Circle.position = circleLocation
        Circle.name = "defaultCircle"
        Circle.strokeColor = SKColor.green
        Circle.glowWidth = 4.0
        Circle.fillColor = SKColor.orange
        self.addChild(Circle)
    }
    
    func getRandomShape() -> Shape {
        var rShape:Shape
        switch (randInt(l: 1, u: 2)){
        case 1:
            rShape = Shape.CIRCLE
        case 2:
            rShape = Shape.TRIANGLE
        default:
            print("random shape index was out of bounds!")
        }
        return rShape
    }
    
    func getRandomColor() -> UIColor {
        var color: UIColor
        switch (randInt(l: 1, u: 15)){
        case 1:
            color = UIColor.black
        case 2:
            color = UIColor.blue
        case 3:
            color = UIColor.brown
        case 4:
            color = UIColor.clear
        case 5:
            color = UIColor.cyan
        case 6:
            color = UIColor.darkGray
        case 7:
            color = UIColor.gray
        case 8:
            color = UIColor.green
        case 9:
            color = UIColor.lightGray
        case 10:
            color = UIColor.magenta
        case 11:
            color = UIColor.orange
        case 12:
            color = UIColor.purple
        case 13:
            color = UIColor.red
        case 14:
            color = UIColor.white
        case 15:
            color = UIColor.yellow
        default:
            print("color index out of bounds!")
        }
        return color
    }
  
  func randInt(l: Int,u: Int) -> Int {
    //10, 30
    return GKRandomSource.sharedRandom().nextInt(upperBound: u-l) + l
  }
  
  func drawGameRound(level: Int){
    var rShapeCount = randInt(l: 1, u: 2)
   
    
    correctShape = ShapeObj(shapeCount: rShapeCount, outerShape: getRandomShape(), innerShape: getRandomShape(), innerShapeFill: getRandomColor(), innerShapeStroke: getRandomColor(), outerShapeFill: getRandomColor(), outerShapeStroke: getRandomColor() )
    
    var ySpace = 0;
    let rows = 4;
    var columns = 0;
    
    if level <= 3 {
      columns = 3
      ySpace = -300
    } else if level <= 6 {
      columns = 4
      ySpace = -300
    }else if level <= 9 {
      columns = 5
      ySpace = -560
    }else if level >= 10 {
      columns = 5
      ySpace = -560
    }

    correctShapeIndex = randInt(l: 0, u: columns * rows)
    var counter = 0
    
    var drawIndex:Int = -300
     for col in 1...columns {
      
      for row in 1...4{
        
      
        if(counter == correctShapeIndex){
            makeShapeInPosition(location: CGPoint(x: 240, y: 420), size: SHAPE_SIZE, correct:true)
        }else{
        let xSpace = drawIndex
        
        print("Row: \(row) y: \(ySpace) x: \(xSpace)")
            makeShapeInPosition(location: CGPoint(x: xSpace, y: (ySpace)), size: SHAPE_SIZE, correct:false)
        }
        drawIndex += 200
        
        counter+=1
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
