//
//  MyFileFolderTableViewCell.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/9.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "MyFileFolderTableViewCell.h"
@interface MyFileFolderTableViewCell()
@property(nonatomic,strong) IBOutlet UILabel * folderTitle;
@end

@implementation MyFileFolderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setFolderTitleName:(NSString *)titleName
{
    self.folderTitle.text = titleName;
}
@end
