//
//  CyNewFeatureCell.h
//  CZ微博fan
//
//  Created by qingyun on 15/12/24.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CyNewFeatureCell : UICollectionViewCell
@property(strong,nonatomic) UIImage *image;

-(void)setIndex:(NSIndexPath *)index count:(NSInteger)count;
@end
