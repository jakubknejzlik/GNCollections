//
//  GNTableViewMediator.h
//
//  Created by Jakub Knejzlik on 08/09/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "GNIndexedDataSource.h"

@protocol GNTableViewMediatorDelegate;

@interface GNTableViewMediator : NSObject<UITableViewDelegate>
@property (nonatomic,readonly) GNIndexedDataSource *dataSource;
@property (nonatomic,weak) id<GNTableViewMediatorDelegate> delegate;
@property (nonatomic,readonly) UITableView *tableView;

-(id)initWithTableView:(UITableView *)tableView dataSource:(GNIndexedDataSource *)dataSource;

@end


@protocol GNTableViewMediatorDelegate <NSObject,UITableViewDelegate>

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end