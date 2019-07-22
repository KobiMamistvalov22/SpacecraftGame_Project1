//
//  Enemy.swift
//  SpacecraftGame_Project1
//
//  Created by Kobi Mamistvalov on 7/22/19.
//  Copyright © 2019 Kobi Mamistvalov. All rights reserved.
//

import UIKit

class Enemy: UIImageView {
    
    private var velocityX, velocityY: CGFloat
    private var _bound: CGRect
    var enemyStartPositionX: CGFloat = CGFloat(Float.random(in: -3..<3))
    init(frame: CGRect, bounds: CGRect) {
        self.velocityX = enemyStartPositionX
        self.velocityY = 7
        self._bound = bounds
        super.init(frame: frame)
    }
    
    func moveEnemy(){
        center = CGPoint(x: center.x , y: center.y + velocityY)
        if frame.maxX > _bound.maxX {
            velocityX *= -1
            center = CGPoint(x: _bound.maxX - frame.width / 2, y: center.y)
        }else if frame.minX < _bound.minX {
            velocityX *= -1
            center = CGPoint(x: frame.width / 2, y: center.y)
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
