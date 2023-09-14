//
//  WelcomeVC.swift
//  AmplifyAuth
//
//  Created by David Perez Espino on 13/09/23.
//

import UIKit

class WelcomeVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signOut(_ sender: Any) {
        Task {
            let result = await AuthHelper().signOutGlobally()
            
            if result {
                self.dismiss(animated: true)
            } else {
                showAlert(message: "Something goes wrong")
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
