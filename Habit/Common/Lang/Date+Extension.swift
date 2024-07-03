//
//  Date+Extension.swift
//  Habit
//
//  Created by Rafael Jáber on 03/07/24.
//

import Foundation

extension Date {
  
  func toString(destPattern dest: String) -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = dest
    
    return formatter.string(from: self)
  }
  
}
