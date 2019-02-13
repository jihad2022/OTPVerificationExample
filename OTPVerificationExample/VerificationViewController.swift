//
//  VerificationViewController.swift
//  OTPVerificationExample
//
//  Created by Hagomer Nasr on 2/13/19.
//  Copyright © 2019 Jihad. All rights reserved.
//

import UIKit

class VerificationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var verfTextFieldCollection: [UITextField]!
    var textFieldsIndexes:[UITextField:Int] = [:]
    var verfCode: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 0 ..< verfTextFieldCollection.count {
            textFieldsIndexes[verfTextFieldCollection[index]] = index
            verfTextFieldCollection[index].delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    enum Direction { case left, right }
    
    func setNextResponder(_ index:Int?, direction:Direction) {
        
        guard let index = index else { return }
        
        if direction == .left {
            index == 0 ?
                (_ = verfTextFieldCollection.first?.resignFirstResponder()) :
                (_ = verfTextFieldCollection[(index - 1)].becomeFirstResponder())
        } else {
            index == verfTextFieldCollection.count - 1 ?
                (_ = verfTextFieldCollection.last?.resignFirstResponder()) :
                (_ = verfTextFieldCollection[(index + 1)].becomeFirstResponder())
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if range.length == 0 {
            textField.text = string
            setNextResponder(textFieldsIndexes[textField], direction: .right)
            return true
        } else if range.length == 1 {
            textField.text = ""
            setNextResponder(textFieldsIndexes[textField], direction: .left)
            return false
        }
        return false
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == self.verfTextFieldCollection[self.verfTextFieldCollection.count - 1]) {
            self.verfCode = ""
            for singleField in verfTextFieldCollection {
                self.verfCode += singleField.text!
            }
            print(self.verfCode)
        }
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
