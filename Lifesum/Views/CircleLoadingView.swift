//
//  CircleLoadingView.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/29/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

import UIKit

class CircleLoadingView: UIView {
    private let progressLayer: CAShapeLayer = CAShapeLayer()
    private var progressLabel: UILabel
    var percentage: Int = 0 {
        didSet(newValue) {
            createProgressLayer()
            createLabel()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        progressLabel = UILabel()
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        progressLabel = UILabel()
        super.init(frame: frame)
        createProgressLayer()
        createLabel()
    }
    
    func createLabel() {
        progressLabel = UILabel(frame: CGRectMake(0.0, 0.0, CGRectGetWidth(frame), 60.0))
        progressLabel.textColor = .blackColor()
        progressLabel.textAlignment = .Center
        progressLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 14.0)
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressLabel)
        
        addConstraint(NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: progressLabel, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal, toItem: progressLabel, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
    }
    
    //setup the circle layer using UIBezierPath and adding it as a sublayer to this view's layer
    private func createProgressLayer() {
        let startAngle = CGFloat(M_PI_2)
        let percentageFinal = Double(percentage)/100.0
        let endAngle = CGFloat((M_PI * 2) * percentageFinal + M_PI_2)
        let centerPoint = CGPointMake(CGRectGetWidth(frame)/2 , CGRectGetHeight(frame)/2)
        let radius = CGRectGetWidth(frame)/2 - 30.0
        
        backGroundCircle(centerPoint, radius: radius, startAngle: startAngle)
        
        let gradientMaskLayer = gradientMask()
        progressLayer.path = UIBezierPath(arcCenter:centerPoint, radius: radius, startAngle:startAngle, endAngle:endAngle, clockwise: true).CGPath
        progressLayer.backgroundColor = UIColor.clearColor().CGColor
        progressLayer.fillColor = nil
        progressLayer.strokeColor = UIColor.blackColor().CGColor
        progressLayer.lineWidth = 4.0
        progressLayer.strokeStart = 0.0
        progressLayer.strokeEnd = 0.0
        
        gradientMaskLayer.mask = progressLayer
        layer.addSublayer(gradientMaskLayer)
    }
    
    //creating the backgorund (gray) circle layer
    private func backGroundCircle(arcCenter: CGPoint, radius: CGFloat, startAngle: CGFloat) {
        let circlePath = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle:CGFloat(M_PI * 2 + M_PI_2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.CGPath
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = UIColor.grayColor().CGColor
        shapeLayer.lineWidth = 4.0
        
        layer.addSublayer(shapeLayer)
    }
    
    //creating the gragient layer that will have the main circle layer as a mask
    private func gradientMask() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        gradientLayer.locations = [0.0, 1.0]
        
        let colorTop: AnyObject = UIColor(red: 73.0/255.0, green: 204.0/255.0, blue: 142.0/255.0, alpha: 1.0).CGColor
        let colorBottom: AnyObject = UIColor(red: 62.0/255.0, green: 178.0/255.0, blue: 120.0/255.0, alpha: 1.0).CGColor
        let arrayOfColors: [AnyObject] = [colorTop, colorBottom]
        gradientLayer.colors = arrayOfColors
        
        return gradientLayer
    }
    
    func hideProgressView() {
        progressLayer.strokeEnd = 0.0
        progressLayer.removeAllAnimations()
    }
    
    //fire up the animation
    func animateProgressView() {
        progressLayer.strokeEnd = 0.0
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = CGFloat(0.0)
        animation.toValue = CGFloat(1.0)
        animation.duration = 1.0
        animation.delegate = self
        animation.removedOnCompletion = false
        animation.additive = true
        animation.fillMode = kCAFillModeForwards
        progressLayer.addAnimation(animation, forKey: "strokeEnd")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        progressLabel.text = "\(percentage) %"
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.progressLabel.transform = CGAffineTransformMakeScale(1.5, 1.5)
            }) { (done) -> Void in
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.progressLabel.transform = CGAffineTransformIdentity
                })
        }
    }
}
