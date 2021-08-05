//
//  ViewController.swift
//  LoginSample
//
//  Created by Siya Dagwar on 04/08/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        let isEmailValidate = checkEmailValidation(emailTextField.text)
        if checkEmailPasswordEmpty(emailTextField.text, passwordTextField.text) {
            if isEmailValidate {
                LoginClient.login(username: emailTextField.text!, password: passwordTextField.text!, completion: handleSessionResponse(success:error:))
            } else {
                showLoginFailure(message: "The format is wrong")
            }
        } else {
            showLoginFailure(message: "Email or Password is empty")
        }
    }
    
    func handleSessionResponse(success: Bool, error: Error?) {
            if success {
                //performSegue(withIdentifier: "homeScreen", sender: nil)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self.navigationController?.pushViewController(vc, animated: true)

            } else {
                if let error = error {
                    showLoginFailure(message: error.localizedDescription)
                } else {
                    showLoginFailure(message: "Email or password is incorrect")
                }
                
            }
        }
    
    func showLoginFailure(message: String) {
        let alertTitle = "Login Failed"
        let alertMessage = message
        let alertOkButtonText = "OK"

        if #available(iOS 8, *) {
            let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            //We add buttons to the alert controller by creating UIAlertActions:
            let actionOk = UIAlertAction(title: alertOkButtonText,
                style: .default,
                handler: nil)

            alertController.addAction(actionOk)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            let alertView = UIAlertView(title: alertTitle, message: alertMessage, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: alertOkButtonText)
            alertView.show()
        }
    }
    
    func checkEmailValidation(_ email: String?) -> Bool {
        guard let email = email else { return false }
        
        return LoginClient.isValidEmailAddress(emailAddressString: email)
    }
    
    func checkEmailPasswordEmpty(_ email: String?, _ password: String?) -> Bool {
        
        if let email = email {
            if let password = password {
                if email.isEmpty && password.isEmpty {
                    return false
                }
            }
        }
        
        return true
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        //textField code

        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            loginTapped(loginButton)
        }
        
        return true
    }
}
