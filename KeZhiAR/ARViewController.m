//
//  ARViewController.m
//  KeZhiAR
//
//  Created by Mr.ZhE on 2017/6/27.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import "ARViewController.h"
#import "OpenGLView.h"
@interface ARViewController ()

@end

@implementation ARViewController{
    OpenGLView *glView;
}

- (void)loadView {
    self->glView = [[OpenGLView alloc] initWithFrame:CGRectZero];
    self.view = self->glView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self->glView setOrientation:self.interfaceOrientation];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 20, 20)];
    [backBtn setImage:[UIImage imageNamed:@"形状-12"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(turnBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}

-(void)turnBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self->glView start];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self->glView stop];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self->glView resize:self.view.bounds orientation:self.interfaceOrientation];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self->glView setOrientation:toInterfaceOrientation];
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
