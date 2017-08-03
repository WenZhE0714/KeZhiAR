//
//  OfficialWebsiteView.m
//  KeZhiAR
//
//  Created by Mr.ZhE on 2017/4/24.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import "OfficialWebsiteView.h"


@implementation OfficialWebsiteView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加WKWebView网页
        WKWebView *webView = [[WKWebView alloc] initWithFrame:self.bounds];
        webView.navigationDelegate=self;
        //加载网址
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.cloudkz.cn/"]]];
        [self addSubview:webView];
        
        //加载提示动画
        _activityIndicator = [[UIActivityIndicatorView alloc] init];
        [_activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        _alertLabel = [[UILabel alloc]init];
        _alertLabel.textColor = [UIColor grayColor];
        _alertLabel.font = [UIFont fontWithName:@"system" size:7];
        [webView addSubview:_alertLabel];
        [webView addSubview:_activityIndicator];

    }
    return self;
}
-(void)layoutSubviews{
    _activityIndicator.frame =CGRectMake(self.frame.size.width/2, self.frame.size.height/2, 20, 20);
    [_activityIndicator setCenter:self.center];
    _alertLabel.frame = CGRectMake(self.center.x-50, self.center.y+10, 200, 20);

}
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //NSLog(@"didStartProvisionalNavigation");
    [_activityIndicator startAnimating];
    _alertLabel.text = @"正在加载官网";
}

-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    //NSLog(@"didCommitNavigation");
    
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //NSLog(@"didFinishNavigation");
    [_activityIndicator stopAnimating];
    _alertLabel.text = @"";
}
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [_activityIndicator stopAnimating];
    _alertLabel.text = @"加载失败";
}

@end
