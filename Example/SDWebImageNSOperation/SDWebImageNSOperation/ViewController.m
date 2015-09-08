//
//  ViewController.m
//  SDWebImageNSOperation
//
//  Created by FelixYin on 15/9/4.
//  Copyright © 2015年 felixios. All rights reserved.
//

#import "ViewController.h"
#import "AppCellTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "App.h"

@interface ViewController ()

@property (nonatomic,strong) NSArray *appArray;

@property (nonatomic,strong) NSOperationQueue *queue;

//操作缓存

@property (nonatomic,strong) NSMutableDictionary *operationDict;

//图像缓存

@property (nonatomic,strong) NSMutableDictionary *imgDict;


//@property (nonatomic,copy) int (^myBlock) (int a,int b);


@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    
    //内存警告时，清除缓存
    
    [self.queue cancelAllOperations];
    
    [self.imgDict removeAllObjects];
}



#pragma mark 懒加载


- (NSArray *)appArray{

    if (!_appArray) {
        
        _appArray = [App arrayApp];
        
        
        [_appArray enumerateObjectsUsingBlock:^(App  *obj, NSUInteger idx, BOOL * __nonnull stop) {
            
            NSLog(@"%@",obj.name);
            
        }];
        
    }
    

    return _appArray;
}


- (NSOperationQueue *)queue{

    if (!_queue) {
        
        _queue = [[NSOperationQueue alloc] init];
        
        
    }

    return _queue;
}


- (NSMutableDictionary *)operationDict{

    if (!_operationDict) {
        
        
        _operationDict = [[NSMutableDictionary alloc] init];
        
    }

    return _operationDict;
}


- (NSMutableDictionary *)imgDict{

    if (!_imgDict) {
        
        _imgDict = [[NSMutableDictionary alloc] init];
        
    }
    
    
    return _imgDict;

}

#pragma mark tableView的代理方法


- (NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView{


    return 1;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section{



    return self.appArray.count;
}

//注意循环引用

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{

    //此方式只适合在storyBoard时候使用，如果storyBoard中没有注明的话，就直接崩溃
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppCell" forIndexPath:indexPath];
    
    AppCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppCell"];
    
    
    if (!cell) {
        
        cell = [[AppCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AppCell"];
        
    }
    
    
    App *app = _appArray[indexPath.row];
    
    
    
    cell.downloadNum.text = app.download;
    
    cell.appName.text = app.name;
    
    [cell.appImg setImageWithURL:app.icon];
    
    NSLog(@"%@",NSHomeDirectory());
    
    
//    //解决重复下载操作
//    
//    
//    //1.1   缓存中有图片的时候，就无需下载
//    
//    if ([self.imgDict valueForKey:app.icon] != nil) {
//        
//        NSLog(@"从缓存加载----");
//        
//        cell.appImg.image = _imgDict[app.icon];
//        
//        return cell;
//    }
//    
//    
//    //1.2  缓存中没有图片的时候，就添加下载操作
//    
//    [self downloadImage:indexPath];
    
    
    return cell;

}






//下载操作代码重构


- (void) downloadImage:(NSIndexPath *) indexPath{


    App *app = self.appArray[indexPath.row];
    
    
    //检查是否有重复下载操作
    
    if (self.operationDict[app.icon]) {
        
        NSLog(@"正在拼命的加载中...");
        
        
        return;
        
    }
    
    
    //创建下载操作,需要防止循环引用
    
    __weak typeof(self) weakSelf = self;
    
    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        
        
        NSURL *url = [NSURL URLWithString:app.icon];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        
        //模拟下载缓慢，滚动快的情况
        
        [NSThread sleepForTimeInterval:3];
        
        //将data写入到沙河   拼接一个路径
//        [data writeToFile:app.icon atomically:YES];
        
        //主队列更新UI
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            //下载完成后，清理缓存
            
            //1.1 移除下载操作缓存
            [weakSelf.operationDict removeObjectForKey:app.icon];
            
            //这种方式想字典中添加值时，值可以为空
            
            //  1.2 移除已经下载好的图片缓存
            [weakSelf.imgDict setValue:[UIImage imageWithData:data] forKey:app.icon];
            
            //这种方法向字典中添加值时，值不能为空  无网状态时
            
//            if (data != nil){
            
//            [weakSelf.imgDict setObject:[UIImage imageWithData:data] forKey:app.icon];
            
            //，要刷新指定cell的img
            
            //   cell.appImg.image = [UIImage imageWithData:data];   这样设置的还是错行cell的img
            
            //刷新指定的行   每一个model对应一个 row
            
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                
//            }
            
            
        }];
        
    }];
    
    
    //1.1   将操作添加到操作缓冲池中
    
    [weakSelf.operationDict setValue:operation forKey:app.icon];
    
    
    //1.2   将操作添加到队列中
    
    [weakSelf.queue addOperation:operation];



}

@end
