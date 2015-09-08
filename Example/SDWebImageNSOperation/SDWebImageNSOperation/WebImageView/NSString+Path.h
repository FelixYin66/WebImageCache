//
//  NSString+Path.h
//  SDWebImageNSOperation
//
//  Created by FelixYin on 15/6/4.
//  Copyright © 2015年 felixios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Path)

///  追加文档目录
- (NSString *)appendDocumentPath;
///  追加缓存目录
- (NSString *)appendCachePath;
///  追加临时目录
- (NSString *)appendTempPath;

@end
