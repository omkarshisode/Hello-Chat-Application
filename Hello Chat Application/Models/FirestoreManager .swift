//
//  FirestoreManager .swift
//  Hello Chat Application
//
//  Created by Omkar Shisode on 05/10/24.
//

import Foundation
import FirebaseFirestore

class FirestoerManager {
    
    // Create shared instance of the firestore manager
        static let manager = FirestoerManager()
    
    // firestore data base
    let db:Firestore
    
    private init() {
        self.db = Firestore.firestore()
    }
    
    
    // Helper method to get and store data into the firestore
//    func getUser()
}
