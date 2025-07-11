//
//  RulesViewController.swift
//  Yahtzee
//
//  Created by Aaron Garman on 9/28/24.
//

import UIKit
import WebKit

class RulesViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBAction func didTapDoneButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "https://www.hasbro.com/common/instruct/yahtzee.pdf") {
            webView.load(URLRequest(url: url))
        }
    }
}
