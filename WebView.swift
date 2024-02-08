//
//  ViewController.swift
//  WebView3
//
//  Created on 28/07/2022.
//
// Useful articles:
//
// if Constraints not keeping WKWebView inside Safe Area
// https://stackoverflow.com/questions/54602785/constraints-not-keeping-wkwebview-inside-safe-area
//
// !!! Apple's documentation on topic of WebView
// https://developer.apple.com/documentation/webkit/wkwebview

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate {
    
    
    // private var webView = WKWebView()
    private var webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: configuration)

        return webView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        
        guard let url = URL(string: "https://apple.com/") else { // <- your website here
            return
        }
        webView.load(URLRequest(url: url))
        
        
        webView.scrollView.contentInsetAdjustmentBehavior = .always
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // To adjust the view's color, change values in this block of code
        // Следующий блок кода, чтобы поменять положение и цвет рамок. НАЧАЛО
        
        // top margin of the view
        // let topPadding = 0
        let topPadding = view.safeAreaInsets.top
        
        // bottom margin of the view
        // let bottomPadding = 0
        let bottomPadding = view.safeAreaInsets.bottom
        
        // color of margins
        view.backgroundColor = .systemBackground  // .white    // .darkGray
        webView.frame = view.frame.inset(by: UIEdgeInsets(top: CGFloat(topPadding), left: CGFloat(0), bottom: CGFloat(bottomPadding), right: CGFloat(0)))
        
        // Color can be chosen here: https://developer.apple.com/design/human-interface-guidelines/foundations/color/
        
        // КОНЕЦ
    }
    
    // only portrait mode orientation available
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }

}

