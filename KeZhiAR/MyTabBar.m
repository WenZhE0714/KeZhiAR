//
//  myTabBar.m
//  program
//
//  Created by Mr.ZhE on 2017/4/1.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import "MyTabBar.h"

@implementation MyTabBar


-(void)layoutSubviews{
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    line.backgroundColor = [UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1.0];
    [self addSubview:line];
    
    
    self.backgroundColor = [UIColor whiteColor];
    self.tintColor = [UIColor colorWithRed:70.0/255 green:218.0/255 blue:193.0/255 alpha:1.0];
    self.items[2].image = [UIImage imageNamed:@"sy_07"];
    self.items[2].selectedImage = [[UIImage imageNamed:@"sy_06"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.items[2].title = @"个人中心";
    
    //占一个tabBarItem
    self.items[1].image = [[UIImage imageNamed:@"sy_06"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    self.items[0].image = [UIImage imageNamed:@"sy_04"];
    self.items[0].selectedImage = [[UIImage imageNamed:@"sy_05"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.items[0].title = @"经典案例";


}


@end
