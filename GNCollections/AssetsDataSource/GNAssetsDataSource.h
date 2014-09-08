//
//  GNAssetsDataSource.h
//
//  Created by Jakub Knejzlik on 08/09/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "GNIndexedDataSource.h"

#import "GNAsset.h"
#import "GNAssetsGroup.h"

@interface GNAssetsDataSource : GNIndexedDataSource
@property (nonatomic,readonly) NSArray *groups;
@property (nonatomic) BOOL newestOnTop;

-(id)initWithAssetsGroupType:(ALAssetsGroupType)groupType filter:(ALAssetsFilter *)filter;

-(void)loadAssetsWithCompletionHandler:(void(^)(NSError *error))completionHandler;
-(void)loadAssetsInBackgroundWithCompletionHandler:(void(^)(NSError *error))completionHandler;

@end



