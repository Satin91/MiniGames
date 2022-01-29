//
//  Dynamic.swift
//  MiniGames
//
//  Created by Артур on 21.01.22.
//

import Foundation

class Dynamic<T> {
    
    //MARK: Properties
    typealias Listener = (T) -> Void
    private var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    //MARK: Public funcs
    public func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    init(_ v: T) {
        self.value = v
    }
}
