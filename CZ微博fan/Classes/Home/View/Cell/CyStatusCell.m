//
//  CyStatusCell.m
//  CZ微博fan
//
//  Created by fan on 15/12/28.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyStatusCell.h"
#import "CyOriginalView.h"
#import "CyRetweetView.h"
#import "CyStatusToolBar.h"
#import "CyStatusFrame.h"

@interface CyStatusCell ()
@property(nonatomic,strong) CyOriginalView *originalView;
@property(nonatomic,strong) CyRetweetView *retweetView;
@property(nonatomic,strong) CyStatusToolBar *toolBar;

@end
@implementation CyStatusCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubViews];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setupSubViews{
    
    //原创微博
    CyOriginalView *originalView= [[CyOriginalView alloc] init];
    [self addSubview:originalView];
    _originalView = originalView;
    
    //转发微博
   CyRetweetView *retweetView = [[CyRetweetView alloc] init];
    [self addSubview:retweetView];
    _retweetView = retweetView;

    //工具条
    CyStatusToolBar *toolBar= [[CyStatusToolBar alloc] init];
    [self addSubview:toolBar];
    _toolBar = toolBar;
    
}


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *Id =@"cell";
    CyStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Id];
    }
    
    return cell;
    
}

-(void)setStatusFrame:(CyStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    
    //计算原创微博的frame 和 赋值
    _originalView.frame = statusFrame.originalViewFrame;
    _originalView.statusFrame = statusFrame;;
    
    //计算转发微博的frame 和 给子空间赋值
    _retweetView.frame = statusFrame.retweetViewFrame;
    _retweetView.statusFrame = statusFrame;
    
    //toolBar
    _toolBar.frame = statusFrame.toolBarFrame;
    _toolBar.status = statusFrame.status;
}





@end
