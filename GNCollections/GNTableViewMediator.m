//
//  GNTableViewMediator.m
//
//  Created by Jakub Knejzlik on 08/09/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//


#import "GNTableViewMediator.h"

@implementation GNTableViewMediator

-(id)initWithTableView:(UITableView *)tableView dataSource:(GNIndexedDataSource *)dataSource{
    self = [super init];
    if (self) {
        _tableView = tableView;
        _dataSource = dataSource;
        self.tableView.delegate = self;
        self.tableView.dataSource = self.dataSource;
        self.tableView.canCancelContentTouches = NO;
    }
    return self;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]){
        return [self.delegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return 40;
}
-(id)forwardingTargetForSelector:(SEL)aSelector{
    return self.delegate;
}

@end
