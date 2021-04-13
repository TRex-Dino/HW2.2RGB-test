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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rgbView.layer.cornerRadius = 15
        
        setSliders()
        setLabelText(for: redLabel, blueLabel, greenLabel)
        setTextField(for: redTextField, blueTextField, greenTextField)
        
    }
    
    //MARK: - IBActions
    @IBAction func sliderChangedColor(_ sender: UISlider) {
        
        switch sender {
        case redSlider: setLabelText(for: redLabel); setTextField(for: redTextField)
        case greenSlider: setLabelText(for: greenLabel); setTextField(for: greenTextField)
        default: setLabelText(for: blueLabel); setTextField(for: blueTextField)
        }
        
        updateRGBView()
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setNewColor(rgbView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    private func setSliders() {
        let ciColor = CIColor(color: color)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    //MARK: - set text for labels
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
    //MARK: - set text for textFields
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
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    // MARK: - Set View Background Color
    private func updateRGBView() {
        rgbView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
    }
}

//MARK: - work with keyboard
extension SettingsViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing (_ textField: UITextField) {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let button = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: textField,
            action: #selector(resignFirstResponder)
        )
        
        toolBar.items = [space, button]
        
        textField.inputAccessoryView = toolBar
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let value = textField.text else { return }
        guard let newValue = Float(value), newValue >= 0 && newValue <= 1  else {
            showAlert(
                title: "Wrong value!",
                message: "Please. Enter value from 0.0 to 1.0",
                textField: textField)
            return }
        
        switch textField {
        case redTextField:
            redSlider.value = newValue
            setTextField(for: textField)
            setLabelText(for: redLabel)
        case greenTextField:
            greenSlider.value = newValue
            setTextField(for: textField)
            setLabelText(for: greenLabel)
        default:
            blueSlider.value = newValue
            setTextField(for: textField)
            setLabelText(for: blueLabel)
        }
        
        updateRGBView()
    }
    
}

//MARK: - alertController
extension SettingsViewController {
    private func showAlert(title: String, message: String, textField: UITextField) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            self.setTextField(for: textField)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
