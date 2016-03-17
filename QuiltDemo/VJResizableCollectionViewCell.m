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
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    if (highlighted) {
//        [self.layer setBorderWidth:2.];
        self.alpha = 1.f;
    }else {
//        [self.layer setBorderWidth:0.];
        self.alpha = 1.f;
    }
}

-(void)setSelected:(BOOL)selected{
    
    if (selected != self.selected) {
        [super setSelected:selected];
        if (selected) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(showEditBlockAboveCell:)]) {
                [self.delegate showEditBlockAboveCell:self];
            }
        }else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(disappearEditBlockAboveCell:)]) {
                [self.delegate disappearEditBlockAboveCell:self];
            }
        }
    }
}
-(void)showEditBlock:(BOOL)showEditBlock{
    
}
@end
