//
//  ViewController.swift
//  CheckList
//
//  Created by Sumona Salma on 4/13/19.
//  Copyright © 2019 Sumona Salma. All rights reserved.
//

import UIKit

class SearchController: UIViewController, UITextFieldDelegate {
    var searchTextField: UITextField!
    var searchListTableView = CommonUIContainer.shared.commonTableView()
    let tableIdentifier = "cell"
    var wikiList = [PageData]()
    var bookmarkList = [PageData]()
    var limit: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTopView()
        setupTableView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.tabBarController?.navigationItem.title = "Search"
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.navigationController?.navigationBar.isHidden = false
    }
    fileprivate func setupTopView(){
        searchTextField = CommonUIContainer.shared.commonUITextField(placeHolder: "Search")
        self.searchTextField.delegate = self
        view.addSubview(searchTextField)
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:-40),
            searchTextField.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.09),
            searchTextField.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    func textFieldShouldReturn(_ searchTextField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        if searchTextField.text != "" {
            limit = 20
            wikiList = []
            LoadingOverlay.shared.showOverlay(view: UIApplication.shared.keyWindow!)
            fetchData(limit: limit)
            //searchTextField.text = ""
            
        }else{
            wikiList = []
            searchListTableView.reloadData()
            //let viewController = BookMarkController()
            //self.navigationController?.pushViewController(viewController, animated: true)
            tabBarController?.selectedIndex = 1
        }
       
        return true
    }
    
    fileprivate func setupTableView(){
        searchListTableView.register(SearchListCell.self, forCellReuseIdentifier: tableIdentifier)
        searchListTableView.dataSource = self
        searchListTableView.delegate = self
        searchListTableView.rowHeight = 50.0
        view.addSubview(searchListTableView)
        NSLayoutConstraint.activate([
            searchListTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant:1),
            searchListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant:-5),
            searchListTableView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    func fetchData(limit:Int) {
        let escapedString = searchTextField.text!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!

        let url = "http://en.wikipedia.org/w/api.php?action=query&list=search&format=json&srsearch=\(escapedString)&srlimit=\(limit)"
        Service.shared.getData(urlString: url) { (results, err) in
            LoadingOverlay.shared.hideOverlayView()

            if let err = err {
                print("Failed to fetch data:", err)
                return
            }
            guard let results = results else {return}
            self.wikiList = results.query.search ?? []
            self.searchListTableView.reloadData()
        }
    }
    @objc func bookmarkBTNTapped(_ sender:UIButton){
        
        let index = sender.tag
        let getArr = self.wikiList[index]
        do {
            let data = UserDefaults.standard.object(forKey: "bookmark")
            let jsonDecoder = JSONDecoder()
            if data != nil {
                let bookmarkData = try jsonDecoder.decode([PageData].self, from: data as! Data)
                self.bookmarkList = bookmarkData
            }
            if self.bookmarkList.count == 0 {
                self.bookmarkList.append(getArr)
            }else{
                for val in self.bookmarkList {
                    if val.pageid == getArr.pageid {
                        self.createAlert(titleText: "", messageText:"Already added.")
                        return
                    }
                }
                self.bookmarkList.append(getArr)
            }
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(bookmarkList)
            UserDefaults.standard.set(jsonData, forKey: "bookmark")
            self.createAlert(titleText: "", messageText:"Added to bookmark.")
            
        } catch {
            print("Err--")
        }
    }
}

