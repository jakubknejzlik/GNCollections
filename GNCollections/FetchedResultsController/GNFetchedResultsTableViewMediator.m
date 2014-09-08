//
//  GNTableViewFetchedResultsMediator.m
//
//  Created by Jakub Knejzlik on 08/09/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//


#import "GNFetchedResultsTableViewMediator.h"

@interface GNFetchedResultsTableViewMediator () <GNFetchedResultsDataSourceDelegate>
@property (nonatomic,readonly) GNFetchedResultsDataSource *dataSource;
@end

@implementation GNFetchedResultsTableViewMediator

-(id)initWithTableView:(UITableView *)tableView dataSource:(GNFetchedResultsDataSource *)dataSource{
    self = [super initWithTableView:tableView dataSource:dataSource];
    if (self) {
        dataSource.delegate = self;
    }
    return self;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.dataSource.cellClass respondsToSelector:@selector(rowHeightForData:)]) {
        return [self.dataSource.cellClass rowHeightForData:[self.dataSource objectAtIndexPath:indexPath]];
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(void)fetchedResultsDataSourceDidUpdateContent:(GNFetchedResultsDataSource *)dataSource{
    [self.tableView reloadData];
}

@end
