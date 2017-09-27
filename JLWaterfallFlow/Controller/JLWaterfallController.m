//
//  JLWaterfallController.m
//  JLWaterfallFlow
//
//  Created by gaojianlong on 2017/9/18.
//  Copyright © 2017年 JLB. All rights reserved.
//

#import "JLWaterfallController.h"
#import "JLWaterfallLayout.h"
#import "WaterfallModel.h"
#import "WaterfallCell.h"

@interface JLWaterfallController () <UICollectionViewDataSource, JLWaterfallLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) JLWaterfallLayout *waterfallLayout;

@property (nonatomic, strong) NSMutableArray <WaterfallModel *> *dataArray;

@end


@implementation JLWaterfallController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"瀑布流";
    
    [self.view addSubview:self.collectionView];
}

// 根据 item 的宽度与 indexPath 计算每一个 item 的高度
- (CGFloat)waterfallLayout:(JLWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath
{
    WaterfallModel *model = self.dataArray[indexPath.item];
    
    return ([model.h floatValue] / [model.w floatValue]) * itemWidth;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterfallModel *model = self.dataArray[indexPath.item];
    WaterfallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WaterfallCell" forIndexPath:indexPath];
    
    cell.model = model;
    return cell;
}

#pragma mark - getter

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.waterfallLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[WaterfallCell class] forCellWithReuseIdentifier:@"WaterfallCell"];
    }
    return _collectionView;
}

- (JLWaterfallLayout *)waterfallLayout
{
    if (!_waterfallLayout) {
        _waterfallLayout = [JLWaterfallLayout waterFallLayoutWithColumnCount:2];
        [_waterfallLayout setColumnSpacing:10 rowSpacing:10 sectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
        _waterfallLayout.delegate = self;
    }
    return _waterfallLayout;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        
        NSString *file = [[NSBundle mainBundle] pathForResource:@"1.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:file];

        for (NSDictionary *dict in dictArray) {
            WaterfallModel *model = [WaterfallModel imageWithImageDic:dict];
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
}

@end
