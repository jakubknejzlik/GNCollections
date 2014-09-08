//
//  GNTableViewDelegate.h
//
//  Created by Jakub Knejzlik on 08/09/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//


#import "GNTableViewMediator.h"
#import "GNDynamicDataSource.h"


@interface GNDynamicTableViewMediator : GNTableViewMediator

@property (nonatomic,getter = isLoadingData) BOOL loadingData;
@property BOOL disableTableViewUserInteractionOnLoad;
@property (nonatomic,strong) UIView *loadingDataIndicatorView;
@property (nonatomic,strong) Class loadMoreCellClass;
@property (nonatomic) CGFloat loadMoreCellHeight;

-(id)initWithTableView:(UITableView *)tableView dataSource:(GNTableViewDynamicSourceWithStaticButton *)dataSource;

-(void)loadDataInSection:(NSInteger)section;
-(void)loadNextDataInSection:(NSInteger)section;

-(void)canDisplayLoadMore:(BOOL)canDisplay inSection:(NSInteger)section;

@end



