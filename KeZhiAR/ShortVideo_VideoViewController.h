//
//  VideoViewController.h
//  KeZhiAR
//
//  Created by Mr.ZhE on 2017/5/2.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShortVideoModel.h"
#import "FMDB.h"

@interface ShortVideo_VideoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * detailTableView;
}
@property (nonatomic, copy) NSString *videoUrlStr;
@property (nonatomic,assign) NSInteger selectedItemNum;

@property (nonatomic,strong)ShortVideoModel * shortVideo;
@property(nonatomic,strong)FMDatabase *db;

@property (nonatomic,strong)UILabel * favorLabel;
@end
