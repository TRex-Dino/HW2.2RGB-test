//
//  ViewController.swift
//  HW2.2RGB
//
//  Created by Dmitry on 26.03.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var rgbView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rgbView.layer.cornerRadius = 15
        
        setValue(for: redLabel, greenLabel, blueLabel)
        
        viewBackgroundChanged()
    }

    
    @IBAction func sliderChangedColor(_ sender: UISlider) {
        
        switch sender {
        case redSlider: setValue(for: redLabel)
        case greenSlider: setValue(for: greenLabel)
        default: setValue(for: blueLabel)
        }
        
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
    
 
    
    // MARK: - Set View Background Color
    private func viewBackgroundChanged() {
        rgbView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                          green: CGFloat(greenSlider.value),
                                          blue: CGFloat(blueSlider.value),
                                          alpha: 1)
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                label.text = string(from: redSlider)
            case greenLabel:
                label.text = string(from: greenSlider)
            default:
                label.text = string(from: blueSlider)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

