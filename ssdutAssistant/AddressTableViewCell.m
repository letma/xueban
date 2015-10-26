//
//  AddressTableViewCell.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/25.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "AddressTableViewCell.h"
@interface AddressTableViewCell()
@property (nonatomic,strong) IBOutlet UILabel * addressLbl;
@end
@implementation AddressTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAddress:(NSString *)addressStr
{
    self.addressLbl.text = addressStr;
}
@end
