//
//  GNTableViewDataSource.h
//
//  Created by Jakub Knejzlik on 08/09/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//


#import "GNIndexedDataSource.h"

@interface GNStaticIndexedDataSource : GNIndexedDataSource
@property BOOL loading;

-(void)addSection;
-(void)addSectionWithTitle:(NSString *)title;
-(void)addObject:(id)object inSection:(NSInteger)section;
-(void)insertObject:(id)object atIndexPath:(NSIndexPath *)indexPath;
-(void)replaceObjectAtIndexPath:(NSIndexPath *)indexPath withObject:(id)object;
-(void)addObjects:(NSArray *)objects inSection:(NSInteger)section;
-(void)setObjects:(NSArray *)objects inSection:(NSInteger)section;

-(void)removeDataAtIndexPath:(NSIndexPath *)indexPath;
-(void)removeDataInSection:(NSInteger)section;

@end
