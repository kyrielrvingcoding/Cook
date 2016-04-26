//
//  RecipeListTableViewController.m
//  Cook
//
//  Created by 叶旺 on 16/4/25.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "RecipeListTableViewController.h"
#import "HomeMoreCookBooksModel.h"
#import "HomeMoreCookBooksModelCell.h"

@interface RecipeListTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RecipeListTableViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)requestData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *search = @{@"m":@"mobile",@"c":@"index",@"a":@"getCookbooksByKeyword", @"keyword":_keyword, @"sessionId":@"f43db4b7e09f0b61717894dd078885d0"};
    [manager GET:@"http://www.xdmeishi.com/index.php" parameters:search progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array= [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil] objectForKey:@"data"];
        for (NSDictionary *dic in array) {
            HomeMoreCookBooksModel *cookbooksModel = [[HomeMoreCookBooksModel alloc] init];
            [cookbooksModel setValuesForKeysWithDictionary:dic];
            NSDictionary * referrerDic = dic[@"referrer"];
            HomeReferrerModel *referrerModel = [[HomeReferrerModel alloc] init];
            [referrerModel setValuesForKeysWithDictionary:referrerDic];
            cookbooksModel.referrerModel = referrerModel;
            [self.dataArray addObject:cookbooksModel];
        }
        [self.tableView reloadData];
        [LoadingDataAnimation stopAnimation];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [LoadingDataAnimation startAnimation];
    [self requestData];
    [self createTableView];
    // Do any additional setup after loading the view.
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 49) style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeMoreCookBooksModelCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([HomeMoreCookBooksModel class])];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark ------- tableView协议方法 ------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeMoreCookBooksModelCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeMoreCookBooksModel class]) forIndexPath:indexPath];
    HomeMoreCookBooksModel *cookBooksModel = self.dataArray[indexPath.row];
    [cell setDataWithModel:cookBooksModel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
