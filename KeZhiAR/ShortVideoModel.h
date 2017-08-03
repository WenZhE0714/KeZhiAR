//
//  ShortVideoModel.h
//  KeZhiAR
//
//  Created by Mr.ZhE on 2017/5/6.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShortVideoModel : NSObject
//对应数据库
@property (nonatomic,assign) int id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *fileName;
@property (nonatomic,assign) int browseNum;
@property (nonatomic,assign) int favorNum;
@property (nonatomic,assign) int durationTime;
@property (nonatomic,copy) NSString *introduce;
@property (nonatomic,assign) int isFavor;

@end
