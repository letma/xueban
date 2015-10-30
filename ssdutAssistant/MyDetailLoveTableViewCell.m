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
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * urlStr = [NSString stringWithFormat:@"%@change_love_status/%ld",DLUT_SOCIAL_IP,loveStatus];
    NSLog(@"%@",urlStr);
    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4];
    [request setValue:[userDefaults objectForKey:LoginToken_Str] forHTTPHeaderField:@"Token"];
    NSData * messageData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary * dic;
    if (messageData) {
        dic = [NSJSONSerialization JSONObjectWithData:messageData options:NSJSONReadingMutableContainers error:nil];
    }
    if ([dic objectForKey:@"status"]) {
        if (loveStatus == 0) {
            self.loveStatusLabel.text = @"单身";
            [userDefaults setObject:@"0" forKey:MySingle_Key];
        }else{
            self.loveStatusLabel.text = @"恋爱中";
            [userDefaults setObject:@"1" forKey:MySingle_Key];
        }
    }else{
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"更改失败" message:@"" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alertView show];
    }

}

-(void)initLoveStatus
{
    NSUserDefaults *  userDefaults = [NSUserDefaults standardUserDefaults];
   // NSDictionary * userDic = [userDefaults objectForKey:UserContent_Key];
    NSLog(@"single%@",[userDefaults objectForKey:MySingle_Key]);
    if ([[userDefaults objectForKey:MySingle_Key] isEqual:@"0"]) {
        self.loveStatusLabel.text = @"单身";
    }else{
        self.loveStatusLabel.text = @"恋爱中";
    }
}
@end
