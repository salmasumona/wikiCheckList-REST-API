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
    var htmlView = CommonUIContainer.shared.commonLabelUI(text: "", color: UIColor.clear, textColor: UIColor.black)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
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

        let stackView = CommonUIContainer.shared.commoninputStackViewFilProportionally(arr: [titleArticle,htmlView])
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor,constant: 50),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
        NSLayoutConstraint.activate([
            titleArticle.heightAnchor.constraint(equalTo: stackView.heightAnchor,multiplier:0.07)])
        
    }
}
