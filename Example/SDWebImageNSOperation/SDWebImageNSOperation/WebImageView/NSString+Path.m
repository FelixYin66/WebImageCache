//
//  NSString+Path.h
//  SDWebImageNSOperation
//
//  Created by FelixYin on 15/6/4.
//  Copyright © 2015年 felixios. All rights reserved.
//

#import "NSString+Path.h"

@implementation NSString (Path)

- (NSString *)appendDocumentPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)appendCachePath {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)appendTempPath {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:self.lastPathComponent];
}

@end
