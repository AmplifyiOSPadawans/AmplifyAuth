//
//  ConfirmationCodeVC.swift
//  AmplifyAuth
//
//  Created by David Perez Espino on 11/09/23.
//

import UIKit

class ConfirmationCodeVC: UIViewController {
    
    @IBOutlet weak var edtCode: UITextField!
    
    var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view.
    }
    
    @IBAction func doConfirmationCode(_ sender: Any) {
        Task {
            await AuthHelper().confirmSignUp(
                for: username ?? "",
                with: edtCode.text ?? ""
            )
            self.dismiss(animated: true)
        }
    }
}