//
//  VJCollectionViewTextContentCell.m
//  QuiltDemo
//
//  Created by Vincent on 16/3/16.
//  Copyright © 2016年 Bryce Redd. All rights reserved.
//

#import "VJCollectionViewTextContentCell.h"

@implementation VJCollectionViewTextContentCell{
    CAShapeLayer *dottedLineLayer;
}

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

-(void)setTextLabelEditable:(BOOL)editable{
    
    [self.textLabel setUserInteractionEnabled:editable];
    [self.textLabel setEditable:editable];
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    [dottedLineLayer removeFromSuperlayer];
    dottedLineLayer = [self addDashedBorderWithColor:[UIColor blackColor].CGColor];
    [self.layer addSublayer:dottedLineLayer];
    if (selected) {
        dottedLineLayer.lineWidth = 1.f;
//        [self.layer setBorderWidth:5.0];
        
    }else {
        dottedLineLayer.lineWidth = 0.f;
//        [self.layer setBorderWidth:.0];
    }
}
- (CAShapeLayer *) addDashedBorderWithColor: (CGColorRef) color {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    CGSize frameSize = self.bounds.size;
    
    CGRect shapeRect = CGRectMake(0.0f, 0.0f, frameSize.width, frameSize.height);
    [shapeLayer setBounds:shapeRect];
    [shapeLayer setPosition:CGPointMake( frameSize.width/2,frameSize.height/2)];
    
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [shapeLayer setStrokeColor:color];
    [shapeLayer setLineWidth:1.f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:2],
      [NSNumber numberWithInt:2],
      nil]];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:shapeRect cornerRadius:0];
    [shapeLayer setPath:path.CGPath];
    
    return shapeLayer;
}
@end
