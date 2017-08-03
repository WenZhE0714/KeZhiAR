//
//  ARModel.h
//  KeZhiAR
//
//  Created by Mr.ZhE on 2017/5/9.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARModel : NSObject
//对应数据库
@property (nonatomic,assign) int id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,assign) int browseNum;
@property (nonatomic,assign) int favorNum;
@property (nonatomic,copy) NSString *introduce;
@property (nonatomic,assign) int isFavor;
@end
