//
//  MyDetailLoveTableViewCell.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/9.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "MyDetailLoveTableViewCell.h"
@interface MyDetailLoveTableViewCell()
@property (nonatomic,strong)IBOutlet UILabel * loveStatusLabel;
@end

@implementation MyDetailLoveTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setLoveStatus:(NSInteger)loveStatus
{
    if (loveStatus == 0) {
        self.loveStatusLabel.text = @"单身狗";
    }else{
        self.loveStatusLabel.text = @"恋爱中";
    }
}

-(void)initLoveStatus
{
    NSUserDefaults *  userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userDic = [userDefaults objectForKey:UserContent_Key];
    NSLog(@"single%@",[userDic objectForKey:@"Single"]);
    if (![[userDic objectForKey:@"Single"] boolValue]) {
        self.loveStatusLabel.text = @"单身狗";
    }else{
        self.loveStatusLabel.text = @"恋爱中";
    }
}
@end
