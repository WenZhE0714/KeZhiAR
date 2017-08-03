//
//  MainViewController.m
//  KeZhiAR
//
//  Created by Mr.ZhE on 2017/4/23.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import "MainViewController.h"
#import "OfficialWebsiteView.h"
#import "ARModelView.h"
#import "ShortVideoView.h"
#import "GoodClassView.h"
#import "ExploreView.h"
#define viewSize CGRectMake(0, _vc.frame.size.height+20, self.view.frame.size.width, self.view.frame.size.height-_vc.frame.size.height-20-49)
@interface MainViewController ()<WJScrollerMenuDelegate>
@property(nonatomic,strong)OfficialWebsiteView *officialWebView;
@property(nonatomic,strong)ARModelView * arModelView;
@property(nonatomic,strong)ShortVideoView * shortVideoView;
@property(nonatomic,strong)GoodClassView * gootClassView;
@property(nonatomic,strong)ExploreView * exploreView;
@property(nonatomic,strong)WJScrollerMenuView *vc;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@property (nonatomic,assign) NSInteger indexNum;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _indexNum = 0;
    //状态栏覆盖颜色
    UIView * stateView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    stateView.backgroundColor = [UIColor colorWithRed:70.0/255 green:218.0/255 blue:193.0/255 alpha:1.0];
    [self.view addSubview:stateView];
    // Do any additional setup after loading the view.
    //加载滚动菜单栏
    _vc = [[WJScrollerMenuView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 50) showArrayButton:YES];
    _vc.delegate=self;
    _vc.backgroundColor=[UIColor colorWithRed:70.0/255 green:218.0/255 blue:193.0/255 alpha:1.0];
    _vc.selectedColor = [UIColor whiteColor];
    _vc.noSlectedColor = [UIColor lightGrayColor];
    _vc.myTitleArray=@[@"科智官网",@"AR模型",@"短视频",@"精品课堂",@"探索发现"];
    //初始化首页显示内容
    _vc.currentIndex = 0;
    _officialWebView =[[OfficialWebsiteView alloc]initWithFrame:viewSize];
    
    [self.view addSubview:_officialWebView];
    
    [self.view addSubview:_vc];
    
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //刷新数据库 重新加载数据
    if (_indexNum == 2) {
        [_shortVideoView.collectionView reloadData];
    }
    if (_indexNum == 3) {
        [_gootClassView.collectionView reloadData];
    }
}

