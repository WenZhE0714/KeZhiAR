//
//  ARModelView.h
//  KeZhiAR
//
//  Created by Mr.ZhE on 2017/4/24.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SortLaneView.h"
#import "WaterFlowLayout.h"
#import "FMDB.h"
#import "ARModel.h"
@interface ARModelView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,WaterFlowLayoutDelegate,SortDelegate>{
    NSMutableArray *cellArray;
}
@property(nonatomic,strong)UILabel *text;
@property(nonatomic,strong)SortLaneView *sortView;
@property(nonatomic,strong)UICollectionView * collectionView;

@property (nonatomic,retain)NSMutableArray * arModelArray;
@property (nonatomic,strong)ARModel *model;

@property(nonatomic,strong)FMDatabase *db;

@end
