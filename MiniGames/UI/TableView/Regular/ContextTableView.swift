//
//  ContextTableView.swift
//  MiniGames
//
//  Created by Артур on 21.01.22.
//

import Foundation
import UIKit

class ContextTableView: UITableView {
    
    
    //MARK: Properties
    private var contextData: [ContextDataModel] = []
    var selectRow: ((IndexPath)-> Void)?
    
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(data: [ContextDataModel]) {
        self.init()
        self.contextData = data
        setupTableView()
    }
    
    //MARK: Action funcs
    func selectRow(completion: ((IndexPath)-> Void)?){
        self.selectRow = completion
    }
    
    //MARK: Private funcs
    private func setupTableView() {
        self.separatorColor = .MGSaturatedImage.withAlphaComponent(0.4)
        self.separatorStyle = .none
        self.backgroundColor = .clear
        self.rowHeight = Insets.contextTableViewRowHeight
        self.register(UINib(nibName: "ContextTableViewCell", bundle: nil) , forCellReuseIdentifier: "ContextTableViewCell")
        self.dataSource = self
        self.delegate = self
    }
    
    private func setupCell(indexPath: IndexPath) -> ContextTableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: ContextTableViewCell.id) as! ContextTableViewCell
        let data = self.contextData[indexPath.row]
        cell.contextLabel.text = data.text
        cell.contextImage.image = UIImage(named: data.imageName)
        cell.selectionStyle = .none
        if indexPath.row == contextData.count - 1 {
            cell.separator.isHidden = true
        }
        return cell
    }
    
    private func registerContextCell() {
       
    }
}

extension ContextTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contextData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return setupCell(indexPath: indexPath)
    }
}
extension ContextTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectRow?(indexPath)
    }
}
