//
//  GNTableViewCellSource.m
//
//  Created by Jakub Knejzlik on 08/09/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//


#import "GNStaticTableViewCellSource.h"

@interface GNStaticTableViewCellSource ()
@property (nonatomic,strong) NSMutableArray *cellHeights;
@end

@implementation GNStaticTableViewCellSource

-(id)init{
    self = [super init];
    if (self) {
        self.cellHeights = [NSMutableArray array];
    }
    return self;
}

-(void)addSectionWithTitle:(NSString *)title{
    [super addSectionWithTitle:title];
    [self.cellHeights addObject:[NSMutableArray array]];
}

-(void)addCell:(UITableViewCell *)cell inSection:(NSInteger)section{
    [self addCell:cell inSection:section cellHeight:0];
}
-(void)addCell:(UITableViewCell *)cell inSection:(NSInteger)section cellHeight:(CGFloat)height{
    [self addObject:cell inSection:section];
    [[self.cellHeights objectAtIndex:section] addObject:[NSNumber numberWithFloat:height]];
}
-(void)insertCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    [self insertCell:cell atIndexPath:indexPath cellHeight:0];
}
-(void)insertCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath cellHeight:(CGFloat)height{
    [self insertObject:cell atIndexPath:indexPath];
    if(height > 0)[[self.cellHeights objectAtIndex:indexPath.section] insertObject:[NSNumber numberWithFloat:height] atIndex:indexPath.row];
}
-(void)replaceCellAtIndexPath:(NSIndexPath *)indexPath withCell:(UITableViewCell *)cell{
    [self replaceCellAtIndexPath:indexPath withCell:cell cellHeight:0];
}
-(void)replaceCellAtIndexPath:(NSIndexPath *)indexPath withCell:(UITableViewCell *)cell cellHeight:(CGFloat)height{
    [self replaceObjectAtIndexPath:indexPath withObject:cell];
    if(height > 0)[[self.cellHeights objectAtIndex:indexPath.section] replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithFloat:height]];
}
-(void)addCells:(NSArray *)cells inSection:(NSInteger)section{
    [self addCells:cells inSection:section cellHeight:0];
}
-(void)addCells:(NSArray *)cells inSection:(NSInteger)section cellHeight:(CGFloat)height{
    [self addObjects:cells inSection:section];
    for (id cell in cells) {
        [cell class];
        [[self.cellHeights objectAtIndex:section] addObject:[NSNumber numberWithFloat:height]];
    }
}
-(void)setCells:(NSArray *)cells inSection:(NSInteger)section{
    [self setCells:cells inSection:section cellHeight:0];
}
-(void)setCells:(NSArray *)cells inSection:(NSInteger)section cellHeight:(CGFloat)height{
    [self setObjects:cells inSection:section];
    NSMutableArray *heights = [NSMutableArray array];
    for (id cell in cells) {
        [cell class];
        [heights addObject:[NSNumber numberWithFloat:height]];
    }
    [self.cellHeights replaceObjectAtIndex:section withObject:heights];
}


#pragma mark - TableView DataSource methods
-(CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[[self.cellHeights objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] floatValue];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self objectAtIndexPath:indexPath];
}

#pragma mark - CollectionView DataSource methods


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self objectAtIndexPath:indexPath];
}

@end
