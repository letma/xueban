//
//  MyFeedBackViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/9.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "MyFeedBackViewController.h"

@interface MyFeedBackViewController ()<UITextViewDelegate>
@property(nonatomic,strong) IBOutlet UIView * feedBackView;
@property(nonatomic,strong) IBOutlet UITextView * contentTV;
@property(nonatomic,strong) IBOutlet UIButton * feedBackBtn;
@property(nonatomic,strong) IBOutlet UILabel * holderLabel;
@end

@implementation MyFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"反馈";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.contentTV.delegate = self;

    self.feedBackBtn.layer.cornerRadius = 5;
    
    self.feedBackView.userInteractionEnabled = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 -(IBAction)tapDo:(id)sender
{
    [self.contentTV resignFirstResponder];
     [self FeedBackViewDown];
}

#pragma mark - UIView

-(void)FeedBackViewUp
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.view.frame = CGRectMake(0, - 100, WINWIDTH, WINHEIGHT);
    [UIView commitAnimations];
}

-(void)FeedBackViewDown
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.view.frame = CGRectMake(0, 64, WINWIDTH, WINHEIGHT);
    [UIView commitAnimations];
}

#pragma mark - UITextView
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [self FeedBackViewUp];
    

}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    [self FeedBackViewDown];
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (self.contentTV.text.length == 0) {
        self.holderLabel.text = @"点击输入您的宝贵意见";
    }else{
        self.holderLabel.text = @"";
    }
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
