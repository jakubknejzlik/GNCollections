//
//  GNTableViewDataSource.m
//
//  Created by Jakub Knejzlik on 08/09/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//


#import "GNIndexedDataSource.h"

@implementation GNIndexedDataSource

-(NSInteger)numberOfSections{
    return 0;
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section{
    return 0;
}

-(id)objectAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
-(NSArray *)objectsAtIndexPaths:(NSArray *)indexPaths{
    NSMutableArray *objects = [NSMutableArray array];
    for (NSIndexPath *indexPath in indexPaths) {
        [objects addObject:[self objectAtIndexPath:indexPath]];
    }
    return [NSArray arrayWithArray:objects];
}
-(NSArray *)indexPathsForObject:(id)object{
    NSMutableArray *array = [NSMutableArray array];
    for (int section=0,sectionsCount=(int)[self numberOfSections]; section<sectionsCount; section++) {
        for (int row=0,rowsCount = (int)[self numberOfRowsInSection:section]; row<rowsCount; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            if(object == [self objectAtIndexPath:indexPath]){
                [array addObject:indexPath];
            }
        }
    }
    return [NSArray arrayWithArray:array];
}

@end





@implementation GNIndexedDataSource (UITableView)

+(NSString *)defaultTableViewCellIdentifier{
    return @"cell";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self numberOfSections];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self numberOfRowsInSection:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[[self class] defaultTableViewCellIdentifier] forIndexPath:indexPath];
    if([cell conformsToProtocol:@protocol(GNTableViewDataCell)])[(id<GNTableViewDataCell>)cell setData:[self objectAtIndexPath:indexPath]];
    return cell;
}

@end



@implementation GNIndexedDataSource (UICollectionView)

+(NSString *)defaultCollectionViewCellIdentifier{
    return @"cell";
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self numberOfSections];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self numberOfRowsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[[self class] defaultCollectionViewCellIdentifier] forIndexPath:indexPath];
    if([cell conformsToProtocol:@protocol(GNCollectionViewDataCell)])[(id<GNCollectionViewDataCell>)cell setData:[self objectAtIndexPath:indexPath]];
    return cell;
}

@end


