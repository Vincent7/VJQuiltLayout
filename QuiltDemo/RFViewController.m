//
//  RFViewController.m
//  QuiltDemo
//
//  Created by Bryce Redd on 12/26/12.
//  Copyright (c) 2012 Bryce Redd. All rights reserved.
//
#define EDITTOOLBLOCKHEIGHT 150
#import "RFViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "VJCollectionViewTextContentCell.h"
#import "VJCollectionViewImageContentCell.h"
@interface RFViewController () <UICollectionViewDelegate,VJResizableCollectionViewCellDelegate> {
    BOOL isAnimating;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) UIImageView *movingCell;
@property (nonatomic) NSMutableArray* allIndexPath;

@property (nonatomic,strong) NSMutableArray <VJCollectionViewContentAndPointDataItem *> *dataItems;

@property (nonatomic,strong) UIView *editToolBlock;
@property (nonatomic,strong) CAShapeLayer *maskLayer;
//@property (nonatomic) NSMutableArray* numbers;
//@property (nonatomic) NSMutableArray* numberWidths;
//@property (nonatomic) NSMutableArray* numberHeights;

@end

int num = 0;
@implementation UIImageView (RFViewController)

- (void)setViewCopiedImage:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 4.f);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.image = image;
}

@end
@implementation RFViewController

- (void)viewDidLoad {
    [self datasInit];

    [self.collectionView registerClass:[VJCollectionViewTextContentCell class] forCellWithReuseIdentifier:@"cellID"];
    
    RFQuiltLayout* layout = (id)[self.collectionView collectionViewLayout];
    layout.direction = UICollectionViewScrollDirectionVertical;
    layout.blockPixels = CGSizeMake(50,75);
    layout.dataSource = self;
    [self.collectionView reloadData];
    self.collectionView.allowsSelection = YES;
}

