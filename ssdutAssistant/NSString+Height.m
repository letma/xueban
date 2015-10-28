//
//  NSString+Height.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/27.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "NSString+Height.h"

@implementation NSString (Height)
- (CGFloat)getHeightWithFontSize:(CGFloat)size Width:(CGFloat)width
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:size]};
    CGSize contentSize = [self boundingRectWithSize:CGSizeMake(width, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return contentSize.height;

}
@end
