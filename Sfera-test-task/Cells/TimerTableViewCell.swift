//
//  TimerTableViewCell.swift
//  Sfera-test-task
//
//  Created by Marcos Vicente on 08.09.2021.
//

import UIKit

class TimerTableViewCell: UITableViewCell {
    
    var stopTimerButton: UIButton!
    
    var timer: Timer?
    var delegate: ViewController?
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        stopTimerButton = UIButton(frame: .zero)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureStopTimerButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func configureCell(withCountdownTimer countdownTimer: MyTimer) {
        self.textLabel?.text = countdownTimer.name
        self.detailTextLabel?.text = calculateTimeRemaining(countdownTimer: countdownTimer).formattedRemainingTime()
        
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
                guard let self = self else { return }
                
                let newTime = self.calculateTimeRemaining(countdownTimer: countdownTimer)
                
                if newTime <= 0 {
                    self.delegate?.countdownHasFinished(forTimerWith: countdownTimer.id)
                    timer.invalidate()
                } else {
                    self.detailTextLabel?.text = newTime.formattedRemainingTime()
                }
            }
        }
    }
    
    func calculateTimeRemaining(countdownTimer: MyTimer) -> Double {
        return Double((countdownTimer.createdAt + countdownTimer.duration) - Date().timeIntervalSince1970)
    }
    
    func configureStopTimerButton() {
        
        contentView.addSubview(stopTimerButton)
        
        stopTimerButton.setTitle("Остановить", for: .normal)
        stopTimerButton.setTitleColor(.red, for: .normal)
        
        stopTimerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stopTimerButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stopTimerButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        stopTimerButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }
    
    @objc private func handleTap() {
        timer?.invalidate()
    }
}
