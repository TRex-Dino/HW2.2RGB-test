//
//  MainViewController.swift
//  HW2.2RGB
//
//  Created by Dmitry on 09.04.2021.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewColor(for color: UIColor)
}
class MainViewController: UIViewController {

    private var color = UIColor(red: 0.55, green: 1, blue: 0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingVC = segue.destination as? SettingsViewController else { return }
        settingVC.color = color
        settingVC.delegate = self
    }

}

extension MainViewController: SettingsViewControllerDelegate {
    func setNewColor(for color: UIColor) {
        view.backgroundColor = color
        self.color = color
    }
}
