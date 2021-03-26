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
        
        setRedLabelValue()
        setGreenLabelValue()
        setBlueLabelValue()
        
        setRedLabelColor()
        setGreenLabelColor()
        setBlueLabelColor()
        
        viewBackgroundChanged()
    }

    
    @IBAction func sliderChangedColor(_ sender: UISlider) {
        
        switch sender.tag {
        case 0:
            setRedLabelValue()
            
        case 1:
            setGreenLabelValue()
            
        case 2:
            setBlueLabelValue()
            
        default:
            break
        }
        
        setRedLabelColor()
        setBlueLabelColor()
        setGreenLabelColor()
        
        viewBackgroundChanged()
     
    }
    
    // MARK: - Set Label Value
    private func setRedLabelValue() {
        redLabel.text = String(format: "%.2f", redSlider.value)
    }
    
    private func setGreenLabelValue() {
        greenLabel.text = String(format: "%.2f", greenSlider.value)
    }
    
    private func setBlueLabelValue() {
        blueLabel.text = String(format: "%.2f", blueSlider.value)
    }
    
    // MARK: - Set Label Color
    private func setRedLabelColor() {
        redLabel.textColor = UIColor(red: CGFloat(redSlider.value),
                                     green: 0,
                                     blue: 0,
                                     alpha: 1)
    }
    private func setGreenLabelColor() {
        greenLabel.textColor = UIColor(red: 0,
                                     green: CGFloat(greenSlider.value),
                                     blue: 0,
                                     alpha: 1)
    }
    private func setBlueLabelColor() {
        blueLabel.textColor = UIColor(red: 0,
                                     green: 0,
                                     blue: CGFloat(blueSlider.value),
                                     alpha: 1)
    }
    
    // MARK: - Set View Background Color
    private func viewBackgroundChanged() {
        rgbView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                          green: CGFloat(greenSlider.value),
                                          blue: CGFloat(blueSlider.value),
                                          alpha: 1)
    }
}

