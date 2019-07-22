//
//  Spacecraft.swift
//  SpacecraftGame_Project1
//
//  Created by Kobi Mamistvalov on 7/22/19.
//  Copyright © 2019 Kobi Mamistvalov. All rights reserved.
//

import UIKit

class Spacecraft: UIImageView{
    private var velocityX: CGFloat
    private var _bound: CGRect
    init(frame: CGRect, bounds: CGRect) {
        self.velocityX = 0
        self._bound = bounds
        super.init(frame: frame)
    }
    
    func moveSpacecraft(){
        center = CGPoint(x: center.x + velocityX, y: center.y)
        if frame.maxX > _bound.maxX {
            center = CGPoint(x: _bound.maxX - frame.width / 2, y: center.y)
        }else if frame.minX < _bound.minX {
            center = CGPoint(x: frame.width / 2, y: center.y)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
