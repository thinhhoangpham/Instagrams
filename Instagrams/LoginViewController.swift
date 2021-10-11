//
//  LoginViewController.swift
//  Instagrams
//
//  Created by Thinh Pham on 10/9/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: Any) {
        let user = usernameTextField.text!
        let password = passwordTextField.text!
        PFUser.logInWithUsername(inBackground: user, password: password) { user, error in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
              } else {
                print("Error: \(String(describing: error?.localizedDescription))")
              }
        }
    }
    @IBAction func signupButton(_ sender: Any) {
        let user = PFUser()
        user.username = usernameTextField.text
        user.password = passwordTextField.text
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
            
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
