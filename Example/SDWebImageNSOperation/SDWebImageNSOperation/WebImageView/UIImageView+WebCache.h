//
//  UIImageView+WebCache.h
//  DefineNSOperation
//
//  Created by FelixYin on 15/9/8.
//  Copyright © 2015年 felixios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WebCache)

@property (nonatomic,copy) NSString *urlString;

- (void) setImageWithURL:(NSString *)urlString;

@end
