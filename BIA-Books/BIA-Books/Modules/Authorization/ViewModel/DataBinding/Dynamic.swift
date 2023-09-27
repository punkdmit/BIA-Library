//
//  Dynamic.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 16.02.2023.
//

import Foundation

class Dynamic <T> {
    typealias Listener = (T) -> Void
    
    // Хранит замыкание слушателя, которое будет вызываться при изменении значения
    private var listener : Listener?
    
    // Позволяет привязать слушателя к объекту Dynamic
    func bind(_ listener : Listener?) {
        self.listener = listener
    }
    
    // Когда значение устанавливается, код вызывает замыкание слушателя и передает новое значение
    var value : T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v : T) {
        value = v
    }
}


