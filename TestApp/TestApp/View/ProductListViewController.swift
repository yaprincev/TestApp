//
//  ProductListViewController.swift
//  TestApp
//
//  Created by student on 31.03.2025.
//

import UIKit
 
class ProductListViewController: UIViewController {
    
    // MARK: - Private properties
 
    private let tableView = UITableView()
    private var viewModel: ProductListViewModelProtocol
 
    // MARK: - Init
    
    init(viewModel: ProductListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
 
}
 
// MARK: - UITableViewDelegate & UITableViewDataSource

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SortButtonTableViewCell.identifier, for: indexPath) as! SortButtonTableViewCell
            cell.onTap = { [weak self] in
                self?.viewModel.toggleSorting()
                cell.updateTitle(isSortedByPrice: self?.viewModel.isSortedByPrice ?? true)
            }
            return cell
        }
        let product = viewModel.products[indexPath.row - 1]
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as! ProductTableViewCell
        cell.configure(with: product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let product = viewModel.product(at: indexPath) else { return }
        let popup = PopupView()
        popup.configure(with: product)
        popup.animateShow(in: view)
    }
    
}

// MARK: - Private methods

private extension ProductListViewController {
    
    func setupUI() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SortButtonTableViewCell.self, forCellReuseIdentifier: "SortButtonTableViewCell")
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductTableViewCell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupBindings() {
        viewModel.onUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
}
