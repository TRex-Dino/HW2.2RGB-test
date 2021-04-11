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
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    var color: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    private var colorComponent: (red: Float, green: Float, blue: Float) {
        (red: Float(color.cgColor.components?[0] ?? 1),
         green: Float(color.cgColor.components?[1] ?? 1),
         blue: Float(color.cgColor.components?[2] ?? 1)
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rgbView.layer.cornerRadius = 15
        
        updateView()
    }
    
    @IBAction func sliderChangedColor(_ sender: UISlider) {
        
        switch sender {
        case redSlider: setLabelText(for: redLabel); setTextField(for: redTextField)
        case greenSlider: setLabelText(for: greenLabel); setTextField(for: greenTextField)
        default: setLabelText(for: blueLabel); setTextField(for: blueTextField)
        }
        
        updateRGBView()
        updateColor()
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setNewColor(for: color)
        dismiss(animated: true)
    }
    
    private func setLabelText(for labels: UILabel...) {
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
    
    private func setTextField(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField:
                textField.text = string(from: redSlider)
            case greenTextField:
                textField.text = string(from: greenSlider)
            default:
                textField.text = string(from: blueSlider)
            }
        }
    }
    
    //MARK: - round value
    private func roundValue(value: Float) -> Float {
        round(value * 100) / 100
    }
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    // MARK: - Set View Background Color
    private func updateRGBView() {
        rgbView.backgroundColor = color
    }
    
    //MARK: - Update screen view
    private func updateView() {
        redSlider.value = colorComponent.red
        greenSlider.value = colorComponent.green
        blueSlider.value = colorComponent.blue

        redLabel.text = String(colorComponent.red)
        greenLabel.text = String(colorComponent.green)
        blueLabel.text = String(colorComponent.blue)

        redTextField.text = redLabel.text
        greenTextField.text = greenLabel.text
        blueTextField.text = blueLabel.text

        updateRGBView()
    }
    //MARK: - change value of color
    private func updateColor() {
        color = UIColor(red: CGFloat(roundValue(value: redSlider.value)),
                         green: CGFloat(roundValue(value: greenSlider.value)),
                         blue: CGFloat(roundValue(value: blueSlider.value)),
                         alpha: 1)
    }
}

