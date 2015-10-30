//
//  PreviewViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/30.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "PreviewViewController.h"

@interface PreviewViewController ()<QLPreviewControllerDataSource,QLPreviewControllerDelegate>

@end

@implementation PreviewViewController
@synthesize pathStr;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xefefef);
    self.delegate = self;
    self.dataSource = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller
{
    return 1;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    return [NSURL fileURLWithPath:pathStr];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
