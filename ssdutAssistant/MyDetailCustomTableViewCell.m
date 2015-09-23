//
//  MyDetailCustomTableViewCell.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/9.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "MyDetailCustomTableViewCell.h"
@interface MyDetailCustomTableViewCell()
@property (nonatomic ,strong) IBOutlet UILabel * title;
@property (nonatomic ,strong) IBOutlet UILabel * content;
@property (nonatomic ,strong) IBOutlet UIView * lineView;
@end

@implementation MyDetailCustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellType:(NSInteger)cellIndex;
{
    NSUserDefaults * userDefualt = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary * UserDic = [userDefualt objectForKey:UserContent_Key];
    
    switch (cellIndex) {
        case 3:
            self.title.text = @"姓名";
            self.content.text = [UserDic objectForKey:@"Name"];
            break;
        case 4:
            self.title.text = @"学号";
            self.content.text = [userDefualt objectForKey:MyStudentId_Key];
            self.lineView.backgroundColor = [UIColor whiteColor];
            break;
        case 6:
            self.title.text = @"学校";
            self.content.text = [UserDic objectForKey:@"University"];
            break;
        case 7:
            self.title.text = @"院系";
            self.content.text = [UserDic objectForKey:@"School"];
            self.lineView.backgroundColor = [UIColor whiteColor];
            break;
        case 9:
            self.title.text = @"性别";
            if ([[UserDic objectForKey:@"Sex"] boolValue]) {
                self.content.text = @"男生";
            }else{
                self.content.text = @"女生";
            }
            
            break;
            
        default:
            break;
    }
}

@end
