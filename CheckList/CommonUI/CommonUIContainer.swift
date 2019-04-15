//
//  CommonUI.swift
//  CheckList
//
//  Created by Sumona Salma on 4/13/19.
//  Copyright © 2019 Sumona Salma. All rights reserved.
//

import UIKit
import Foundation

class CommonUIContainer: UIViewController {
    static let shared = CommonUIContainer()
    func commonUITextField (placeHolder:String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeHolder
        textField.textAlignment = .left
        textField.textColor = UIColor.darkGray
        textField.backgroundColor = UIColor.white
        textField.tintColor = UIColor.black
        textField.adjustsFontSizeToFitWidth = true
        //textField.becomeFirstResponder()
        textField.minimumFontSize = 12
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    func commonTableView() -> UITableView {
        let view = UITableView(frame: CGRect.zero, style: .plain)
        view.rowHeight = UITableView.automaticDimension
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    func commonLabelUI(text: String, color: UIColor,textColor:UIColor) -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.text = text
        label.textColor = textColor
        label.backgroundColor = color
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = label.font.withSize(16)
        label.minimumScaleFactor=0.3
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    func commonInputButton(withColor color:UIColor, title:String, width:Int, height:Int,target:String,alphaVal:CGFloat,titleColor:UIColor) -> UIButton{
        let button = UIButton()
        button.backgroundColor = color
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.backgroundColor = color.withAlphaComponent(alphaVal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.titleLabel!.font = UIFont.boldSystemFont(ofSize: button.titleLabel!.font.pointSize)
        button.titleLabel?.minimumScaleFactor=0.1
        button.titleLabel!.numberOfLines = 2
        button.clipsToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        button.titleLabel!.adjustsFontSizeToFitWidth = true
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }
    func commoninputStackViewFilProportionally(arr: Array<Any>)-> UIStackView{
        //Stack View
        let stackView   = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.backgroundColor = UIColor.blue
        
        for row in arr {
            stackView.addArrangedSubview(row as! UIView)
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
}
extension UIViewController {
    
    func createAlert(titleText : String, messageText : String){
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
