//
//  GoodClassView.h
//  KeZhiAR
//
//  Created by Mr.ZhE on 2017/5/2.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SortLaneView.h"
#import "GoodClassModel.h"
#import "FMDB.h"

@interface GoodClassView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,SortDelegate>{
    NSMutableArray *cellArray;
}
@property(nonatomic,strong)UILabel *text;
@property(nonatomic,strong)SortLaneView *sortView;
@property(nonatomic,strong)UICollectionView * collectionView;


@property (nonatomic,retain)NSArray * goodClassArray;
@property (nonatomic,strong)GoodClassModel *video;

@property(nonatomic,strong)FMDatabase *db;

- (UIImage *)getScreenShotImageFromVideoPath:(NSString *)filePath;

@end
