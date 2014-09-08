//
//  GNAssetGroup.m
//  GNCollections
//
//  Created by Jakub Knejzlik on 08/09/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "GNAssetsGroup.h"


@interface GNAssetsGroup ()
@end
@implementation GNAssetsGroup

-(id)initWithGroup:(ALAssetsGroup *)group{
    self = [super init];
    if (self) {
        _group = group;
    }
    return self;
}
-(NSString *)name{
    return [self.group valueForProperty:ALAssetsGroupPropertyName];
}
-(NSString *)persistentID{
    return [self.group valueForProperty:ALAssetsGroupPropertyPersistentID];
}
-(NSURL *)URL{
    return [self.group valueForProperty:ALAssetsGroupPropertyURL];
}
-(NSInteger)numberOfAssets{
    return [self.group numberOfAssets];
}

@end

