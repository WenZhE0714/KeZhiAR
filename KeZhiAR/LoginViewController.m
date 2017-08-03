//
//  LoginViewController.m
//  KeZhiAR
//
//  Created by Mr.ZhE on 2017/4/29.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.backItem.title=@"";
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    self.title = @"登录";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.isMovingFromParentViewController) {
        [self.navigationController setNavigationBarHidden:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
