//
//  SessionManager.swift
//  MedBook
//
//  Created by Rhytthm Mahajan on 14/08/23.
//

import Foundation
import SwiftUI

final class SessionManager: ObservableObject {
    
    @AppStorage("USER_KEY") private var mail = ""
    @AppStorage("PASSWORD_KEY") private var pass = ""
    
    enum CurrentState {
        case loggedIn
        case loggedOut
    }
    
    @Published private (set) var currentState: CurrentState?
    
    func validateCredentials(email: String? , password: String?) -> String {
        if mail.isEmpty || pass.isEmpty{
            return "No Credentials Found"
        }else{
            if email != mail {
                return "Incorrect email"
            }else if password != pass{
                return "Incorrect password"
            }else{
                return ""
            }
        }
    }
    
    func setupCredentials(email: String? , password: String?){
        if let email = email{
            mail = email
        }
        if let password = password{
            pass = password
        }
    }
    
    func signIn() {
        currentState = .loggedIn
        print("signed In")
    }
    
    func signOut () {
        currentState = .loggedOut
        print("signed Out")
    }
    
}
