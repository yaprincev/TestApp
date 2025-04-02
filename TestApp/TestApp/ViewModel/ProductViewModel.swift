//
//  ProductViewModel.swift
//  TestApp
//
//  Created by student on 31.03.2025.
//

import Foundation

class ProductListViewModel: ProductListViewModelProtocol {
    
    // MARK: - Private properties
    
    private var allProducts: [Product] = []
    
    // MARK: - Properties
    
    var products: [Product] = [] {
        didSet { onUpdate?() }
    }
    var isSortedByPrice = true
    var onUpdate: (() -> Void)?
 
    // MARK: - Init
    
    init() {
        loadProducts()
    }
 
    // MARK: - Methods
 
    func toggleSorting() {
        isSortedByPrice.toggle()
        sortProducts()
    }
 
    func product(at indexPath: IndexPath) -> Product? {
        guard indexPath.row > 0 else { return nil }
        return products[indexPath.row - 1]
    }
 

}

// MARK: - Private metods

private extension ProductListViewModel {
    
    func sortProducts() {
        products = isSortedByPrice
        ? allProducts.sorted { $0.price < $1.price }
        : allProducts.sorted { $0.name < $1.name }
    }
    
    func loadProducts() {
        let json = """
        [
            {"id": "tovar1", "name": "Товар 1", "description": "Это какой-то очень чудесный товар для того, чтобы вы его купили", "price": 100},
            {"id": "car", "name": "Машинка с названием, которое скорее всего не влезет в одну строку на очень маленьком экране iPhone", "description": "Зато описание у этой машинки очень даже короткое", "price": 10000.23},
            {"id": "flower", "name": "Букет цветов", "description": "В нем и гвоздики, и герани, и даже чуть цветов акации. Пахнет просто замечательно! И долго радует глаз...", "price": 77.24},
            {"id": "eda", "name": "Набор на ужин", "description": "Колбаса и немного хлеба. Возможно, если очень повезет, будет еще и масло. Обязательно будет и черный чай с сахаром из стакана в подстаканнике (но его вы купите сами).", "price": 77.24}
        ]
        """
        
        if let data = json.data(using: .utf8),
           let decodedProducts = try? JSONDecoder().decode([Product].self, from: data) {
            allProducts = decodedProducts
            sortProducts()
        }
    }
    
}
