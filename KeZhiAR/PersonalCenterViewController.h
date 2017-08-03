//
//  PersonalCenterViewController.h
//  KeZhiAR
//
//  Created by Mr.ZhE on 2017/4/29.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalCenterViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *personalTableView;
}
@property(nonatomic,strong) UIImageView *headImageView;
@property(nonatomic,strong) UIButton *loginBtn;
@end
