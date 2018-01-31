//
//  MetaField.swift
//  Deli
//
//  Created by David Valencia on 29/08/17.
//  Copyright © 2017 Magnetink. All rights reserved.
//

import UIKit
import GLKit

private let rungKutaStep: Float = 1.0

class MetaField: UIView {
    
    let fieldThreshold: CGFloat = 0.04
    
    var ballFillColor: UIColor = UIColor.black {
        didSet {
            pathLayer.fillColor = ballFillColor.cgColor
        }
    }
    
    fileprivate var unitThreshold: CGFloat = 0
    
    var currentPath: CGPath? {
        didSet {
            pathLayer.path = currentPath
        }
    }
    
    fileprivate var pathLayer = CAShapeLayer()
    
    fileprivate var minSizeBall: CGFloat = 1000 {
        didSet {
            unitThreshold = fieldThreshold / minSizeBall
        }
    }
    
    fileprivate(set) var metaBalls: [MetaBall] = []
    
    override init(frame: CGRect) {
        let rect = CGRect(x: frame.minX, y: frame.minY, width: CGFloat(Int(frame.width)), height: CGFloat(Int(frame.height)))
        
        super.init(frame: rect)
        
        pathLayer.fillColor = ballFillColor.cgColor
        pathLayer.frame = bounds
        layer.addSublayer(pathLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addMetaBallAt(_ position: CGPoint, radius: CGFloat) {
        let newBall = MetaBall(center: position, radius: radius)
        addMetaBall(newBall)
    }
    
    func addMetaBall(_ metaBall: MetaBall) {
        metaBalls.append(metaBall)
        updateMinSize()
        setNeedsDisplay()
    }
    
    fileprivate func updateMinSize() {
        minSizeBall = 100000
        for metaBall in metaBalls {
            if metaBall.mess < minSizeBall {
                minSizeBall = metaBall.mess
            }
        }
    }
    
    func pathForCurrentConfiguration() -> CGPath? {
        
        let path = CGMutablePath()
        
        for metaBall in metaBalls {
            metaBall.trackingPosition = trackTheBorder(GLKVector2Add(metaBall.center, GLKVector2Make(0, 1)))
            metaBall.borderPosition = metaBall.trackingPosition
            
            metaBall.tracking = true
        }
        
        for metaBall in metaBalls {
            
            path.move(to: CGPoint(x: CGFloat(metaBall.borderPosition.x), y: CGFloat(metaBall.borderPosition.y)))
            
            for i in 0..<1000 {
                
                if !metaBall.tracking {
                    break
                }
                
                // Store the old tracking position
                // Walk along the tangent
                metaBall.trackingPosition = rungeKutta2(metaBall.trackingPosition, h: rungKutaStep, targetFunction: {
                    let tenant = self.tangentAt($0)
                    return tenant
                })
                
                // Correction step towards the border
                (metaBall.trackingPosition, _) = stepOnceTowardsBorder(metaBall.trackingPosition)
                
                path.addLine(to: CGPoint(x: CGFloat(metaBall.trackingPosition.x), y: CGFloat(metaBall.trackingPosition.y)))
                
                // Check if we've gone a full circle or hit some other edge tracker
                for otherBall in metaBalls {
                    if (otherBall !== metaBall || i > 3) && GLKVector2Distance(otherBall.borderPosition, metaBall.trackingPosition) < rungKutaStep {
                        // CGPathCloseSubpath(metaBall.borderPath)
                        if otherBall !== metaBall {
                            path.addLine(to: CGPoint(x: CGFloat(otherBall.borderPosition.x), y: CGFloat(otherBall.borderPosition.y)))
                        } else {
                            path.closeSubpath()
                        }
                        
                        metaBall.tracking = false
                    }
                }
            }
        }
        
        return path
    }
    
    private func trackTheBorder(_ position: GLKVector2) -> GLKVector2 {
        var position = position
        // Track the border of the metaball and return new coordinates
        var currentForce: CGFloat = 1000000
        
        while currentForce > fieldThreshold {
            (position, currentForce) = stepOnceTowardsBorder(position)
            
            if !bounds.contains(CGPoint(x: CGFloat(position.x), y: CGFloat(position.y))) {
                continue
            }
        }
        
        return position
    }
    
    fileprivate func stepOnceTowardsBorder(_ position: GLKVector2) -> (GLKVector2, CGFloat) {
        // Step once towards the border of the metaball field, return the new coordinates and force at old coordinates.
        let force = forceAt(position)
        let np = normalAt(position)
        
        let stepSize = pow(minSizeBall / fieldThreshold, 1 / DistanceConstant) -
            pow(minSizeBall / force, 1 / DistanceConstant) + 0.01
        return (GLKVector2Add(position, GLKVector2MultiplyScalar(np, Float(stepSize))), force)
    }
    
    fileprivate func tangentAt(_ position: GLKVector2) -> GLKVector2 {
        // Normalized (length = 1) tangent at position
        let np = normalAt(position)
        
        return GLKVector2Make(-np.y, np.x)
    }
    
    fileprivate func normalAt(_ position: GLKVector2) -> GLKVector2 {
        // Normalized (length = 1) normal at position
        
        var totalNormal = GLKVector2Make(0, 0)
        
        // Loop through the meta balls
        for metaBall in metaBalls {
            let div = pow(GLKVector2Distance(metaBall.center, position), Float(2 + DistanceConstant))
            let addition = GLKVector2MultiplyScalar(GLKVector2Subtract(metaBall.center, position),
                                                    Float(-DistanceConstant * metaBall.mess) / div)
            totalNormal = GLKVector2Add(totalNormal, addition)
        }
        
        return GLKVector2Normalize(totalNormal)
    }
    
    fileprivate func forceAt(_ position: GLKVector2) -> CGFloat {
        var totalForce: CGFloat = 0
        
        // Loop through the meta balls and calculate the total force
        for metaBall in metaBalls {
            totalForce += metaBall.forceAt(position)
        }
        
        return totalForce
    }
    
    fileprivate func rungeKutta2(_ position: GLKVector2, h: Float, targetFunction: (GLKVector2) -> GLKVector2) -> GLKVector2 {
        let oneTime = GLKVector2MultiplyScalar(targetFunction(position), h / 2)
        let nextInput = GLKVector2Add(position, oneTime)
        let twoTime = GLKVector2MultiplyScalar(targetFunction(nextInput), h)
        
        return GLKVector2Add(position, twoTime)
    }
}

