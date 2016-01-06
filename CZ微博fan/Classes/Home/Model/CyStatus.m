//
//  CyStatus.m
//  CZ微博fan
//
//  Created by fan on 15/12/26.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyStatus.h"
#import "CyPhoto.h"
#import "NSDate+MJ.h"
@implementation CyStatus

//实现这个方法就会自动的把字典中得数组转变为模型
+(NSDictionary *)objectClassInArray{
    
    return @{@"pic_urls":[CyPhoto class]};
    
}


//-(NSString *)created_at{
//    
//    NSDateFormatter *format=[[NSDateFormatter alloc] init];
//    format.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
//    
//    NSDate *creat_at = [format dateFromString:_created_at];
//    
//    if ([creat_at isThisYear]) {//今年
//        
//        if ([creat_at isToday]) {//今天
//            
//            //计算与当前时间的差值
//            NSDateComponents *components = [creat_at deltaWithNow];
//            
//            if (components.hour > 1) {
//               
//                return [NSString stringWithFormat:@"%ld小时之前", components.hour];
//            }else if (components.minute > 1){
//                
//                return [NSString stringWithFormat:@"%ld分钟之前",components.minute];
//            }else{
//                return @"刚刚";
//            }
//            
//            
//        }else if ([creat_at isYesterday]){//昨天
//            format.dateFormat = @"昨天 HH:mm";
//            return [format stringFromDate:creat_at];
//        }else{//前天以及前天之前
//            format.dateFormat = @"MM-dd HH:mm";
//            return [format stringFromDate:creat_at];
//        }
//        
//    }else{//不是今年
//        format.dateFormat = @"yyyy-MM-dd HH:mm";
//        return [format stringFromDate:creat_at];
//    }
//    return _created_at;
//}

-(void)setCreated_at:(NSString *)created_at{
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    format.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    
    NSDate *Creat_at = [format dateFromString:created_at];
    
    if ([Creat_at isThisYear]) {//今年
        
        if ([Creat_at isToday]) {//今天
            
            //计算与当前时间的差值
            NSDateComponents *components = [Creat_at deltaWithNow];
            
            if (components.hour > 1) {
                
                _created_at = [NSString stringWithFormat:@"%ld小时之前", components.hour];
            }else if (components.minute > 1){
                
                _created_at =  [NSString stringWithFormat:@"%ld分钟之前",components.minute];
            }else{
                 _created_at =  @"刚刚";
            }
            
            
        }else if ([Creat_at isYesterday]){//昨天
            format.dateFormat = @"昨天 HH:mm";
            _created_at = [format stringFromDate:Creat_at];
        }else{//前天以及前天之前
            format.dateFormat = @"MM-dd HH:mm";
            _created_at = [format stringFromDate:Creat_at];
        }
        
    }else{//不是今年
        format.dateFormat = @"yyyy-MM-dd HH:mm";
       _created_at =  [format stringFromDate:Creat_at];
    }
    
}

#warning 为什么这里必须用set方法而不是getter方法才能不超出界限
#warning .......... 有一个bug，没有图片，没有昵称，没有来源，只有时间和正文，而且就只有这一个cell
//
//-(void)setSource:(NSString *)source{
//
//    NSRange range = [source rangeOfString:@">"];
//    source = [source substringFromIndex:range.location + range.length];
//    range = [source rangeOfString:@"<"];
//    source = [source substringToIndex:range.location];
//    source = [NSString stringWithFormat:@"来自 %@",source];
//    
//    _source = source;
//    
//}



-(NSString *)source{
    //NSLog(@"%@",_source);
    NSString *source  = _source;
    if (source.length == 0 || source == @"") {
        return @"";
    }
    NSRange range = [source rangeOfString:@">"];
    source = [source substringFromIndex:range.location + range.length];
    range = [source rangeOfString:@"<"];
    source = [source substringToIndex:range.location];
    source = [NSString stringWithFormat:@"来自 %@",source];
        
    return source;
}



-(void)setRetweeted_status:(CyStatus *)retweeted_status{
    _retweeted_status = retweeted_status;
    
    _retweetName = [NSString stringWithFormat:@"@%@",retweeted_status.user.name];
}


@end
