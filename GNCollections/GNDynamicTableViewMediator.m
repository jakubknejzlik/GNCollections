//
//  GNTableViewDelegate.m
//
//  Created by Jakub Knejzlik on 08/09/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//


#import "GNDynamicTableViewMediator.h"


@interface GNDynamicTableViewMediator ()
@property (nonatomic,readonly) GNTableViewDynamicSourceWithStaticButton *dataSource;
@end

@implementation GNDynamicTableViewMediator

-(id)initWithTableView:(UITableView *)tableView dataSource:(GNTableViewDynamicSourceWithStaticButton *)dataSource{
    return [super initWithTableView:tableView dataSource:dataSource];
}

-(void)loadDataInSection:(NSInteger)section{
    self.loadingData = YES;
    __weak GNDynamicTableViewMediator *weakself = self;
    [self.dataSource loadDataInSection:section withCompletionHandler:^(NSError *error, BOOL canLoadMore) {
        self.loadingData = NO;
        [weakself canDisplayLoadMore:canLoadMore inSection:section];
        [self.tableView reloadData];
    }];
}
-(void)loadNextDataInSection:(NSInteger)section{
    __weak GNDynamicTableViewMediator *weakself = self;
    [self.dataSource loadNextDataInSection:section withCompletionHandler:^(NSError *error, BOOL canLoadMore) {
        [weakself canDisplayLoadMore:canLoadMore inSection:section];
        [self.tableView reloadData];
    }];
}

-(void)setLoadingData:(BOOL)loadingData{
    _loadingData = loadingData;
    if(loadingData){
        if(!self.loadingDataIndicatorView){
            self.loadingDataIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            self.loadingDataIndicatorView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
            [(UIActivityIndicatorView *)self.loadingDataIndicatorView startAnimating];
            
        }
        if(self.disableTableViewUserInteractionOnLoad)self.tableView.userInteractionEnabled = NO;
        self.loadingDataIndicatorView.frame = self.tableView.bounds;
        [self.tableView addSubview:self.loadingDataIndicatorView];
    }else{
        [self.loadingDataIndicatorView removeFromSuperview];
        if(self.disableTableViewUserInteractionOnLoad)self.tableView.userInteractionEnabled = YES;
    }
}

-(void)canDisplayLoadMore:(BOOL)canDisplay inSection:(NSInteger)section{
    if (canDisplay) {
        UITableViewCell *cell;
        if(self.loadMoreCellClass)cell = [[self.loadMoreCellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        else{
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            UILabel *l = [[UILabel alloc] initWithFrame:cell.bounds];
            l.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            l.textAlignment = NSTextAlignmentCenter;
            l.text = NSLocalizedString(@"LOAD_MORE_TITLE", nil);
            l.font = [UIFont systemFontOfSize:18];
            [cell addSubview:l];
        }
        [self.dataSource setBottomCell:cell forSection:section];
    }else [self.dataSource removeBottomCellForSection:section];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.dataSource isIndexPathForBottomCell:indexPath tableView:tableView]){
        [self loadNextDataInSection:indexPath.section];
    }else{
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.dataSource isIndexPathForBottomCell:indexPath tableView:tableView]){
        return self.loadMoreCellHeight > 0?self.loadMoreCellHeight:40;
    }
    if ([self.dataSource.cellClass respondsToSelector:@selector(rowHeightForData:)]) {
        return [self.dataSource.cellClass rowHeightForData:[self.dataSource objectAtIndexPath:indexPath]];
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

#pragma mark - LoadMoreView
//-(UIView *)loadMoreView{
//    if(!_loadMoreView){
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.tableView.contentSize.height, self.tableView.frame.size.width, 60)];
//        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        label.text = NSLocalizedString(@"load more", @"text for load more option in bottom of tableView");
//        label.textAlignment = NSTextAlignmentCenter;
//        _loadMoreView = label;
//        
//        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnLoadMoreView:)];
//        [label addGestureRecognizer:tapRecognizer];
//    }
//    return _loadMoreView;
//}
//-(void)didTapOnLoadMoreView:(UITapGestureRecognizer *)recognizer{
//    [self loadNextData];
//}

@end
