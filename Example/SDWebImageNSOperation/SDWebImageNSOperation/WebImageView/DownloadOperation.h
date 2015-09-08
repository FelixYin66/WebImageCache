//
//  DownloadOperation.h
//  DefineNSOperation
//
//  Created by FelixYin on 15/9/7.
//  Copyright © 2015年 felixios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

@interface DownloadOperation : NSOperation

//提供一个创建操作对象的类方法

+(instancetype) downloadOperationWithURL:(NSString *) urlString   finished:(void (^) (UIImage *img)) finished;

@end
