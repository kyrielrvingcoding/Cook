//
//  MyselfHeaderView.h
//  Cook
//
//  Created by lanou on 16/4/25.
//  Copyright © 2016年 class17. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyselfHeaderView : UIView
@property (strong, nonatomic) IBOutlet UIImageView *headerImageview;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (strong, nonatomic) IBOutlet UILabel *genderLabel;
@property (strong, nonatomic) IBOutlet UILabel *jionTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *careLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@end
