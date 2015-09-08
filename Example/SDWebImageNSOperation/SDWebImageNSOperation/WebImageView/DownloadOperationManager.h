//
//  DownloadOperationManager.h
//  DefineNSOperation
//
//  Created by FelixYin on 15/9/7.
//  Copyright © 2015年 felixios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

@interface DownloadOperationManager : NSObject

+ (instancetype) sharedDownloadOperationManager;


//下载操作
- (void) downloadImage:(NSString *)urlString finished:(void (^) (UIImage *img)) finished;

//取消操作

- (void) cancelOperation:(NSString *) urlString;

@end
