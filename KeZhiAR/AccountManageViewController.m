//
//  AccountManageViewController.m
//  KeZhiAR
//
//  Created by Mr.ZhE on 2017/4/29.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import "AccountManageViewController.h"

@interface AccountManageViewController ()

@end

@implementation AccountManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:70.0/255 green:218.0/255 blue:193.0/255 alpha:1.0]];
    self.navigationController.navigationBar.backItem.title=@"";
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.title = @"账号管理";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    
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
