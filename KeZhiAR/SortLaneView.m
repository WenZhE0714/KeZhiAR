//
//  SortLaneView.m
//  KeZhiAR
//
//  Created by Mr.ZhE on 2017/4/24.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import "SortLaneView.h"

@implementation SortLaneView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _newestBtn = [[UIButton alloc]init];
        _hotestBtn = [[UIButton alloc]init];
        _moreFavorBtn = [[UIButton alloc]init];
    
        [_newestBtn setTitle:@"最新" forState:UIControlStateNormal];
        [_newestBtn setTitleColor:[UIColor colorWithRed:70.0/255 green:218.0/255 blue:193.0/255 alpha:1.0] forState:UIControlStateNormal];
        _newestBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_newestBtn addTarget:self action:@selector(sortWithNewest:) forControlEvents:UIControlEventTouchUpInside];
        
        [_hotestBtn setTitle:@"最热" forState:UIControlStateNormal];
        [_hotestBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _hotestBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_hotestBtn addTarget:self action:@selector(sortWithHotest:) forControlEvents:UIControlEventTouchUpInside];
        
        [_moreFavorBtn setTitle:@"最多收藏" forState:UIControlStateNormal];
        [_moreFavorBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _moreFavorBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_moreFavorBtn addTarget:self action:@selector(sortWithMoreFavor:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_newestBtn];
        [self addSubview:_hotestBtn];
        [self addSubview:_moreFavorBtn];
    }
    return self;
}

-(void)layoutSubviews{
    _newestBtn.frame = CGRectMake(0, 0, self.frame.size.width/3, self.frame.size.height);
    _hotestBtn.frame = CGRectMake(self.frame.size.width/3, 0, self.frame.size.width/3, self.frame.size.height);
    _moreFavorBtn.frame = CGRectMake(self.frame.size.width/3*2, 0, self.frame.size.width/3, self.frame.size.height);
}

//改颜色
-(void)sortWithNewest:(id)sender{
    [_newestBtn setTitleColor:[UIColor colorWithRed:70.0/255 green:218.0/255 blue:193.0/255 alpha:1.0] forState:UIControlStateNormal];
    [_hotestBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_moreFavorBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

-(void)sortWithHotest:(id)sender{
    [_hotestBtn setTitleColor:[UIColor colorWithRed:70.0/255 green:218.0/255 blue:193.0/255 alpha:1.0] forState:UIControlStateNormal];
    [_newestBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_moreFavorBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

-(void)sortWithMoreFavor:(id)sender{
    [_moreFavorBtn setTitleColor:[UIColor colorWithRed:70.0/255 green:218.0/255 blue:193.0/255 alpha:1.0] forState:UIControlStateNormal];
    [_newestBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_hotestBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

@end
