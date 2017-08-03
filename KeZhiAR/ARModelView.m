//
//  ARModelView.m
//  KeZhiAR
//
//  Created by Mr.ZhE on 2017/4/24.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import "ARModelView.h"
#import "ARModelCollectionViewCell.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height)
@implementation ARModelView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(NSArray *)arModelArray{
    if (!_arModelArray) {
        _arModelArray = [NSMutableArray array];
    }
    return _arModelArray;
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
            FMResultSet *resultSet = [self.db executeQuery:@"SELECT * FROM KeZhi_ARModel"];
            // 2.遍历结果
            while ([resultSet next]) {
                ARModel * model = [[ARModel alloc]init];
                
                model.id = [resultSet intForColumn:@"id"];
                model.name = [resultSet stringForColumn:@"name"];
                model.imageName = [resultSet stringForColumn:@"imageName"];
                model.browseNum = [resultSet intForColumn:@"browseNum"];
                model.favorNum = [resultSet intForColumn:@"favorNum"];
                model.introduce = [resultSet stringForColumn:@"introduce"];
                model.isFavor = [resultSet intForColumn:@"isFavor"];
                
                //NSLog(@"%d %@ %@ %d %@", video.id, video.name, video.fileName,video.durationTime,video.introduce);
                [mutArray addObject:model];
            }
            _arModelArray=mutArray;
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
            FMResultSet *resultSet = [self.db executeQuery:@"SELECT * FROM KeZhi_ARModel"];
            // 2.遍历结果
            while ([resultSet next]) {
                ARModel * model = [[ARModel alloc]init];
                
                model.id = [resultSet intForColumn:@"id"];
                model.name = [resultSet stringForColumn:@"name"];
                model.imageName = [resultSet stringForColumn:@"imageName"];
                model.browseNum = [resultSet intForColumn:@"browseNum"];
                model.favorNum = [resultSet intForColumn:@"favorNum"];
                model.introduce = [resultSet stringForColumn:@"introduce"];
                model.isFavor = [resultSet intForColumn:@"isFavor"];
                
                //NSLog(@"%d %@ %@ %d %@", video.id, video.name, video.fileName,video.durationTime,video.introduce);
                [mutArray addObject:model];
            }
            //_arModelArray=mutArray;
        }
        [self.db close];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.arModelArray addObjectsFromArray:mutArray];
            [self.collectionView reloadData];
            [self.collectionView.mj_footer endRefreshing];
            
        });
        
    });
}


- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        WaterFlowLayout *layout = [[WaterFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 30, self.frame.size.width, self.frame.size.height-30) collectionViewLayout:layout];
        
        //注册cell
        [_collectionView registerClass:[ARModelCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        //设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        layout.delegate=self;
        
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
    NSLog(@"arModel:%lu",(unsigned long)[self.arModelArray count]);
    _collectionView.mj_footer.hidden = self.arModelArray.count == 0;
    return [_arModelArray count];
}


#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    ARModelCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    
    //获取标题
    _model = self.arModelArray[indexPath.item];
    cell.label.text = _model.name;
    //获得缩略图
    [cell.imgView setImage:[UIImage imageNamed:_model.imageName]];
    //获得收藏数
    cell.browseNumLabel.text = [NSString stringWithFormat:@"%d",_model.favorNum];
    //NSLog(@"%d",_video.favorNum);
    //是否收藏 状态显示
    if (_model.isFavor) {
        cell.favorImageView.image = [UIImage imageNamed:@"sy_03"];
    }else{
        [cell.favorImageView setImage:[UIImage imageNamed:@"sy_02"]];
        
    }
    return cell;
}


#pragma mark UICollectionView被选中时调用的方法
/*
 -(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
 {
 _model=self.arModelArray[indexPath.item];
 
 //访问一次就修改访问次数
 if ([self.db open]) {
 [self.db beginTransaction];
 //executeUpdate要是NSObject类型 不能是原始数据类型
 NSNumber * newBrowseNum = [NSNumber numberWithInteger:++_model.browseNum];
 NSNumber *selectedId = [NSNumber numberWithInteger:_model.id];
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
 //    ShortVideo_VideoViewController *view = [[ShortVideo_VideoViewController alloc]init];
 //    view.selectedItemNum = indexPath.item;
 //    view.shortVideo = _shortVideoArray[indexPath.item];
 //    view.db = self.db;
 //    [[self viewController].navigationController pushViewController:view animated:YES];
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
 */
- (CGFloat)WaterFlowLayout:(WaterFlowLayout *)WaterFlowLayout heightForRowAtIndexPath:(NSInteger )index itemWidth:(CGFloat)itemWidth
{
    _model = self.arModelArray[index];
    UIImage * image = [[UIImage alloc]init];
    image = [UIImage imageNamed:_model.imageName];
    return itemWidth * image.size.height / image.size.width+10;
}
@end
