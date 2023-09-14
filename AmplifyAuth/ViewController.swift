//
//  ViewController.swift
//  AmplifyAuth
//
//  Created by David Perez Espino on 05/09/23.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var edtSingInUsername: UITextField!
    @IBOutlet weak var edtSingInPassword: UITextField!
    
    @IBOutlet weak var edtSingUpUsername: UITextField!
    @IBOutlet weak var edtSingUpPass: UITextField!
    @IBOutlet weak var edtSingUpEmail: UITextField!
    
    @IBOutlet weak var fbLogo: UIImageView!
    @IBOutlet weak var googleLogo: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fbRecognizer = UITapGestureRecognizer(target: self, action: #selector(fbLogoTapped(tapGestureRecognizer:)))
        fbLogo.isUserInteractionEnabled = true
        fbLogo.addGestureRecognizer(fbRecognizer)
        
        let googleRecognizer = UITapGestureRecognizer(target: self, action: #selector(googleLogoTapped(tapGestureRecognizer:)))
        googleLogo.isUserInteractionEnabled = true
        googleLogo.addGestureRecognizer(googleRecognizer)
        
        
        /****************/
        // Biometrics code
        var error: NSError?
        let context = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: "Por favor autentícate para continuar"
            ) { succeed, error in
                if succeed {
                    self.showAlert(message: "Autenticación biométrica completada")
                } else {
                    self.showAlert(message: "Error en la autenticación biométrica")
                }
            }
        } else {
            showAlert(message: "El dispositivo no soporta autenticación Biométrica")
        }
        /****************/
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "GoCodeVC") {
            let secondView = segue.destination as! ConfirmationCodeVC
            
            let object = sender as! [String: Any?]
            secondView.username = object["username"] as? String
        }
    }
    

    @IBAction func clickSignIn(_ sender: UIButton) {
        Task {
            let isSucceed = await AuthHelper().signIn(
                username: edtSingInUsername.text ?? "",
                password: edtSingInPassword.text ?? ""
            )
            if isSucceed {
                self.performSegue(withIdentifier: "GoWelcomeVC", sender: self)
            } else {
                showAlert(message: "An error occures")
            }
                
        }
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
    
    @objc func fbLogoTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        Task {
            let isSucceed = await AuthHelper().socialSignInWithWebUI(with: .facebook, in: self.view.window!)
            
            if isSucceed {
                self.performSegue(withIdentifier: "GoWelcomeVC", sender: self)
            } else {
                showAlert(message: "An error occures")
            }
        }
        
    }
    
    @objc func googleLogoTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        Task {
            let isSucceed = await AuthHelper().socialSignInWithWebUI(with: .google, in: self.view.window!)
            
            if isSucceed {
                self.performSegue(withIdentifier: "GoWelcomeVC", sender: self)
            } else {
                showAlert(message: "An error occures")
            }
        }
    }
    
    func showAlert(message: String) {
        let dialogMessage = UIAlertController(title: "Atention", message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            dialogMessage.dismiss(animated: true)
        })
        
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
}

