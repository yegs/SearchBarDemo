//
//  SearchHistoryTableView.h
//  ScrollView
//
//  Created by yeguoshuai on 16/7/28.
//  Copyright © 2016年 AK. All rights reserved.
//

//搜索历史记录界面


#import <UIKit/UIKit.h>

@protocol SearchHistoryTableViewDelegate <NSObject>

/**
 *  点击历史记录列表进行搜索
 *
 *  @param value 将要搜索的字符串
 */
- (void)searchValueKey:(NSString *)value;

@end

@interface SearchHistoryTableView : UITableView

@property (assign, nonatomic) id<SearchHistoryTableViewDelegate> searchDelegate;
@property (assign, nonatomic) BOOL doShowHeader;//是否显示header
- (void)saveSearchValue:(NSString *)value;//保存搜索的内容

@end
