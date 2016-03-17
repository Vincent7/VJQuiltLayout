//
//  VJResizableCollectionViewCell.m
//  QuiltDemo
//
//  Created by Vincent on 16/3/17.
//  Copyright © 2016年 Bryce Redd. All rights reserved.
//

#import "VJResizableCollectionViewCell.h"

@implementation VJResizableCollectionViewCell{

}
- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.alpha = .7f;
    }else {
        self.alpha = 1.f;
    }
}
@end
