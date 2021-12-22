//
//  Registration.swift
//  TestApp
//
//  Created by Joyce Lim on 21/12/21.
//

import Foundation
import UIKit


protocol RegistrationDelegate: AnyObject {
    func didCompleteRegistration(user : UserModel)
}

class Registration: UIViewController {
    
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var email: UITextField!
    weak var delegate: RegistrationDelegate?
    @IBOutlet weak var register: UIButton!
    
    @IBAction func registerButtonPressed(_ sender:UIButton){
        print("User Registered")
        //registerUser()
        let user = UserModel(firstName: firstName.text ?? "firstName", lastName: lastName.text ?? "lastName", age: age.text ?? "age" ,
                             gender: gender.text ?? "gender", email: email.text ?? "email")
        saveUser(user: user)
    }
    
    func registerUser() {
        let user = UserModel(firstName: firstName.text ?? "firstName", lastName: lastName.text ?? "lastName", age: age.text ?? "age" ,
                             gender: gender.text ?? "gender", email: email.text ?? "email")
        delegate?.didCompleteRegistration(user: user)
    }
    
    func saveUser(user : UserModel) {
        UserDefaultsManager.shared.saveUser(user) {
            // now we know....
            // our registration completed...// saving is completed...
            self.navigationController?.popToRootViewController(animated: true)
            //self.dismiss(animated: true, completion: nil)
        }
    }
    

    

    
    
    
    
    

}

//
//class UserDefaultsManager {
//
//
//
//
//public let shared = UserDefaultsManager()
//
//
//
//let standard = UserDefaults.standard
//
//private let entryKey = "userModelKey"
//
//
//
//    func saveUser(_ user : UserModel) {
//
//
//
//        if let userData = retrieveUsersData() {
//
//            let arr = userData.users + [user]
//
//            let data = UserData(users: arr)
//
//            self.saveUserData(data)
//
//        }​​​​​​​​​ else {
//
//// no data present....
//
//// initial save...
//
//            let userData = UserData(users: [user])
//
//            self.saveUserData(userData)
//
//        }
//
//    }
//
//
//
//    func getUsers() -> [UserModel]? {
//
//        if let user = retrieveUsersData() {
//
//            return user.users
//
//        }
//
//
//
//        return nil
//
//    }
//
//
//
//    private func saveUserData(_ userData : UserData) {
//
//        do {
//
//            let data = try JSONEncoder().encode(userData)
//
//            standard.set(data, forKey: entryKey)
//
//        }​​​​​​​​​ catch {
//
//print("unable to convert into data")
//
//        }
//
//    }
//
//
//
//private func retrieveUsersData() ->  UserData? {
//
//        guard let userData = standard.value(forKey: entryKey) as? Data else {
//
//            return nil
//
//        }
//
//        do {
//
//            let user = try JSONDecoder().decode(UserData.self, from: userData)
//
//            return user
//
//        }​​​​​​​​​ catch {
//
//print("unable to parse value...")
//
//        }
//
//        return nil
//
//    }
//
//}
//
//
//
