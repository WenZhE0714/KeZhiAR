//
//  MainTabBarViewController.m
//  KeZhiAR
//
//  Created by Mr.ZhE on 2017/4/29.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "ARViewController.h"
@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建camera按钮 覆盖中间的tabBarItem
    UIButton *cameraBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.tabBar.frame.size.width*3.7/9, self.tabBar.frame.origin.y-10, 60, 60)];
    [cameraBtn setImage:[UIImage imageNamed:@"形状-7"] forState:UIControlStateNormal];
    [cameraBtn addTarget:self action:@selector(turnToAR) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cameraBtn];
    
    // Do any additional setup after loading the view.
}
-(void)turnToAR{
    ARViewController *controller = [[ARViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
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
