//
//  VJCollectionViewContentAndPointDataItem.m
//  QuiltDemo
//
//  Created by Vincent on 16/3/17.
//  Copyright © 2016年 Bryce Redd. All rights reserved.
//

#import "VJCollectionViewContentAndPointDataItem.h"

@implementation VJCollectionViewContentAndPointDataItem

-(instancetype)initWithIndex:(NSInteger)index andBlockSize:(CGSize)size andContent:(id)content{
    self = [super init];
    if (self) {
        self.orderingInfo = [[VJCollectionViewCellOrderInfoData alloc]initWithIndex:index andBlockSize:size];
        //TODO: Content的初始化处理
        self.contentData = content;
    }
    return self;
}
@end
