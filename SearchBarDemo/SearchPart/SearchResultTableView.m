//
//  SearchResultTableView.m
//  ScrollView
//
//  Created by yeguoshuai on 16/7/28.
//  Copyright © 2016年 AK. All rights reserved.
//

#import "SearchResultTableView.h"

@interface SearchResultTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSArray *dataSourceArr;

@end

@implementation SearchResultTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        _dataSourceArr = [NSArray new];
        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = [UIView new];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return self;
}
- (void)theSearchResult:(NSArray *)searchValue {
    _dataSourceArr = searchValue;
    [self reloadData];
}
#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"hahahahahah";
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([_searchResultDelegate respondsToSelector:@selector(searchResultTableView:didSelectRowAtIndexPath:)]) {
        [_searchResultDelegate searchResultTableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}
#pragma mark -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //滑动列表 隐藏键盘
    if (_searchResultDelegate) {
        [[(UIViewController *)_searchResultDelegate view] endEditing:YES];
    }else {
        [self.superview endEditing:YES];
    }
}
@end
