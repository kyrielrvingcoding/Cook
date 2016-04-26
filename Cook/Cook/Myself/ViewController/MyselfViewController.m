//
//  MyselfViewController.m
//  Cook
//
//  Created by 诸超杰 on 16/4/23.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "MyselfViewController.h"
#import "CYloginRegisterViewController.h"
#import "MySelfTableView.h"

@interface MyselfViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MySelfTableView *myselfTableView;

@end

@implementation MyselfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationController.navigationBarHidden = YES;
    _myselfTableView = [[[NSBundle mainBundle] loadNibNamed:@"MySelfTableView" owner:nil options:nil] lastObject];
    _myselfTableView.dataSource = self;
    _myselfTableView.delegate = self;
    [self.view addSubview:_myselfTableView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(change)];
    [self.view addGestureRecognizer:tap];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   static NSString *str = @"reuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.textLabel.text = @"测试";
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.imageView.image = [UIImage imageNamed:@"ms_caipu_level_un"];
        if (indexPath.row % 2 == 0) {
             cell.backgroundColor = [UIColor colorWithRed:234 / 255.0 green:230 / 255.0 blue:148 / 255.0 alpha:1.0];
        } else {
            cell.backgroundColor = [UIColor colorWithRed:210 / 255.0 green:206 / 255.0 blue:134 / 255.0 alpha:1.0];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)change {/*
    CYloginRegisterViewController *cy = [[CYloginRegisterViewController alloc] initWithNibName:@"CYloginRegisterViewController" bundle:nil];
    [self presentViewController:cy animated:YES completion:nil];*/
}
 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
