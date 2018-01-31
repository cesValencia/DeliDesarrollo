//
//  MetaSpin.swift
//  Deli
//
//  Created by David Valencia on 29/08/17.
//  Copyright © 2017 Magnetink. All rights reserved.
//

import UIKit
import GLKit

class MetaSpin: UIView {
    
    var centralBallRadius: CGFloat = 50 {
        didSet {
            centralBall.radius = centralBallRadius
            cruiseRadius = (centralBallRadius + sideBallRadius) / 2 * 2
        }
    }
    var sideBallRadius: CGFloat = 10 {
        didSet {
            self.sideBall.radius = sideBallRadius
            cruiseRadius = (centralBallRadius + sideBallRadius) / 2 * 2
        }
    }
    var cruiseRadius: CGFloat = 50
    var ballFillColor: UIColor = UIColor.white {
        didSet {
            self.metaField.ballFillColor = ballFillColor
        }
    }
    
    // The following two variables will toggle the speed and the efficiency of the ball.
    var speed: CGFloat = 0.02
    
    fileprivate var centralBall: MetaBall!
    fileprivate var sideBall: MetaBall!
    fileprivate var metaField: MetaField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set backgrounds
        backgroundColor = UIColor.clear
        
        metaField = MetaField(frame: frame)
        metaField.backgroundColor = UIColor.clear
        
        addCentralBall()
        addSideBall()
        
        addSubview(metaField)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func addCentralBall() {
        centralBall = MetaBall(center: center, radius: centralBallRadius)
        
        metaField.addMetaBall(centralBall)
    }
    
    fileprivate func addSideBall() {
        sideBall = MetaBall(center: CGPoint(x: center.x, y: center.y), radius: sideBallRadius)
        
        metaField.addMetaBall(sideBall)
    }
    
    func animateSideBall() {
        //        let animationCenter = CGPoint(x: CGFloat(centralBall.center.x), y: CGFloat(centralBall.center.y) - centralBall.radius)
        //
        //        let animationPath = UIBezierPath(arcCenter: animationCenter, radius: centralBall.radius, startAngle: CGFloat(3 * M_PI_2), endAngle: CGFloat(7 * M_PI_2), clockwise: true)
        //
        //        let pathAnimation = CAKeyframeAnimation(keyPath: "position")
        //        pathAnimation.path = animationPath.CGPath
        //        pathAnimation.calculationMode = kCAAnimationPaced
        //        pathAnimation.fillMode = kCAFillModeForwards
        //        pathAnimation.removedOnCompletion = false
        //        pathAnimation.repeatCount = HUGE
        //        pathAnimation.duration = 1.0
        //        pathAnimation.delegate = self
        //
        
        let displayLink = CADisplayLink(target: self, selector: #selector(MetaSpin.moveSideBall))
        
        displayLink.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    
    var currentAngle = CGFloat(0)
    var maxAngle = CGFloat(2.0 * Double.pi)
    var flip = false
    
    fileprivate var pathPool: [Float: CGPath] = [:]
    
    @objc func moveSideBall() {
        nextAngle()
        
        let adjustedAngle = toEaseIn(toEaseIn(currentAngle))
        
        sideBall.center = newCenter(adjustedAngle, relatedToCenter: centralBall.center)
        
        let centerIndex = sideBall.center.x * sideBall.center.y
        
        // We'll store the path and reuse it.
        if pathPool[centerIndex] == nil {
            pathPool[centerIndex] = metaField.pathForCurrentConfiguration()
        }
        
        metaField.currentPath = pathPool[centerIndex]
        
        metaField.setNeedsDisplay()
    }
    
    func newCenter(_ angle: CGFloat, relatedToCenter center: GLKVector2) -> GLKVector2 {
        let x = center.x + Float(cruiseRadius) * Float(flip ? -sin(angle) : sin(angle))
//        let y = center.y + Float(flip ? cruiseRadius : -cruiseRadius) + Float(cruiseRadius) * Float(flip ? -cos(angle) : cos(angle))
        
        let one = Float(flip ? cruiseRadius : -cruiseRadius)
        let two = Float(flip ? -cos(angle) : cos(angle))
        let three = Float(cruiseRadius) * two
        let y = center.y + one + three
        
        
        return GLKVector2Make(x, y)
    }
    
    fileprivate func nextAngle() {
        if currentAngle >= maxAngle {
            currentAngle = 0
            flip = !flip
        } else {
            currentAngle += CGFloat(maxAngle * speed)
        }
        
    }
    
    fileprivate func toEaseIn(_ angle: CGFloat) -> CGFloat {
        let ratio = angle / CGFloat(2 * Double.pi)
        var processed_ratio: CGFloat = ratio
        if ratio < 0.5 {
            processed_ratio =  (1 - pow(1 - ratio, 3.0)) * 8 / 14
        } else {
            processed_ratio = 1 - (1 - pow(ratio, 3.0)) * 8 / 14
        }
        
        return processed_ratio * CGFloat(2 * Double.pi)
    }
}
