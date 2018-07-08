//
//  DragView.m
//  signatureDemo
//
//  Created by panchuang on 2018/7/6.
//  Copyright © 2018年 panchuang. All rights reserved.
//

#import "PC_DrawView.h"

@interface PC_DrawView ()
@property (nonatomic, strong) UIPanGestureRecognizer *drawPan;
@property (nonatomic, strong) UIRotationGestureRecognizer *rotationPan;
@property (nonatomic, assign) CGPoint drawStartPoint;
@end

@implementation PC_DrawView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    _drawPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(drawAction:)];
    [self addGestureRecognizer:_drawPan];
}

- (void)drawAction:(UIPanGestureRecognizer *)recognizer {
    CGPoint currentPoint = [recognizer translationInView:self];
    float drawX = currentPoint.x;
    float drawY = currentPoint.y;
    CGPoint newCenter = CGPointMake(self.center.x + drawX, self.center.y + drawY);
    self.center = newCenter;
    //重置移动后的坐标  防止每次计算时位置叠加(飞走)
    [recognizer setTranslation:CGPointZero inView:self];
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self checkBounds];
    }
    
}

- (void)checkBounds {
    CGRect rect = self.frame;
    if (rect.origin.x <= 0) {
        rect.origin.x = self.superview.frame.origin.x;
    }
    
    if (rect.origin.y <= 0) {
        rect.origin.y = self.superview.frame.origin.y;
    }
    
    if (rect.origin.x + rect.size.width >= self.superview.frame.size.width) {
        rect.origin.x = self.superview.frame.size.width - rect.size.width;
    }
    
    if (rect.origin.y + rect.size.height >= self.superview.frame.size.height) {
        rect.origin.y = self.superview.frame.size.height - rect.size.height;
    }
    [UIView beginAnimations:@"move" context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.frame = rect;
    [UIView commitAnimations];
}

- (void)setRotationEnable:(BOOL)rotationEnable {
    _rotationEnable = rotationEnable;
    if (_rotationEnable) {
        if (_rotationPan == nil) {
            _rotationPan = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotatipnAction:)];
        }
    }else {
        if (_rotationPan) {
            [self removeGestureRecognizer:_rotationPan];
        }
    }
}

- (void)rotatipnAction:(UIRotationGestureRecognizer *)recognizer {
    float rotation = recognizer.rotation;
    UIView *view = recognizer.view;
    view.transform = CGAffineTransformRotate(view.transform, rotation);
    recognizer.rotation = 0;
}
@end
