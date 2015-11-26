//
//  ViewController.swift
//  JBrowser
//
//  Created by JW on 11/26/27 H.
//  Copyright © 27 Heisei Woo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    @IBOutlet weak var stopButton: UIBarButtonItem!
  
    
    
    //homepage
    let homeUrl = "http://www.yahoo.co.jp"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        openUrl(homeUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func openUrl(urlString: String){
        
        let url = NSURL(string: urlString)
        let urlRequest = NSURLRequest(URL: url!)
        webView.loadRequest(urlRequest)
    }
    
    @IBAction func backButtonTapped(sender: UIBarButtonItem) {
    }

    @IBAction func reloadButtonTapped(sender: UIBarButtonItem) {
    }
    
    @IBAction func stopButtonTapped(sender: UIBarButtonItem) {
    }
}

