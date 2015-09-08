//
//  DownloadOperationManager.m
//  DefineNSOperation
//
//  Created by FelixYin on 15/9/7.
//  Copyright © 2015年 felixios. All rights reserved.
//

#import "DownloadOperationManager.h"
#import "DownloadOperation.h"
#import "NSString+Path.h"


@interface DownloadOperationManager ()

@property (nonatomic,strong) NSOperationQueue *queue;

@property (nonatomic,strong) NSMutableDictionary *cacheImg;

@property (nonatomic,strong) NSMutableDictionary *cacheOperation;

@end
@implementation DownloadOperationManager

+(instancetype)sharedDownloadOperationManager{

    static DownloadOperationManager *instance;
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[DownloadOperationManager alloc] init];
        
    });
    
    
    return instance;

}


//+ (instancetype)allocWithZone:(struct _NSZone *)zone{
//
//    return [self sharedDownloadOperationManager];
//}


- (void)downloadImage:(NSString *)urlString finished:(void (^)(UIImage *))finished{
    
    NSAssert(finished != nil, @"完成回调不可缺少");
    
    //检查是否有相同的操作存在
    
    if ([self.cacheOperation valueForKey:urlString] != nil) {
        
        NSLog(@"努力加载中...😡😡😡😡😡😡😡😡😡😡😡😡");
        
        return;
        
    }
    
    //检查缓存
    
    if ([self.cacheImg objectForKey:urlString]){
    
        NSLog(@"从内存中读取!");
        
        finished([self.cacheImg objectForKey:urlString]);
        
        
        return;
    
    }
    
    
    UIImage *img = [UIImage imageNamed:[urlString appendCachePath]];
    
    if (img) {
        
        //添加到内存缓存
        
        NSLog(@"从沙盒中读取!");
        
        [self.cacheImg setObject:img forKey:urlString];
        
        finished(img);
        
        return;
        
    }

    
    //创建下载操作
    
    typeof(self) weakSelf = self;
    
    DownloadOperation *operation = [DownloadOperation downloadOperationWithURL:urlString finished:^(UIImage *img) {
        
        finished(img);
        
        //移除操作缓存
        
        [weakSelf.cacheOperation removeObjectForKey:urlString];
        
        
    }];
    
    //将操作添加到缓冲池中
    
    [self.cacheOperation setObject:operation forKey:urlString];
    
    //将操作添加到操作队列中
    
    [self.queue addOperation:operation];
    
    


}


//取消操作

- (void)cancelOperation:(NSString *) urlString{
    
    //当下载操作为空的时候，直接返回
    
    NSOperation *operation = [self.cacheOperation objectForKey:urlString];
    

    if (operation == nil) {
        
        
        NSLog(@"❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️操作已经被移除..........❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️");
        
        return;
    }
    
    //取消下载操作
    
    [operation cancel];
    
    
    [self.cacheOperation removeObjectForKey:urlString];


}



#pragma mark   懒加载


- (NSOperationQueue *)queue{

    if (!_queue) {
        
        
        _queue = [[NSOperationQueue alloc] init];
        
        [_queue setMaxConcurrentOperationCount:6];
        
        
    }
    
    return _queue;

}



- (NSMutableDictionary *)cacheImg{

    if (!_cacheImg) {
        
        _cacheImg = [[NSMutableDictionary alloc] init];
        
    }
    
    return _cacheImg;
   
}



- (NSMutableDictionary *)cacheOperation{


    if (!_cacheOperation) {
        
        _cacheOperation = [[NSMutableDictionary alloc] init];
        
    }

    return _cacheOperation;

}



@end
