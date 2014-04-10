//
//  BMKBaseViewController.m
//  BaiduMap
//
//  Created by xiangming on 14-4-10.
//  Copyright (c) 2014年 a. All rights reserved.
//

#import "BMKBaseViewController.h"

@interface BMKBaseViewController ()

@end

@implementation BMKBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




- (void)setIsBackButton:(BOOL)isBackButton
{
    _isBackButton = isBackButton;
    if(_isBackButton){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 44, 44);
        [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"BaseNavigationBar_Back_IronGray_Arrow_Normal.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"BaseNavigationBar_Back_IronGray_Arrow_Highlighted.png"] forState:UIControlStateHighlighted];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    
}


- (void)setIsCancelButton:(BOOL)isCancelButton

{
    _isCancelButton = isCancelButton;
    if(_isCancelButton){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"BaseNavigationBar_Back_White_Cross_Normal.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"BaseNavigationBar_Back_White_Cross_Highlighted.png"] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(0, 0, 44, 44);
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    
}



- (void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)cancleAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
