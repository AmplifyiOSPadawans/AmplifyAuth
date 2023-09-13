//
//  AuthHelper.swift
//  AmplifyAuth
//
//  Created by David Perez Espino on 06/09/23.
//

import Amplify
import UIKit


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
    
    func confirmSignUp(for username: String, with confirmationCode: String) async -> Bool {
        do {
            let confirmSignUpResult = try await Amplify.Auth.confirmSignUp(
                for: username,
                confirmationCode: confirmationCode
            )
            print("Confirm sign up result completed: \(confirmSignUpResult.isSignUpComplete)")
            if confirmSignUpResult.isSignUpComplete {
                return true
            }
        } catch let error as AuthError {
            print("An error occurred while confirming sign up \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
        return false
    }
    
    func signIn(username: String, password: String) async -> Bool {
        do {
            let signInResult = try await Amplify.Auth.signIn(
                username: username,
                password: password
            )
            if signInResult.isSignedIn {
                print("Sign in succeeded")
                return true
            }
        } catch let error as AuthError {
            print("Sign in failed \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
        return false
    }
    
    func socialSignInWithWebUI(with provider: AuthProvider, in window: UIWindow) async -> Bool {
        do {
            let signInResult = try await Amplify.Auth.signInWithWebUI(for: provider, presentationAnchor: window)
            if signInResult.isSignedIn {
                print("Sign in succeeded")
                return true
            }
        } catch let error as AuthError {
            print("Sign in failed \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
        return false
    }
}
