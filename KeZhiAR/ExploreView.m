//
//  ExploreView.m
//  KeZhiAR
//
//  Created by Mr.ZhE on 2017/5/2.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import "ExploreView.h"

@implementation ExploreView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:244.0/255 green:244.0/255 blue:244.0/255 alpha:1];
        
        _text = [[UILabel alloc]init];
        [_text setText:@"探索发现版块"];
        [_text setTextColor:[UIColor blackColor]];
        [_text setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_text];
        
        _sortView = [[SortLaneView alloc]init];
        [self addSubview:_sortView];
        
    }
    return self;
}

-(void)layoutSubviews{
    _text.frame = self.bounds;
    _sortView.frame = CGRectMake(0, 0, self.frame.size.width, 30);
    
}
@end
