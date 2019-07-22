//
//  Lazer.swift
//  SpacecraftGame_Project1
//
//  Created by Kobi Mamistvalov on 7/22/19.
//  Copyright © 2019 Kobi Mamistvalov. All rights reserved.
//

import UIKit

class Lazer: UIImageView {
    private var blablaY: CGFloat
    override init(frame: CGRect) {
        self.blablaY = -17
        super.init(frame: frame)
    }
    
    func lazerMoved(){
        center = CGPoint(x: center.x, y: center.y + blablaY)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
