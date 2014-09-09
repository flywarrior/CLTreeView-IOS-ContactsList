//
//  CLTreeView_LEVEL0_Cell.h
//  这个cell可以作为树形列表的根节点或者第二层节点
//
//  Created by 钟由 on 14-9-9.
//  Copyright (c) 2014年 flywarrior24@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLTreeViewNode.h"

@interface CLTreeView_LEVEL0_Cell : UITableViewCell

@property (retain,strong,nonatomic) CLTreeViewNode *node; //data
@property (strong,nonatomic) IBOutlet UIImageView *imgView;
@property (strong,nonatomic) IBOutlet UIImageView *arrowView; //箭头
@property (strong,nonatomic) IBOutlet UILabel *name;

@end
