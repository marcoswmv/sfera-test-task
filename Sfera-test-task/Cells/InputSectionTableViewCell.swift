//
//  InputSectionTableViewCell.swift
//  Sfera-test-task
//
//  Created by Marcos Vicente on 08.09.2021.
//

import UIKit

class InputSectionTableViewCell: UITableViewCell {

    var nameTextField: UITextField!
    var timeTextField: UITextField!
    private var addButton: UIButton!
    
    private var labelsStackView: UIStackView!
    
    var tapHandler: () -> Void = { }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        nameTextField = UITextField(frame: .zero)
        timeTextField = UITextField(frame: .zero)
        addButton = UIButton(frame: .zero)
        labelsStackView = UIStackView(frame: .zero)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviewsToContentView()
        configureLabels()
        configureLabelsStackView()
        configureAddButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviewsToContentView() {
        contentView.addSubview(nameTextField)
        contentView.addSubview(timeTextField)
        contentView.addSubview(labelsStackView)
        contentView.addSubview(addButton)
    }
    
    private func configureLabels() {
        nameTextField.placeholder = "Название таймера"
        nameTextField.font = UIFont.systemFont(ofSize: 13)
        nameTextField.borderStyle = .roundedRect
        
        timeTextField.placeholder = "Время в секундах"
        timeTextField.font = UIFont.systemFont(ofSize: 13)
        timeTextField.borderStyle = .roundedRect
    }
    
    private func configureLabelsStackView() {
        labelsStackView.axis = .vertical
        labelsStackView.distribution = .fill
        labelsStackView.spacing = 15
        
        labelsStackView.addArrangedSubview(nameTextField)
        labelsStackView.addArrangedSubview(timeTextField)
        
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            labelsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            labelsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -110),
            labelsStackView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -30)
        ])
    }
    
    private func configureAddButton() {
        
        addButton.setTitle("Добавить", for: .normal)
        addButton.setTitleColor(.systemBlue, for: .normal)
        addButton.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        addButton.layer.cornerRadius = 12
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            addButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        addButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }
    
    @objc private func handleTap() {
        tapHandler()
    }
}
