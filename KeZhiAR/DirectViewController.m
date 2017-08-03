//
//  DirectViewController.m
//  KeZhiAR
//
//  Created by Mr.ZhE on 2017/5/31.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import "DirectViewController.h"

@interface DirectViewController ()
@property (nonatomic,assign)NSInteger i;
@property (nonatomic,strong)UIImageView * imageView;
@property (nonatomic,strong)NSArray *imageArray;
@property (nonatomic,strong)UIButton *nextBtn;
@property (nonatomic,strong)UIButton *jumpBtn;
@end

@implementation DirectViewController
//引导页
- (void)viewDidLoad {
    [super viewDidLoad];
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //添加引导页的5张图
     _imageArray= [NSArray arrayWithObjects:@"yd_01",@"yd_02-1",@"yd_03",@"yd_04",@"yd_05", nil];
    _i=0;
    [_imageView setImage:[UIImage imageNamed:_imageArray[_i]]];
     _nextBtn = [[UIButton alloc]init];
    _jumpBtn =[[UIButton alloc]init];
    [_jumpBtn setImage:[UIImage imageNamed:@"跳过"] forState:UIControlStateNormal];
    [_nextBtn setImage:[UIImage imageNamed:@"下一步"] forState:UIControlStateNormal];
    //第一个页面有跳过按钮
    if (_i==0) {
        _jumpBtn.frame =CGRectMake(self.view.frame.size.width-_jumpBtn.imageView.image.size.width-20, 40, _jumpBtn.imageView.image.size.width, _jumpBtn.imageView.image.size.height);
        [_jumpBtn addTarget:self action:@selector(turnToMain) forControlEvents:UIControlEventTouchUpInside];
    }
    
        _nextBtn.frame = CGRectMake(self.view.frame.size.width/2-_nextBtn.imageView.image.size.width/2, self.view.frame.size.height-150, _nextBtn.imageView.image.size.width, _nextBtn.imageView.image.size.height);
    
    [_nextBtn addTarget:self action:@selector(turnToNext:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_imageView];
    [self.view addSubview:_jumpBtn];
    [self.view addSubview:_nextBtn];
}

-(void)turnToNext:(UIButton *)sender{
    //其他页面不需要跳过按钮
    [_jumpBtn setHidden:YES];
    _i++;
    //只有在前5个页面中 点击按钮是切换图片
    if (_i<=4) {
        [_imageView setImage:[UIImage imageNamed:_imageArray[_i]]];
    }
    //第4个页面中按钮就改变位置
    if (_i==3) {
        _nextBtn.frame = CGRectMake(self.view.frame.size.width/2-_nextBtn.imageView.image.size.width/2, self.view.frame.size.height*3/5, _nextBtn.imageView.image.size.width, _nextBtn.imageView.image.size.height);
    }
    //最后一个页面的按钮要改变位置 而且要改变按钮样式及方法
    if (_i==4) {
        _nextBtn.frame = CGRectMake(self.view.frame.size.width/2-_nextBtn.imageView.image.size.width/2, self.view.frame.size.height/2.5, _nextBtn.imageView.image.size.width, _nextBtn.imageView.image.size.height);
        [_nextBtn setImage:[UIImage imageNamed:@"立即体验"] forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(turnToMain) forControlEvents:UIControlEventTouchUpInside];
    }

}
//跳转到主页面 没有动画过程
-(void)turnToMain{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [self presentViewController:mainStoryboard.instantiateInitialViewController animated:NO completion:nil];
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
