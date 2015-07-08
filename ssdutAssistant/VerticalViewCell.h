//
//  VerticalViewCell.h
//  ssdutAssistant
//
//  Created by OurEDA on 8/7/15.
//  Copyright (c) 2015 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerticalViewCell : UITableViewCell
/**
 *动态设置时间和节次的字体大小
 */
- (void)setSectionLabelFont:(CGFloat) sectionSize TimeLabelFont:(CGFloat) timeSize;

/*
 *初始化view
 *index 0～11
 */
- (void)initSectionViewWithIndex:(NSInteger)index;

@end
