//
//  GameViewController.swift
//  Punk Video Poker
//
//  Created by Daniel Gheorghe on 12/10/2016.
//  Copyright © 2016 The CodePunker. All rights reserved.
//

import UIKit
import WebKit;
import JavaScriptCore;

class GameViewController: UIViewController, WKScriptMessageHandler {
    var webview: WKWebView?;

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        let contentController = WKUserContentController();
        let userScript: WKUserScript;
        userScript = WKUserScript(
            source: "console.log('test')",
            injectionTime: WKUserScriptInjectionTime.atDocumentEnd,
            forMainFrameOnly: true
        )

        contentController.addUserScript(userScript);
        //set the native handlers for the return of the JS methods
        contentController.add(
            self,
            name: "nativeCallbackHandler"
        );

        //put the above config into a brand new wkwebview
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        self.webview = WKWebView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: self.view.frame.height), configuration: config);
        
        //put the wkwebview into the view and load the html url
        for subview in self.view.subviews {
            if(subview is WKWebView) {
                print("Found the previous wkwebview");
                subview.removeFromSuperview();
            }
        }
        self.view.addSubview(self.webview!)
        
        let folderPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
        let url = URL(fileURLWithPath: folderPath.path + "/videopoker/index.html");
        self.webview!.loadFileURL(url, allowingReadAccessTo: folderPath);
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if (message.name == "nativeCallbackHandler") {
            //whatever
            let userDefaults = UserDefaults.standard
            userDefaults.set(message.body, forKey: "userData");
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
