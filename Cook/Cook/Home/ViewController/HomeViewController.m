//
//  HomeViewController.m
//  Cook
//
//  Created by 诸超杰 on 16/4/23.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableView.h"
#import "HomeMoreCookBooksModelCell.h"
#import "HomeMoreCookBooksModel.h"
#import "RecipeListTableViewController.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) HomeTableView *hometableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.navigationController.navigationBar.translucent = NO;
    [LoadingDataAnimation startAnimation];
    
     _hometableView = [[HomeTableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 49) style:UITableViewStylePlain];
    [self.hometableView registerNib:[UINib nibWithNibName:@"HomeMoreCookBooksModelCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
     _hometableView.delegate = self;
     _hometableView.dataSource = self;
    
    [self.view addSubview: _hometableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchButton:) name:@"homeSearchButton" object:nil];
    
}

- (void)searchButton:(NSNotification *)noti {
    UIButton *button = noti.object;
    RecipeListTableViewController *recipeListVC = [[RecipeListTableViewController alloc] init];
    recipeListVC.keyword = button.titleLabel.text;
    [self.navigationController pushViewController:recipeListVC animated:YES];
}

#pragma mark ------- tableView协议方法 ------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return _hometableView.moreCookbooksArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeMoreCookBooksModelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    HomeMoreCookBooksModel *homeMoreCookBooksModel = _hometableView.moreCookbooksArray[indexPath.row];
    [cell setDataWithModel:homeMoreCookBooksModel];
    cell.selectionStyle = NO;
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREENWIDTH * 0.34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 300;
//}



 @end
