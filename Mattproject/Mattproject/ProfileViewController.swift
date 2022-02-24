//
//  ProfileViewController.swift
//  Mattproject
//
//  Created by Matthew Harris on 2/3/22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    var user: User?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if user == nil {
            getUser()
        }
        
       
    }
    
    func getUser() {
        if(!Utilities.itsNetworkAvailable()) {
            showAlert(title: "No network", messaage: "No internet connection, please connect to continue")
        }
        showIndicator(message: "Getting User")
        let userURL = URL(string: BASE_URL + USER)!
        let userRequest = URLRequest(url: userURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
        
        URLSession.shared.dataTask(with: userRequest) {
            (data, response, error) in
            guard let Data = data, error==nil
            else{
                print(error as Any)
                return
            }
            if let httpStatus = (response as?
            HTTPURLResponse)
            {
                if(httpStatus.statusCode != 200)
                {
                    print(httpStatus.statusCode)
                    return
                }
            }
            
            DispatchQueue.main.async {
                self.extractData(data:Data)
            }
        }.resume()
    }
    
    
    func extractData(data: Data) {
        print("got Data")
        hideIndicator()
        let userData = try? JSONDecoder().decode(Single.self, from: data)
        self.user = userData!.data
        print(user?.first_name)
        
        
        
        firstNameLabel.text = user?.first_name ?? ""
        lastNameLabel.text = user?.last_name ?? ""
        profileImage.image =  Utilities.downloadImageWithUrl(url: user?.avatar ?? "")
       
        
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
