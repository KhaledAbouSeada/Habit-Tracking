//
//  AddHabitVC+UITableView.swift
//  Habit Tracking App
//
//  Created by Khaled on 11/01/2025.
//
import UIKit

extension AddHabitVC: UITableViewDelegate,UITableViewDataSource {
    
    func setUpTableView() {
        habitsTableView.separatorStyle = .none
        habitsTableView.dataSource = self
        habitsTableView.delegate = self
        habitsTableView.register(UINib(nibName: "HabitTableViewCell", bundle: nil), forCellReuseIdentifier: "HabitTableViewCell")
        habitsTableView.rowHeight = UITableView.automaticDimension
        habitsTableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return addHabitViewModel.habitsData.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let date = addHabitViewModel.dates[section]
        return addHabitViewModel.habitsData[date]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HabitTableViewCell", for: indexPath) as? HabitTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        let date = addHabitViewModel.dates[indexPath.section]
        let habit = addHabitViewModel.habitsData[date]?[indexPath.row]
        cell.habitNameLabel.text = habit?.name
        DispatchQueue.main.async {
            cell.completionImageView.image = habit?.isCompleted ?? false ? UIImage(named: "check") : UIImage(named: "close")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return addHabitViewModel.dates[section] 
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let date = addHabitViewModel.dates[indexPath.section]
        guard let habit = addHabitViewModel.habitsData[date]?[indexPath.row] else { return }
        let newCompletionStatus = !habit.isCompleted
        
        addHabitViewModel.updateHabitCompletion(habit: habit, isCompleted: newCompletionStatus)
        
        // Show alert if completed
        if newCompletionStatus {
            addHabitViewModel.showCompletionAlert(controller: self, for: habit)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let date = addHabitViewModel.dates[indexPath.section]
                guard let habit = addHabitViewModel.habitsData[date]?[indexPath.row] else { return }
                // Delete the habit from Firebase
                addHabitViewModel.deleteHabitFromFirebase(habit: habit)
            }
        }
    
}
