//
//  VJResizableCollectionViewCell.h
//  QuiltDemo
//
//  Created by Vincent on 16/3/17.
//  Copyright © 2016年 Bryce Redd. All rights reserved.
//
@protocol VJResizableCollectionViewCellDelegate;
#import <UIKit/UIKit.h>

@interface VJResizableCollectionViewCell : UICollectionViewCell
@property (nonatomic,weak) id<VJResizableCollectionViewCellDelegate> delegate;
- (void)showEditBlock:(BOOL)showEditBlock;

@end

@protocol VJResizableCollectionViewCellDelegate <NSObject>

@optional
-(void)showEditBlockAboveCell:(VJResizableCollectionViewCell *)collectionViewCell;
-(void)disappearEditBlockAboveCell:(VJResizableCollectionViewCell *)collectionViewCell;
@end