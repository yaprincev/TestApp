//
//  ProductViewModelProtocol.swift
//  TestApp
//
//  Created by student on 02.04.2025.
//

import Foundation

protocol ProductListViewModelProtocol: AnyObject {
    var products: [Product] { get }
    var isSortedByPrice: Bool { get }
    var onUpdate: (() -> Void)? { get set }
    
    func toggleSorting()
    func product(at indexPath: IndexPath) -> Product?
}
