//
//  ViewController.m
//  SearchBarDemo
//
//  Created by yeguoshuai on 16/7/28.
//  Copyright © 2016年 AK. All rights reserved.
//

#import "ViewController.h"
#import "PopSearchView.h"
#import "UITextField+DatePicker.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//    for (int i = 1; i < 5; i ++) {
//        UITextField *textField = [self.view viewWithTag:i];
//        if (i == 1) {
//            [textField showDatePicker:^(id value) {
//                
//            } datePickerMode:UIDatePickerModeTime];
//        }
//        if (i == 2) {
//            [textField showDatePicker:^(id value) {
//                
//            } datePickerMode:UIDatePickerModeDate];
//        }
//        if (i == 3) {
//            [textField showDatePicker:^(id value) {
//                
//            }];
//        }
//        if (i == 4) {
//            [textField showDatePicker:^(id value) {
//                
//            } datePickerMode:UIDatePickerModeCountDownTimer];
//        }
//    }
    

    if (_titleStr) {
        self.title = _titleStr;
    }else {
        self.title = @"首页";
    }
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = [[PopSearchView alloc] initWithPlaceHolder:@"快来搜索吧~~~"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"----------->>>";
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
