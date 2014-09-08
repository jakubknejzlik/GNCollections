//
//  GNTableViewCellSource.m
//
//  Created by Jakub Knejzlik on 08/09/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//


#import "GNDynamicDataSource.h"

@implementation GNDynamicDataSource

-(id)init{
    self = [super init];
    if (self) {
        self.cellClass = [UITableViewCell class];
    }
    return self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.cellClass){
        NSString *reuseIdentifier = NSStringFromClass(self.cellClass);
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        
        if(!cell){
            cell = [[self.cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        }
        if([cell respondsToSelector:@selector(setData:)]){
            [cell performSelector:@selector(setData:) withObject:[self objectAtIndexPath:indexPath]];
        }
        
        return cell;
    }else return nil;
}

-(void)loadDataInSection:(NSInteger)section withCompletionHandler:(void (^)(NSError *error,BOOL canLoadMore))completionHandler{
    completionHandler([NSError errorWithDomain:@"not implemented" code:-1 userInfo:nil],NO);
}
-(void)loadNextDataInSection:(NSInteger)section withCompletionHandler:(void (^)(NSError *error,BOOL canLoadMore))completionHandler{
    completionHandler([NSError errorWithDomain:@"not implemented" code:-1 userInfo:nil],NO);    
}

@end




@interface GNTableViewDynamicSourceWithStaticButton ()
@property (nonatomic,strong) NSMutableDictionary *sectionBottomCells;
@property (nonatomic,strong) NSMutableDictionary *sectionBottomCollectionCells;
@end
@implementation GNTableViewDynamicSourceWithStaticButton

-(NSMutableDictionary *)sectionBottomCells{
    if(!_sectionBottomCells)_sectionBottomCells = [NSMutableDictionary dictionary];
    return _sectionBottomCells;
}
-(NSMutableDictionary *)sectionBottomCollectionCells{
    if(!_sectionBottomCollectionCells)_sectionBottomCollectionCells = [NSMutableDictionary dictionary];
    return _sectionBottomCollectionCells;
}

-(void)setBottomCell:(UITableViewCell *)cell forSection:(NSInteger)section{
    [self.sectionBottomCells setObject:cell forKey:[NSNumber numberWithInteger:section]];
}
-(void)removeBottomCellForSection:(NSInteger)section{
    [self.sectionBottomCells removeObjectForKey:[NSNumber numberWithInteger:section]];
}
-(UITableViewCell *)bottomCellForSection:(NSInteger)section{
    return [self.sectionBottomCells objectForKey:[NSNumber numberWithInteger:section]];
}

-(BOOL)isIndexPathForBottomCell:(NSIndexPath *)indexPath tableView:(UITableView *)tableView{
    return [self bottomCellForSection:indexPath.section] != nil && indexPath.row == [self tableView:tableView numberOfRowsInSection:indexPath.section]-1;
}


-(void)setBottomCollectionCell:(UITableViewCell *)cell forSection:(NSInteger)section{
    [self.sectionBottomCollectionCells setObject:cell forKey:[NSNumber numberWithInteger:section]];
}
-(void)removeBottomCollectionCellForSection:(NSInteger)section{
    [self.sectionBottomCollectionCells removeObjectForKey:[NSNumber numberWithInteger:section]];
}
-(id)bottomCollectionCellForSection:(NSInteger)section{
    return [self.sectionBottomCollectionCells objectForKey:[NSNumber numberWithInteger:section]];
}

-(BOOL)isIndexPathForBottomCell:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView{
    return [self bottomCollectionCellForSection:indexPath.section] != nil && indexPath.row == [self collectionView:collectionView numberOfItemsInSection:indexPath.section]-1;
}


#pragma mark - TableView DataSource methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [super tableView:tableView numberOfRowsInSection:section] + ([self bottomCellForSection:section]?1:0);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self isIndexPathForBottomCell:indexPath tableView:tableView]) {
        return [self bottomCellForSection:indexPath.section];
    }else return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - CollectionView DataSource methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
        return [super collectionView:collectionView numberOfItemsInSection:section] + ([self bottomCellForSection:section]?1:0);
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self isIndexPathForBottomCell:indexPath collectionView:collectionView]) {
        return (UICollectionViewCell *)[self bottomCollectionCellForSection:indexPath.section];
    }else return [super collectionView:collectionView cellForItemAtIndexPath:indexPath];
}

@end