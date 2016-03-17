//
//  VJCollectionViewTextContentCell.h
//  QuiltDemo
//
//  Created by Vincent on 16/3/16.
//  Copyright © 2016年 Bryce Redd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VJResizableCollectionViewCell.h"
@interface VJCollectionViewTextContentCell : VJResizableCollectionViewCell
@property (weak, nonatomic) IBOutlet UITextView *textLabel;
- (void)setTextLabelEditable:(BOOL)editable;
@end
