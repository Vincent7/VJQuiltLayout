//
//  VJCollectionViewImageContentCell.m
//  QuiltDemo
//
//  Created by Vincent on 16/3/17.
//  Copyright © 2016年 Bryce Redd. All rights reserved.
//

#import "VJCollectionViewImageContentCell.h"

@implementation VJCollectionViewImageContentCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    [self.layer setBorderColor:[UIColor redColor].CGColor];
    if (selected) {
        [self.layer setBorderWidth:2.];
    }else {
        [self.layer setBorderWidth:0.];
    }
}
@end
