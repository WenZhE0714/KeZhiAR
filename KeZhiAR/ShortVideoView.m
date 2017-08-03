//
//  ShortVideoView.m
//  KeZhiAR
//
//  Created by Mr.ZhE on 2017/4/24.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "ShortVideoView.h"
#import "ShortVideoCollectionViewCell.h"
#import "ShortVideo_VideoViewController.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height)

@implementation ShortVideoView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(NSArray *)shortVideoArray{
    if (!_shortVideoArray) {
        _shortVideoArray= [NSMutableArray array];
    }
    return _shortVideoArray;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _sortView = [[SortLaneView alloc]init];
        [self addSubview:_sortView];
        
        [self addSubview:self.collectionView];
        [_sortView.newestBtn addTarget:self action:@selector(sortWithNewest:) forControlEvents:UIControlEventTouchUpInside];
        [_sortView.hotestBtn addTarget:self action:@selector(sortWithHotest:) forControlEvents:UIControlEventTouchUpInside];
        [_sortView.moreFavorBtn addTarget:self action:@selector(sortWithMoreFavor:) forControlEvents:UIControlEventTouchUpInside];
        //数据库
        NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"KeZhiAR.sqlite"];
        NSBundle *bundle = [NSBundle mainBundle];
        NSError *error;
        
        NSString *filenameAgo = [bundle pathForResource:@"KeZhiAR" ofType:@"sqlite"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        [fileManager copyItemAtPath:filenameAgo toPath:filename error:&error];
        FMDatabase *db=[FMDatabase databaseWithPath:filename];
        if (![db open]) {
            NSLog(@"失败");
        }
        self.db = db;
        
    }
    [self setupRefresh];
    
    return self;
}

-(void)sortWithNewest:(id)sender{
    NSLog(@"最新");
}
-(void)sortWithHotest:(id)sender{
    NSLog(@"最热");
}
-(void)sortWithMoreFavor:(id)sender{
    NSLog(@"最多收藏");
}
-(void)layoutSubviews{
    //NSLog(@"layoutSubviews");
    _text.frame = self.bounds;
    _sortView.frame = CGRectMake(0, 0, self.frame.size.width, 30);
}

- (void)setupRefresh
{
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    [_collectionView.mj_header beginRefreshing];
    
    _collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    _collectionView.mj_footer.hidden = YES;
}

- (void)loadNewShops
{
    NSMutableArray * mutArray = [NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([self.db open]) {
            
            // 1.执行查询语句
            FMResultSet *resultSet = [self.db executeQuery:@"SELECT * FROM KeZhi_ShortVideo"];
            // 2.遍历结果
            while ([resultSet next]) {
                ShortVideoModel * video = [[ShortVideoModel alloc]init];
                
                video.id = [resultSet intForColumn:@"id"];
                video.name = [resultSet stringForColumn:@"name"];
                video.fileName = [resultSet stringForColumn:@"fileName"];
                video.browseNum = [resultSet intForColumn:@"browseNum"];
                video.favorNum = [resultSet intForColumn:@"favorNum"];
                video.durationTime = [resultSet intForColumn:@"durationTime"];
                video.introduce = [resultSet stringForColumn:@"introduce"];
                video.isFavor = [resultSet intForColumn:@"isFavor"];
                
                //NSLog(@"%d %@ %@ %d %@", video.id, video.name, video.fileName,video.durationTime,video.introduce);
                [mutArray addObject:video];
            }
            _shortVideoArray=mutArray;
        }
        [self.db close];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            [_collectionView.mj_header endRefreshing];
            
        });
        
    });
}

- (void)loadMoreShops
{
    NSMutableArray * mutArray = [NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([self.db open]) {
            
            // 1.执行查询语句
            FMResultSet *resultSet = [self.db executeQuery:@"SELECT * FROM KeZhi_ShortVideo"];
            // 2.遍历结果
            while ([resultSet next]) {
                ShortVideoModel * video = [[ShortVideoModel alloc]init];
                
                video.id = [resultSet intForColumn:@"id"];
                video.name = [resultSet stringForColumn:@"name"];
                video.fileName = [resultSet stringForColumn:@"fileName"];
                video.browseNum = [resultSet intForColumn:@"browseNum"];
                video.favorNum = [resultSet intForColumn:@"favorNum"];
                video.durationTime = [resultSet intForColumn:@"durationTime"];
                video.introduce = [resultSet stringForColumn:@"introduce"];
                video.isFavor = [resultSet intForColumn:@"isFavor"];
                
                //NSLog(@"%d %@ %@ %d %@", video.id, video.name, video.fileName,video.durationTime,video.introduce);
                [mutArray addObject:video];
            }
            _shortVideoArray=mutArray;
        }
        [self.db close];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            [self.collectionView.mj_footer endRefreshing];
            
        });
        
    });
}


