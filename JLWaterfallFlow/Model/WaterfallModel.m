//
//  WaterfallModel.m
//  JLWaterfallFlow
//
//  Created by gaojianlong on 2017/9/18.
//  Copyright © 2017年 JLB. All rights reserved.
//

#import "WaterfallModel.h"

@implementation WaterfallModel

+ (instancetype)imageWithImageDic:(NSDictionary *)imageDic
{
    WaterfallModel *model = [[WaterfallModel alloc] init];
    model.img = imageDic[@"img"];
    model.w = imageDic[@"w"];
    model.h = imageDic[@"h"];
    return model;
}


@end
