//
//  TableViewController.swift
//  CheckList
//
//  Created by Sumona Salma on 4/13/19.
//  Copyright © 2019 Sumona Salma. All rights reserved.
//

import UIKit

extension SearchController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wikiList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .default, reuseIdentifier: tableIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: tableIdentifier, for: indexPath) as! SearchListCell
        if wikiList.isEmpty == false {
            cell.info = wikiList[indexPath.item]
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let total = (self.wikiList.count )
        if (indexPath.item + 1) == (self.wikiList.count ){

            self.limit = Int(self.limit+20)
            if total < limit {
                self.fetchData(limit:self.limit)
            }
        }
    }
}

extension SearchController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        let mv = ModalViewController()
        if wikiList.isEmpty == false {
            mv.data = wikiList[indexPath.item] 
        }
        present(mv, animated: true, completion: { })
    }
}