- (UIView *)createEditToolBlockWithOffSet:(CGFloat)offset{
    if (!self.editToolBlock) {
        self.editToolBlock = [[UIView alloc]initWithFrame:CGRectMake(0, 0, EDITTOOLBLOCKHEIGHT, 50)];
        self.editToolBlock.backgroundColor = [UIColor blueColor];
        
        
    }
    [self.maskLayer removeFromSuperlayer];
    self.maskLayer = [CAShapeLayer layer];
    self.maskLayer.frame = CGRectMake(0, 0, self.editToolBlock.bounds.size.width, self.editToolBlock.bounds.size.height);
    self.maskLayer.fillRule = kCAFillRuleEvenOdd;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.editToolBlock.bounds.size.width, self.editToolBlock.bounds.size.height), NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //draw hour hand
    CGContextSetLineWidth(ctx, 1);
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, self.editToolBlock.bounds.size.width, 0);
    CGContextAddLineToPoint(ctx, self.editToolBlock.bounds.size.width, self.editToolBlock.bounds.size.height - 10);
    CGContextAddLineToPoint(ctx, self.editToolBlock.bounds.size.width/2 + 10 - offset, self.editToolBlock.bounds.size.height - 10);
    CGContextAddLineToPoint(ctx, self.editToolBlock.bounds.size.width/2 - offset , self.editToolBlock.bounds.size.height);
    CGContextAddLineToPoint(ctx, self.editToolBlock.bounds.size.width/2 - 10 - offset, self.editToolBlock.bounds.size.height - 10);
    CGContextAddLineToPoint(ctx, 0, self.editToolBlock.bounds.size.height - 10);
    CGContextAddLineToPoint(ctx, 0, 0);
    
    CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextFillPath(ctx);
    self.maskLayer.contents = (id)UIGraphicsGetImageFromCurrentImageContext().CGImage;;
    
    self.editToolBlock.layer.mask = self.maskLayer;
    return self.editToolBlock;
}
- (void)datasInit {
    num = 0;
    self.dataItems = [@[] mutableCopy];

    for(; num<7; num++) {
        switch (num) {
            case 0:{
                VJCollectionViewContentAndPointDataItem *dataItem = [[VJCollectionViewContentAndPointDataItem alloc]initWithIndex:num andBlockSize:CGSizeMake(6, 1) andContent:@"Something I wanna type"];
                [self.dataItems addObject:dataItem];
                break;
            }
            case 1:{
                VJCollectionViewContentAndPointDataItem *dataItem = [[VJCollectionViewContentAndPointDataItem alloc]initWithIndex:num andBlockSize:CGSizeMake(3, 1) andContent:@"Something I wanna type2"];
                [self.dataItems addObject:dataItem];
                break;
            }
            case 2:{
                VJCollectionViewContentAndPointDataItem *dataItem = [[VJCollectionViewContentAndPointDataItem alloc]initWithIndex:num andBlockSize:CGSizeMake(2, 2) andContent:@"Something I wanna type3"];
                [self.dataItems addObject:dataItem];
                break;
            }
            case 3:{
                VJCollectionViewContentAndPointDataItem *dataItem = [[VJCollectionViewContentAndPointDataItem alloc]initWithIndex:num andBlockSize:CGSizeMake(6, 4) andContent:@"Something I wanna type4"];
                [self.dataItems addObject:dataItem];
                break;
            }
            case 4:{
                VJCollectionViewContentAndPointDataItem *dataItem = [[VJCollectionViewContentAndPointDataItem alloc]initWithIndex:num andBlockSize:CGSizeMake(2, 1) andContent:@"Something I wanna type5"];
                [self.dataItems addObject:dataItem];
                break;
            }
            case 5:{
                VJCollectionViewContentAndPointDataItem *dataItem = [[VJCollectionViewContentAndPointDataItem alloc]initWithIndex:num andBlockSize:CGSizeMake(3, 1) andContent:@"Something I wanna type6"];
                [self.dataItems addObject:dataItem];
                break;
            }
            case 6:{
                VJCollectionViewContentAndPointDataItem *dataItem = [[VJCollectionViewContentAndPointDataItem alloc]initWithIndex:num andBlockSize:CGSizeMake(2, 2) andContent:@"Something I wanna type7"];
                [self.dataItems addObject:dataItem];
                break;
            }
            case 7:{
                break;
            }
            case 8:{
                break;
            }
            case 9:{
                break;
            }
            case 10:{
                break;
            }
            default:
                break;
        }
        
        
    }
    
  
}
- (void) viewDidAppear:(BOOL)animated {
    [self.collectionView reloadData];
}

- (IBAction)remove:(id)sender {
    
    if (!self.dataItems.count) {
        return;
    }
    
//    NSArray *visibleIndexPaths = [self.collectionView indexPathsForVisibleItems];
//    NSIndexPath *toRemove = [visibleIndexPaths lastObject];
    [self removeIndexPath:[NSIndexPath indexPathForRow:self.dataItems.count inSection:0]];
}

- (IBAction)refresh:(id)sender {
    [self datasInit];
    [self.collectionView reloadData];
}

