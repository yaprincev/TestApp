//
//  PopapView.swift
//  TestApp
//
//  Created by student on 31.03.2025.
//

import UIKit
 
class PopupView: UIView {
    
    // MARK: - Private properties
 
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let containerView = UIView()
    private var initialCenter: CGPoint = .zero
 
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
 
    @objc private func handleBackgroundTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self)
        if !containerView.frame.contains(location) {
            animateHide()
        }
    }
 
    @objc private func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
 
        switch sender.state {
        case .began:
            initialCenter = containerView.center
        case .changed:
            let newY = max(initialCenter.y, initialCenter.y + translation.y)
            containerView.center = CGPoint(x: initialCenter.x, y: newY)
        case .ended, .cancelled:
            let velocity = sender.velocity(in: self)
            let movedDistance = containerView.center.y - initialCenter.y
 
            if movedDistance > 150 || velocity.y > 500 {
                animateDismiss()
            } else {
                animateRestore()
            }
        default:
            break
        }
    }
    
    // MARK: - Methods
    
    func configure(with product: Product) {
        titleLabel.text = product.name
        priceLabel.attributedText = formatPrice(product.price)
        descriptionLabel.text = product.description
    }
 
    func animateShow(in view: UIView) {
        self.alpha = 0
        view.addSubview(self)
        self.frame = view.bounds
        containerView.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
 
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
            self.alpha = 1
            self.containerView.transform = .identity
        }
    }
 
}

// MARK: - Private methods

private extension PopupView {
    
    func setupUI() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
 
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 16
        containerView.clipsToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
 
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
 
        priceLabel.font = UIFont.boldSystemFont(ofSize: 16)
        priceLabel.textAlignment = .center
        priceLabel.textColor = .black
 
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .darkGray
 
        containerView.addSubview(titleLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(descriptionLabel)
        addSubview(containerView)
 
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
 
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 300),
 
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
 
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            priceLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
 
            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
 
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap))
        addGestureRecognizer(tapGesture)
 
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        containerView.addGestureRecognizer(panGesture)
    }
    
    func animateRestore() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
            self.containerView.center = self.initialCenter
        }
    }
    
    func animateDismiss() {
        UIView.animate(withDuration: 0.3, animations: {
            self.containerView.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    func animateHide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    func formatPrice(_ price: Double) -> NSAttributedString {
        let priceString = String(format: "%.2f ₽", price)
        let attributedString = NSMutableAttributedString(string: priceString)
        attributedString.addAttribute(.foregroundColor, value: UIColor.gray, range: NSRange(location: priceString.count - 1, length: 1))
        return attributedString
    }
    
}
