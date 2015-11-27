//
//  ViewController.swift
//  JBrowser
//
//  Created by JW on 11/26/27 H.
//  Copyright © 27 Heisei Woo. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIWebViewDelegate {


    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    @IBOutlet weak var stopButton: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // homepage
    let homeUrl = "http://www.yahoo.co.jp"
    
    // URL whitelist
    let whiteList = [
    "https?://.*\\.yahoo.\\.co\\.jp",
    "https?://.*\\.yahoo\\.com"
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        openUrl(homeUrl)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Open the URL by the WebView which specified by the string.
    func openUrl(urlString: String){
        let url = NSURL(string: urlString)
        let urlRequest = NSURLRequest(URL: url!)
        webView.loadRequest(urlRequest)
    }
    
    // Open the URL by the Safari which specified by the string.
    func openUrlInSafari(urlstring: String){
        if let nsUrl = NSURL(string: urlstring){
            UIApplication.sharedApplication().openURL(nsUrl)
        }
    }
    
    // Processing when finishing readed.
    func stopLoading(){
        activityIndicator.alpha = 0
        activityIndicator.stopAnimating()
        backButton.enabled = self.webView.canGoBack
        reloadButton.enabled = true
        stopButton.enabled = false
    }
    
    
    
    
    // MARK: - UIWebViewDelegate
    func webViewDidStartLoad(webView: UIWebView) {
        activityIndicator.alpha = 1
        activityIndicator.startAnimating()
        backButton.enabled = false
        reloadButton.enabled = false
        stopButton.enabled = true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
       // activityIndicator.alpha = 0
       // activityIndicator.stopAnimating()
       // backButton.enabled = webView.canGoBack
       // reloadButton.enabled = true
       // stopButton.enabled = false
        stopLoading()
    }
    
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        // Display permission If it is not requested by the operation of the user.
        if navigationType == UIWebViewNavigationType.Other{
            return true;
        }
        
        // Get the URL of the currently displayed
        var theUrl:String
        if let unwrappedUrl = request.URL?.absoluteString{
            theUrl = unwrappedUrl
        }else{
            // if can't get the URL return false
            stopLoading()
            return false
        }
        
        //Checking the URL is in the white list.
        var canStayInApp = false;
        for url in whiteList {
            if let _ = theUrl.rangeOfString(url, options: NSStringCompareOptions.RegularExpressionSearch){
                
                canStayInApp = true;
                break;
            }
        }
        //if not in whith list, it will be open in safari.
        if !canStayInApp{
            openUrlInSafari(theUrl)
            stopLoading()
            return false;
        }
        return true
    }
    
    
    
    
    // MARK: - IBAction
    @IBAction func backButtonTapped(sender: UIBarButtonItem) {
        webView.goBack()
    }

    @IBAction func reloadButtonTapped(sender: UIBarButtonItem) {
        webView.reload()
    }
    
    @IBAction func stopButtonTapped(sender: UIBarButtonItem) {
        webView.stopLoading()
    }
}

