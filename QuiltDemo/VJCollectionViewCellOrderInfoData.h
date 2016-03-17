//
//  VJCollectionViewCellOrderInfoData.h
//  QuiltDemo
//
//  Created by Vincent on 16/3/17.
//  Copyright © 2016年 Bryce Redd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VJCollectionViewCellOrderInfoData : NSObject
@property (nonatomic,assign) NSInteger numberIndex;
@property (nonatomic,assign) NSInteger itemWidth;
@property (nonatomic,assign) NSInteger itemHeight;

-(instancetype)initWithIndex:(NSInteger)index andBlockSize:(CGSize)size;
@end
