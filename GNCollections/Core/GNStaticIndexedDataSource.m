//
//  GNTableViewDataSource.m
//
//  Created by Jakub Knejzlik on 08/09/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//


#import "GNStaticIndexedDataSource.h"


@interface GNStaticIndexedDataSource ()
@property NSMutableArray *sections;
@end

@implementation GNStaticIndexedDataSource

-(id)init{
    self = [super init];
    if (self) {
        self.sections = [NSMutableArray array];
    }
    return self;
}

-(NSInteger)numberOfSections{
    return [self.sections count];
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section{
    return [[[self.sections objectAtIndex:section] objects] count];
}

#pragma mark - content building methods
-(void)addSection{
    [self addSectionWithTitle:nil];
}
-(void)addSectionWithTitle:(NSString *)title{
    GNIndexedDataSourceSection *section = [[GNIndexedDataSourceSection alloc] init];
    [self.sections addObject:section];
}
-(void)addObject:(id)object inSection:(NSInteger)section{
    [self addObjects:[NSArray arrayWithObject:object] inSection:section];
}
-(void)insertObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    if([self.sections count] == 0 && indexPath.section == 0)[self addSection];
    [[[self sectionForIndex:indexPath.section] objects] insertObject:object atIndex:indexPath.row];
}
-(void)replaceObjectAtIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    [[[self sectionForIndex:indexPath.section] objects] replaceObjectAtIndex:indexPath.row withObject:object];
}
-(GNIndexedDataSourceSection *)sectionForIndex:(NSInteger)index{
    return [self.sections objectAtIndex:index];
}
-(void)addObjects:(NSArray *)objects inSection:(NSInteger)section{
    if([self.sections count] == 0 && section == 0)[self addSection];
    [[[self sectionForIndex:section] objects] addObjectsFromArray:objects];
}
-(void)setObjects:(NSArray *)objects inSection:(NSInteger)section{
    if([self.sections count] == 0 && section == 0)[self addSection];
    [self removeDataInSection:section];
    [[[self sectionForIndex:section] objects] addObjectsFromArray:objects];
}
-(void)removeDataAtIndexPath:(NSIndexPath *)indexPath{
    [[[self sectionForIndex:indexPath.section] objects] removeObjectAtIndex:indexPath.row];
}
-(void)removeDataInSection:(NSInteger)section{
    [[[self sectionForIndex:section] objects] removeAllObjects];
}
-(id)objectAtIndexPath:(NSIndexPath *)indexPath{
    if(!indexPath)return nil;
    return [[[self.sections objectAtIndex:indexPath.section] objects] objectAtIndex:indexPath.row];
}


@end

