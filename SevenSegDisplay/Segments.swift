//
//  Segments.swift
//  SevenSegDisplay
//
//  Created by Sam Nelson on 5/19/19.
//  Copyright © 2019 TSLSDN. All rights reserved.
//

import Foundation
import UIKit

class SevenSegment{
    fileprivate var size: CGSize
    public var numberOfDigitsToPad = 1
    public weak var imageView: UIImageView?
    public var offColor = UIColor(displayP3Red: 0.7, green: 1, blue: 0.7, alpha: 0.2).cgColor
    public var onColor = UIColor(displayP3Red: 0.0, green: 0.9, blue: 0.4, alpha: 1.0).cgColor
    public var blur:CGFloat = 10
    public private(set) var image: UIImage!{
        didSet{
            imageView?.image = image
        }
    }
    public var value: Int{
        didSet{
            draw()
        }
    }
    
    init(integer: Int = 0, imageView: UIImageView){
        size = imageView.frame.size
        self.imageView = imageView
        value = integer
    }
    
    init(integer: Int = 0, size: CGSize){
        self.size = size
        value = integer
    }

    public func draw(){
        let renderer = UIGraphicsImageRenderer(size: size)
        
        let image = renderer.image(actions: { (context) in
            let context = UIGraphicsGetCurrentContext()
            var digits = value.asDigits()
            if digits.count < numberOfDigitsToPad{
                for _ in 1...numberOfDigitsToPad-digits.count{
                    digits.insert(0, at: 0)
                }
            }
            let height = size.height
            var localWidth = size.width / CGFloat(digits.count) * 0.85
            if localWidth > 0.8*height{
                localWidth = 0.8*height
            }
            let lineThickness:CGFloat = localWidth * 0.2 * 0.9
            let widthGap = localWidth * 0.01 * 0.9
            let heightGap = height * 0.01
            let gap = heightGap * widthGap
            for i in 0..<digits.count{
                let localOriginX = size.width / CGFloat(digits.count) * CGFloat(i)
                context?.setShadow(offset: CGSize(width: 0, height: 0), blur: blur)

                //top
                if [2,3,5,7,8,9,0].contains(digits[i]){
                    context?.setFillColor(onColor)
                }else{
                    context?.setFillColor(offColor)
                }
                context?.move(to: CGPoint(x: localOriginX, y: lineThickness * 2.5))
                context?.addLine(to: CGPoint(x: localOriginX, y: 0 + lineThickness))
                context?.addArc(tangent1End: CGPoint(x: localOriginX, y: 0), tangent2End: CGPoint(x: lineThickness + localOriginX, y: 0), radius: CGFloat(lineThickness))
                context?.addLine(to: CGPoint(x: localWidth + localOriginX - gap, y: 0)) //upper top right
                context?.addLine(to: CGPoint(x: localWidth - lineThickness + localOriginX - gap, y: lineThickness)) //lower top right
                context?.addLine(to: CGPoint(x: lineThickness+gap+localOriginX, y: lineThickness))
                context?.addArc(tangent1End: CGPoint(x: lineThickness+localOriginX, y: lineThickness), tangent2End: CGPoint(x: lineThickness+localOriginX, y: lineThickness+gap), radius: CGFloat(gap)) //inner radius
                context?.addLine(to: CGPoint(x: lineThickness+localOriginX, y: lineThickness*2 - gap/2)) //left bottom right
                context?.addLine(to: CGPoint(x: localOriginX, y: lineThickness * 2.5 - gap/2)) //left bottom left
                context?.closePath()
                context?.fillPath()
                
                //top left
                if [4,5,6,8,9,0].contains(digits[i]){
                    context?.setFillColor(onColor)
                }else{
                    context?.setFillColor(offColor)
                }
                context?.move(to: CGPoint(x: localOriginX, y: lineThickness * 2.5 + gap)) //top left corner
                context?.addLine(to: CGPoint(x: lineThickness+localOriginX, y: lineThickness*2 + gap)) //top right corner
                context?.addLine(to: CGPoint(x: lineThickness+localOriginX, y: height*0.5 - lineThickness*0.5 - gap)) //bottom right corner
                context?.addLine(to: CGPoint(x: localOriginX, y: height*0.5 + lineThickness*0.5 - gap)) //bottom left corner
                context?.addLine(to: CGPoint(x: localOriginX, y: lineThickness * 2.5 + gap)) //top left corner
                context?.closePath()
                context?.fillPath()
                
                //top right
                if [1,2,3,4,7,8,9,0].contains(digits[i]){
                    context?.setFillColor(onColor)
                }else{
                    context?.setFillColor(offColor)
                }
                context?.move(to: CGPoint(x: localWidth + localOriginX, y: gap)) //top right
                context?.addLine(to: CGPoint(x: localWidth + localOriginX, y: height*0.5 + lineThickness*0.5 - gap)) //lower right
                context?.addLine(to: CGPoint(x: localWidth + localOriginX - lineThickness, y: height*0.5 - lineThickness*0.5 - gap)) //lower left
                context?.addLine(to: CGPoint(x: localWidth + localOriginX - lineThickness, y: lineThickness + gap)) //top left
                context?.addLine(to: CGPoint(x: localWidth + localOriginX, y: gap)) //top right
                context?.closePath()
                context?.fillPath()
                
                //middle
                if [2,3,4,5,6,8,9].contains(digits[i]){
                    context?.setFillColor(onColor)
                }else{
                    context?.setFillColor(offColor)
                }
                context?.move(to: CGPoint(x: localOriginX + gap, y: height*0.5 + lineThickness/2 )) //bottom left
                context?.addLine(to: CGPoint(x: localOriginX + gap + lineThickness, y: height*0.5 - lineThickness/2 )) //top left
                context?.addLine(to: CGPoint(x: localOriginX + localWidth - lineThickness - gap, y: height*0.5 - lineThickness/2 )) //top right
                context?.addLine(to: CGPoint(x: localOriginX + localWidth - gap, y: height*0.5 + lineThickness/2 )) // bottom right
                context?.addLine(to: CGPoint(x: localOriginX, y: height*0.5 + lineThickness/2 )) //bottom left
                context?.closePath()
                context?.fillPath()
                
                //bottom left
                if [2,6,8,0].contains(digits[i]){
                    context?.setFillColor(onColor)
                }else{
                    context?.setFillColor(offColor)
                }
                context?.move(to: CGPoint(x: localOriginX + lineThickness, y: height*0.5 + lineThickness/2 + gap)) //top right
                context?.addLine(to: CGPoint(x: localOriginX + lineThickness, y: height - lineThickness*2 - gap)) //lower right
                context?.addLine(to: CGPoint(x: localOriginX, y: height - lineThickness*2 - gap)) //lower left
                context?.addLine(to: CGPoint(x: localOriginX, y: height*0.5 + lineThickness/2 + gap)) //top left
                context?.addLine(to: CGPoint(x: localOriginX + lineThickness, y: height*0.5 + lineThickness/2 + gap)) //top right
                context?.closePath()
                context?.fillPath()
                
                //bottom right
                if [1,3,4,5,6,7,8,9,0].contains(digits[i]){
                    context?.setFillColor(onColor)
                }else{
                    context?.setFillColor(offColor)
                }
                context?.move(to: CGPoint(x: localOriginX + localWidth, y: height*0.5 + lineThickness/2 + gap)) //top right
                context?.addLine(to: CGPoint(x: localOriginX + localWidth, y: height - gap)) //lower right
                context?.addLine(to: CGPoint(x: localOriginX + localWidth - lineThickness, y: height - lineThickness - gap)) //lower left
                context?.addLine(to: CGPoint(x: localOriginX + localWidth - lineThickness, y: height*0.5 + lineThickness/2 + gap)) //top left
                context?.addLine(to: CGPoint(x: localOriginX + localWidth, y: height*0.5 + lineThickness/2 + gap)) //top right
                context?.closePath()
                context?.fillPath()
                
                //bottom
                if [2,3,5,6,8,0].contains(digits[i]){
                    context?.setFillColor(onColor)
                }else{
                    context?.setFillColor(offColor)
                }
                context?.move(to: CGPoint(x: localOriginX, y: height - lineThickness*2))
                context?.addLine(to: CGPoint(x: localOriginX + lineThickness, y: height - lineThickness*2))
                context?.addArc(tangent1End: CGPoint(x: localOriginX + lineThickness, y: height - lineThickness), tangent2End: CGPoint(x: localOriginX + lineThickness + gap, y: height - lineThickness), radius: gap)
                context?.addLine(to: CGPoint(x: localOriginX + localWidth - lineThickness - gap, y: height - lineThickness))
                context?.addLine(to: CGPoint(x: localOriginX + localWidth - gap, y: height))
                //context?.addLine(to: <#T##CGPoint#>)
                context?.addArc(tangent1End: CGPoint(x: localOriginX, y: height), tangent2End: CGPoint(x: localOriginX, y: height - lineThickness), radius: lineThickness)
                context?.addLine(to: CGPoint(x: localOriginX, y: height - lineThickness*2 + gap))
                context?.closePath()
                context?.fillPath()
            }
        })
        self.image = image
    }
}

extension Int{
    func asDigits() -> [Int]{
        var digits = [Int]()
        digits.append(0)
        var value = self
        while value > 0{
            digits.append(value%10)
            value = value/10
        }
        digits.removeFirst()
        return digits.reversed()
    }
}
