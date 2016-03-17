//
//  VJCollectionViewTextContentCell.m
//  QuiltDemo
//
//  Created by Vincent on 16/3/16.
//  Copyright © 2016年 Bryce Redd. All rights reserved.
//

#import "VJCollectionViewTextContentCell.h"

@implementation VJCollectionViewTextContentCell

- (void)awakeFromNib {
    // Initialization code
}
-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
//        NSString *cellNibName = @"VJCollectionViewTextContentCell";
        NSArray *resultantNibs = [[NSBundle mainBundle] loadNibNamed:@"VJCollectionViewTextContentCell" owner:nil options:nil];
        
        if ([resultantNibs count] < 1) {
            return nil;
        }
        
        if (![[resultantNibs objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        self = [resultantNibs objectAtIndex:0];
    }
    
    return self;    
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}
@end
