//
//  GoodClass_VideoViewController.h
//  KeZhiAR
//
//  Created by Mr.ZhE on 2017/5/9.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDB.h"
#import "GoodClassModel.h"

@interface GoodClass_VideoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * detailTableView;
}
@property (nonatomic, copy) NSString *videoUrlStr;
@property (nonatomic,assign) NSInteger selectedItemNum;

@property (nonatomic,strong)GoodClassModel * shortVideo;
@property(nonatomic,strong)FMDatabase *db;

@property (nonatomic,strong)UILabel * favorLabel;


@end
