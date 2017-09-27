//
//  WaterfallCell.m
//  JLWaterfallFlow
//
//  Created by gaojianlong on 2017/9/18.
//  Copyright © 2017年 JLB. All rights reserved.
//

#import "WaterfallCell.h"

@interface WaterfallCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation WaterfallCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        
        [self.contentView addSubview:self.imageView];
    }
    return self;
}


#pragma mark - getter

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _imageView;
}

#pragma mark - setter

- (void)setModel:(WaterfallModel *)model
{
    _model = model;
    
    self.imageView.frame = self.bounds;
    

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_model.img] placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

@end
