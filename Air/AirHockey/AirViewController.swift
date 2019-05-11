//
//  AirViewController.swift
//  Air
//
//  Created by Art Karma on 5/11/19.
//  Copyright © 2019 Art Karma. All rights reserved.
//

import UIKit

class AirViewController: UIViewController {
    
    var topSide: UIView!
    var bottomSide: UIView!
    var field: UIView!
    
    var topRacket: AirRoundView!
    var bottomRacket: AirRoundView!
    var puck: AirRoundView!
    
    var animator: UIDynamicAnimator!
    var collision: UICollisionBehavior!
    var puckBehavior: UIDynamicItemBehavior!
    var snap1: UISnapBehavior!
    var snap2: UISnapBehavior!
    var snap3: UISnapBehavior!

    
    var collision1: UICollisionBehavior!
    var collision2: UICollisionBehavior!
    
    var timer = Timer()
    
    func get() {
        field = UIView(frame: CGRect(x: 0, y: -Size.size.goalSize, width: Int(view.frame.width), height: Int(view.frame.height) + (2 * Size.size.goalSize)))
        field.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        
        topSide = UIView(frame: CGRect(x: 0, y: Size.size.goalSize, width: Int(view.frame.width), height: Int(view.frame.height) / 2))
//        topSide.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(topSidePanorama(_:))))
        topSide.backgroundColor = UIColor.clear
        topSide.isUserInteractionEnabled = true
        
        bottomSide = UIView(frame: CGRect(x: 0, y: Int(view.frame.height) / 2 + Size.size.goalSize, width: Int(view.frame.width), height: Int(view.frame.height) / 2))
        bottomSide.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(bottomSidePanorama(_:))))
        bottomSide.backgroundColor = UIColor.clear
        bottomSide.isUserInteractionEnabled = true
        
//        player2SideView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan2(_:))))

        
        topRacket = AirRoundView(frame: CGRect(x: 0, y: 0, width: Size.size.racketSize, height: Size.size.racketSize))
        topRacket.color = .red
        topRacket.center = topSide.center
        
        bottomRacket = AirRoundView(frame: CGRect(x: 50, y: 50, width: Size.size.racketSize, height: Size.size.racketSize))
        bottomRacket.color = .green
        bottomRacket.center = bottomSide.center
        
        puck = AirRoundView(frame: CGRect(x: 0, y: 0, width: Size.size.puckSize, height: Size.size.puckSize))
        puck.color = .black
        field.addSubview(puck)

        puck.center = CGPoint(x: field.frame.size.width / 2, y: field.frame.size.height / 2)
        
        view.addSubview(field)
        field.addSubview(topRacket)
        field.addSubview(bottomRacket)
        
        field.addSubview(topSide)
        field.addSubview(bottomSide)
 


    }
    
    
