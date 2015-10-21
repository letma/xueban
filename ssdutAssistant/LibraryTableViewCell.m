//
//  LibraryTableViewCell.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/17.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "LibraryTableViewCell.h"
@interface LibraryTableViewCell()
@property (nonatomic,strong) IBOutlet UIView * backGroundView;
@property(nonatomic) IBOutlet UILabel * bookNameLbl;
@property (nonatomic) IBOutlet UILabel * locationLbl;
@property (nonatomic) IBOutlet UILabel * startTimeLbl;
@property (nonatomic) IBOutlet UILabel * endTimeLbl;
@property (nonatomic) IBOutlet UILabel * borrowNumLbl;
@property (nonatomic) IBOutlet UIButton * borrowBtn;
@end

@implementation LibraryTableViewCell

- (void)awakeFromNib {
    
    self.backGroundView.layer.shadowColor = UIColorFromRGB(0xaaaaaa).CGColor;
    self.backGroundView.layer.shadowOffset = CGSizeMake(6, 6);
    self.backGroundView.layer.shadowOpacity = 0.8;
    self.backGroundView.layer.shadowRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)creatCellWithName:(NSString *)nameStr Location:(NSString *)locationStr StartTime:(NSString *)startTimeStr EndTime:(NSString *)endTimeStr NumStr:(NSString *)numStr BorrowStatus:(NSInteger)borrowStatus
{
    self.borrowBtn.userInteractionEnabled = NO;
    
    self.bookNameLbl.text = nameStr;
    self.locationLbl.text = locationStr;
    self.startTimeLbl.text = startTimeStr;
    self.endTimeLbl.text = endTimeStr;
    self.borrowNumLbl.text = numStr;
    
    NSString * titleStr;
    NSInteger colorNum;
    
    switch (borrowStatus) {
        case 0:
            titleStr = @"无须续借";
            colorNum = 0xA0A0A0;
            break;
        case 1:
            self.borrowBtn.userInteractionEnabled = YES;
            titleStr = @"立即续借";
            colorNum = 0x16ADC7;
            break;
        case 2:
            titleStr = @"续借成功";
            colorNum = 0xA0A0A0;
            break;
        case 3:
            titleStr = @"图书到期";
            colorNum = 0xE44F64;
            break;
            
        default:
            break;
    }
    
    [self.borrowBtn setTitle:titleStr forState:UIControlStateNormal];
    [self.borrowBtn setTitleColor:UIColorFromRGB(colorNum) forState:UIControlStateNormal];

}
@end
