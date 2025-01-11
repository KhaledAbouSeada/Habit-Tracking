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
        return habitsData.keys.count  // Number of unique dates
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let date = dates[section]
        return habitsData[date]?.count ?? 0  // Number of habits for that date
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HabitTableViewCell", for: indexPath) as? HabitTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        let date = dates[indexPath.section]
        let habit = habitsData[date]?[indexPath.row]
        cell.habitNameLabel.text = habit?.name
        DispatchQueue.main.async {
            cell.completionImageView.image = habit?.isCompleted ?? false ? UIImage(named: "check") : UIImage(named: "close")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dates[section]  // Display the date as the section header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let date = dates[indexPath.section]
        guard let habit = habitsData[date]?[indexPath.row] else { return }
        let newCompletionStatus = !habit.isCompleted
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let date = dates[indexPath.section]
                guard let habit = habitsData[date]?[indexPath.row] else { return }
                
            }
        }
    
}
