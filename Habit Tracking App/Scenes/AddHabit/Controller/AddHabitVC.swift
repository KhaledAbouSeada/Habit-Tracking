//
//  AddHabitVC.swift
//  Habit Tracking App
//
//  Created by Khaled on 11/01/2025.
//

import UIKit

class AddHabitVC: UIViewController {
    
    @IBOutlet weak var habitsTableView: UITableView!
    
    var addHabitViewModel = AddHabitViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        addHabitViewModel.listenForHabits(habitsTableView)
        
    }
    
    @IBAction func onAddHabitButtonPressed(_ sender: Any) {
        addHabitViewModel.alertWithTextField(self, "New Habit", "Enter your habit name") { text in
            if text == "" {
                return
            }else{
                self.addHabitViewModel.sendHabit(habitName: text ?? "", isCompleted: false)
            }
        }
    }
}
