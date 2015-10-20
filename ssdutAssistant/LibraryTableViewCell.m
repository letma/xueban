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
    
    NSString * btnImgName;
    switch (borrowStatus) {
        case 0:
            btnImgName = @"erp_library_icon_borrowSucceed";
            break;
        case 1:
            self.borrowBtn.userInteractionEnabled = YES;
            btnImgName = @"erp_library_icon_borrowNow";
            break;
        case 2:
            btnImgName = @"erp_library_icon_borrowSucceed";
            break;
        case 3:
            btnImgName = @"erp_library_icon_timeOut";
            break;
            
        default:
            break;
    }
    
    [self.borrowBtn setImage:UIIMGName(btnImgName) forState:UIControlStateNormal];

}
@end
