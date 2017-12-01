//
//  FloatActionButton.swift
//  Prototype IOS
//
//  Created by Ludimila Queiroz on 26/11/17.
//  Copyright © 2017 Raphael Menezes. All rights reserved.
//

import UIKit

class FloatActionButton: UIButton {

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        UIView.animate(withDuration: 0.3, animations: {
            if self.transform == .identity {
            
            self.transform = CGAffineTransform(rotationAngle: 45 * (.pi / 180))
                self.backgroundColor = #colorLiteral(red: 0.9569, green: 0.7843, blue: 0.0902, alpha: 1) /* #f4c817 */
            } else {
                self.transform = .identity
                self.backgroundColor = #colorLiteral(red: 1, green: 0.8196, blue: 0.098, alpha: 1) /* #ffd119 */
            }
        })
        
        return true
        
    }
    

}
