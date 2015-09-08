//
//  AppCellTableViewCell.h
//  SDWebImageNSOperation
//
//  Created by FelixYin on 15/9/5.
//  Copyright © 2015年 felixios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App.h"

@interface AppCellTableViewCell : UITableViewCell

@property (nonatomic,weak) App *app;

@property (weak, nonatomic) IBOutlet UIImageView *appImg;

@property (weak, nonatomic) IBOutlet UILabel *appName;

@property (weak, nonatomic) IBOutlet UILabel *downloadNum;

@end
