//
//  UIImageView+WebCache.m
//  DefineNSOperation
//
//  Created by FelixYin on 15/9/8.
//  Copyright © 2015年 felixios. All rights reserved.
//

#import "UIImageView+WebCache.h"
#import "DownloadOperationManager.h"
#import <objc/runtime.h>

@implementation UIImageView (WebCache)

const void * imgURLKEY = @"IMGURL";

- (void)setUrlString:(NSString *)urlString{


    objc_setAssociatedObject(self, imgURLKEY, urlString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *) urlString{

 
    return objc_getAssociatedObject(self, imgURLKEY);
}


//方法实现

- (void)setImageWithURL:(NSString *)urlString{

   
    //在不同的urlString,在重用的时候，cell中的img包含一个urlString,检查此urlString是否已下载，如果还在下载或者下载完了都取消
    
    DownloadOperationManager *manger = [DownloadOperationManager sharedDownloadOperationManager];

    if (![urlString isEqualToString:self.urlString]){
    
        [manger cancelOperation:self.urlString];
        
        self.image = nil;
       
    }
    
    typeof(self) weakSelf = self;
    
    [manger downloadImage:urlString finished:^(UIImage *img) {
        weakSelf.image = img;
    }];
    
    


}



@end
