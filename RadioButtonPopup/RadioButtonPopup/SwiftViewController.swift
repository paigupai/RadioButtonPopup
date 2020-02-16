//
//  SwiftViewController.swift
//  RadioButtonPopup
//
//  Created by USER on 2020/01/14.
//  Copyright © 2020 USER. All rights reserved.
//

import UIKit

class SwiftViewController:UIViewController {
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func showPopup(_ sender: Any) {
        let msgList: [String] = ["河野都",
                       "斎藤ニコル",
                       "佐藤麗華",
                       "滝川みう",
                       "立川絢香",
                       "戸田ジュン",
                       "藤間桜",
                       "丸山あかね",
                       "神木みかみ",
                       "東条悠希",
                       "柊つぼみ"]
      
        
        let firstMsg = msgList[0] as String
        
        RadioButtonPopupViewController.showRadioButtonPopup(buttonType:{type,selectedMsg in
            switch type{
            case .ButtonTypeCancel:
                break
            case.ButtonTypeOK:
                self.label.text = selectedMsg
            @unknown default:
                print("unknown")
            }
        }, messages: msgList, uicolor: .black, selectedMessage:firstMsg )
    }
}
