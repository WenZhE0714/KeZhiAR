//
//  SingleTon.m
//  Unity-iPhone
//
//  Created by Mr.ZhE on 2017/3/26.
//
//

#import "SingleTon.h"

@implementation SingleTon
static SingleTon * _instance = nil;
+(instancetype)shareInstance{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL]init];
    });
    return _instance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    return [SingleTon shareInstance];
}

-(id)copyWithZone:(struct _NSZone *)zone{
    return [SingleTon shareInstance];
}

@end
