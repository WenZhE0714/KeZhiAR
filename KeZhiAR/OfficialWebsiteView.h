//
//  OfficialWebsiteView.h
//  KeZhiAR
//
//  Created by Mr.ZhE on 2017/4/24.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface OfficialWebsiteView : UIView<WKNavigationDelegate>
@property (nonatomic,strong)UIActivityIndicatorView* activityIndicator;
@property (nonatomic,strong)UILabel *alertLabel;
@end
