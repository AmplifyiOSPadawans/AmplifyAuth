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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "GoCodeVC") {
            let secondView = segue.destination as! ConfirmationCodeVC
            
            let object = sender as! [String: Any?]
            secondView.username = object["username"] as? String
        }
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
            
            let sender: [String: Any?] = ["username": edtSingUpUsername.text ?? ""]
            self.performSegue(withIdentifier: "GoCodeVC", sender: sender)
        }
        
        
    }
}

