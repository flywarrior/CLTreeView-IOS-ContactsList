//
//  CLTreeViewViewController.m
//  CLTreeView
//
//  Created by 钟由 on 14-9-7.
//  Copyright (c) 2014年 flywarrior24@163.com. All rights reserved.
//

#import "CLTreeViewController.h"
#import "CLTree.h"

@interface CLTreeViewController ()

@property(strong,nonatomic) NSMutableArray* dataArray; //保存全部数据的数组
@property(strong,nonatomic) NSArray *displayArray;   //保存要显示在界面上的数据的数组

@end

@implementation CLTreeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _myTableView = [[UITableView alloc]init];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    CGRect tableViewFrame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height);
    _myTableView.frame = tableViewFrame;
    [self.view addSubview:_myTableView];
    [self addTestData];
    [self reloadDataForDisplayArray];//初始化将要显示的数据
}

//添加演示数据
-(void) addTestData{
    CLTreeViewNode *node0 = [[CLTreeViewNode alloc]init];
    node0.nodeLevel = 0;
    node0.type = 0;
    node0.sonNodes = nil;
    node0.isExpanded = FALSE;
    CLTreeView_LEVEL0_Model *tmp0 =[[CLTreeView_LEVEL0_Model alloc]init];
    tmp0.name = @"收藏";
    tmp0.headImgPath = @"contacts_collect.png";
    tmp0.headImgUrl = nil;
    node0.nodeData = tmp0;
    
    CLTreeViewNode *node1 = [[CLTreeViewNode alloc]init];
    node1.nodeLevel = 0;
    node1.type = 0;
    node1.sonNodes = nil;
    node1.isExpanded = FALSE;
    CLTreeView_LEVEL0_Model *tmp1 =[[CLTreeView_LEVEL0_Model alloc]init];
    tmp1.name = @"软件技术";
    tmp1.headImgPath = @"contacts_major.png";
    tmp1.headImgUrl = nil;
    node1.nodeData = tmp1;
    
    CLTreeViewNode *node2 = [[CLTreeViewNode alloc]init];
    node2.nodeLevel = 0;
    node2.type = 0;
    node2.sonNodes = nil;
    node2.isExpanded = FALSE;
    CLTreeView_LEVEL0_Model *tmp2 =[[CLTreeView_LEVEL0_Model alloc]init];
    tmp2.name = @"信息工程";
    tmp2.headImgPath = @"contacts_major.png";
    tmp2.headImgUrl = nil;
    node2.nodeData = tmp2;
    
    CLTreeViewNode *node3 = [[CLTreeViewNode alloc]init];
    node3.nodeLevel = 1;
    node3.type = 1;
    node3.sonNodes = nil;
    node3.isExpanded = FALSE;
    CLTreeView_LEVEL1_Model *tmp3 =[[CLTreeView_LEVEL1_Model alloc]init];
    tmp3.name = @"软件技术1班";
    tmp3.sonCnt = @"1";
    node3.nodeData = tmp3;
    
    CLTreeViewNode *node4 = [[CLTreeViewNode alloc]init];
    node4.nodeLevel = 1;
    node4.type = 1;
    node4.sonNodes = nil;
    node4.isExpanded = FALSE;
    CLTreeView_LEVEL1_Model *tmp4 =[[CLTreeView_LEVEL1_Model alloc]init];
    tmp4.name = @"软件技术2班";
    tmp4.sonCnt = @"1";
    node4.nodeData = tmp4;
    
    CLTreeViewNode *node5 = [[CLTreeViewNode alloc]init];
    node5.nodeLevel = 2;
    node5.type = 2;
    node5.sonNodes = nil;
    node5.isExpanded = FALSE;
    CLTreeView_LEVEL2_Model *tmp5 =[[CLTreeView_LEVEL2_Model alloc]init];
    tmp5.name = @"flywarrior";
    tmp5.signture = @"老是失眠怎么办啊";
    tmp5.headImgPath = @"head1.jpg";
    tmp5.headImgUrl = nil;
    node5.nodeData = tmp5;
    
    CLTreeViewNode *node6 = [[CLTreeViewNode alloc]init];
    node6.nodeLevel = 2;
    node6.type = 2;
    node6.sonNodes = nil;
    node6.isExpanded = FALSE;
    CLTreeView_LEVEL2_Model *tmp6 =[[CLTreeView_LEVEL2_Model alloc]init];
    tmp6.name = @"flywarrior2";
    tmp6.signture = @"用头用力撞下键盘就好了。";
    tmp6.headImgPath = @"head2.jpg";
    tmp6.headImgUrl = nil;
    node6.nodeData = tmp6;
    
    node1.sonNodes = [NSMutableArray arrayWithObjects:node3,node4,nil];
    node3.sonNodes = [NSMutableArray arrayWithObjects:node5,nil];
    node4.sonNodes = [NSMutableArray arrayWithObjects:node6,nil];
    _dataArray = [NSMutableArray arrayWithObjects:node0,node1,node2, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    return _displayArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"level0cell";
    static NSString *indentifier1 = @"level1cell";
    static NSString *indentifier2 = @"level2cell";
    CLTreeViewNode *node = [_displayArray objectAtIndex:indexPath.row];
    
    if(node.type == 0){//类型为0的cell
        CLTreeView_LEVEL0_Cell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"Level0_Cell" owner:self options:nil] lastObject];
        }
        cell.node = node;
        [self loadDataForTreeViewCell:cell with:node];//重新给cell装载数据
        [cell setNeedsDisplay]; //重新描绘cell
        return cell;
    }
    else if(node.type == 1){//类型为1的cell
        CLTreeView_LEVEL1_Cell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier1];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"Level1_Cell" owner:self options:nil] lastObject];
        }
        cell.node = node;
        [self loadDataForTreeViewCell:cell with:node];
        [cell setNeedsDisplay];
        return cell;
    }
    else{//类型为2的cell
        CLTreeView_LEVEL2_Cell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier2];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"Level2_Cell" owner:self options:nil] lastObject];
        }
        cell.node = node;
        [self loadDataForTreeViewCell:cell with:node];
        [cell setNeedsDisplay];
        return cell;
    }
}

