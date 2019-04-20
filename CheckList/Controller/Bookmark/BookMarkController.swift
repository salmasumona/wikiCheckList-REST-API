//
//  BookMarkController.swift
//  CheckList
//
//  Created by Sumona Salma on 4/14/19.
//  Copyright © 2019 Sumona Salma. All rights reserved.
//

import UIKit

class BookMarkController: UIViewController {
    
    var bmTableView = CommonUIContainer.shared.commonTableView()
    let tableIdentifier = "cell"
    var bookmarkList = [PageData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        print("test")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.tabBarController?.navigationItem.title = "Bookmark"
        do {
            
            let data = UserDefaults.standard.object(forKey: "bookmark")
            let jsonDecoder = JSONDecoder()
            guard let bookmarkdata = data else{return}
            bookmarkList = try jsonDecoder.decode([PageData].self, from: bookmarkdata as! Data)
            print(bookmarkList)
            bmTableView.reloadData()
        } catch {
            print("geterr")
        }
    }
    
    fileprivate func setupTableView(){
        bmTableView.register(SearchListCell.self, forCellReuseIdentifier: tableIdentifier)
        bmTableView.dataSource = self
        bmTableView.delegate = self
        bmTableView.rowHeight = 50.0
        view.addSubview(bmTableView)
        NSLayoutConstraint.activate([
            bmTableView.topAnchor.constraint(equalTo: view.topAnchor, constant:1),
            bmTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant:0),
            bmTableView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if(velocity.y>0) {
            UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                print("Hide")
                self.tabBarController?.tabBar.isHidden = false
                self.tabBarController?.navigationController?.navigationBar.isHidden = true
            }, completion: nil)
            
        } else {
            UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                print("show")
                self.tabBarController?.tabBar.isHidden = true
                self.tabBarController?.navigationController?.navigationBar.isHidden = false

            }, completion: nil)
        }
    }
}
extension BookMarkController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableIdentifier, for: indexPath) as! SearchListCell
        if bookmarkList.isEmpty == false {
            cell.titleLabel.text = bookmarkList[indexPath.item].title
        }
        return cell
    }
    
}

extension BookMarkController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        let mv = ModalViewController()
        if bookmarkList.isEmpty == false {
            mv.data = bookmarkList[indexPath.item]
        }
        present(mv, animated: true, completion: { })
    }
}

extension BookMarkController: UIScrollViewDelegate{
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.navigationController?.navigationBar.isHidden = false
    }
}
