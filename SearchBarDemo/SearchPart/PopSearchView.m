//
//  PopSearchView.m
//  ScrollView
//
//  Created by yeguoshuai on 16/7/27.
//  Copyright © 2016年 AK. All rights reserved.
//




#import "PopSearchView.h"
#import "ViewController.h"
@interface PopSearchView ()


@property (strong, nonatomic) PopSearch *popSearch;
@property (strong, nonatomic) UISearchBar *defautSearchBar;

@end

@implementation PopSearchView

- (id)initWithPlaceHolder:(NSString *)placeHolder {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenWidth, 44);
        _placeHolder = placeHolder;
        
        [self initView];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
- (id)init {
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}
- (void)initView {
    _defautSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    _defautSearchBar.placeholder = _placeHolder;
    [self addSubview:_defautSearchBar];
    
    //在搜索框上边覆盖一层button  点击button弹出搜索页面
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = _defautSearchBar.frame;
    [self addSubview:btn];
    [btn addTarget:self action:@selector(showPopView) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = placeHolder;
    _defautSearchBar.placeholder = _placeHolder;
}
#pragma mark -
- (void)showPopView {
    _popSearch = nil;
    _popSearch = [[PopSearch alloc] init];
    _popSearch.view.frame = [UIScreen mainScreen].bounds;
    _popSearch.searchBar.placeholder = _placeHolder;
    _popSearch.view.backgroundColor = [UIColor colorWithWhite:1 alpha:.5];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_popSearch];
    nav.navigationBarHidden = YES;
    //获取root controller
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    rootVC.navigationController.navigationBarHidden = YES;
    [rootVC.view addSubview:nav.view];
    [rootVC addChildViewController:nav];
}

@end


#import "SearchHistoryTableView.h"
#import "SearchResultTableView.h"
@interface PopSearch ()<UISearchBarDelegate,SearchHistoryTableViewDelegate,SearchResultTableViewDelegate>

@property (strong, nonatomic) NSMutableArray *dataSource;//历史记录
@property (strong, nonatomic) UIView *topView;//搜索框放置位置

@property (strong, nonatomic) SearchHistoryTableView *historyTableView;//历史记录
@property (strong, nonatomic) SearchResultTableView *resultTableView;//搜索到的数据
@property (assign, nonatomic) BOOL doHaveResult;
@end

@implementation PopSearch
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.historyTableView];
    [self.view addSubview:self.resultTableView];
    [self show];
}
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
        _topView.backgroundColor = [UIColor colorWithRed:239/255.0 green:238/255.0 blue:244/255.0 alpha:0];
    }
    return _topView;
}
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 70, CGRectGetWidth(self.view.frame)-20, 44)];
        _searchBar.placeholder = @"你妹啊啊啊啊啊";
        _searchBar.delegate = self;
        _searchBar.tag = 1008611;
        [self.view addSubview:_searchBar];
        
        for (UIView *view in _searchBar.subviews) {
            if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
                [[view.subviews objectAtIndex:0] removeFromSuperview];
                break;
            }
        }
        
        [_searchBar becomeFirstResponder];
        [_searchBar setShowsCancelButton:YES];
    }
    return _searchBar;
}
- (UITableView *)historyTableView {
    if (!_historyTableView) {
        _historyTableView = [[SearchHistoryTableView alloc] initWithFrame:CGRectMake(0, 70+44, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _historyTableView.searchDelegate = self;
    }
    return _historyTableView;
}
- (UITableView *)resultTableView {
    if (!_resultTableView) {
        _resultTableView = [[SearchResultTableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _resultTableView.searchResultDelegate = self;
        _resultTableView.hidden = YES;
    }
    return _resultTableView;
}
- (void)show {
    [self.searchBar setShowsCancelButton:YES animated:YES];
    //每次展示的时候  显示搜索框 隐藏headerView 以及搜索结果列表
    self.historyTableView.hidden = NO;//显示历史记录tableview
    self.historyTableView.doShowHeader = NO;//
    self.resultTableView.hidden = YES;

    [UIView animateWithDuration:.25 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
        _topView.backgroundColor = [UIColor colorWithRed:239/255.0 green:238/255.0 blue:244/255.0 alpha:1];
        self.searchBar.frame = CGRectMake(10, 20, CGRectGetWidth(self.view.frame)-20, 44);
        self.historyTableView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64);
    }];
}
#pragma mark - search bar delegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {

    [UIView animateWithDuration:.25 animations:^{
        self.searchBar.frame = CGRectMake(10, 70, CGRectGetWidth(self.view.frame)-20, 44);
        self.historyTableView.frame = CGRectMake(0, 70+44, kScreenWidth, kScreenHeight-64);
        self.resultTableView.frame = CGRectMake(0, 70+44, kScreenWidth, kScreenHeight-64);
        self.view.backgroundColor = [UIColor colorWithWhite:1 alpha:.5];
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        
        UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        NSArray *subview = rootVC.view.subviews;
        for (UIView *view in subview) {
            if ([view isKindOfClass:NSClassFromString(@"UILayoutContainerView")]) {
                //如果不移除 则页面不能进行交互
                [view removeFromSuperview];
            }
        }
    }];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
    [self.historyTableView saveSearchValue:searchBar.text];
    //没有搜到结果时展示
    if (searchBar.text.length%3 == 0) {
        self.historyTableView.hidden = YES;//搜索到结果 隐藏历史记录列表
        self.historyTableView.doShowHeader = NO;//搜索到结果 隐藏历史记录的header
        self.resultTableView.hidden = NO;//搜索到结果 显示搜索结果页面
        [self.resultTableView theSearchResult:@[@"1",@"2",@"3"]];//搜索到结果 给搜索列表界面传值显示
    }else {
        self.historyTableView.hidden = NO;
        self.historyTableView.doShowHeader = YES;
        self.resultTableView.hidden = YES;
        [self.resultTableView theSearchResult:@[]];
    }
}
#pragma mark - delegate
- (void)searchResultTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //点击搜索的结果 进入相应界面RechargeHelperController
    ViewController *vc = [[ViewController alloc] init];
    vc.titleStr = @"搜索到的yemian";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    vc.navigationController.navigationBarHidden = NO;
}

@end
