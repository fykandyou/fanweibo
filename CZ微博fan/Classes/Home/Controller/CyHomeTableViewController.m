//
//  CyHomeTableViewController.m
//  CZ微博fan
//
//  Created by fan on 15/12/23.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyHomeTableViewController.h"
#import "UIBarButtonItem+CyItem.h"
#import "CyTitleBtton.h"
#import "CyCover.h"
#import "CyPopMenu.h"
#import "CyMenuViewController.h"

#import "CyAcountTool.h"
#import "CyAccountModel.h"
#import "CyUser.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "CyStatus.h"
#import "CyHttpTool.h"
#import "CyStatusTool.h"
#import "CyUserTool.h"
#import "CyStatusCell.h"
#import "CyStatusFrame.h"

#import "CyCaptureController.h"

@interface CyHomeTableViewController ()<CyCoverPro>
@property(nonatomic,strong) CyTitleBtton *titleButton;

@property(nonatomic,strong) CyMenuViewController *one;

//viewModel:CyStatusFrame
@property(nonatomic,strong) NSMutableArray *statusFrame;
@end

@implementation CyHomeTableViewController

-(NSMutableArray *)statusFrame{
    if (_statusFrame == nil) {
        _statusFrame = [NSMutableArray array];
    }
    return _statusFrame;
}

-(CyMenuViewController*)one{
    if (_one == nil) {
        _one = [[CyMenuViewController alloc] init];
    }
    return _one;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    [self setupNavigationBar];
    //下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewDatas)];
    //添加自动刷新
    [self.tableView headerBeginRefreshing];

    [self.tableView addFooterWithTarget:self action:@selector(loadMoreDatas)];
    
    [CyUserTool userInfoWithSuccess:^(CyUser *result) {
        [self.titleButton setTitle:result.name forState:UIControlStateNormal];
        
        CyAccountModel *account = [CyAcountTool acount];
        account.name = result.name;
        
        [CyAcountTool saveAcount:account];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


-(void)refresh{
    [self.tableView headerBeginRefreshing];
}


-(void)loadMoreDatas{
    
    NSString *maxId = nil;
    
    if (self.statusFrame.count) {
        CyStatusFrame *statusFra =[self.statusFrame lastObject];
        CyStatus *statusA =statusFra.status;
       long long maxValue = [[statusA idstr] longLongValue]- 1;
       maxId = [NSString stringWithFormat:@"%lld",maxValue];
    }
    
    
    [CyStatusTool moreStatusWithMaxId:maxId sucess:^(NSArray *status) {
        //停止刷新
        [self.tableView footerEndRefreshing];
        
        NSMutableArray *statusF = [NSMutableArray array];
        for (CyStatus *statusModel in status) {
            CyStatusFrame *statusFrame = [[CyStatusFrame alloc] init];
            statusFrame.status = statusModel;
            [statusF addObject:statusFrame];
        }
        
        [self.statusFrame addObjectsFromArray:statusF];
        
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
           NSLog(@"%@",error);
    }];
    
}

-(void)loadNewDatas{
       
        //停止刷新
    [self.tableView headerEndRefreshing];
    
    NSString *sinceId = nil;
    
    if (self.statusFrame.count) {
        CyStatusFrame *frame =self.statusFrame[0];
        sinceId = frame.status.idstr ;
    }
    
    
    [CyStatusTool newStatusWithSinceId:sinceId  sucess:^(NSArray *status) {
       
        
        [self showConuntOfNewStatus:status.count];

        NSMutableArray *statusF = [NSMutableArray array];
        for (CyStatus *statusModel in status) {
            CyStatusFrame *statusFrame = [[CyStatusFrame alloc] init];
            statusFrame.status = statusModel;
            [statusF addObject:statusFrame];
        }
        
#warning NSIndexSet？干什么的？
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, status.count)];
        
  
        
        [self.statusFrame insertObjects:statusF atIndexes:indexSet];
        
        
        [self.tableView reloadData];

        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    
}

-(void)showConuntOfNewStatus:(NSInteger)count{
    
    
    if (count == 0) {
        return;
    }
    
    
    CGFloat h =35;
    CGFloat y =CGRectGetMaxY(self.navigationController.navigationBar.frame) - h;
    CGFloat W =self.view.bounds.size.width;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,y, W, h)];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@"最新微博数%ld",count];
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];

    [UIView animateWithDuration:0.25 animations:^{
        
        //zealer网
        label.transform = CGAffineTransformMakeTranslation(0, h);
        
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.25 delay:2 options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    
}

-(void)setupNavigationBar{
    
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendsearch) forControlEvents:UIControlEventTouchUpInside];
    
    // 右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];


    //title设置成button。UIBarButtonItem 自定义的时候更多的时候是设置成UIButton，
    CyTitleBtton *titleButton = [CyTitleBtton buttonWithType:UIButtonTypeCustom] ;
    _titleButton = titleButton;
    
    
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateHighlighted];
    
    //titleButton 高亮状态下不需要调整图片
    titleButton.adjustsImageWhenHighlighted = NO;
    
    [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    

    
    self.navigationItem.titleView = _titleButton;
    
}

#pragma mark - TitleButtonClick
-(void)titleButtonClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    CyCover *cover = [CyCover show];
    cover.delegate = self;
//    cover.dimBackground = YES;
    cover.dimBackground = NO;
    
    //设置菜单并弹出
    CGFloat W = 200;
    CGFloat X = (self.view.frame.size.width - W) * 0.5;
    CGFloat Y = 55;
    CGFloat H = W;
    
    CyPopMenu *menu =[CyPopMenu showInRect:CGRectMake(X, Y, W, H)];
    menu.userInteractionEnabled = YES;
    menu.contentView = self.one.view;
    
}

//该代理方法是通知蒙版已经移除，使titleButton.selected = NO,使菜单移除
-(void)coverDidClicked:(CyCover *)cover{
    _titleButton.selected = NO;
    
    [CyPopMenu hide];
}


#pragma mark - rightBarButtonItemClick
-(void)pop{
    
    [self.navigationController pushViewController:[[CyCaptureController alloc] init] animated:YES];
    
}
#pragma mark - leftBarButtonItemClick
-(void)friendsearch{
    
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrame.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        
    CyStatusFrame *statusFrame = self.statusFrame[indexPath.row];
    CyStatusCell *cell =[CyStatusCell cellWithTableView:tableView];
    cell.statusFrame = statusFrame;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     CyStatusFrame *statusFrame =  self.statusFrame[indexPath.row];
    return statusFrame.cellHeight;
}















@end
