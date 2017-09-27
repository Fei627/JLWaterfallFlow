//
//  WaterfallModel.h
//  JLWaterfallFlow
//
//  Created by gaojianlong on 2017/9/18.
//  Copyright © 2017年 JLB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WaterfallModel : NSObject

@property (nonatomic , strong) NSNumber *w;

@property (nonatomic , strong) NSNumber *h;

@property (nonatomic , copy) NSString *img;

+ (instancetype)imageWithImageDic:(NSDictionary *)imageDic;

@end