- (IBAction)add:(id)sender {

//    NSArray *visibleIndexPaths = [self.collectionView indexPathsForVisibleItems];
    if (self.dataItems.count == 0) {

        [self addIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        return;
    }
    NSIndexPath *toAdd = [NSIndexPath indexPathForRow:self.dataItems.count-1 inSection:0];//[visibleIndexPaths lastObject];
    NSLog(@"toAdd = 0 %@",toAdd);
    [self addIndexPath:toAdd];
}

- (UIColor*) colorForNumber:(NSNumber*)num {
    return [UIColor colorWithHue:((19 * num.intValue) % 255)/255.f saturation:1.f brightness:1.f alpha:1.f];
}

#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return self.dataItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    

    VJCollectionViewContentAndPointDataItem *data = self.dataItems[indexPath.row];
    id content = data.contentData;
    if ([content isKindOfClass:[NSString class]]) {
        VJCollectionViewTextContentCell *cell = (VJCollectionViewTextContentCell*)[cv dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
        [cell.textLabel setText:(NSString *)content];
        cell.delegate = self;
        return cell;
    }else{
        VJCollectionViewImageContentCell *cell = (VJCollectionViewImageContentCell*)[cv dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
        //Image content
    }
//    UILabel* label = (id)[cell viewWithTag:5];
//    if(!label) label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
//    label.tag = 5;
//    label.textColor = [UIColor blackColor];
//    label.text = [NSString stringWithFormat:@"%@", self.numbers[indexPath.row]];
//    label.backgroundColor = [UIColor clearColor];
//    [cell addSubview:label];
    
    return nil;
}


#pragma mark – RFQuiltLayoutDelegate
- (NSIndexPath*)collectionViewLastIndexPath{
    NSArray *visibleIndexPaths = [self.collectionView indexPathsForVisibleItems];
    NSIndexPath *lastIndex = [visibleIndexPaths lastObject];
    return lastIndex;
}

-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout blockSizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row >= self.dataItems.count) {
        NSLog(@"Asking for index paths of non-existant cells!! %ld from %lu cells", (long)indexPath.row, (unsigned long)self.dataItems.count);
    }
    VJCollectionViewContentAndPointDataItem *data = self.dataItems[indexPath.row];
    CGFloat width = data.orderingInfo.itemWidth;
    CGFloat height = data.orderingInfo.itemHeight;
    return CGSizeMake(width, height);
    
    //    if (indexPath.row % 10 == 0)
    //        return CGSizeMake(3, 1);
    //    if (indexPath.row % 11 == 0)
    //        return CGSizeMake(2, 1);
    //    else if (indexPath.row % 7 == 0)
    //        return CGSizeMake(1, 3);
    //    else if (indexPath.row % 8 == 0)
    //        return CGSizeMake(1, 2);
    //    else if(indexPath.row % 11 == 0)
    //        return CGSizeMake(2, 2);
    //    if (indexPath.row == 0) return CGSizeMake(5, 5);
    //    
    //    return CGSizeMake(1, 1);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetsForItemAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark - Helper methods

- (void)addIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > self.dataItems.count) {
        return;
    }
    
    if(isAnimating) return;
    isAnimating = YES;
    
    [self.collectionView performBatchUpdates:^{
        NSInteger index = indexPath.row+1;
        VJCollectionViewContentAndPointDataItem *dataItem = [[VJCollectionViewContentAndPointDataItem alloc]initWithIndex:num++ andBlockSize:CGSizeMake(self.randomWidth, self.randomLength) andContent:@"Something I wanna type7"];
        [self.dataItems insertObject:dataItem atIndex:index];
        
//        [self.numbers insertObject:@(num++) atIndex:index];
//        [self.numberWidths insertObject:@(self.randomWidth) atIndex:index];
//        [self.numberHeights insertObject:@(self.randomLength) atIndex:index];
        [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]];
    } completion:^(BOOL done) {
        isAnimating = NO;
    }];
    
//    [self.collectionView performBatchUpdates:^{
//        NSInteger index = indexPath.row;
//        [self.numbers removeObjectAtIndex:index];
//        [self.numberWidths removeObjectAtIndex:index];
//        [self.numberHeights removeObjectAtIndex:index];
//        [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]];
//    } completion:^(BOOL done) {
//        isAnimating = NO;
//    }];
}

- (void)removeIndexPath:(NSIndexPath *)indexPath {
    if(!self.dataItems.count || indexPath.row > self.dataItems.count) return;
    
    if(isAnimating) return;
    isAnimating = YES;
    
    [self.collectionView performBatchUpdates:^{
        NSInteger index = indexPath.row;
        [self.dataItems removeObjectAtIndex:index];
        
        [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]];
    } completion:^(BOOL done) {
        isAnimating = NO;
    }];
}

