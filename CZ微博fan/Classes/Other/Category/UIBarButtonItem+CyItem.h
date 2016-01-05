//
//  UIBarButtonItem+CyItem.h
//  CZ微博fan
//
//  Created by qingyun on 15/12/24.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CyItem)



+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
