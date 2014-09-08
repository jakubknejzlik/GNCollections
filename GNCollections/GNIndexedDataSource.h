//
//  GNTableViewDataSource.h
//
//  Created by Jakub Knejzlik on 08/09/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "GNIndexedDataSourceSection.h"

@protocol GNTableViewDataCell <NSObject>
-(void)setData:(id)data;
@optional
+(CGFloat)rowHeightForData:(id)data;
@end

@protocol GNCollectionViewDataCell <NSObject>
-(void)setData:(id)data;
@end


@interface GNIndexedDataSource : NSObject

-(NSInteger)numberOfSections;
-(NSInteger)numberOfRowsInSection:(NSInteger)section;

-(id)objectAtIndexPath:(NSIndexPath *)indexPath;
-(NSArray *)objectsAtIndexPaths:(NSArray *)indexPaths;

-(NSArray *)indexPathsForObject:(id)object;

@end




@interface GNIndexedDataSource (UITableView) <UITableViewDataSource>
+(NSString *)defaultTableViewCellIdentifier;
@end

@interface GNIndexedDataSource (UICollectionView) <UICollectionViewDataSource>
+(NSString *)defaultCollectionViewCellIdentifier;
@end