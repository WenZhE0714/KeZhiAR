//
//  ARModelCollectionViewCell.m
//  KeZhiAR
//
//  Created by Mr.ZhE on 2017/5/9.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import "ARModelCollectionViewCell.h"
#import "SingleTon.h"
@implementation ARModelCollectionViewCell

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
    CGFloat imageWidth = _imgView.image.size.width;
    CGFloat imageHeight = _imgView.image.size.height;
    CGFloat cellWidth = [SingleTon shareInstance].cellWidth;
    _imgView.frame= CGRectMake(5, 5,cellWidth, cellWidth*imageHeight/imageWidth);
    _label.frame = CGRectMake(5,2+5+_imgView.frame.size.height, 100, 10);
    _favorImageView.frame = CGRectMake(self.window.frame.size.width/2-5-40-2, 2+5+_imgView.frame.size.height, 10, 10);
    _browseNumLabel.frame = CGRectMake(self.window.frame.size.width/2-5-30, 2+5+_imgView.frame.size.height, 20, 10);
    
}

@end
