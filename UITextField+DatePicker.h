//
//  UITextField+DatePicker.h
//  WD_OA
//
//  Created by ygs on 16/7/15.
//  Copyright © 2016年 kellen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DoneBlock)(id value);

@interface UITextField (DatePicker)<UITextFieldDelegate>

@property (strong, nonatomic) UIDatePicker *datePicker;
@property(nonatomic,copy) DoneBlock doneBlock;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (nonatomic) UIDatePickerMode datePickerMode;
- (void)showDatePicker:(DoneBlock)block;
- (void)showDatePicker:(DoneBlock)block datePickerMode:(UIDatePickerMode)datePickerMode;
- (void)removeDatePicker;
@end
