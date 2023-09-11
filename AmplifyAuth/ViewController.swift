//
//  ViewController.swift
//  AmplifyAuth
//
//  Created by David Perez Espino on 05/09/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var edtSingInUsername: UITextField!
    @IBOutlet weak var edtSingInPassword: UITextField!
    
    @IBOutlet weak var edtSingUpUsername: UITextField!
    @IBOutlet weak var edtSingUpPass: UITextField!
    @IBOutlet weak var edtSingUpEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func clickSignIn(_ sender: UIButton) {
    }
    
    @IBAction func clickSignUp(_ sender: UIButton) {
        Task {
            await AuthHelper().signUp(
                username: edtSingUpUsername.text ?? "",
                password: edtSingUpPass.text ?? "",
                email: edtSingUpEmail.text ?? ""
            )
        }
    }
}

