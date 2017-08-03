//
//  CollectionViewCell.m
//  collectionView
//
//  Created by shikee_app05 on 14-12-10.
//  Copyright (c) 2014年 shikee_app05. All rights reserved.
//

#import "ShortVideoCollectionViewCell.h"

@implementation ShortVideoCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:244.0/255 green:244.0/255 blue:244.0/255 alpha:1];
        
        self.imgView = [[UIImageView alloc]init];
        self.imgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:self.imgView];
        
        self.label = [[UILabel alloc]init];
        //_label.text = @"灭火器模型";
        _label.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.label];
        
        self.favorImageView = [[UIImageView alloc]init];
        [self addSubview:self.favorImageView];
        
        _browseNumLabel = [[UILabel alloc]init];
        //_browseNumLabel.text=@"468";
        [_browseNumLabel setTextColor:[UIColor lightGrayColor]];
        _browseNumLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:self.browseNumLabel];
    }
    return self;
}
-(void)layoutSubviews{
    _imgView.frame= CGRectMake(5, 5, self.window.frame.size.width/2-15, 95);
    _label.frame = CGRectMake(5,2+5+_imgView.frame.size.height, 100, 10);
    _favorImageView.frame = CGRectMake(self.window.frame.size.width/2-5-40-2, 2+5+_imgView.frame.size.height, 10, 10);
    _browseNumLabel.frame = CGRectMake(self.window.frame.size.width/2-5-30, 2+5+_imgView.frame.size.height, 20, 10);
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
