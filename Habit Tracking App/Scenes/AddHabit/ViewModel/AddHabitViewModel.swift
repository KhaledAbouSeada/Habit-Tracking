//
//  AddHabitViewModel.swift
//  Habit Tracking App
//
//  Created by Khaled on 11/01/2025.
//

import UIKit
import FirebaseDatabase
import FirebaseFirestore

class AddHabitViewModel: UIViewController {
    
    var habitsData:[String: [HabitModel]] = [:]
    var dates: [String] = []
    
    /// function for popup alert with textfield
    /// - Parameters:
    ///   - controller: controller that alert going to present from
    ///   - title: alert title
    ///   - message: alert message
    ///   - completion: it returns the text that the user entered
    func alertWithTextField(_ controller: UIViewController,  _ title: String, _ message: String, completion: @escaping (_ text: String?) -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter your text here"
        }
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak alert] _ in
            let textField = alert?.textFields?[0]
            completion(textField?.text)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
    
    /// popup alert for success completing the habit
    /// - Parameters:
    ///   - controller: controller that alert going to present from
    ///   - habit: the habit that the user completed
    func showCompletionAlert(controller:UIViewController, for habit: HabitModel) {
        let alert = UIAlertController(title: "Congratulations! 😍", message: "You completed your habit: \(habit.name) for \(habit.date)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
    
    /// Posting New Habit To Firebase Database
    /// - Parameters:
    ///   - habitName: the new habit name
    ///   - isCompleted: is it done or not for the exact date
    func sendHabit(habitName: String, isCompleted: Bool) {
        let db = Database.database().reference()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"  // Format for the date
        let currentDate = dateFormatter.string(from: Date())
        let habitData: [String: Any] = [
            "name": habitName,
            "isCompleted": isCompleted,
            "date": currentDate
        ]
        // Push a new habit under the "habits" node
        db.child("habits").child(currentDate).childByAutoId().setValue(habitData) { error, _ in
            if let error = error {
                print("Error sending habit: \(error.localizedDescription)")
            } else {
                print("Habit sent successfully!")
            }
        }
    }
    
    /// function to listen for the habits node in database
    /// - Parameter tableView: tableview wanted to reload
    func listenForHabits(_ tableView: UITableView) {
        let db = Database.database().reference()
        db.child("habits").observe(.value) { snapshot in
            
            var categorizedHabits: [String: [HabitModel]] = [:]
            
            for child in snapshot.children {
                if let dateSnapshot = child as? DataSnapshot {
                    let date = dateSnapshot.key
                    var dailyHabits: [HabitModel] = []
                    
                    for habitChild in dateSnapshot.children {
                        if let habitSnapshot = habitChild as? DataSnapshot,
                           let habitData = habitSnapshot.value as? [String: Any],
                           let name = habitData["name"] as? String,
                           let isCompleted = habitData["isCompleted"] as? Bool {
                            let habitKey = habitSnapshot.key
                            
                            let habit = HabitModel(key: habitKey, name: name, isCompleted: isCompleted, date: date)
                            dailyHabits.append(habit)
                        }
                    }
                    
                    categorizedHabits[date] = dailyHabits
                }
            }
            
            self.habitsData = categorizedHabits
            self.dates = Array(categorizedHabits.keys).sorted()
            
            DispatchQueue.main.async {
                tableView.reloadData()  // Replace with your table view reference
            }
        }
    }
    
    /// function to update the completion Bool value of habit
    /// - Parameters:
    ///   - habit: the habit i want to change its completion status
    ///   - isCompleted: completion status
    func updateHabitCompletion(habit: HabitModel, isCompleted: Bool) {
        let db = Database.database().reference()
        
        // Use the habit's date and unique key for the update
        let date = habit.date
        let habitKey = habit.key
        
        db.child("habits").child(date).child(habitKey).updateChildValues(["isCompleted": isCompleted]) { error, _ in
            if let error = error {
                print("Error updating habit: \(error.localizedDescription)")
            } else {
                print("Habit updated successfully!")
            }
        }
    }
    
    /// function to delete the habit you want
    /// - Parameter habit: the habit you want to delete
    func deleteHabitFromFirebase(habit: HabitModel) {
        let db = Database.database().reference()
        
        // Use the habit's date and unique key to delete it
        let date = habit.date
        let habitKey = habit.key
        
        db.child("habits").child(date).child(habitKey).removeValue { error, _ in
            if let error = error {
                print("Error deleting habit: \(error.localizedDescription)")
            } else {
                print("Habit deleted successfully!")
            }
        }
    }
    
}
