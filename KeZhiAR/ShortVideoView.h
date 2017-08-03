//
//  ShortVideoView.h
//  KeZhiAR
//
//  Created by Mr.ZhE on 2017/4/24.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SortLaneView.h"
#import "ShortVideoModel.h"
#import "FMDB.h"

@interface ShortVideoView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,SortDelegate>{
    NSMutableArray *cellArray;
}
@property(nonatomic,strong)UILabel *text;
@property(nonatomic,strong)SortLaneView *sortView;
@property(nonatomic,strong)UICollectionView * collectionView;

@property (nonatomic,retain)NSArray * shortVideoArray;
@property (nonatomic,strong)ShortVideoModel *video;

@property(nonatomic,strong)FMDatabase *db;

- (UIImage *)getScreenShotImageFromVideoPath:(NSString *)filePath;

@end
