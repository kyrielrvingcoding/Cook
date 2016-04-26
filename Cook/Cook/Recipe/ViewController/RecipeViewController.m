//
//  RecipeViewController.m
//  Cook
//
//  Created by 诸超杰 on 16/4/23.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "RecipeViewController.h"
#import "RecipeCategoryModel.h"
#import "TYCircleCell.h"
#import "TYCircleMenu.h"
#import "RecipeListWaterfallViewController.h"
#import "NewWorkListWaterfallViewController.h"
#import "RecipeSearchBar.h"

#define Home_URL @"http://www.xdmeishi.com/index.php"

@interface RecipeViewController () <TYCircleMenuDelegate>

@property (nonatomic, strong) NSMutableArray *categoryArray;
@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation RecipeViewController

- (NSMutableArray *)categoryArray {
    if (!_categoryArray) {
        self.categoryArray = [NSMutableArray array];
    }
    return _categoryArray;
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        self.imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (void)createModelAddToArrayWithDictionary:(NSDictionary *)dic {
    if (dic == nil) {
        return;
    }
    RecipeCategoryModel *model = [[RecipeCategoryModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    [self.categoryArray addObject:model];
}

- (void)requestData {
    NSDictionary *parameter = @{@"m":@"mobile",@"c":@"index",@"a":@"getHomeEntity",@"sessionId":@"f43db4b7e09f0b61717894dd078885d0"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:Home_URL parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dictionary = [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil] objectForKey:@"data"];
        [self createModelAddToArrayWithDictionary:dictionary[@"mostPopularOfWeek"]]; //本周最热
        [self createModelAddToArrayWithDictionary:dictionary[@"newWorks"]]; //最新作品
        [self createModelAddToArrayWithDictionary:dictionary[@"newCookbook"]]; //最新菜谱
        [self createModelAddToArrayWithDictionary:dictionary[@"newPai"]]; //最新随拍
        [self createModelAddToArrayWithDictionary:dictionary[@"recommend"]]; //家常菜
        [self createModelAddToArrayWithDictionary:dictionary[@"breakfast"]]; //面条
        [self createModelAddToArrayWithDictionary:dictionary[@"lunch"]]; //私房菜
        [self createModelAddToArrayWithDictionary:dictionary[@"dinner"]]; //小吃
        [self createCircleMenu];
        [LoadingDataAnimation stopAnimation];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    [LoadingDataAnimation startAnimation];
    self.navigationItem.titleView = [[RecipeSearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH * 0.8, 30)];
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)createCircleMenu {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, SCREENWIDTH, SCREENHEIGHT - 44)];
    imageView.image = [UIImage imageNamed:@"beijingtupian04"];
    imageView.userInteractionEnabled = YES;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 180)];
    label.backgroundColor = [UIColor colorWithRed:220 / 255.0 green:1.0 blue:156 / 255.0 alpha:1.0];
    [imageView addSubview:label];
    [self.view addSubview:imageView];
    NSMutableDictionary *menuDic = [NSMutableDictionary dictionary];
    for (int i = 0; i < _categoryArray.count; i ++) {
        if (![_categoryArray[i] name]) {
            [menuDic setValue:[_categoryArray[i] imageUrl] forKey:[_categoryArray[i] Description]];
        } else {
            [menuDic setValue:[_categoryArray[i] imageUrl] forKey:[_categoryArray[i] name]];
        }
    }
    NSArray *titleArray = [menuDic allKeys];
    for (NSString *key in titleArray) {
        [self.imageArray addObject:menuDic[key]];
    }
    TYCircleMenu *menu = [[TYCircleMenu alloc] initWithRadious:(SCREENWIDTH * 4 / 5) itemOffset:0 imageArray:self.imageArray titleArray:titleArray cycle:YES menuDelegate:self];
    [imageView addSubview:menu];
}

//点击cell的方法
- (void)selectMenuAtIndex:(NSInteger)index {
    if (index == 2 | index == 6) {
        NewWorkListWaterfallViewController *newworkVC = [[NewWorkListWaterfallViewController alloc] init];
        [self.navigationController pushViewController:newworkVC animated:YES];
    } else {
        RecipeListWaterfallViewController *waterfallVC = [[RecipeListWaterfallViewController alloc] init];
        for (RecipeCategoryModel *model in _categoryArray) {
            if ([model.imageUrl isEqualToString:self.imageArray[index]]) {
                waterfallVC.ID = model.ID;
            }
        }
        [self.navigationController pushViewController:waterfallVC animated:YES];
    }
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
