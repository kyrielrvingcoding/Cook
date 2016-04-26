//
//  MySelfTableView.m
//  Cook
//
//  Created by lanou on 16/4/25.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "MySelfTableView.h"
#import "MyselfHeaderView.h"

@implementation MySelfTableView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.frame = SCREENBOUNDS;
        [self createHeaderView];
    }
    return self;
}

- (void)createHeaderView {
    
     MyselfHeaderView *myselfHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"MyselfHeaderView" owner:nil options:nil]lastObject];
    self.tableHeaderView = myselfHeaderView;
}


@end
