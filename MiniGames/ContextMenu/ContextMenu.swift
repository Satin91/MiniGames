//
//  ContextMenu.swift
//  MiniGames
//
//  Created by Артур on 21.01.22.
//

import Foundation
import UIKit
 

protocol ContextMenuDelegate {
    var contextData: [ContextDataModel] { get set }
    func didTappedContextCell(index: IndexPath)
}

class ContextMenu: UIView {
    
    //MARK: Properties
    var tableView: ContextTableView!
    var completion: ((IndexPath) -> Void)?
    private var holderView: UIView?
    private var contextData = [ContextDataModel]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init(holderView: UIView, data: [ContextDataModel]) {
        self.init()
        self.holderView = holderView
        self.contextData = data
        setupView()
        setupTableView(data: data)
        tappedOnCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Action funcs
    func show(onView: UIView, completion: ((IndexPath) -> Void)?) {
        self.completion = completion
        self.accessibilityIdentifier = "ContextMenu"
        self.standartShow(onView: onView)
    }
    
    
    //MARK: Private funcs
    private func setupView() {
        guard let holderView = holderView else { return }
        self.frame = CGRect(x: holderView.frame.origin.x, y: holderView.frame.origin.y + holderView.bounds.height + Insets.textIndent, width: 140, height: CGFloat(contextData.count) * Insets.contextTableViewRowHeight)
        self.backgroundColor = .white
        self.layer.cornerRadius = Insets.contextCornerRadius
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 12
        self.layer.shadowOpacity = 0.15
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
    }
    
    private func setupTableView(data: [ContextDataModel]) {
        tableView = ContextTableView(data: data)
       
        tableView.frame = self.bounds
        tableView.layer.cornerRadius = Insets.contextCornerRadius
        addSubview(tableView)
    }
    
    private func tappedOnCell() {
        tableView.selectRow { [weak self] index in
            self?.completion?(index)
            self?.removeFromSuperview()
        }
    }
}


