//
//  RFViewController.m
//  QuiltDemo
//
//  Created by Bryce Redd on 12/26/12.
//  Copyright (c) 2012 Bryce Redd. All rights reserved.
//

#import "RFViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "VJCollectionViewTextContentCell.h"
@interface RFViewController () <UICollectionViewDelegate> {
    BOOL isAnimating;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) UIImageView *movingCell;
@property (nonatomic) NSMutableArray* allIndexPath;
@property (nonatomic) NSMutableArray* numbers;
@property (nonatomic) NSMutableArray* numberWidths;
@property (nonatomic) NSMutableArray* numberHeights;

@end

int num = 0;

@implementation RFViewController

- (void)viewDidLoad {
    [self datasInit];
//    _longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
//    _longPressGesture.delegate = self;
    [self.collectionView registerClass:[VJCollectionViewTextContentCell class] forCellWithReuseIdentifier:@"cellID"];
    
    RFQuiltLayout* layout = (id)[self.collectionView collectionViewLayout];
    layout.direction = UICollectionViewScrollDirectionVertical;
    layout.blockPixels = CGSizeMake(100,100);
    layout.dataSource = self;
    [self.collectionView reloadData];
}
- (void)datasInit {
    num = 0;
    self.numbers = [@[] mutableCopy];
    self.numberWidths = @[].mutableCopy;
    self.numberHeights = @[].mutableCopy;
    for(; num<7; num++) {
        [self.numbers addObject:@(num)];
        switch (num) {
            case 0:{
                [self.numberWidths addObject:@(1)];
                [self.numberHeights addObject:@(1)];
                break;
            }
            case 1:{
                [self.numberWidths addObject:@(1)];
                [self.numberHeights addObject:@(2)];
                break;
            }
            case 2:{
                [self.numberWidths addObject:@(1)];
                [self.numberHeights addObject:@(3)];
                break;
            }
            case 3:{
                [self.numberWidths addObject:@(1)];
                [self.numberHeights addObject:@(1)];
                break;
            }
            case 4:{
                [self.numberWidths addObject:@(2)];
                [self.numberHeights addObject:@(1)];
                break;
            }
            case 5:{
                [self.numberWidths addObject:@(3)];
                [self.numberHeights addObject:@(1)];
                break;
            }
            case 6:{
                [self.numberWidths addObject:@(1)];
                [self.numberHeights addObject:@(4)];
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
    
    if (!self.numbers.count) {
        return;
    }
    
    NSArray *visibleIndexPaths = [self.collectionView indexPathsForVisibleItems];
    NSIndexPath *toRemove = [visibleIndexPaths lastObject];
    [self removeIndexPath:[NSIndexPath indexPathForRow:self.numbers.count inSection:0]];
}

- (IBAction)refresh:(id)sender {
    [self datasInit];
    [self.collectionView reloadData];
}

- (IBAction)add:(id)sender {
//    NSArray *visibleIndexPaths = [self.collectionView indexPathsForVisibleItems];
    NSArray *visibleIndexPaths = [self.collectionView indexPathsForVisibleItems];
    if (visibleIndexPaths.count == 0) {
        NSLog(@"visibleIndexPaths.count = 0 %@",visibleIndexPaths);
        [self addIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        return;
    }
    NSIndexPath *toAdd = [NSIndexPath indexPathForRow:visibleIndexPaths.count-1 inSection:0];//[visibleIndexPaths lastObject];
    NSLog(@"toAdd = 0 %@",toAdd);
    [self addIndexPath:[NSIndexPath indexPathForRow:self.numbers.count-1 inSection:0]];
}

- (UIColor*) colorForNumber:(NSNumber*)num {
    return [UIColor colorWithHue:((19 * num.intValue) % 255)/255.f saturation:1.f brightness:1.f alpha:1.f];
}

#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self removeIndexPath:indexPath];
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return self.numbers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VJCollectionViewTextContentCell *cell = (VJCollectionViewTextContentCell*)[cv dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.backgroundColor = [self colorForNumber:self.numbers[indexPath.row]];
    
//    UILabel* label = (id)[cell viewWithTag:5];
//    if(!label) label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
//    label.tag = 5;
//    label.textColor = [UIColor blackColor];
//    label.text = [NSString stringWithFormat:@"%@", self.numbers[indexPath.row]];
//    label.backgroundColor = [UIColor clearColor];
//    [cell addSubview:label];
    
    return cell;
}


#pragma mark – RFQuiltLayoutDelegate
- (NSIndexPath*)collectionViewLastIndexPath{
    NSArray *visibleIndexPaths = [self.collectionView indexPathsForVisibleItems];
    NSIndexPath *lastIndex = [visibleIndexPaths lastObject];
    return lastIndex;
}

-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout blockSizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row >= self.numbers.count) {
        NSLog(@"Asking for index paths of non-existant cells!! %ld from %lu cells", (long)indexPath.row, (unsigned long)self.numbers.count);
    }
    
    CGFloat width = [[self.numberWidths objectAtIndex:indexPath.row] floatValue];
    CGFloat height = [[self.numberHeights objectAtIndex:indexPath.row] floatValue];
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
    if (indexPath.row > self.numbers.count) {
        return;
    }
    
    if(isAnimating) return;
    isAnimating = YES;
    
    [self.collectionView performBatchUpdates:^{
        NSInteger index = indexPath.row+1;
        [self.numbers insertObject:@(num++) atIndex:index];
        [self.numberWidths insertObject:@(self.randomWidth) atIndex:index];
        [self.numberHeights insertObject:@(self.randomLength) atIndex:index];
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
    if(!self.numbers.count || indexPath.row > self.numbers.count) return;
    
    if(isAnimating) return;
    isAnimating = YES;
    
    [self.collectionView performBatchUpdates:^{
        NSInteger index = indexPath.row;
        [self.numbers removeObjectAtIndex:index];
        [self.numberWidths removeObjectAtIndex:index];
        [self.numberHeights removeObjectAtIndex:index];
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

//-(void)handleLongPressGesture:(UIPanGestureRecognizer *)panRecognizer {
//    
//    CGPoint locationPoint = [panRecognizer locationInView:self.collectionView];
//    
//    if (panRecognizer.state == UIGestureRecognizerStateBegan) {
//        
//        NSIndexPath *indexPathOfMovingCell = [self.collectionView indexPathForItemAtPoint:locationPoint];
//        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPathOfMovingCell];
//        
//        UIGraphicsBeginImageContext(cell.bounds.size);
//        [cell.layer renderInContext:UIGraphicsGetCurrentContext()];
//        UIImage *cellImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        
//        self.movingCell = [[UIImageView alloc] initWithImage:cellImage];
//        [self.movingCell setCenter:locationPoint];
//        [self.movingCell setAlpha:0.75f];
//        [self.collectionView addSubview:self.movingCell];
//        
//    }
//    
//    if (panRecognizer.state == UIGestureRecognizerStateChanged) {
//        [self.movingCell setCenter:locationPoint];
//    }
//    
//    if (panRecognizer.state == UIGestureRecognizerStateEnded) {
//        [self.movingCell removeFromSuperview];
//    }
//}
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
    NSInteger number = [[self.numbers objectAtIndex:fromIndexPath.item] integerValue];
    NSInteger numberWidth = [[self.numberWidths objectAtIndex:fromIndexPath.item] integerValue];
    NSInteger numberHeight = [[self.numberHeights objectAtIndex:fromIndexPath.item] integerValue];
    
    [self.numbers removeObjectAtIndex:fromIndexPath.item];
    [self.numberWidths removeObjectAtIndex:fromIndexPath.item];
    [self.numberHeights removeObjectAtIndex:fromIndexPath.item];
    
    [self.numbers insertObject:@(number) atIndex:toIndexPath.item];
    [self.numberWidths insertObject:@(numberWidth) atIndex:toIndexPath.item];
    [self.numberHeights insertObject:@(numberHeight) atIndex:toIndexPath.item];
//    [self.numbers insertObject:@(num++) atIndex:index];
//    [self.numberWidths insertObject:@(self.randomWidth) atIndex:index];
//    [self.numberHeights insertObject:@(self.randomLength) atIndex:index];
//    UIImage *image = [_photosArray objectAtIndex:fromIndexPath.item];
//    [_photosArray removeObjectAtIndex:fromIndexPath.item];
//    [_photosArray insertObject:image atIndex:toIndexPath.item];
}
@end
