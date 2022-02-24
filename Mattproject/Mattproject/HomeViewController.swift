//
//  HomeViewController.swift
//  Mattproject
//
//  Created by Matthew Harris on 2/4/22.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddUserProtocolDelegate {
    
    @IBOutlet weak var userTableView: UITableView!
    
    var users = [User]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        userTableView.dataSource = self
        userTableView.delegate = self
//        getUsersList()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if users.isEmpty {getUsersList()}
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(users.count)
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!
        HomeTableViewCell
        
        let rowData = users[indexPath.row]
        cell.nameLabel.text = "\(users[indexPath.row].first_name) \(users[indexPath.row].last_name)"
        cell.emailLabel.text = rowData.email
        cell.customImage.image = Utilities.downloadImageWithUrl(url: rowData.avatar)
        
        
        
        return cell
    }
    
    func getUsersList() {
        if(!Utilities.itsNetworkAvailable()) {
            showAlert(title: "No network", messaage: "No internet connection, please connect to continue")
        }
        showIndicator(message: "Getting Users")
        let userURL = URL(string: BASE_URL + USERS)!
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
        let users = try? JSONDecoder().decode(Result.self, from: data)
        print(users?.total)
        self.users = users!.data
        
        userTableView.reloadData()
        
    }
    

   
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier
        identifier: String, sender: Any?) -> Bool {
        if userTableView.indexPathForSelectedRow?.row == 7 {
            return false
        }
        return true
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        
        if segue.identifier == "UserDetailSegue" {
            var userDetailViewController = segue.destination as!
            DetailViewController
            
            var indexPath = userTableView.indexPathForSelectedRow
            
            var userToSendToSecondView = users[indexPath!.row]
            
            userDetailViewController.user = userToSendToSecondView
        }
        
        if segue.identifier == "AddUserSegue"
        {
            let addUserController = segue.destination as!
            AddUserViewController
            addUserController.addUserDelegate = self
        }
        
    }
    
    func cancelAddingUser(_ controller: AddUserViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    func saveUser(_ controller: AddUserViewController, user: User)
    {
        //users.append(<#T##Element#>)
        users.insert(user, at: 0)
        userTableView.reloadData()
        controller.dismiss(animated: true, completion: nil)
        
    }
    

}
