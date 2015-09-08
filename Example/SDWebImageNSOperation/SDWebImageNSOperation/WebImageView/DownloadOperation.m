//
//  DownloadOperation.m
//  DefineNSOperation
//
//  Created by FelixYin on 15/9/7.
//  Copyright © 2015年 felixios. All rights reserved.
//

#import "DownloadOperation.h"
#import "NSString+Path.h"

@interface DownloadOperation ()

//下载操作的URL

@property (nonatomic,copy) NSString *urlString;

//完成回调

@property (nonatomic,copy) void (^finishBlock) (UIImage *img);

@end

@implementation DownloadOperation


+ (instancetype)downloadOperationWithURL: (NSString *) urlString  finished:(void (^)(UIImage *))finished{
    
    
    //加断言，防止其他人调用时出现不必要的麻烦
    
    NSAssert(finished != nil, @"您没有传入回调函数!");
    

    DownloadOperation *operation = [[DownloadOperation alloc] init];
    
    operation.urlString = urlString;
    
    operation.finishBlock = finished;
    
    
    return operation;
    
}



- (void)main{

    @autoreleasepool {
        
        NSLog(@"😄😄😄😄😄😄😄执行%@----->当前任务的线程是----%@",self.urlString,[NSThread currentThread]);
        
        
        
        //耗时操作
        
//        [NSThread sleepForTimeInterval:1];
        
        NSURL *url = [NSURL URLWithString:_urlString];
        
        NSData *data= [NSData dataWithContentsOfURL:url];
        
        //写入到缓存目录中
        
        [data writeToFile:[_urlString appendCachePath] atomically:YES];
        
        
        
        //如果耗时操作还没有完成，但是用户取消了操作
        
        if ([self isCancelled]) {
            
            NSLog(@"💰💰💰💰💰💰💰💰用户取消了操作，无需回调.....💰💰💰💰💰💰💰💰");
            
            return;
        }
        
    
        //完成回调
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            
//            NSLog(@"线程回调----%@",[NSThread currentThread]);
            
            self.finishBlock([UIImage imageWithData:data]);
            
            
        }];
        
        
    }


}



//重写start方法

- (void)start{

    [super start];
    
    
    //取消了操作此方法也会被调用
    
    
    NSLog(@"%s",__func__);



}

@end
