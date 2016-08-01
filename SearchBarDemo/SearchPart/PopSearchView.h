//
//  PopSearchView.h
//  ScrollView
//
//  Created by yeguoshuai on 16/7/27.
//  Copyright © 2016年 AK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopSearchView : UIView

@property (strong, nonatomic) NSString *placeHolder;
- (id)initWithPlaceHolder:(NSString *)placeHolder;

@end

@interface PopSearch : UIViewController

@property (strong, nonatomic) UISearchBar *searchBar;//搜索框

@end

