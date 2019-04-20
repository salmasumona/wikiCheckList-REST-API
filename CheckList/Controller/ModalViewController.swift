//
//  ModalViewController.swift
//  CheckList
//
//  Created by Sumona Salma on 4/13/19.
//  Copyright © 2019 Sumona Salma. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
    var data : PageData?
    var titleArticle = CommonUIContainer.shared.commonLabelUI(text: "", color: UIColor.clear, textColor: UIColor.black)
    var htmlView = CommonUIContainer.shared.commonTextView(text: "", color: UIColor.clear, textColor: UIColor.black)
    let bookmarkBTN = CommonUIContainer.shared.commonInputButton(withColor: UIColor.lightGray, title: "Add To BookMark", width: 0, height: 0, target: "", alphaVal: 0.7, titleColor: UIColor.black)
    var bookmarkList = [PageData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        htmlView.addGestureRecognizer(tap)
    }
    
    @objc func doubleTapped(){
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromBottom
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
    func setupViews(){
        titleArticle.text = data?.title
        titleArticle.textAlignment = .center
        let htmlText = data?.snippet
        htmlView.attributedText = htmlText?.htmlToAttributedString
       // htmlView.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.byWordWrapping"
        let stackView = CommonUIContainer.shared.commoninputStackViewFilProportionally(arr: [titleArticle,htmlView,bookmarkBTN])
        bookmarkBTN.addTarget(self, action: #selector(bookmarkBTNTapped), for: .touchUpInside)

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor,constant: 50),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
        NSLayoutConstraint.activate([
            titleArticle.heightAnchor.constraint(equalTo: stackView.heightAnchor,multiplier:0.07)])
        
        NSLayoutConstraint.activate([
            bookmarkBTN.heightAnchor.constraint(equalTo: stackView.heightAnchor,multiplier:0.07)])
    }
    @objc func bookmarkBTNTapped(_ sender:UIButton){
        
        let getArr = self.data
        self.bookmarkList.append(getArr!)
        do {
            let data = UserDefaults.standard.object(forKey: "bookmark")
            let jsonDecoder = JSONDecoder()
            if data != nil {
                let bookmarkData = try jsonDecoder.decode([PageData].self, from: data as! Data)
                self.bookmarkList = bookmarkData
            }
            if self.bookmarkList.count > 0 {
                for val in self.bookmarkList {
                    if val.pageid == getArr!.pageid {
                        self.createAlert(titleText: "", messageText:"Already added.")
                        return
                    }
                }
                self.bookmarkList.append(getArr!)
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
