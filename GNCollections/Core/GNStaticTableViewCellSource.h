//
//  GNTableViewCellSource.h
//
//  Created by Jakub Knejzlik on 08/09/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//


#import "GNStaticIndexedDataSource.h"

@interface GNStaticTableViewCellSource : GNStaticIndexedDataSource

-(void)addCell:(UITableViewCell *)cell inSection:(NSInteger)section;
-(void)addCell:(UITableViewCell *)cell inSection:(NSInteger)section cellHeight:(CGFloat)height;
-(void)insertCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
-(void)insertCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath cellHeight:(CGFloat)height;
-(void)replaceCellAtIndexPath:(NSIndexPath *)indexPath withCell:(UITableViewCell *)cell;
-(void)replaceCellAtIndexPath:(NSIndexPath *)indexPath withCell:(UITableViewCell *)cell cellHeight:(CGFloat)height;
-(void)addCells:(NSArray *)cells inSection:(NSInteger)section;
-(void)addCells:(NSArray *)cells inSection:(NSInteger)section cellHeight:(CGFloat)height;
-(void)setCells:(NSArray *)cells inSection:(NSInteger)section;
-(void)setCells:(NSArray *)cells inSection:(NSInteger)section cellHeight:(CGFloat)height;

-(CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