/*---------------------------------------
 为不同类型cell填充数据
--------------------------------------- */
-(void) loadDataForTreeViewCell:(UITableViewCell*)cell with:(CLTreeViewNode*)node{
    if(node.type == 0){
        CLTreeView_LEVEL0_Model *nodeData = node.nodeData;
        ((CLTreeView_LEVEL0_Cell*)cell).name.text = nodeData.name;
        if(nodeData.headImgPath != nil){
            //本地图片
            [((CLTreeView_LEVEL0_Cell*)cell).imageView setImage:[UIImage imageNamed:nodeData.headImgPath]];
        }
        else if (nodeData.headImgUrl != nil){
            //加载图片，这里是同步操作。建议使用SDWebImage异步加载图片
            [((CLTreeView_LEVEL0_Cell*)cell).imageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:nodeData.headImgUrl]]];
        }
    }
    
    else if(node.type == 1){
        CLTreeView_LEVEL1_Model *nodeData = node.nodeData;
        ((CLTreeView_LEVEL1_Cell*)cell).name.text = nodeData.name;
        ((CLTreeView_LEVEL1_Cell*)cell).sonCount.text = nodeData.sonCnt;
    }
    
    else{
        CLTreeView_LEVEL2_Model *nodeData = node.nodeData;
        ((CLTreeView_LEVEL2_Cell*)cell).name.text = nodeData.name;
        ((CLTreeView_LEVEL2_Cell*)cell).signture.text = nodeData.signture;
        if(nodeData.headImgPath != nil){
            //本地图片
            [((CLTreeView_LEVEL2_Cell*)cell).headImg setImage:[UIImage imageNamed:nodeData.headImgPath]];
        }
        else if (nodeData.headImgUrl != nil){
            //加载图片，这里是同步操作。建议使用SDWebImage异步加载图片
            [((CLTreeView_LEVEL2_Cell*)cell).headImg setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:nodeData.headImgUrl]]];
        }
    }
}

/*---------------------------------------
cell高度默认为50
 --------------------------------------- */
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 50;
}

/*---------------------------------------
处理cell选中事件，需要自定义的部分
 --------------------------------------- */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CLTreeViewNode *node = [_displayArray objectAtIndex:indexPath.row];
    [self reloadDataForDisplayArrayChangeAt:indexPath.row];//修改cell的状态(关闭或打开)
    if(node.type == 2){
        //处理叶子节点选中，此处需要自定义
    }
    else{
        CLTreeView_LEVEL0_Cell *cell = (CLTreeView_LEVEL0_Cell*)[tableView cellForRowAtIndexPath:indexPath];
        if(cell.node.isExpanded ){
            [self rotateArrow:cell with:M_PI_2];
        }
        else{
            [self rotateArrow:cell with:0];
        }
    }
}

/*---------------------------------------
 旋转箭头图标
 --------------------------------------- */
-(void) rotateArrow:(CLTreeView_LEVEL0_Cell*) cell with:(double)degree{
    [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        cell.arrowView.layer.transform = CATransform3DMakeRotation(degree, 0, 0, 1);
    } completion:NULL];
}

/*---------------------------------------
初始化将要显示的cell的数据
 --------------------------------------- */
-(void) reloadDataForDisplayArray{
    NSMutableArray *tmp = [[NSMutableArray alloc]init];
    for (CLTreeViewNode *node in _dataArray) {
        [tmp addObject:node];
        if(node.isExpanded){
            for(CLTreeViewNode *node2 in node.sonNodes){
                [tmp addObject:node2];
                if(node2.isExpanded){
                    for(CLTreeViewNode *node3 in node2.sonNodes){
                        [tmp addObject:node3];
                    }
                }
            }
        }
    }
    _displayArray = [NSArray arrayWithArray:tmp];
    [self.myTableView reloadData];
}

/*---------------------------------------
修改cell的状态(关闭或打开)
 --------------------------------------- */
-(void) reloadDataForDisplayArrayChangeAt:(NSInteger)row{
    NSMutableArray *tmp = [[NSMutableArray alloc]init];
    NSInteger cnt=0;
    for (CLTreeViewNode *node in _dataArray) {
        [tmp addObject:node];
        if(cnt == row){
            node.isExpanded = !node.isExpanded;
        }
        ++cnt;
        if(node.isExpanded){
            for(CLTreeViewNode *node2 in node.sonNodes){
                [tmp addObject:node2];
                if(cnt == row){
                    node2.isExpanded = !node2.isExpanded;
                }
                ++cnt;
                if(node2.isExpanded){
                    for(CLTreeViewNode *node3 in node2.sonNodes){
                        [tmp addObject:node3];
                        ++cnt;
                    }
                }
            }
        }
    }
    _displayArray = [NSArray arrayWithArray:tmp];
    [self.myTableView reloadData];
}
@end
