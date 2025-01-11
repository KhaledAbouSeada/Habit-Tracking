//
//  AddHabitVC.swift
//  Habit Tracking App
//
//  Created by Khaled on 11/01/2025.
//

import UIKit
import FirebaseDatabase
import FirebaseFirestore

class AddHabitVC: UIViewController {
    
    @IBOutlet weak var habitsTableView: UITableView!
    
    var habitsData:[String: [HabitModel]] = [:]
    var dates: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        
    }
    
    
    @IBAction func onAddHabitButtonPressed(_ sender: Any) {
        
    }
}
