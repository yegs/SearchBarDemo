//
//  SearchHistoryTableView.m
//  ScrollView
//
//  Created by yeguoshuai on 16/7/28.
//  Copyright © 2016年 AK. All rights reserved.
//

#import "SearchHistoryTableView.h"

@interface SearchHistoryTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *histroyArr;//历史记录
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation SearchHistoryTableView
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = [UIView new];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return self;
}
- (NSMutableArray *)histroyArr {
    if (!_histroyArr) {
        _histroyArr = [NSMutableArray new];
        NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"HistroyRecord"];
        if (!arr) {
            [_histroyArr addObjectsFromArray:@[]];
        }else {
            [_histroyArr addObjectsFromArray:arr];
        }
    }
    return _histroyArr;
}
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth-30, 44)];
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_headerView addSubview:_titleLabel];
    }
    return _headerView;
}
- (void)setDoShowHeader:(BOOL)doShowHeader {
    _doShowHeader = doShowHeader;
    self.tableHeaderView = _doShowHeader?self.headerView:nil;
    //header显示的内容
    self.titleLabel.text = self.histroyArr.count > 0?[self.histroyArr firstObject]:@"";
    [self reloadData];
}
#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.histroyArr.count > 0) {
        return self.histroyArr.count + 1;
    }
    return self.histroyArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.histroyArr.count > 0) {
        return 30;
    }
    return 0;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.histroyArr.count > 0 && !_doShowHeader) {
        return @"历史记录";
    }
    return @"";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.histroyArr.count > 0) {
        if (self.histroyArr.count == indexPath.row) {
            cell.textLabel.text = @"清空搜索记录";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }else {
            cell.textLabel.text = self.histroyArr[indexPath.row];
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.histroyArr.count > 0) {
        if (self.histroyArr.count  == indexPath.row) {
            //点击清空
            [self.histroyArr removeAllObjects];
            [[NSUserDefaults standardUserDefaults] setObject:self.histroyArr forKey:@"HistroyRecord"];
            self.tableHeaderView = nil;
            [tableView reloadData];
        }else {
            if ([_searchDelegate respondsToSelector:@selector(searchValueKey:)]) {
                [_searchDelegate searchValueKey:self.histroyArr[indexPath.row]];
            }
        }
    }
}
#pragma mark - 
- (void)saveSearchValue:(NSString *)value {
    //搜索的内容 如果已经存在 则先移除再添加
    NSInteger index = [self.histroyArr indexOfObject:value];
    if (index != NSNotFound) {
        [self.histroyArr removeObject:value];
    }
    [self.histroyArr insertObject:value atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:self.histroyArr forKey:@"HistroyRecord"];
    [self reloadData];
}
#pragma mark - 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //滑动列表 隐藏键盘
    if (_searchDelegate) {
        [[(UIViewController *)_searchDelegate view] endEditing:YES];
    }
}
@end
