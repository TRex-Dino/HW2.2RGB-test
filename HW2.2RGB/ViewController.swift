//
//  ViewController.swift
//  HW2.2RGB
//
//  Created by Dmitry on 26.03.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var rgbView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRedColor()
        setGreenColor()
        setBlueColor()
        
        viewBackgroundChanged()
    }

    
    @IBAction func sliderChangedColor(_ sender: UISlider) {
        
        switch sender.tag {
        case 0:
            setRedColor()
        case 1:
            setGreenColor()
        case 2:
            setBlueColor()
        default:
            break
        }
        
        viewBackgroundChanged()
     
    }
    
    private func setRedColor() {
        redLabel.text = String(format: "%.2f", redSlider.value)
    }
    
    private func setGreenColor() {
        greenLabel.text = String(format: "%.2f", greenSlider.value)
    }
    
    private func setBlueColor() {
        blueLabel.text = String(format: "%.2f", blueSlider.value)
    }
    
    private func viewBackgroundChanged() {
        rgbView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                          green: CGFloat(greenSlider.value),
                                          blue: CGFloat(blueSlider.value),
                                          alpha: 1)
    }
}