- (NSUInteger)randomLength
{
    // always returns a random length between 1 and 3, weighted towards lower numbers.
    NSUInteger result = arc4random() % 6;
    // 3/6 chance of it being 1.
    if (result <= 2)
    {
        result = 1;
    }
    // 1/6 chance of it being 3.
    else if (result == 5)
    {
        result = 3;
    }
    // 2/6 chance of it being 2.
    else {
        result = 2;
    }
    
    return result;
}
- (NSUInteger)randomWidth
{
    // always returns a random length between 1 and 3, weighted towards lower numbers.
    NSUInteger result = arc4random() % 2 + 1;
    return result;
    // 3/6 chance of it being 1.
    if (result <= 2)
    {
        result = 1;
    }
    // 1/6 chance of it being 3.
    else if (result == 5)
    {
        result = 3;
    }
    // 2/6 chance of it being 2.
    else {
        result = 2;
    }
    
    return result;
}


- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
//        return NO;
//    }
    return YES;
}
- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath canMoveToIndexPath:(NSIndexPath *)toIndexPath
{
//    if (toIndexPath.section == 0) {
//        return NO;
//    }
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath didMoveToIndexPath:(NSIndexPath *)toIndexPath
{
    VJCollectionViewContentAndPointDataItem *dataItem = [self.dataItems objectAtIndex:fromIndexPath.item] ;

    
    [self.dataItems removeObjectAtIndex:fromIndexPath.item];
    
    [self.dataItems insertObject:dataItem atIndex:toIndexPath.item];
    
}

-(void)showEditBlockAboveCell:(VJResizableCollectionViewCell *)collectionViewCell{

    CGPoint cPoint = CGPointMake(collectionViewCell.bounds.origin.x + collectionViewCell.bounds.size.width/2,
                                  - 30);
    CGPoint pointAtScrollView = [self.collectionView convertPoint:cPoint fromView:collectionViewCell];

    CGFloat offset = 0;
    
    CGPoint pointMoved = pointAtScrollView;
    if (pointMoved.x < EDITTOOLBLOCKHEIGHT/2 + 10) {
        offset = EDITTOOLBLOCKHEIGHT/2 + 10 - pointMoved.x;
        pointMoved.x = EDITTOOLBLOCKHEIGHT/2 + 10;
        
    }
    
    if (pointMoved.x > self.collectionView.bounds.size.width - EDITTOOLBLOCKHEIGHT/2 - 10) {
        offset = pointMoved.x - self.collectionView.bounds.size.width - EDITTOOLBLOCKHEIGHT/2 - 10 ;
        pointMoved.x = self.collectionView.bounds.size.width - EDITTOOLBLOCKHEIGHT/2 - 10;
        
    }
    
    if (pointMoved.y < self.editToolBlock.bounds.size.height/2 + 5) {
        pointMoved.y = self.editToolBlock.bounds.size.height/2 + 5;
    }
    
    self.editToolBlock = [self createEditToolBlockWithOffSet:offset];
    
    
    
    self.editToolBlock.center = pointMoved;
    
//    UIImageView *tempEditBlockImageView = [[UIImageView alloc] initWithFrame:self.editToolBlock.frame];
//    tempEditBlockImageView.backgroundColor = [UIColor yellowColor];
//    tempEditBlockImageView.alpha = 0;
//    [self.collectionView addSubview:tempEditBlockImageView];
    
    [self.collectionView addSubview:self.editToolBlock];
    
//    [UIView animateWithDuration:.3 animations:^{
//        tempEditBlockImageView.alpha = 1;
//    } completion:^(BOOL finished) {
//        [tempEditBlockImageView removeFromSuperview];
////        [self.collectionView addSubview:self.editToolBlock];
//    }];
    
}

-(void)disappearEditBlockAboveCell:(VJResizableCollectionViewCell *)collectionViewCell{
    
//    UIImageView *tempEditBlockImageView = [[UIImageView alloc] initWithFrame:self.editToolBlock.frame];
//    tempEditBlockImageView.backgroundColor = [UIColor yellowColor];
//    tempEditBlockImageView.alpha = 1;
//    [self.collectionView addSubview:tempEditBlockImageView];
////
////    
//    [UIView animateWithDuration:.3 animations:^{
//        tempEditBlockImageView.alpha = 0;
//    } completion:^(BOOL finished) {
//        [tempEditBlockImageView removeFromSuperview];
//        
//    }];
    [self.editToolBlock removeFromSuperview];
}
@end
