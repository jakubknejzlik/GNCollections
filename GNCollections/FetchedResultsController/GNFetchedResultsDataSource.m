//
//  GNTableViewFetchedResultsMediator.m
//
//  Created by Jakub Knejzlik on 08/09/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//


#import "GNFetchedResultsDataSource.h"
#import <CoreData/CoreData.h>

@interface GNFetchedResultsDataSource () <NSFetchedResultsControllerDelegate>

@end

@implementation GNFetchedResultsDataSource

-(id)initFetchedResultsController:(NSFetchedResultsController *)controller{
    self = [super init];
    if(self){
        _fetchedResultsController = controller;
        controller.delegate = self;
    }
    return self;
}

-(void)performFetch:(NSError **)error{
    [self.fetchedResultsController performFetch:error];
}
-(id)objectAtIndexPath:(NSIndexPath *)indexPath{
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}


-(NSInteger)numberOfSections{
    return [[self.fetchedResultsController sections] count];
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section{
    return [[[[self.fetchedResultsController sections] objectAtIndex:section] objects] count];
}


#pragma mark - FetchedResultsController Delegate methods
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    if ([self.delegate respondsToSelector:@selector(fetchedResultsDataSourceDidUpdateContent:)]) {
        [self.delegate fetchedResultsDataSourceDidUpdateContent:self];
    }
}


@end
