//
//  ProductTableViewCell.swift
//  TestApp
//
//  Created by student on 31.03.2025.
//

import UIKit
 
class ProductTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "ProductTableViewCell"
    
    // MARK: - Private properties
 
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    
    // MARK: - Init
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
 
    func configure(with product: Product) {
        nameLabel.text = product.name
        priceLabel.attributedText = formatPrice(product.price)
    }
 
}

// MARK: - Private methods

private extension ProductTableViewCell {
    
    func setupUI() {
        self.selectionStyle = .none
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textColor = .black
 
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
 
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -90),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func formatPrice(_ price: Double) -> NSAttributedString {
        let priceString = String(format: "%.2f ₽", price)
        let attributedString = NSMutableAttributedString(string: priceString)
        attributedString.addAttribute(.foregroundColor, value: UIColor.gray, range: NSRange(location: priceString.count - 1, length: 1))
        return attributedString
    }
    
}
