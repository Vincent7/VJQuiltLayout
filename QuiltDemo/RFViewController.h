//
//  RFViewController.h
//  QuiltDemo
//
//  Created by Bryce Redd on 12/26/12.
//  Copyright (c) 2012 Bryce Redd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFQuiltLayout.h"
#import "VJCollectionViewContentAndPointDataItem.h"
@interface RFViewController : UIViewController <RFQuiltLayoutDelegate,RFQuiltLayoutDataSource>

@end
