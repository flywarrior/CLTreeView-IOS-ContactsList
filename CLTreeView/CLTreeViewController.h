//
//  CLTreeViewController.h
//  CLTreeView
//
//  Created by 钟由 on 14-9-7.
//  Copyright (c) 2014年 flywarrior24@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CLTreeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UITableView* myTableView;

@end
