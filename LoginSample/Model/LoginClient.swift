//
//  LoginClient.swift
//  LoginSample
//
//  Created by Siya Dagwar on 05/08/21.
//

import Foundation

var json = """
{
    "email": "test@luxpmsoft.com",
    "password": "test1234!"
}
""".data(using: .utf8)!

class LoginClient {
    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        // create a JSON decoder
        let decoder = JSONDecoder()
        
        // decode the JSON into your model object and print the result
        do {
            let loginResponse = try decoder.decode(Login.self, from: json)
            if username == loginResponse.email && password == loginResponse.password {
                completion(true, nil)
            } else {
                completion(false, nil)
            }
            
        } catch {
            print(error)
            completion(false, error)
        }
    }
}

extension LoginClient {
    class func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var isSucess = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                isSucess = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            isSucess = false
        }
        
        return  isSucess
    }
}
