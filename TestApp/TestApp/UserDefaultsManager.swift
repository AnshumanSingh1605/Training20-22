//
//  UserDefaultsManager.swift
//  TestApp
//
//  Created by Joyce Lim on 21/12/21.
//

import Foundation


struct UserData : Codable {
    var users : [UserModel]
}
  
struct UserModel : Codable {
    var firstName : String
    var lastName : String
    var age : String
    var gender : String
    var email : String
}


class UserDefaultsManager {
    
    private init(){}
    public static let shared = UserDefaultsManager()
    
    let standard = UserDefaults.standard
    private let entryKey = "userModelKey"
    
    func saveUser(_ user : UserModel, completionHandler : @escaping () -> Void) {
        
        if let userData = retrieveUsersData() {
            let arr = userData.users + [user]
            let data = UserData(users: arr)
            self.saveUserData(data)
            completionHandler()
        } else {
            // no data present....
            // initial save...
            let userData = UserData(users: [user])
            self.saveUserData(userData)
            completionHandler()
        }
    }
    
    func getUsers(completion : @escaping ([UserModel]?) -> Void) {
        if let user = retrieveUsersData() {
            // if data exists..then we will return list users
            completion(user.users)
        } else {
            // if no data is found..we will nil
            completion(nil)
        }
    }
    
    private func saveUserData(_ userData : UserData) {
        do {
            let data = try JSONEncoder().encode(userData) // NSData or Data
            standard.set(data, forKey: entryKey)            
        } catch {
            print("unable to convert into data")
        }
    }
    
    private func retrieveUsersData() ->  UserData? {
        guard let userData = standard.value(forKey: entryKey) as? Data else {
            return nil
        }
        do {
            let user = try JSONDecoder().decode(UserData.self, from: userData)
            return user
        } catch {
            print("unable to parse value...")
        }
        return nil
    }
}

