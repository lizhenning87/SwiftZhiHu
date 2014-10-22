//
//  ZNHUDProgress.swift
//  SwiftZhiHu
//
//  Created by lizhenning on 14/10/21.
//  Copyright (c) 2014年 lizhenning. All rights reserved.
//

import UIKit
import Foundation

let view_width : CGFloat = 100
let view_height : CGFloat = 100

class ZNHUDProgress : UIView
{
    var activityIndicatory = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
    var viewbg : UIView?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.userInteractionEnabled = false
        viewbg = UIView(frame:CGRectMake((frame.size.width - view_width)/2, (frame.size.height - view_height)/2, view_width, view_height))
        viewbg!.backgroundColor = UIColor.grayColor()
        viewbg!.layer.masksToBounds = true
        viewbg!.layer.cornerRadius = 4.0
        viewbg!.alpha = 0.0
        self.addSubview(viewbg!)
        
        activityIndicatory.hidesWhenStopped = true
        activityIndicatory.center = CGPointMake(view_width/2, view_height/2)
        viewbg!.addSubview(activityIndicatory)
        
        
    }
    
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show()
    {
        activityIndicatory.startAnimating()
        
        UIView.animateWithDuration(0.3, animations: {
        
            self.viewbg!.alpha = 1.0
        
        })
        
        
    }
    
    func hide()
    {
        activityIndicatory.stopAnimating();
        
        UIView.animateWithDuration(0.3, animations: {
            
            self.viewbg!.alpha = 0.0
            
        })
    }
    
}