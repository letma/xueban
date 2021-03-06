//
//  WeekDayButton.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/7.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeekDayButton : UIButton


/*
 *设置星期几和日期
 */
-(void)setWeekDayLabel:(NSString *)weekDay DayLabel:(NSString *)day;

/*
 *动态设置日期星期的字体大小
 */
-(void)setWeekDayFont:(CGFloat)weekDaySize DayFont:(CGFloat)daySize;
/*
 *如果是这个button所在的日期调用    17 12
 *weekDay day line 都变绿  HelveticaNeue-Bold  #00bad1
 *weekDay字体变粗
 */
-(void)onItDay;

/*
 *如果这个button被点击时调用
 *weekDay字体变粗 line变成奇怪的棕色  HelveticaNeue-Bold #828282 
 *把今天和所选的button比较 若相同line变绿 否则便棕
*/
-(void)clickedOnByTodayTag:(NSInteger )todayTag WithButtonTag:(NSInteger)buttonTag;

/*
 *如果其他button被点击 上一button要恢复状态时调用
 *weekDay字体变细 line变成clearcolor    HelveticaNeue  #ffffff
 */
-(void)clickedOut;
@end
