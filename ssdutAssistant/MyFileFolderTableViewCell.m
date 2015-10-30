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
@property(nonatomic,strong) IBOutlet UIImageView * headImg;
@end

@implementation MyFileFolderTableViewCell
@synthesize fileName;
@synthesize formate;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFolderTitleName:(NSString *)titleName
{
    
    fileName = titleName;
    NSInteger location = [fileName rangeOfString:@"."].location;
    self.folderTitle.text = [fileName substringToIndex:location - 1];
   
    formate = [fileName substringFromIndex:location];
    UIImage * tempImg ;
    
    if ([formate isEqual:@".apk"]) {
        tempImg = UIIMGName(@"icon_myfile_apk");
    }else if ([formate isEqual:@".doc"] || [formate isEqual:@".docx"]) {
        tempImg = UIIMGName(@"icon_myfile_doc");
    }else if ([formate isEqual:@".pdf"]) {
        tempImg = UIIMGName(@"icon_myfile_pdf");
    }else if ([formate isEqual:@".jpg"]||[formate isEqual:@".jpeg"]||[formate isEqual:@".png"]) {
        tempImg = UIIMGName(@"icon_myfile_pic");
    }else if ([formate isEqual:@".txt"]) {
        tempImg = UIIMGName(@"icon_myfile_txt");
    }else if ([formate isEqual:@".xls"] || [formate isEqual:@".xlsx"]) {
        tempImg = UIIMGName(@"icon_myfile_xls");
    }else if ([formate isEqual:@".zip"] ) {
        tempImg = UIIMGName(@"icon_myfile_zip");
    }else{
        tempImg = UIIMGName(@"icon_myfile_other");
    }
    
    self.headImg.image = tempImg;
    
}
@end
