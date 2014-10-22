//
//  ZhiHuRequest.swift
//  SwiftZhiHu
//
//  Created by lizhenning on 14/10/22.
//  Copyright (c) 2014年 lizhenning. All rights reserved.
//

import UIKit

class ZhiHuRequest: NSObject {
    
    ///最新消息
    let URL_NEWS_LATEST = "http://news-at.zhihu.com/api/3/news/latest"
    
    func requestNewsLatest (completionHandler:(result:NSArray , state:ZNHttpState) -> Void)
    {
        ZNHttpRequest.requestWithURL(URL_NEWS_LATEST, completionHandler: {data in
        
            var array = NSMutableArray(capacity: 10)
            
            if (data === NSNull())
            {
                completionHandler(result:array ,state:ZNHttpState.ERROR)
            }else
            {
                var stories = data.valueForKey("stories") as NSArray
                var count : NSInteger = stories.count
                
                for var i : NSInteger = 0 ; i < count ; i++
                {
                    var dic = stories.objectAtIndex(i) as NSDictionary
                    
                    var model = StoryModel()
                    model.title = dic.valueForKey("title") as? NSString
                    model.images = dic.valueForKey("images") as? NSString
                    
                    array.addObject(model)
                    
                }
                
                completionHandler(result: array, state: ZNHttpState.OK)
            }
        
        })
        
        
        
    }
    
}
