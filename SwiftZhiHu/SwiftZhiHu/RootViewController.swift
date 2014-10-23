//
//  RootViewController.swift
//  SwiftZhiHu
//
//  Created by lizhenning on 14/10/22.
//  Copyright (c) 2014年 lizhenning. All rights reserved.
//

import UIKit

class RootViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    let cellIdentifier : NSString = "cellIdentifier"
    var table : UITableView?
    var progressHUD : ZNHUDProgress?
    var arrayResult : NSMutableArray?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Swift"
        arrayResult = NSMutableArray(capacity: 10)
        self.initView()
        self.loadNewsLatest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    func initView()
    {
        table = UITableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.height), style: UITableViewStyle.Plain)
        table?.delegate = self
        table?.dataSource = self
        table?.registerClass(RootTableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
        table?.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view .addSubview(table!)
        
        progressHUD = ZNHUDProgress(frame: self.view.bounds)
        self.view.addSubview(progressHUD!)
        progressHUD!.show()
        
    }
    
    func loadNewsLatest()
    {
        var request = ZhiHuRequest()
        request.requestNewsLatest { (result, state) -> Void in
            
            self.progressHUD!.hide()
            
            if (state == ZNHttpState.ERROR)
            {
                println("error")
            }else
            {
                self.arrayResult!.addObjectsFromArray(result)
                self.table!.reloadData()
            }
            
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = self.arrayResult!.count
        return count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var model = self.arrayResult!.objectAtIndex(indexPath.row) as StoryModel
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as RootTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.setModel(model)
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var model = self.arrayResult!.objectAtIndex(indexPath.row) as StoryModel
        
        var viewController = DetailViewController()
        viewController.model = model
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
