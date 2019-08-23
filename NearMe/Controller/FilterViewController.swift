//
//  FilterViewController.swift
//  NearMe
//
//  Created by Eren Besel on 2019/08/23.
//  Copyright © 2019 Eren Besel. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var keywordTextField: UITextField!
    @IBOutlet weak var radiusTitleLabel: UILabel!
    @IBOutlet weak var radiusValueLabel: UILabel!
    @IBOutlet weak var radiusSlider: UISlider!
    
    var viewModel: FilterViewModel!
    
    var updateHandler: ((String?, Float) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupValues()
    }
    
    func setupValues() {
        radiusSlider.value = viewModel.radius
        keywordTextField.text = viewModel.keyword
        radiusValueLabel.text = String(Int(radiusSlider.value)) + "m"
    }

    @IBAction func sliderValueChanged(_ sender: Any) {
        radiusValueLabel.text = String(Int(radiusSlider.value)) + "m"
    }
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        // update the view model then return it with the closure
        viewModel.updateValues(keyword: keywordTextField.text, radius: radiusSlider.value)
        updateHandler?(viewModel.keyword, viewModel.radius)
        dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