//    fileprivate func createField() {
//        field = UIView(frame: CGRect(x: 0, y: -Size.size.goalSize, width: Int(view.frame.width), height: Int(view.frame.height) + (2 * Size.size.goalSize)))
//        field.backgroundColor = .gray
////        view.addSubview(field)
//    }
//
//    fileprivate func createTopSideView() {
//        topSide = UIView(frame: CGRect(x: 0, y: Size.size.goalSize, width: Int(view.frame.width), height: Int(view.frame.height) / 2))
//        topSide.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(topSidePanorama(param:))))
//        topSide.backgroundColor = .lightGray
//        topSide.isUserInteractionEnabled = true
//
////        field.addSubview(topSide)
//    }
//
//    fileprivate func createBottomSideView() {
//        bottomSide = UIView(frame: CGRect(x: 0, y: Int(view.frame.height) / 2 + Size.size.goalSize, width: Int(view.frame.width), height: Int(view.frame.height) / 2))
//        bottomSide.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(bottomSidePanorama(param:))))
//        bottomSide.backgroundColor = .red
//        bottomSide.isUserInteractionEnabled = true
//
////        field.addSubview(bottomSide)
//    }
//
//    fileprivate func createHockey() {
//        topRacket = AirRoundView(frame: CGRect(x: 0, y: 0, width: Size.size.racketSize, height: Size.size.racketSize))
//        topRacket.color = .red
//        topRacket.center = topSide.center
//
//        bottomRacket = AirRoundView(frame: CGRect(x: 50, y: 50, width: Size.size.racketSize, height: Size.size.racketSize))
//        bottomRacket.color = .green
//        bottomRacket.center = bottomSide.center
//
//        puck = AirRoundView(frame: CGRect(x: 0, y: 0, width: Size.size.puckSize, height: Size.size.puckSize))
//        puck.color = .black
//        puck.center = CGPoint(x: field.frame.size.width / 2, y: field.frame.size.height / 2)
//
////        field.addSubview(puck)
////        field.addSubview(topRacket)
////        field.addSubview(bottomRacket)
    
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        createField()
//        createTopSideView()
//        createBottomSideView()
//        createHockey()
        get()
  
        
        engineAirHockey()
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(statusPack), userInfo: nil, repeats: true)
    }
    
    fileprivate func engineAirHockey() {
        
        animator = UIDynamicAnimator(referenceView: field)
        
        collision = UICollisionBehavior(items: [topRacket, bottomRacket])
        
        collision.collisionDelegate = self
        
        collision.addItem(puck)
        
        collision.addBoundary(withIdentifier: "top" as NSCopying, from: field.bounds.origin, to: field.bounds.topRight)
        collision.addBoundary(withIdentifier: "left" as NSCopying, from: field.bounds.origin, to: field.bounds.botLeft)
        collision.addBoundary(withIdentifier: "right" as NSCopying, from: field.bounds.topRight, to: field.bounds.end)
        collision.addBoundary(withIdentifier: "bottom" as NSCopying, from: field.bounds.botLeft, to: field.bounds.end)
        
        collision1 = UICollisionBehavior(items: [topRacket])
        collision1.collisionMode = .boundaries
        collision1.addBoundary(withIdentifier: "col1" as NSCopying, for: UIBezierPath(rect: topSide.frame))
        
        collision2 = UICollisionBehavior(items: [bottomRacket])
        collision2.collisionMode = .boundaries
        collision2.addBoundary(withIdentifier: "col2" as NSCopying, for: UIBezierPath(rect: bottomSide.frame))
        
        puckBehavior = UIDynamicItemBehavior(items: [puck])
        puckBehavior.friction = 0.9
        puckBehavior.elasticity = 1.0
        
        animator.addBehavior(collision2)
        animator.addBehavior(collision)
        animator.addBehavior(puckBehavior)
        animator.addBehavior(collision1)
    }
    
    @objc func topSidePanorama(_ gesture: UIGestureRecognizer) {
        if animator == nil { return }
        if snap1 != nil {
            animator.removeBehavior(snap1)
        }
        let locTo = gesture.location(in: field)
        snap1 = UISnapBehavior(item: topRacket, snapTo: locTo)
        animator.addBehavior(snap1)
    }
    
    @objc func bottomSidePanorama(_ gesture: UIGestureRecognizer) {
        if animator == nil { return }
        if snap2 != nil {
            animator.removeBehavior(snap2)
        }
        let locTo = gesture.location(in: field)
        snap2 = UISnapBehavior(item: bottomRacket, snapTo: locTo)
        animator.addBehavior(snap2)
    }
    
    @objc func statusPack() {

        
        snap3 = UISnapBehavior(item: topRacket, snapTo: puck.center)
        animator.addBehavior(snap3)

//        animator.removeBehavior(snap3)

        
        if puck.center.y == topSide.frame.maxY && puck.center.x < topSide.frame.minX { //view.frame.maxY
            print(" puck y - \(puck.center.y) topSide Y - \(topSide.center.y)")

            snap3.damping = 1
            
            
        }
        
    }
    
}

extension AirViewController: UICollisionBehaviorDelegate {
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        if item === puck {
            if identifier?.string == "top" {
                print("Goal 1")
            } else if identifier?.string == "bottom" {
                print("Goal 2")
            }
        }
    }
}
