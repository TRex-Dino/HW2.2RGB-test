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
        
        rgbView.backgroundColor = color
        
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

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if let currentValue = Float(text) {
            switch textField {
            case redTextField:
                redSlider.setValue(currentValue, animated: true)
                setLabelText(for: redLabel)
            case greenTextField:
                greenSlider.setValue(currentValue, animated: true)
                setLabelText(for: greenLabel)
            default:
                blueSlider.setValue(currentValue, animated: true)
                setLabelText(for: blueLabel)
            }
            
            updateRGBView()
            return
        }
        
        showAlert(title: "Wrong format!", message: "Please enter correct value", textField: textField)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        textField.inputAccessoryView = keyboardToolbar
        keyboardToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            title:"Done",
            style: .done,
            target: self,
            action: #selector(didTapDone)
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
}

//MARK: - alertController
extension SettingsViewController {
    private func showAlert(title: String, message: String, textField: UITextField) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            //
            self.setTextField(for: textField)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
}
