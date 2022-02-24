//
//  LoginViewController.swift
//  Mattproject
//
//  Created by Matthew Harris on 2/1/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var passwordField: UITextField!
        
    @IBOutlet weak var emailField: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        loginView.layer.cornerRadius = 10

        loginView.layer.borderColor = UIColor.blue.cgColor

        loginView.layer.borderWidth = 2.0
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    @IBAction func loginUser(_ sender: Any) {
        
        if !Utilities.itsNetworkAvailable() {
            showAlert(title: "Network Error", messaage: "You dont have an internet connection. Please check your settings")
            return 
        }
        
        if emailField.text!.isEmpty || (passwordField.text!.isEmpty) {
            showAlert(title: "Field error", messaage: "Both fields need to be filled in")
            return
        }
        
        self.showIndicator(message: "Authenticating")
        
        let loginURL = URL(string: "https://reqres.in/api/login")
        
        var loginRequest = URLRequest(url: loginURL!, cachePolicy: .reloadIgnoringLocalCacheData,
        timeoutInterval: 30)
        
        loginRequest.httpMethod = "POST"
        loginRequest.addValue("application/json",
        forHTTPHeaderField: "Content-Type")
        let params = ["email": emailField.text, "password": passwordField.text] as! Dictionary<String,
        String>
        
        loginRequest.httpBody = try?JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        
        URLSession.shared.dataTask(with: loginRequest) { (data, response, error) in
            guard error == nil else
            {
                print(error as Any)
                return
            }
            
            let status  = (response as! HTTPURLResponse).statusCode
            guard status == 200 else
            {
                print(status)
                return
            }
            if let Data = data {
                let d = try! JSONSerialization.jsonObject(with: Data, options: .allowFragments) as?
                Dictionary<String, String>
                print(d!["token"]!)
                
                DispatchQueue.main.async {
                    self.getData(data: Data)
                }
                
                print(NSHomeDirectory())
            }
            
            
        }.resume()
        
            
        }
    
    func getData (data: Data) {
        self.hideIndicator()
        let response = try?JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, String>
        let token = response!["token"]
        print(token)
        
        UserDefaults.standard.setValue(token, forKey: "TOKEN")
        
        if let TOK = UserDefaults.standard.string(forKey: "TOKEN")
        {
            print(TOK)
        }
        
        self.performSegue(withIdentifier: "LoginSegue", sender: nil)
    }
    
    
    
    }
    
   
   


