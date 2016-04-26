//
//  MyselfHeaderView.m
//  Cook
//
//  Created by lanou on 16/4/25.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "MyselfHeaderView.h"


@implementation MyselfHeaderView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT * 0.3);
        [self createBackgroundViewAndHeaderView];
    }
    return self;
}

- (void)createBackgroundViewAndHeaderView {
    //########之后改
    UIImageView * backgroundImageView = (UIImageView *)[self viewWithTag:3000];
    backgroundImageView.image = [UIImage imageNamed:@"test"];
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectView.frame = self.frame;
    effectView.alpha = 0.6;
    [backgroundImageView addSubview:effectView];

    UIImageView * headerImageview = (UIImageView *)[self viewWithTag:3001];
    headerImageview.image = [UIImage imageNamed:@"test"];

}

@end
