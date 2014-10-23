//
//  DetailViewController.swift
//  SwiftZhiHu
//
//  Created by lizhenning on 14/10/23.
//  Copyright (c) 2014年 lizhenning. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var model : StoryModel?
    var progressHUD : ZNHUDProgress?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = model!.title!
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("btnBack"))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        progressHUD = ZNHUDProgress(frame: self.view.bounds)
        self.view.addSubview(progressHUD!)
        progressHUD!.show()
        
        
        var request = ZhiHuRequest()
        request.requestNewsDetail(model!.storyID!, completionHandler: { (detail, state) -> Void in
            
            self.progressHUD!.hide()
            
            if (state == ZNHttpState.ERROR)
            {
                
            }else
            {
                var body : NSString = detail.body
                
                body = body.stringByReplacingOccurrencesOfString("<div class=\"img-place-holder\"></div>", withString: "")
                
                var html = "<html><head><link rel=\"stylesheet\" type=\"text/css\" href=\"" + detail.css + "\" /></head><body>" + body + "</body></html>"
                
                var webView = UIWebView(frame: CGRectMake(0, 64, self.view.frame.width, self.view.frame.height - 64))
                webView.loadHTMLString(html, baseURL: nil)
                self.view.addSubview(webView)
                
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func btnBack()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
