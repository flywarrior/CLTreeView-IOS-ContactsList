//
//  CLTreeView_LEVEL2_Cell.h
//  这个cell一般作为叶子节点来处理
//
//  Created by 钟由 on 14-9-9.
//  Copyright (c) 2014年 flywarrior24@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLTreeViewNode.h"

@interface CLTreeView_LEVEL2_Cell : UITableViewCell

@property (retain,strong,nonatomic) CLTreeViewNode *node;//data
@property (strong,nonatomic) IBOutlet UIImageView *headImg;
@property (strong,nonatomic) IBOutlet UILabel *signture;//个性签名
@property (strong,nonatomic) IBOutlet UILabel *name;

@end
