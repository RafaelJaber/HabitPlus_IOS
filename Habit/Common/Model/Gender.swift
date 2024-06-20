//
//  Gender.swift
//  Habit
//
//  Created by Rafael Jáber on 20/06/24.
//

import Foundation


enum Gender: String, CaseIterable, Identifiable{
    case male = "Masculindo"
    case female = "Feminino"
    
    var id: String {
        self.rawValue
    }
}
