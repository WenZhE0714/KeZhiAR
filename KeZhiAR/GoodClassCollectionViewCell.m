//
//  GoodClassCollectionViewCell.m
//  KeZhiAR
//
//  Created by Mr.ZhE on 2017/5/4.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import "GoodClassCollectionViewCell.h"

@implementation GoodClassCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:244.0/255 green:244.0/255 blue:244.0/255 alpha:1];
        
        self.imgView = [[UIImageView alloc]init];
        self.imgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:self.imgView];
        
        self.coverView = [[UIView alloc]init];
        self.coverView.backgroundColor = [UIColor colorWithRed:169.0/255 green:169.0/255 blue:169.0/255 alpha:0.5];
        [self.imgView addSubview:self.coverView];
        
        self.label = [[UILabel alloc]init];
        //_label.text = @"灭火器模型";
        [_label setTextColor:[UIColor whiteColor]];
        _label.font = [UIFont systemFontOfSize:12];
        [self.coverView addSubview:self.label];
        
        self.favorImageView = [[UIImageView alloc]init];
        [self.coverView addSubview:self.favorImageView];
        
        _browseNumLabel = [[UILabel alloc]init];
        //_browseNumLabel.text=@"468";
        [_browseNumLabel setTextColor:[UIColor whiteColor]];
        _browseNumLabel.font = [UIFont systemFontOfSize:10];
        [self.coverView addSubview:self.browseNumLabel];
    }
    return self;
}
-(void)layoutSubviews{
    _imgView.frame= CGRectMake(5, 5, self.window.frame.size.width-30, 120);
    _coverView.frame = CGRectMake(0, _imgView.frame.size.height-20, self.window.frame.size.width-30, 20) ;
    _label.frame = CGRectMake(10,3, 100, 10);
    _favorImageView.frame = CGRectMake(_label.frame.origin.x+_label.frame.size.width+5, 3, 10, 10);
    _browseNumLabel.frame = CGRectMake(_favorImageView.frame.origin.x+_favorImageView.frame.size.width+5, 3, 20, 10);
    
}

@end
