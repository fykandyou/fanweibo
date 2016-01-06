//
//  CyStatusCell.h
//  CZ微博fan
//
//  Created by fan on 15/12/28.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CyStatus.h"
#import "CystatusFrame.h"
@interface CyStatusCell : UITableViewCell

@property(nonatomic,strong) CyStatusFrame *statusFrame;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
