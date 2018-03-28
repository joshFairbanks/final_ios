//
//  ShapeObj.swift
//  Final Project
//
//  Created by Student on 2018-03-28.
//  Copyright © 2018 Josh Fairbanks . All rights reserved.
//

import Foundation
import GameplayKit

class ShapeObj:NSObject {
    var shapeCount:Int;
    var outerShape: Shape
    var innerShape: Shape
    var innerShapeFill: UIColor
    var innerShapeStroke: UIColor
    var outerShapeFill: UIColor
    var outerShapeStroke: UIColor
    
    init(shapeCount: Int, outerShape:Shape, innerShape: Shape, innerShapeFill: UIColor, innerShapeStroke: UIColor, outerShapeFill: UIColor, outerShapeStroke: UIColor){
        self.shapeCount = shapeCount
        self.innerShapeFill = innerShapeFill
        self.innerShapeStroke = innerShapeStroke
        self.outerShapeFill = outerShapeFill
        self.outerShapeStroke = outerShapeStroke
        self.innerShape = innerShape
        self.outerShape = outerShape
    }
}
