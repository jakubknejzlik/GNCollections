//
//  GNTableViewFetchedResultsMediator.h
//
//  Created by Jakub Knejzlik on 08/09/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//


#import "GNTableViewMediator.h"
#import "GNFetchedResultsDataSource.h"

@interface GNFetchedResultsTableViewMediator : GNTableViewMediator

-(id)initWithTableView:(UITableView *)tableView dataSource:(GNFetchedResultsDataSource *)dataSource;

@end
