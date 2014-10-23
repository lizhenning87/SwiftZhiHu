//
//  RootTableViewCell.swift
//  SwiftZhiHu
//
//  Created by lizhenning on 14/10/22.
//  Copyright (c) 2014年 lizhenning. All rights reserved.
//

import UIKit

class RootTableViewCell: UITableViewCell {
    
    var photo : UIImageView?
    var viewItem : UIView?
    var viewLabelBg : UIView?
    var labelTitle : UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        var width = UIScreen.mainScreen().bounds.width
        
        viewItem = UIView(frame: CGRectMake(10, 5, width - 20, 190))
        viewItem!.backgroundColor = colorCellBg
        self.contentView .addSubview(viewItem!)
        
        photo = UIImageView(frame: viewItem!.bounds)
        photo!.contentMode = UIViewContentMode.ScaleToFill
        photo!.layer.masksToBounds = true
        viewItem!.addSubview(photo!)
        
        viewLabelBg = UIView(frame: viewItem!.bounds)
        viewLabelBg!.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        viewItem!.addSubview(viewLabelBg!)
        
        labelTitle = UILabel(frame: CGRectMake(10, 10, viewItem!.frame.width - 20, viewItem!.frame.height - 20))
        labelTitle!.backgroundColor = UIColor.clearColor()
        labelTitle!.textAlignment = NSTextAlignment.Center
        labelTitle!.font = UIFont(name: "Helvetica", size: 15)
        labelTitle!.numberOfLines = 0
        labelTitle!.textColor = UIColor.whiteColor()
        viewLabelBg!.addSubview(labelTitle!)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(model : StoryModel)
    {
        photo!.image = nil
        labelTitle!.text = model.title
        var url = NSURL(string: model.photo!)
        photo!.hnk_setImageFromURL(url!, placeholder: nil, format: nil, failure: nil, success: nil)
    }

}
