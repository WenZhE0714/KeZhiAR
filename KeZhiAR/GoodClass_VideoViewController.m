//
//  GoodClass_VideoViewController.m
//  KeZhiAR
//
//  Created by Mr.ZhE on 2017/5/9.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import "GoodClass_VideoViewController.h"
#import "HcdCachePlayer.h"

@interface GoodClass_VideoViewController ()
{
    HcdCacheVideoPlayer *play;
}
@end

@implementation GoodClass_VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:244.0/255 green:244.0/255 blue:244.0/255 alpha:1];
    
    NSLog(@"%@",_shortVideo.name);
    //添加播放器
    play = [[HcdCacheVideoPlayer alloc]init];
    UIView *videoView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 0.5625)];
    [self.view addSubview:videoView];
    NSURL *url;
    if ([_shortVideo.fileName hasPrefix:@"https"] || [_shortVideo.fileName hasPrefix:@"http"]) {
        //网络
        url = [NSURL URLWithString:_shortVideo.fileName];//您要播放的url地址
    }else{
        //本地
        url =[[NSBundle mainBundle] URLForResource:_shortVideo.fileName withExtension:nil];
    }
    
    
    [play playWithUrl:url showView:videoView andSuperView:self.view withCache:YES];
    
    //添加返回按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 20, 20)];
    [backBtn setImage:[UIImage imageNamed:@"形状-12"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backToFront) forControlEvents:UIControlEventTouchUpInside];
    
    [play.showView addSubview:backBtn];
    
    
    
    //列表
    detailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20+videoView.frame.size.height, [UIScreen mainScreen].bounds.size.width, 80) style:UITableViewStyleGrouped];
    [self.view addSubview:detailTableView];
    
    detailTableView.delegate=self;
    detailTableView.dataSource=self;
    detailTableView.bounces=NO;
    detailTableView.showsVerticalScrollIndicator=NO;
    detailTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    detailTableView.scrollEnabled=NO;
    
    //介绍内容
    NSString *string = _shortVideo.introduce;
    CGSize labelSize = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-detailTableView.frame.size.height-play.showView.frame.size.height-30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, detailTableView.frame.origin.y+detailTableView.frame.size.height+5, labelSize.width-10, labelSize.height)];
    contentLabel.backgroundColor = [UIColor colorWithRed:244.0/255 green:244.0/255 blue:244.0/255 alpha:1];
    contentLabel.font = [UIFont systemFontOfSize:12];
    contentLabel.textColor = [UIColor colorWithRed:106.0/255 green:102.0/255 blue:102.0/255 alpha:1.0];
    contentLabel.numberOfLines=0;
    [self.view addSubview:contentLabel];
    contentLabel.text=string;

}
-(void)backToFront{
    if (play.isFullScreen) {
        [play toOrientation:UIInterfaceOrientationPortrait];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [play stop];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //分组数 也就是section数
    return 1;
}

//设置每个分组下tableview得行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
//每个分组上边预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
//每个分组下边预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
//每个分组下对应的tableview高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
//设置每行对应的cell（展示的内容）
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer=@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    if (indexPath.row==0) {
        
        cell.textLabel.text = _shortVideo.name;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        
        UIButton * favorBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-80, cell.frame.origin.y+5, 70, 30)];
        [favorBtn.layer setBorderColor:[UIColor colorWithRed:70.0/255 green:218.0/255 blue:193.0/255 alpha:1.0].CGColor];
        [favorBtn.layer setBorderWidth:1.0];
        [favorBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [favorBtn setTitleColor:[UIColor colorWithRed:70.0/255 green:218.0/255 blue:193.0/255 alpha:1.0] forState:UIControlStateNormal];
        favorBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [favorBtn addTarget:self action:@selector(favorNumAdd) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:favorBtn];
        
        //cell.separatorInset = UIEdgeInsetsMake(1, 1, 1, 1);
    }else{
        int browseNum =_shortVideo.browseNum;
        int favorNum = _shortVideo.favorNum;
        int duration = _shortVideo.durationTime;
        
        UIImageView *browseImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, cell.frame.origin.y+15, 10, 10)];
        [browseImageView setImage:[UIImage imageNamed:@"dsp_02"]];
        [cell addSubview:browseImageView];
        
        UILabel * browseLabel = [[UILabel alloc]initWithFrame:CGRectMake(browseImageView.frame.origin.x+browseImageView.frame.size.width+5, cell.frame.origin.y+15, 80, 10)];
        browseLabel.text = [NSString stringWithFormat:@"浏览：%d次",browseNum];
        browseLabel.textColor = [UIColor colorWithRed:154.0/255 green:154.0/255 blue:154.0/255 alpha:1.0];
        browseLabel.font = [UIFont systemFontOfSize:10];
        [cell addSubview:browseLabel];
        
        UIImageView *favorImageView = [[UIImageView alloc]initWithFrame:CGRectMake(browseLabel.frame.origin.x+browseLabel.frame.size.width+15  , cell.frame.origin.y+15, 10, 10)];
        [favorImageView setImage:[UIImage imageNamed:@"dsp_03"]];
        [cell addSubview:favorImageView];
        
        _favorLabel= [[UILabel alloc]initWithFrame:CGRectMake(favorImageView.frame.origin.x+favorImageView.frame.size.width+5, cell.frame.origin.y+15, 80, 10)];
        _favorLabel.text = [NSString stringWithFormat:@"收藏：%d人",favorNum];
        _favorLabel.textColor = [UIColor colorWithRed:154.0/255 green:154.0/255 blue:154.0/255 alpha:1.0];
        _favorLabel.font = [UIFont systemFontOfSize:10];
        [cell addSubview:_favorLabel];
        
        UIImageView *timeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_favorLabel.frame.origin.x+_favorLabel.frame.size.width+15  , cell.frame.origin.y+15, 10, 10)];
        [timeImageView setImage:[UIImage imageNamed:@"dsp_04"]];
        [cell addSubview:timeImageView];
        
        UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(timeImageView.frame.origin.x+timeImageView.frame.size.width+5, cell.frame.origin.y+15, 80, 10)];
        if (duration <60) {
            timeLabel.text = [NSString stringWithFormat:@"时长：%d秒",duration];
        }else if (duration<3600){
            timeLabel.text = [NSString stringWithFormat:@"时长：%d分%d秒",duration /60,duration%60];
        }else{
            timeLabel.text = [NSString stringWithFormat:@"时长：%d时%d分%d秒",duration /3600,(duration%3600)/60,(duration%3600)%60];
        }
        timeLabel.textColor = [UIColor colorWithRed:154.0/255 green:154.0/255 blue:154.0/255 alpha:1.0];
        timeLabel.font = [UIFont systemFontOfSize:10];
        [cell addSubview:timeLabel];
        
        
        //cell.separatorInset = UIEdgeInsetsMake(1, 1, 1, 1);
    }
    return cell;
}

