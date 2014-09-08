//
//  GNTableViewCellSource.h
//
//  Created by Jakub Knejzlik on 08/09/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//


#import "GNStaticIndexedDataSource.h"

@interface GNDynamicDataSource : GNStaticIndexedDataSource
@property (nonatomic,strong) Class cellClass;

-(void)loadDataInSection:(NSInteger)section withCompletionHandler:(void (^)(NSError *error,BOOL canLoadMore))completionHandler;
-(void)loadNextDataInSection:(NSInteger)section withCompletionHandler:(void (^)(NSError *error,BOOL canLoadMore))completionHandler;

@end


@interface GNTableViewDynamicSourceWithStaticButton : GNDynamicDataSource

-(void)setBottomCell:(UITableViewCell *)cell forSection:(NSInteger)section;
-(void)setBottomCollectionCell:(UICollectionViewCell *)cell forSection:(NSInteger)section;
-(void)removeBottomCellForSection:(NSInteger)section;
-(id)bottomCellForSection:(NSInteger)section;

-(BOOL)isIndexPathForBottomCell:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;

@end