//手势处理
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        if (_indexNum < 0 ){
            _indexNum = 0 ;
        }else if ( _indexNum != 0 ){
            _indexNum --;
            [UIView beginAnimations: nil context : nil ];
            
            // 持续时间
            [UIView setAnimationDuration: 0.2 ];
            
            // 在出动画的时候减缓速度
            [UIView setAnimationCurve: UIViewAnimationCurveEaseOut ];
            
            // 添加动画开始及结束的代理
            
            [UIView setAnimationDelegate: self ];
            [UIView setAnimationWillStartSelector: @selector (begin)];
            [UIView setAnimationDidStopSelector : @selector (stop)];
            // 动画效果
            [UIView setAnimationTransition : UIViewAnimationTransitionNone forView :self. view cache: YES ];
            
            //View 切换
            if (_indexNum!=0){
                [_officialWebView removeFromSuperview];
                
            }else{
                _vc.currentIndex = 0;
                //修改选中跟没选中的Button字体颜色
                for (int i=0; i<_vc.items.count; i++) {
                    [_vc.items[i] setTitleColor:(i==_indexNum)?_vc.selectedColor:_vc.noSlectedColor forState:UIControlStateNormal];
                }
                if (_officialWebView == nil) {
                    _officialWebView =[[OfficialWebsiteView alloc]initWithFrame:viewSize];
                }
                [self.view insertSubview:_officialWebView atIndex:0];
            }
            
            if (_indexNum!=1){
                [_arModelView removeFromSuperview];
                
            }else{
                _vc.currentIndex = 1;
                //修改选中跟没选中的Button字体颜色
                for (int i=0; i<_vc.items.count; i++) {
                    [_vc.items[i] setTitleColor:(i==_indexNum)?_vc.selectedColor:_vc.noSlectedColor forState:UIControlStateNormal];
                }
                if (_arModelView == nil) {
                    _arModelView = [[ARModelView alloc]initWithFrame:viewSize];
                }
                [self.view insertSubview:_arModelView atIndex:0];
            }
            
            if (_indexNum!=2){
                [_shortVideoView removeFromSuperview];
                
            }else{
                _vc.currentIndex = 2;
                //修改选中跟没选中的Button字体颜色
                for (int i=0; i<_vc.items.count; i++) {
                    [_vc.items[i] setTitleColor:(i==_indexNum)?_vc.selectedColor:_vc.noSlectedColor forState:UIControlStateNormal];
                }
                if (_shortVideoView ==nil) {
                    _shortVideoView = [[ShortVideoView alloc]initWithFrame:viewSize];
                }
                [self.view insertSubview:_shortVideoView atIndex:0];
            }
            
            if (_indexNum!=3){
                [_gootClassView removeFromSuperview];
                
            }else{
                _vc.currentIndex = 3;
                //修改选中跟没选中的Button字体颜色
                for (int i=0; i<_vc.items.count; i++) {
                    [_vc.items[i] setTitleColor:(i==_indexNum)?_vc.selectedColor:_vc.noSlectedColor forState:UIControlStateNormal];
                }
                if (_gootClassView ==nil) {
                    _gootClassView = [[GoodClassView alloc]initWithFrame:viewSize];
                }
                [self.view insertSubview:_gootClassView atIndex:0];
            }
            
            if (_indexNum!=4){
                [_exploreView removeFromSuperview];
                
            }else{
                _vc.currentIndex = 4;
                //修改选中跟没选中的Button字体颜色
                for (int i=0; i<_vc.items.count; i++) {
                    [_vc.items[i] setTitleColor:(i==_indexNum)?_vc.selectedColor:_vc.noSlectedColor forState:UIControlStateNormal];
                }
                if (_exploreView ==nil) {
                    _exploreView = [[ExploreView  alloc]initWithFrame:viewSize];
                }
                [self.view insertSubview:_exploreView atIndex:0];
            }
            [UIView commitAnimations ];
        }
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (_indexNum > _vc.items.count ){
            _indexNum = _vc.items.count-1 ;
        }else if ( _indexNum != _vc.items.count-1 ){
            _indexNum ++;
            [UIView beginAnimations: nil context : nil ];
            
            // 持续时间
            [UIView setAnimationDuration: 0.2 ];
            
            // 在出动画的时候减缓速度
            [UIView setAnimationCurve: UIViewAnimationCurveEaseOut ];
            
            // 添加动画开始及结束的代理
            
            [UIView setAnimationDelegate: self ];
            [UIView setAnimationWillStartSelector: @selector (begin)];
            [UIView setAnimationDidStopSelector : @selector (stop)];
            // 动画效果
            [UIView setAnimationTransition : UIViewAnimationTransitionNone forView :self. view cache: YES ];
            
            //View 切换
            if (_indexNum!=0){
                [_officialWebView removeFromSuperview];
                
            }else{
                _vc.currentIndex = 0;
                //修改选中跟没选中的Button字体颜色
                for (int i=0; i<_vc.items.count; i++) {
                    [_vc.items[i] setTitleColor:(i==_indexNum)?_vc.selectedColor:_vc.noSlectedColor forState:UIControlStateNormal];
                }
                if (_officialWebView == nil) {
                    _officialWebView =[[OfficialWebsiteView alloc]initWithFrame:viewSize];
                }
                [self.view insertSubview:_officialWebView atIndex:0];
            }
            
            if (_indexNum!=1){
                [_arModelView removeFromSuperview];
                
            }else{
                _vc.currentIndex = 1;
                //修改选中跟没选中的Button字体颜色
                for (int i=0; i<_vc.items.count; i++) {
                    [_vc.items[i] setTitleColor:(i==_indexNum)?_vc.selectedColor:_vc.noSlectedColor forState:UIControlStateNormal];
                }
                if (_arModelView == nil) {
                    _arModelView = [[ARModelView alloc]initWithFrame:viewSize];
                }
                [self.view insertSubview:_arModelView atIndex:0];
            }
            
            if (_indexNum!=2){
                [_shortVideoView removeFromSuperview];
                
            }else{
                _vc.currentIndex = 2;
                //修改选中跟没选中的Button字体颜色
                for (int i=0; i<_vc.items.count; i++) {
                    [_vc.items[i] setTitleColor:(i==_indexNum)?_vc.selectedColor:_vc.noSlectedColor forState:UIControlStateNormal];
                }
                if (_shortVideoView ==nil) {
                    _shortVideoView = [[ShortVideoView alloc]initWithFrame:viewSize];
                }
                [self.view insertSubview:_shortVideoView atIndex:0];
            }
            
            if (_indexNum!=3){
                [_gootClassView removeFromSuperview];
                
            }else{
                _vc.currentIndex = 3;
                //修改选中跟没选中的Button字体颜色
                for (int i=0; i<_vc.items.count; i++) {
                    [_vc.items[i] setTitleColor:(i==_indexNum)?_vc.selectedColor:_vc.noSlectedColor forState:UIControlStateNormal];
                }
                if (_gootClassView ==nil) {
                    _gootClassView = [[GoodClassView alloc]initWithFrame:viewSize];
                }
                [self.view insertSubview:_gootClassView atIndex:0];
            }
            
            if (_indexNum!=4){
                [_exploreView removeFromSuperview];
                
            }else{
                _vc.currentIndex = 4;
                //修改选中跟没选中的Button字体颜色
                for (int i=0; i<_vc.items.count; i++) {
                    [_vc.items[i] setTitleColor:(i==_indexNum)?_vc.selectedColor:_vc.noSlectedColor forState:UIControlStateNormal];
                }
                if (_exploreView ==nil) {
                    _exploreView = [[ExploreView  alloc]initWithFrame:viewSize];
                }
                [self.view insertSubview:_exploreView atIndex:0];
            }
            [UIView commitAnimations ];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)itemDidSelectedWithIndex:(NSInteger)index{
    //根据不同的选项卡 跳转不同view
    if (index == 0) {
        _indexNum=0;
        if (_officialWebView == nil) {
            _officialWebView =[[OfficialWebsiteView alloc]initWithFrame:viewSize];
        }
        [self removeView];
        [self.view addSubview:_officialWebView];
        
        
    }
    
    if (index == 1) {
        _indexNum=1;
        if (_arModelView == nil) {
            _arModelView = [[ARModelView alloc]initWithFrame:viewSize];
        }
        [self removeView];
        [self.view addSubview:_arModelView];
        
    }
    
    if (index == 2) {
        _indexNum=2;
        if (_shortVideoView == nil) {
            _shortVideoView = [[ShortVideoView alloc]initWithFrame:viewSize];
        }
        [self removeView];
        [self.view addSubview:_shortVideoView];
        
    }
    
    if (index == 3) {
        _indexNum=3;
        if( _gootClassView == nil){
            _gootClassView = [[GoodClassView alloc]initWithFrame:viewSize];
            
        }
        [self removeView];
        [self.view addSubview:_gootClassView];
        
    }
    
    if (index == 4) {
        _indexNum=4;
        if( _exploreView == nil){
            _exploreView = [[ExploreView  alloc]initWithFrame:viewSize];
            
        }
        [self removeView];
        [self.view addSubview:_exploreView];
        
    }
}

-(void)removeView{
    [_officialWebView removeFromSuperview];
    [_shortVideoView removeFromSuperview];
    [_arModelView removeFromSuperview];
    [_gootClassView removeFromSuperview];
    [_exploreView removeFromSuperview];
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
