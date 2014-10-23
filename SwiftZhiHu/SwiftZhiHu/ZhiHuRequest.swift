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
    let URL_NEWS_DETAIL = "http://news-at.zhihu.com/api/3/news/"
    
    func requestNewsDetail (nid : NSString , completionHandler:(detail : StoryDetailModel , state:ZNHttpState) -> Void)
    {
        var url = URL_NEWS_DETAIL.stringByAppendingString(nid)
        
        ZNHttpRequest.requestWithURL(url, completionHandler: {data in
            
            if (data === NSNull())
            {
                var detail = StoryDetailModel()
                completionHandler(detail:detail,state:ZNHttpState.ERROR)
                
            }else
            {
                var detail = StoryDetailModel()
                
                
                detail.body = data.valueForKey("body") as NSString
                detail.image = data.valueForKey("image") as NSString
                var css = data.valueForKey("css") as NSArray
                detail.css = css.objectAtIndex(0) as NSString
                
                completionHandler(detail:detail,state:ZNHttpState.OK)
            }
            
            
        })
        
    }
    
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
                    
                    var nid = dic.valueForKey("id") as? NSInteger
                    model.storyID = NSString(format: "%d",nid!)
                    var images = dic.valueForKey("images") as? NSArray
                    var photo = images?.objectAtIndex(0) as NSString
                    model.photo = photo
                    
                    array.addObject(model)
                    
                }
                
                completionHandler(result: array, state: ZNHttpState.OK)
            }
        
        })
        
        
        
    }
    
}
