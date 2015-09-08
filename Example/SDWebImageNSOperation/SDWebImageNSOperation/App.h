//
//  App.h
//  SDWebImageNSOperation
//
//  Created by FelixYin on 15/9/5.
//  Copyright © 2015年 felixios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

@interface App : NSObject

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *icon;

@property (nonatomic,copy) NSString *download;


//加载所有的App信息

+ (NSArray *) arrayApp;

- (instancetype) initWithDict:(NSDictionary *) dict;

@end
