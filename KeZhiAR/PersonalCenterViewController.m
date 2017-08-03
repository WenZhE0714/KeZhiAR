//
//  PersonalCenterViewController.m
//  KeZhiAR
//
//  Created by Mr.ZhE on 2017/4/29.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "MyFavorViewController.h"
#import "AccountManageViewController.h"
#import "CleanCacheViewController.h"
#import "CopyRightViewController.h"
#import "LoginViewController.h"
@interface PersonalCenterViewController ()
@property (weak, nonatomic) IBOutlet UIView *upView;
@property (weak, nonatomic) IBOutlet UIButton *myFavorBtn;

@end

@implementation PersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //头像及登录按钮
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(23, (_upView.frame.size.height-70)/2, 60, 60)];
    _headImageView.layer.masksToBounds=YES;
    _headImageView.layer.cornerRadius=30;
    [_headImageView setImage:[UIImage imageNamed:@"gr_01"]];
    [self.view addSubview:_headImageView];
    
    _loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(23+60+10, (_upView.frame.size.height-_myFavorBtn.frame.size.height)/2, 80, 20)];
    [_loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_loginBtn addTarget:self action:@selector(turnToLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    //列表
    personalTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.upView.frame.size.height, self.view.frame.size.width,self.view.frame.size.height-self.upView.frame.size.height-self.tabBarController.tabBar.frame.size.height) style:UITableViewStyleGrouped];
    [self.view addSubview:personalTableView];

    personalTableView.delegate=self;
    personalTableView.dataSource=self;
    personalTableView.bounces =NO;
    personalTableView.showsVerticalScrollIndicator = NO;
    personalTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    //我的收藏按钮
    [_myFavorBtn addTarget:self action:@selector(turnToMyFavor) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark Function
-(void)turnToMyFavor{
    MyFavorViewController *myFavorViewController = [[MyFavorViewController alloc]init];
    [self.navigationController pushViewController:myFavorViewController animated:YES];
}
-(void)turnToLogin{
    LoginViewController *loginViewController = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginViewController animated:YES];
}


#pragma mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //分组数 也就是section数
    return 2;
}

//设置每个分组下tableview得行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }else{
        return 1;
    }
}
//每个分组上边预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.1;
    }
    if (section==1) {
        return 5;
    }
    return 0.01;
}
//每个分组下边预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
//每个分组下对应的tableview高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
//设置每行对应的cell（展示的内容）
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer=@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell.imageView setImage:[UIImage imageNamed:@"gr_04"]];
            cell.textLabel.text = @"账号管理";
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.separatorInset = UIEdgeInsetsMake(1, 1, 1, 1);
        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell.imageView setImage:[UIImage imageNamed:@"gr_05"]];
            cell.textLabel.text = @"清理缓存";
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.separatorInset = UIEdgeInsetsMake(1, 1, 1, 1);
        }
    }
    
    if (indexPath.section==1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.imageView setImage:[UIImage imageNamed:@"gr_06"]];
        cell.textLabel.text = @"版权信息";
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.separatorInset = UIEdgeInsetsMake(1, 1, 1, 1);
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //
    [self performSelector:@selector(delectCellColor:) withObject:nil afterDelay:0.5];
        if (indexPath.section==0) {
        if (indexPath.row==0) {
            AccountManageViewController *accountManageViewController = [[AccountManageViewController alloc]init];
            [self.navigationController pushViewController:accountManageViewController animated:YES];
        }else{
            CleanCacheViewController *cleanCacheViewController = [[CleanCacheViewController alloc]init];
            [self.navigationController pushViewController:cleanCacheViewController animated:YES];
        }
    }
    if (indexPath.section==1) {
        CopyRightViewController *copyRightViewController = [[CopyRightViewController alloc]init];
        [self.navigationController pushViewController:copyRightViewController animated:YES];
    }
}

- (void)delectCellColor:(id)sender{
    [personalTableView deselectRowAtIndexPath:[personalTableView indexPathForSelectedRow] animated:YES];
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
