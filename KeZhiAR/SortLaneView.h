//
//  SortLaneView.h
//  KeZhiAR
//
//  Created by Mr.ZhE on 2017/4/24.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SortDelegate
-(void)sortWithNewest:(id)sender;
-(void)sortWithHotest:(id)sender;
-(void)sortWithMoreFavor:(id)sender;
@end

@interface SortLaneView : UIView
@property(nonatomic,strong)UIButton * newestBtn;
@property(nonatomic,strong)UIButton * hotestBtn;
@property(nonatomic,strong)UIButton * moreFavorBtn;
@end
