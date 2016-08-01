//
//  SearchResultTableView.h
//  ScrollView
//
//  Created by yeguoshuai on 16/7/28.
//  Copyright © 2016年 AK. All rights reserved.
//


//搜索结果列表

#import <UIKit/UIKit.h>

@protocol SearchResultTableViewDelegate <NSObject>

/**
 *  查看搜索结果详情
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 */
- (void)searchResultTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface SearchResultTableView : UITableView

@property (assign, nonatomic) id<SearchResultTableViewDelegate> searchResultDelegate;
/**
 *  传入数据源
 *
 *  @param searchValue 将要显示的数据
 */
- (void)theSearchResult:(NSArray *)searchValue;

@end
