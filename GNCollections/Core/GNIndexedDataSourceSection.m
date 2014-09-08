//
//  GNIndexedDataSourceSection.m
//  GNCollections
//
//  Created by Jakub Knejzlik on 08/09/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "GNIndexedDataSourceSection.h"

@implementation GNIndexedDataSourceSection

-(NSMutableArray *)objects{
    if(!_objects)_objects = [NSMutableArray array];
    return _objects;
}

@end