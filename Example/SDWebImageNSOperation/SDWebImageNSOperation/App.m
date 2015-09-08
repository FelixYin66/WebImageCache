//
//  App.m
//  SDWebImageNSOperation
//
//  Created by FelixYin on 15/9/5.
//  Copyright © 2015年 felixios. All rights reserved.
//

#import "App.h"

@implementation App

+ (NSArray *)arrayApp{

    NSURL *path = [[NSBundle mainBundle] URLForResource:@"apps" withExtension:@"plist"];
    
    NSArray * array = [NSArray arrayWithContentsOfURL:path];
    
    
    //多加断言，当array.count != 0 时才会放行
    
    NSAssert(array.count != 0, @"App数据不能为空");
    
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:10];
    
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * __nonnull stop) {
        
        App *app = [[self alloc] initWithDict:obj];
        
        [arrayM addObject:app];
        
    }];
    
    
    return [arrayM copy];

}


- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        
        
        [self setValuesForKeysWithDictionary:dict];
        
    }

    return self;
}

@end
