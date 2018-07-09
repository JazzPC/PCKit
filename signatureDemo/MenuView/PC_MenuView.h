//
//  MenuView.h
//  signatureDemo
//
//  Created by panchuang on 2018/7/9.
//  Copyright © 2018年 panchuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AngleLocation) {
    AngleLeft,
    AngleRight,
};

typedef void(^menuDidSelected)(NSUInteger index);
@interface PC_MenuView : UIView

/**
 数据源
 */
@property (nonatomic, copy) NSArray *dataArray;

/**
 背景颜色 默认为白色
 */
@property (nonatomic, strong) UIColor *groundColor;

/**
 文字颜色 默认为白色
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 cell底部线条颜色
 */
@property (nonatomic, strong) UIColor *lineColor;

/**
 点击回调
 */
@property (nonatomic, copy) menuDidSelected didselected;

/**
 三角的位置 默认为右侧
 */
@property (nonatomic, assign) AngleLocation angleLocation;

/**
 显示
 */
- (void)pc_showMenu;

/**
 隐藏
 */
- (void)pc_hiddenMenu;
@end
