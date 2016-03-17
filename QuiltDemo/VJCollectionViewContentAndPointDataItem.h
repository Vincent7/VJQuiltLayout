//
//  VJCollectionViewContentAndPointDataItem.h
//  QuiltDemo
//
//  Created by Vincent on 16/3/17.
//  Copyright © 2016年 Bryce Redd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VJCollectionViewCellOrderInfoData.h"
#import "VJCollectionViewImageData.h"
#import "VJCollectionViewTextData.h"
@interface VJCollectionViewContentAndPointDataItem : NSObject
@property (nonatomic, strong) VJCollectionViewCellOrderInfoData *orderingInfo;
@property (nonatomic, strong) id contentData;
-(instancetype)initWithIndex:(NSInteger)index andBlockSize:(CGSize)size andContent:(id)content;
@end
