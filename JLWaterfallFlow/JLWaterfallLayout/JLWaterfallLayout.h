//
//  JLWaterfallLayout.h
//  JLWaterfallFlow
//
//  Created by gaojianlong on 2017/9/18.
//  Copyright © 2017年 JLB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JLWaterfallLayout;
@protocol JLWaterfallLayoutDelegate <NSObject>

@required
//计算 item 高度的代理方法，将 item 的高度与 indexPath 传递给外界
- (CGFloat)waterfallLayout:(JLWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath;

@end

@interface JLWaterfallLayout : UICollectionViewLayout

/**总列数，默认为2 */
@property (nonatomic , assign) NSInteger columnCount;

/**列间距，默认为0 */
@property (nonatomic , assign) NSInteger columnSpacing;

/**行间距，默认为0 */
@property (nonatomic , assign) NSInteger rowSpacing;

/**section 到 collectionView 的边间距，默认为（0，0，0，0） */
@property (nonatomic , assign) UIEdgeInsets sectionInset;

/**计算 item 高度的 block，将 item 的宽度与 indexPath 传递给外界 */
@property (nonatomic , copy) CGFloat(^itemHeightBlock)(CGFloat itemWidth, NSIndexPath *indexPath);

/**代理，用来计算 item 的高度 */
@property (nonatomic, assign) id <JLWaterfallLayoutDelegate> delegate;

/**同时设置列间距，行间距，sectionInset */
- (void)setColumnSpacing:(NSInteger)columnSpacing rowSpacing:(NSInteger)rowSepacing sectionInset:(UIEdgeInsets)sectionInset;

#pragma mark - 构造方法

+ (instancetype)waterFallLayoutWithColumnCount:(NSInteger)columnCount;

- (instancetype)initWithColumnCount:(NSInteger)columnCount;

@end
