//
//  ViewController.swift
//  Sfera-test-task
//
//  Created by Marcos Vicente on 08.09.2021.
//

import UIKit

struct MyTimer {
    var id = UUID().uuidString
    var name: String
    var createdAt: TimeInterval
    var duration: TimeInterval
}

class ViewController: UIViewController {

    private var tableView: UITableView!
    
    private let cellId = "cellId"
    private let firstSectionTitle = "Добавление таймаров"
    private let secondSectionTitle = "Таймеры"
    
    var timers: [MyTimer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.title = "Мульти таймер"
        
        configureTableView()
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellId)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return self.firstSectionTitle
        }
        return self.secondSectionTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return timers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? InputSectionTableViewCell ?? InputSectionTableViewCell(style: .default, reuseIdentifier: cellId)
            
            cell.tapHandler = { [weak self] in
                
                if let name = cell.nameTextField.text,
                   let timerString = cell.timeTextField.text,
                   let duration = TimeInterval(timerString) {
                    
                    let myTimer = MyTimer(name: name, createdAt: Date().timeIntervalSince1970, duration: duration)
                    
                    self?.timers.append(myTimer)
                    self?.timers.sort { $0.duration > $1.duration }
                    self?.tableView.reloadData()
                }
            }
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? TimerTableViewCell ?? TimerTableViewCell(style: .value1, reuseIdentifier: cellId)
        
        cell.delegate = self
        cell.configureCell(withCountdownTimer: timers[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func countdownHasFinished(forTimerWith id: String) {
        if timers.count > 0 {
            timers.removeAll { $0.id == id }
            tableView.reloadData()
        }
    }
}
