//
//  MainViewController.swift
//  HW2.2RGB
//
//  Created by Dmitry on 09.04.2021.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewColor(_ color: UIColor)
}

class MainViewController: UIViewController {

  //123
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingVC = segue.destination as? SettingsViewController else { return }
        settingVC.color = view.backgroundColor
        settingVC.delegate = self
    }

}

extension MainViewController: SettingsViewControllerDelegate {
    func setNewColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
