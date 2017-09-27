//
//  JLWaterfallLayout.m
//  JLWaterfallFlow
//
//  Created by gaojianlong on 2017/9/18.
//  Copyright © 2017年 JLB. All rights reserved.
//

#import "JLWaterfallLayout.h"

@interface JLWaterfallLayout ()

// 保存每一列最大Y值的数组
@property (nonatomic , strong) NSMutableArray *maxYArray;

// 保存每一个 item 的 attributes 的数组
@property (nonatomic , strong) NSMutableArray *attributesArray;

// 内容的高度
@property (nonatomic, assign) CGFloat contentSizeHeight;

@end

@implementation JLWaterfallLayout

#pragma mark - 构造方法

- (instancetype)init
{
    if (self = [super init]) {
        self.columnCount = 2;
    }
    return self;
}

- (instancetype)initWithColumnCount:(NSInteger)columnCount
{
    if (self = [super init]) {
        self.columnCount = columnCount;
    }
    return self;
}

+ (instancetype)waterFallLayoutWithColumnCount:(NSInteger)columnCount
{
    return [[self alloc] initWithColumnCount:columnCount];
}

#pragma mark - 公共接口 - 相关属性设置方法

- (void)setColumnSpacing:(NSInteger)columnSpacing rowSpacing:(NSInteger)rowSepacing sectionInset:(UIEdgeInsets)sectionInset
{
    self.columnSpacing = columnSpacing;
    self.rowSpacing = rowSepacing;
    self.sectionInset = sectionInset;
}

#pragma mark - 布局相关

// 布局前的准备工作
- (void)prepareLayout
{
    [super prepareLayout];
    
    self.contentSizeHeight = 0;
    
    [self.maxYArray removeAllObjects];
    // 初始化数组
    for (int i = 0; i < self.columnCount; i ++) {
        [self.maxYArray addObject:@(self.sectionInset.top)];
    }
    
    // 创建每个 item 的 attributes 并存入数组
    // 获取 item 的总数
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    [self.attributesArray removeAllObjects];
    
    // 为每一个 item 创建 attribute 并存入数组
    for (int i = 0; i < itemCount; i ++) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        [self.attributesArray addObject:attributes];
    }
}

// 计算 collectionView 的 contentSize
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(0, self.contentSizeHeight + self.sectionInset.bottom);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 根据 indexPath 获取 item 的 attributes
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // 获取 collectionView 的宽度
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    
    // item 的宽度 = (collectionView 的宽度 - 内边距与列间距) / 列数
    CGFloat columnSpace = (self.columnCount - 1) * self.columnSpacing;
    CGFloat itemWidth = (collectionViewWidth - self.sectionInset.left - self.sectionInset.right - columnSpace) / self.columnCount;
    
    // 获取 item 的高度，由外界计算得到
    CGFloat itemHeight = 0;
    if (self.itemHeightBlock) {
        itemHeight = self.itemHeightBlock(itemWidth, indexPath);
    } else {
        if ([self.delegate respondsToSelector:@selector(waterfallLayout:itemHeightForWidth:atIndexPath:)])
            itemHeight = [self.delegate waterfallLayout:self itemHeightForWidth:itemWidth atIndexPath:indexPath];
    }
    // 找出最短的那一列
    NSInteger minColumn = 0;
    // 默认第一列的高度最短
    CGFloat minColumnHeight = [self.maxYArray[0] doubleValue];

    for (int i = 0; i < self.maxYArray.count; i ++) {
        // 取出每一列的高度
        CGFloat columnHeight = [self.maxYArray[i] doubleValue];
        
        if (columnHeight < minColumnHeight) {
            minColumnHeight = columnHeight;
            minColumn = i;
        }
    }
    
    // 根据最短列的列数计算 item 的 x 值
    CGFloat itemX = self.sectionInset.left + (self.columnSpacing + itemWidth) * minColumn;
    
    // item 的 y 值 = 最短列的最大 y 值 + 行间距
    CGFloat itemY = minColumnHeight + self.rowSpacing;
    
    // 设置 attributes 的 frame
    attributes.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
    
    // 更新数组中的最大 y 值
    self.maxYArray[minColumn] = @(CGRectGetMaxY(attributes.frame));
    
    //记录最大高度
    CGFloat maxColumnHeight = [self.maxYArray[minColumn] doubleValue];
    if (self.contentSizeHeight < maxColumnHeight) {
        self.contentSizeHeight = maxColumnHeight;
    }
    
    return attributes;
}

// 返回 rect 范围内 item 的 attributes
// cell的排布
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributesArray;
}


#pragma mark - getter

- (NSMutableArray *)maxYArray
{
    if (!_maxYArray) {
        _maxYArray = [NSMutableArray array];
    }
    return _maxYArray;
}

- (NSMutableArray *)attributesArray
{
    if (!_attributesArray) {
        _attributesArray = [NSMutableArray array];
    }
    return _attributesArray;
}

@end
