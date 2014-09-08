//
//  GNAssetsDataSource.m
//
//  Created by Jakub Knejzlik on 08/09/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//


#import "GNAssetsDataSource.h"

@interface GNAssetsDataSource ()
@property BOOL assetsLoaded;
@property (nonatomic) NSUInteger groupType;
@property (nonatomic) ALAssetsFilter *filter;
@property (nonatomic,strong) NSMutableArray *_groups;
@property (nonatomic,strong) ALAssetsLibrary *library;
@end

@implementation GNAssetsDataSource

-(id)initWithAssetsGroupType:(ALAssetsGroupType)groupType filter:(ALAssetsFilter *)filter{
    self = [super init];
    if (self) {
        self.groupType = groupType;
        self.filter = filter;
        self._groups = [NSMutableArray array];
    }
    return self;
}

-(void)loadAssetsInBackgroundWithCompletionHandler:(void(^)(NSError *error))completionHandler{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSError *err;
        [self loadAssetsWithCompletionHandler:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(err);
            });
        }];
    });
}

-(void)loadAssetsWithCompletionHandler:(void(^)(NSError *error))completionHandler{
    if(self.assetsLoaded){
        return completionHandler(nil);
    }
    
    if(!self.library)self.library = [[ALAssetsLibrary alloc] init];
    [self.library enumerateGroupsWithTypes:self.groupType usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if(group){
            GNAssetsGroup *g = [[GNAssetsGroup alloc] initWithGroup:group];
            g.title = g.name;
            if(g.URL){
                [__groups addObject:g];
            }
            self.assetsLoaded = YES;
        }else{
            __block int groupCount = (int)[__groups count];
            for (int x=0,l=(int)[__groups count]; x<l; x++) {
                GNAssetsGroup *group = [__groups objectAtIndex:x];
                [group.group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                    if(result){
                        GNAsset *asset = [[GNAsset alloc] initWithAsset:result];
                        [group.objects addObject:asset];
                    }else{
                        if(--groupCount == 0){
                            completionHandler(nil);
                        }
                    }
                }];
            }
        }
    } failureBlock:^(NSError *error) {
        completionHandler(error);
    }];
}

-(NSInteger)numberOfSections{
    return [self.groups count];
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section{
    if(self.newestOnTop){
        return [[[self.groups objectAtIndex:[self numberOfSections]-1-section] objects] count];
    }else{
        return [[[self.groups objectAtIndex:section] objects] count];
    }
}
-(id)objectAtIndexPath:(NSIndexPath *)indexPath{
    if(self.newestOnTop){
        return [[[self.groups objectAtIndex:[self numberOfSections]-1-indexPath.section] objects] objectAtIndex:[self numberOfRowsInSection:indexPath.section]-1-indexPath.row];
    }else{
        return [[[self.groups objectAtIndex:indexPath.section] objects] objectAtIndex:indexPath.row];
    }
}

-(NSArray *)groups{
    return [self._groups copy];
}


@end








