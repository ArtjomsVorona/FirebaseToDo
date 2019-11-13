//
//  User.swift
//  FirebaseToDo
//
//  Created by Artjoms Vorona on 12/11/2019.
//  Copyright © 2019 Artjoms Vorona. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

class Users {
    let uid: String
    let email: String
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email!
    }
}
