//
//  VJCollectionViewCellOrderInfoData.m
//  QuiltDemo
//
//  Created by Vincent on 16/3/17.
//  Copyright © 2016年 Bryce Redd. All rights reserved.
//

#import "VJCollectionViewCellOrderInfoData.h"

@implementation VJCollectionViewCellOrderInfoData
-(instancetype)initWithIndex:(NSInteger)index andBlockSize:(CGSize)size{
    self = [super init];
    if (self) {
        self.numberIndex = index;
        self.itemWidth = size.width;
        self.itemHeight = size.height;
    }
    return self;
}
@end
