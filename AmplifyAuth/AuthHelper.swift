//
//  AuthHelper.swift
//  AmplifyAuth
//
//  Created by David Perez Espino on 06/09/23.
//

import Amplify


class AuthHelper {
    
    func signUp(username: String, password: String, email: String) async {
        let userAttributes = [
            AuthUserAttribute(.email, value: email)
        ]
        
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        
        do {
            let signUpResult = try await Amplify.Auth.signUp(
                username: username,
                password: password,
                options: options
            )
            
            if case let .confirmUser(deliveryDetails, _, userId) = signUpResult.nextStep {
                print("Delivery details \(String(describing: deliveryDetails)) for userId: \(String(describing: userId))")
            } else {
                print("SignUp Complete")
            }
            
        } catch let error as AuthError {
            print("An error occurred while registering a user \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
}
