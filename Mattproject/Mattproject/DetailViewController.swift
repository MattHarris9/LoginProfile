//
//  DetailViewController.swift
//  Mattproject
//
//  Created by Matthew Harris on 2/4/22.
//

import UIKit


class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var userImageView: UIImageView!
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userEmailLabel: UILabel!
    
    var user: User?
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        userNameLabel.text = user!.first_name + " " + user!.last_name
        userEmailLabel.text = user!.email
        userImageView.image =  Utilities.downloadImageWithUrl(url: user!.avatar)
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
