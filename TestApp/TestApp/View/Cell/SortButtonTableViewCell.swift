//
//  SortButtonTableViewCell.swift
//  TestApp
//
//  Created by student on 31.03.2025.
//

import UIKit
 
class SortButtonTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "SortButtonTableViewCell"
    var onTap: (() -> Void)?
    
    // MARK: - Private properties
 
    private let button: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Сортировать по алфавиту", for: .normal)
        return btn
    }()
    
    // MARK: - Init
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
 
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
 
    // MARK: - Actions
    
    @objc private func sortTapped() {
        onTap?()
    }
    
    // MARK: - Methods
 
    func updateTitle(isSortedByPrice: Bool) {
        let title = (isSortedByPrice == true) ? "Сортировать по алфавиту" : "Сортировать по цене"
        button.setTitle(title, for: .normal)
    }
}

// MARK: - Private methods

private extension SortButtonTableViewCell {
    
    func setupUI() {
        self.selectionStyle = .none
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        button.addTarget(self, action: #selector(sortTapped), for: .touchUpInside)
    }
    
}
