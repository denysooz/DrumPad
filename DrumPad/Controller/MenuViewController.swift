//
//  ViewController.swift
//  Drum
//
//  Created by Denis Dareuskiy on 15.08.23.
//

import UIKit

class MenuViewController: UIViewController {
    
    var size = ["2*2","3*3","4*4"]
    var currentSize = ""
   
    @IBOutlet var picker: UIPickerView!
    @IBOutlet var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self
        picker.delegate = self
        currentSize = size[0]
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toPlayView":
            preparePlayScreen(segue)
        default:
            break
        }
    }
    
    private func preparePlayScreen(_ segue: UIStoryboardSegue) {
        guard let destination = segue.destination as? DrumViewController else { return }
        destination.currentSize = self.currentSize
    }
}
 
extension MenuViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        size.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return size[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currentSize = size[row]
    }
}

        



