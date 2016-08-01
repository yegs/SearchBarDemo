//
//  UITextField+DatePicker.m
//  WD_OA
//
//  Created by ygs on 16/7/15.
//  Copyright © 2016年 kellen. All rights reserved.
//

#import "UITextField+DatePicker.h"
#import <objc/runtime.h>

static const void *PickerKey = &PickerKey;
static const void *DoneBlockKey = &DoneBlockKey;
static const void *IndexPathKey = &IndexPathKey;

@implementation UITextField (DatePicker)

- (void)showDatePicker:(DoneBlock)block {
    [self showDatePicker:block datePickerMode:UIDatePickerModeDateAndTime];
}
- (void)showDatePicker:(DoneBlock)block datePickerMode:(UIDatePickerMode)datePickerMode {
    CGFloat inputViewHeight = 0;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    if (width == 320) {
        inputViewHeight = 180;
    } else if (width == 375) {
        inputViewHeight = 210;
    } else if (width == 414) {
        inputViewHeight = 220;
    }
    
    if (!self.doneBlock) {
        self.doneBlock = block;
    }
    self.doneBlock = block;
    
    UIDatePicker *picker = objc_getAssociatedObject(self, PickerKey);
    if (picker) {
        return;
    }
    
    picker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, width, inputViewHeight)];
    picker.backgroundColor = [UIColor whiteColor];
    picker.datePickerMode = datePickerMode;
    //    picker.datePickerMode = UIDatePickerModeDateAndTime;
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *minDate = [formatter dateFromString:@"1949-01-01 00:00"];
    picker.minimumDate = minDate;
    //    picker.maximumDate = [NSDate date];
    self.datePicker = picker;
    
    
    UIView *toolView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 44)];
    toolView.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 1)];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.1;
    [toolView addSubview:lineView];
    
    // 完成按钮
    UIButton *doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    doneBtn.center = CGPointMake(width - 30, 22);
    [toolView addSubview:doneBtn];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    doneBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [doneBtn setTitleColor:[UIColor colorWithRed:56/255.0 green:179/255.0 blue:51/255.0 alpha:1] forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 取消按钮
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    cancelBtn.center = CGPointMake(30, 22);
    [toolView addSubview:cancelBtn];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [cancelBtn setTitleColor:[UIColor colorWithRed:56/255.0 green:179/255.0 blue:51/255.0 alpha:1] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.inputView = picker;
    self.inputAccessoryView = toolView;
    self.tintColor = [UIColor clearColor];
    self.textColor = [UIColor lightGrayColor];
    self.clearButtonMode = UITextFieldViewModeNever;
    self.delegate = self;
}
- (void)removeDatePicker {
    self.inputView = nil;
    self.inputAccessoryView = nil;
    [self.datePicker removeFromSuperview],self.datePicker = nil;;
}
#pragma mark - 
//选择器
- (void)setDatePicker:(UIDatePicker *)datePicker {
    objc_setAssociatedObject(self, PickerKey, datePicker, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIDatePicker *)datePicker {
    return objc_getAssociatedObject(self, PickerKey);
}
//完成block
- (void)setDoneBlock:(DoneBlock)doneBlock {
    objc_setAssociatedObject(self, DoneBlockKey, doneBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (DoneBlock)doneBlock {
    return objc_getAssociatedObject(self, DoneBlockKey);
}
//索引
- (NSIndexPath *)indexPath {
    return objc_getAssociatedObject(self, IndexPathKey);
}
- (void)setIndexPath:(NSIndexPath *)indexPath {
    objc_setAssociatedObject(self, IndexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//时间选择器
#pragma mark - 
- (void)doneAction:(UIButton *)sender {
    [self resignFirstResponder];
    if (self.doneBlock) {
        NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *dateStr = [formatter stringFromDate:self.datePicker.date];
        self.text = dateStr;
        self.doneBlock(dateStr);
    }
}
- (void)cancelBtnAction:(id)sender {
    [self resignFirstResponder];
}
#pragma mark - uitextfield delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return NO;
}
@end
