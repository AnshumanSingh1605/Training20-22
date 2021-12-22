//
//  ViewController.swift
//  TestApp
//
//  Created by Joyce Lim on 21/12/21.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,RegistrationDelegate {
    
    func didCompleteRegistration(user: UserModel) {
        tableViewData.append(user)
    }
    
    
    var tableViewData : [UserModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    @IBAction func registrationAction(_ sender: Any){
        if let registrationVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "Registration") as? Registration{
            registrationVC.delegate = self
            self.navigationController?.pushViewController(registrationVC, animated: true)
            //self.present(registrationVC, animated: true, completion: nil)
        }
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var showRegistration: UIButton!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? CustomCell
        
        let user = tableViewData[indexPath.row]
        cell?.name.text = user.firstName + " " + user.lastName
        cell?.gender.text = user.gender
        cell?.age.text = user.age
        cell?.email.text = user.email

//        cell?.layer.masksToBounds = true
//        cell?.layer.cornerRadius = 5
//        cell?.layer.borderWidth = 2
//        cell?.layer.shadowOffset = CGSize(width: -1, height: 1)
//        
//        let borderColor: UIColor = .green
//        cell?.layer.borderColor = borderColor.cgColor
        
        cell?.insetsLayoutMarginsFromSafeArea = true
        cell?.layoutIfNeeded()
        return cell ?? UITableViewCell()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.dataSource = self
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserDefaultsManager.shared.getUsers(completion: { [weak self] users in
            self?.tableViewData = users ?? []
        })
    }
}

class CustomCell: UITableViewCell{
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var age: UILabel!

}
