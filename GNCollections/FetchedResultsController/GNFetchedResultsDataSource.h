//
//  GNTableViewFetchedResultsMediator.h
//
//  Created by Jakub Knejzlik on 08/09/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//


#import "GNIndexedDataSource.h"

@class NSFetchedResultsController;
@protocol GNFetchedResultsDataSourceDelegate;

@interface GNFetchedResultsDataSource : GNIndexedDataSource
@property (nonatomic,strong) Class cellClass;
@property (nonatomic,strong) NSString *collectionCellIdentifier;
@property (nonatomic,weak) id<GNFetchedResultsDataSourceDelegate> delegate;
@property (nonatomic,readonly) NSFetchedResultsController *fetchedResultsController;

-(id)initFetchedResultsController:(NSFetchedResultsController *)controller;
-(void)performFetch:(NSError **)error;

@end


@protocol GNFetchedResultsDataSourceDelegate <NSObject>
@optional
-(void)fetchedResultsDataSourceDidUpdateContent:(GNFetchedResultsDataSource *)dataSource;

@end