//
//  SectionView.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/7.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionView : UIView

/**
 *动态设置时间和节次的字体大小
 */
- (void)setSectionLabelFont:(CGFloat) sectionSize TimeLabelFont:(CGFloat) timeSize;

/*
 *初始化view
 *index 0～11
 */
- (void)initSectionView:(NSInteger)index;

@end