-(void)favorNumAdd{
    //收藏数++
    
    if ([self.db open]) {
        [self.db beginTransaction];
        //executeUpdate要是NSObject类型 不能是原始数据类型
        NSNumber * newFavorNum = [NSNumber numberWithInteger:++_shortVideo.favorNum];
        NSNumber *selectedId = [NSNumber numberWithInteger:_shortVideo.id];
        NSNumber * favorState;
        if (_shortVideo.isFavor == 0) {
            favorState = [NSNumber numberWithInteger:++_shortVideo.isFavor];
        }else{
            favorState = [NSNumber numberWithInteger:--_shortVideo.isFavor];
            
        }
        BOOL isSuccuss = [self.db executeUpdate:@"UPDATE KeZhi_ShortVideo SET favorNum = ? , isFavor = ? where id = ?",newFavorNum,favorState,selectedId];
        if (isSuccuss) {
            NSLog(@"%d",_shortVideo.isFavor);
            NSLog(@"favorNumAdd:成功");
        }else{
            NSLog(@"favorNumAdd:失败");
        }
        
        [self.db commit];
    }
    [self.db close];
    _favorLabel.text = [NSString stringWithFormat:@"收藏：%d人",_shortVideo.favorNum];
    
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark - 关闭设备自动旋转, 然后手动监测设备旋转方向来旋转avplayerView
-(BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskPortrait;
}

@end

@implementation UINavigationController (Rotation)

- (BOOL)shouldAutorotate
{
    return [[self.viewControllers lastObject] shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}


@end
