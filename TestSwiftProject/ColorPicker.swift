//
//  ColorPicker.swift
//
//  Created by Dejan Atanasov on 12/25/15.
//

import UIKit
@objc protocol colorDelegate{
    @objc optional func pickedColor(_ color:UIColor)
}


class ColorPicker: UIView {
    var currentSelectionX: CGFloat = 0;
    var selectedColor: UIColor!
    var delegate: colorDelegate!
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        UIColor.black.set()
        var tempYPlace = self.currentSelectionX;
        if (tempYPlace < CGFloat (0.0)) {
            tempYPlace = CGFloat (0.0);
        } else if (tempYPlace >= self.frame.size.width) {
            tempYPlace = self.frame.size.width - 1.0;
        }
        
//        let temp = CGRect(x: 0.0, y: tempYPlace, width: 10.0, height: self.frame.size.height);
//        UIRectFill(temp);
        
//        //draw central bar over it
//        let width = Int(self.frame.size.width / 10)
//        for i in 0 ..< width {
//            UIColor(hue:CGFloat (i * 10)/self.frame.size.width * 10, saturation: 1.0, brightness: 1.0, alpha: 1.0).set()
//            let temp = CGRect(x: CGFloat (i * 10), y: 0, width: 10.0, height: self.frame.size.height);
//            UIRectFill(temp);
//        }
        
        for i in 0 ..< 15 {
            getPaletteColor(i).set()
            let temp = CGRect(x: CGFloat(i * Int(self.frame.size.width) / 15), y: 0, width: self.frame.size.width / 15, height: self.frame.size.height)
            UIRectFill(temp)
        }
        
    }
    
    //Get color palette
    func getPaletteColor(_ index: Int)-> UIColor{
        switch index {
        case 0:
            return UIColor.white
        case 1:
            return UIColor.lightGray
        case 2:
            return UIColor.gray
        case 3:
            return UIColor.black
        case 4:
            return UIColor(hue: 331 / 360, saturation: 0.35, brightness: 1.0, alpha: 1.0)
        case 5:
            return UIColor.red
        case 6:
            return UIColor.orange
        case 7:
            return UIColor.brown
        case 8:
            return UIColor.yellow
        case 9:
            return UIColor(hue: 89 / 360, saturation: 0.7, brightness: 0.88, alpha: 1.0)
        case 10:
            return UIColor.green
        case 11:
            return UIColor(hue: 183 / 360, saturation: 1.0, brightness: 0.87, alpha: 1.0)
        case 12:
            return UIColor(hue: 200 / 360, saturation: 1.0, brightness: 0.78, alpha: 1.0)
        case 13:
            return UIColor(hue: 289 / 360, saturation: 0.52, brightness: 0.89, alpha: 1.0)
        case 14:
            return UIColor.purple
        default:
            return UIColor.white
        }

    }
    
    //Changes the selected color, updates the UI, and notifies the delegate.
    func selectedColor(_ sColor: UIColor){
        if (sColor != selectedColor)
        {
            var hue: CGFloat = 0
            var saturation: CGFloat = 0
            var brightness: CGFloat = 0
            var alpha: CGFloat = 0
            
            if sColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha){
                currentSelectionX = CGFloat (hue * self.frame.size.height);
                self.setNeedsDisplay();
                
            }
            selectedColor = sColor
            self.delegate.pickedColor!(selectedColor)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch =  touches.first
        updateColor(touch!)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch =  touches.first
        updateColor(touch!)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch =  touches.first
        updateColor(touch!)
    }
    
    func updateColor(_ touch: UITouch){
        currentSelectionX = (touch.location(in: self).x)
//        selectedColor = UIColor(hue: (currentSelectionX / self.frame.size.width), saturation: 1.0, brightness: 1.0, alpha: 1.0)
        selectedColor = getPaletteColor(Int(currentSelectionX) * 15 / Int(self.frame.size.width))
        self.delegate.pickedColor!(selectedColor)
        self.setNeedsDisplay()
    }
}
