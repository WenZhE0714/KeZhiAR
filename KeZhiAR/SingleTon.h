//
//  SingleTon.h
//  Unity-iPhone
//
//  Created by Mr.ZhE on 2017/3/26.
//
//

#import <Foundation/Foundation.h>
@interface SingleTon : NSObject
@property(nonatomic,assign)float cellWidth;

+(instancetype)shareInstance;
@end
