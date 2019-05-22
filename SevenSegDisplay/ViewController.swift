//
//  ViewController.swift
//  SevenSegDisplay
//
//  Created by Sam Nelson on 5/19/19.
//  Copyright © 2019 TSLSDN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var number: UITextField!
    var segs: SevenSegment?
    var value = 0.0{
        didSet{
            number.text = String(self.value)
            segs?.value = Int(self.value)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        segs = SevenSegment(integer: Int(self.value), imageView: imageView)
        segs?.draw()
    }

    @IBAction func step(_ sender: UIStepper) {
         value = sender.value
    }
    
}

