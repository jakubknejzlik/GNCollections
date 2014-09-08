//
//  GNAssetGroup.h
//  GNCollections
//
//  Created by Jakub Knejzlik on 08/09/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "GNIndexedDataSourceSection.h"

#import <AssetsLibrary/AssetsLibrary.h>

@interface GNAssetsGroup : GNIndexedDataSourceSection
@property (nonatomic,readonly) ALAssetsGroup *group;
@property (nonatomic,readonly) NSString *name;
@property (nonatomic,readonly) NSString *persistentID;
@property (nonatomic,readonly) NSURL *URL;

-(id)initWithGroup:(ALAssetsGroup *)group;

-(NSInteger)numberOfAssets;

@end
