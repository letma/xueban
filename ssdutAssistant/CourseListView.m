//
//  CourseListView.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/6.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//



#import "CourseListView.h"
#import "SectionView.h"

@interface CourseListView()
@property (nonatomic) IBOutlet UIView * horizonView;
@property (nonatomic) IBOutlet UIView * verticalView;
@property (nonatomic) IBOutlet UIScrollView * horizonScrollView;
@property (nonatomic) IBOutlet UIScrollView * verticalScrollView;
@end

@implementation CourseListView

// 7 : 17 : 10*4
-(void)initCourseListView
{

    [self insetSectionViews];
    
}

//添加左边栏的课节views
- (void)insetSectionViews
{
    CGFloat sectionHeight ;
    CGFloat sectionWidth = WINWIDTH/64.0*7;
    if (WINHEIGHT == 480) {
        sectionHeight = (WINHEIGHT - 64)/9.0;
    }else{
        sectionHeight = (WINHEIGHT - 64)/11.0;
    }
    for (NSInteger i = 0 ; i < 12; i ++) {
        NSArray * nibArray = [[NSBundle mainBundle]loadNibNamed:@"SectionView" owner:self options:nil];
        SectionView * sectionView = [nibArray objectAtIndex:0];
        [sectionView initSectionView:i];
        sectionView.frame = CGRectMake(0, 0 + sectionHeight * i, sectionWidth, sectionHeight);
        NSLog(@"%f",sectionHeight);
        [self.verticalView addSubview:sectionView];
    }
}

@end