//获得缩略图的方法
- (UIImage *)getScreenShotImageFromVideoPath:(NSString *)filePath{
    //视频路径URL
    NSURL *url;
    if ([_video.fileName hasPrefix:@"https"] || [_video.fileName hasPrefix:@"http"]) {
        //网络
        url = [NSURL URLWithString:_video.fileName];//您要播放的url地址
    }else{
        //本地
        url =[[NSBundle mainBundle] URLForResource:_video.fileName withExtension:nil];
    }
    UIImage *shotImage;
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    shotImage = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return shotImage;
    
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 30, self.frame.size.width, self.frame.size.height-30) collectionViewLayout:flowLayout];
        //定义每个UICollectionView 的大小
        flowLayout.itemSize = CGSizeMake((fDeviceWidth-20)/2, fDeviceWidth/3+10);
        //定义每个UICollectionView 横向的间距
        flowLayout.minimumLineSpacing = 0;
        //定义每个UICollectionView 纵向的间距
        flowLayout.minimumInteritemSpacing = 0;
        //定义每个UICollectionView 的边距距
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);//上左下右
        //注册cell
        [_collectionView registerClass:[ShortVideoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        //设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        //背景颜色
        _collectionView.backgroundColor = [UIColor colorWithRed:244.0/255 green:244.0/255 blue:244.0/255 alpha:1];
        //自适应大小
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
    }
    return _collectionView;
}
#pragma mark - UICollectionView delegate dataSource
#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //return [cellArray count];
    NSLog(@"shortVideo:%lu",(unsigned long)[self.shortVideoArray count]);
    _collectionView.mj_footer.hidden = self.shortVideoArray.count == 0;
    return [_shortVideoArray count];
}


#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    ShortVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    
    //获取标题
    _video = self.shortVideoArray[indexPath.item];
    cell.label.text = _video.name;
    //获得缩略图
    cell.imgView.image = [self getScreenShotImageFromVideoPath:_video.fileName];
    //获得收藏数
    cell.browseNumLabel.text = [NSString stringWithFormat:@"%d",_video.favorNum];
    //NSLog(@"%d",_video.favorNum);
    //是否收藏 状态显示
    if (_video.isFavor) {
        cell.favorImageView.image = [UIImage imageNamed:@"sy_03"];
    }else{
        [cell.favorImageView setImage:[UIImage imageNamed:@"sy_02"]];
        
    }
    return cell;
}


#pragma mark UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _video=self.shortVideoArray[indexPath.item];
    
    //访问一次就修改访问次数
    if ([self.db open]) {
        [self.db beginTransaction];
        //executeUpdate要是NSObject类型 不能是原始数据类型
        NSNumber * newBrowseNum = [NSNumber numberWithInteger:++_video.browseNum];
        NSNumber *selectedId = [NSNumber numberWithInteger:_video.id];
        BOOL isSuccuss = [self.db executeUpdate:@"UPDATE KeZhi_ShortVideo SET browseNum = ? where id = ?",newBrowseNum,selectedId];
        if (isSuccuss) {
            NSLog(@"修改访问次数:成功");
        }else{
            NSLog(@"修改访问次数:失败");
        }
        
        [self.db commit];
    }
    [self.db close];
    
    //点击跳转页面
    ShortVideo_VideoViewController *view = [[ShortVideo_VideoViewController alloc]init];
    view.selectedItemNum = indexPath.item;
    view.shortVideo = _shortVideoArray[indexPath.item];
    view.db = self.db;
    [[self viewController].navigationController pushViewController:view animated:YES];
    //    NSLog(@"选择%ld",indexPath.item);
}


- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


@end
