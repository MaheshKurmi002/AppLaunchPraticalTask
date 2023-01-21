//
//  WebViewController.swift
//  Task
//
//  Created by IPS-172 on 20/01/23.
//

import UIKit
import WebKit

class WebViewController: UIViewController,WKNavigationDelegate {
    
    var webView: WKWebView!
    var url : String = ""
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: url)!
        webView.load(URLRequest(url: url))
        // Do any additional setup after loading the view.
    }
}
