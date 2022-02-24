//
//  AddUserViewController.swift
//  Mattproject
//
//  Created by Matthew Harris on 2/4/22.
//

import UIKit
protocol AddUserProtocolDelegate: AnyObject {
    func cancelAddingUser(_ controller: AddUserViewController)
        
    func saveUser(_ controller: AddUserViewController, user: User)
}

class AddUserViewController: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var email: UITextField!
    weak var addUserDelegate: AddUserProtocolDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelAddingUser(_ sender: Any) {
        addUserDelegate?.cancelAddingUser(self)
    }
    
    @IBAction func saveUser(_ sender: Any) {
        let user = User(id: 12, fname: firstName.text!, lName: lastName.text!, email: email.text!)
        
        addUserDelegate?.saveUser(self, user: user)
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
