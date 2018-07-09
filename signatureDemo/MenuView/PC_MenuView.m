//
//  MenuView.m
//  signatureDemo
//
//  Created by panchuang on 2018/7/9.
//  Copyright © 2018年 panchuang. All rights reserved.
//

#import "PC_MenuView.h"


#define topMargin 15
@interface PC_MenuView () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tableSuperView;
@end

@implementation PC_MenuView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self upDateUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self upDateUI];
    }
    return self;
}

- (void)upDateUI {
    self.backgroundColor = [UIColor clearColor];
    self.textColor = [UIColor whiteColor];
    self.groundColor = [UIColor whiteColor];
    _tableSuperView = [[UIView alloc] initWithFrame:CGRectMake(0, topMargin, self.bounds.size.width, self.bounds.size.height - topMargin)];
    _tableSuperView.backgroundColor = [UIColor clearColor];
    [self addSubview:_tableSuperView];
    
    UIBezierPath *tablePath = [UIBezierPath bezierPathWithRoundedRect:_tableSuperView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(6, 6)];
    CAShapeLayer *tableLayer = [CAShapeLayer layer];
    tableLayer.frame = _tableSuperView.bounds;
    tableLayer.path = tablePath.CGPath;
    _tableSuperView.layer.mask = tableLayer;
    
    _tableView = [[UITableView alloc] initWithFrame:_tableSuperView.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 44;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableSuperView addSubview:_tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *menuCellID = @"menuCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuCellID];
    }
    if ([self.dataArray[indexPath.row] isKindOfClass:[NSString class]]) {
        cell.textLabel.text = self.dataArray[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = self.textColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.didselected) {
        self.didselected(indexPath.row);
    }
//    [self pc_hiddenMenu];
}

- (void)pc_showMenu {
        self.hidden = NO;
        self.alpha = 0.0;
        [UIView animateWithDuration:0.3f animations:^{
            self.alpha = 1.0;
        }];
    
}

- (void)pc_hiddenMenu {
    self.alpha = 1.0;
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
}

- (void)setBackColor:(UIColor *)backColor {
    
}

- (void)setGroundColor:(UIColor *)groundColor {
    _groundColor = groundColor;
    self.tableSuperView.backgroundColor = _groundColor;
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *locationPath = [UIBezierPath bezierPath];
    if (self.angleLocation == AngleRight) {
        [locationPath moveToPoint:CGPointMake(self.bounds.size.width - 30, 0)];
        [locationPath addLineToPoint:CGPointMake(self.bounds.size.width - 20, topMargin)];
        [locationPath addLineToPoint:CGPointMake(self.bounds.size.width - 40, topMargin)];
    }else {
        [locationPath moveToPoint:CGPointMake(30, 0)];
        [locationPath addLineToPoint:CGPointMake(20, topMargin)];
        [locationPath addLineToPoint:CGPointMake(40, topMargin)];
    }
    [self.groundColor set];
    [locationPath fill];
    [locationPath stroke];
}

-  (void)dealloc {
    NSLog(@"%@ 释放了",NSStringFromClass([self class]));
}

@end
