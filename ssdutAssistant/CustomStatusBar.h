//
//  CustomStatusBar.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/27.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

//自定义statusbar 暂时没用上
#import <UIKit/UIKit.h>

@interface CustomStatusBar : UIWindow
{
    UILabel *_statusMsgLabel;
}

- (void)showStatusMessage:(NSString *)message;
- (void)hide;
@end
