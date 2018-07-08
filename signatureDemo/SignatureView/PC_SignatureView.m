//
//  Signature View.m
//  signatureDemo
//
//  Created by panchuang on 2018/7/6.
//  Copyright © 2018年 panchuang. All rights reserved.
//

#import "PC_SignatureView.h"

#define ColorValue 240.0/255.0

@interface PC_SignatureView ()
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) NSMutableArray *pathArray;
@property (nonatomic, strong) UIBezierPath *path;
@end

@implementation PC_SignatureView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addPanGestures];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self addPanGestures];
    }
    return self;
}

- (void)addPanGestures {
    self.backgroundColor = [UIColor colorWithRed:ColorValue green:ColorValue blue:ColorValue alpha:1];
    self.lineColor = [UIColor blackColor];
    self.lineWidth = 3.0;
    [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)]];
    if (!self.pathArray) {
        self.pathArray = [NSMutableArray array];
    }
}

- (void)pan:(UIPanGestureRecognizer *)recognizer {
   
    CGPoint currentPoint = [recognizer locationInView:self];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.path = [UIBezierPath bezierPath];
        [self.path moveToPoint:currentPoint];
        [self.pathArray addObject:self.path];
    }else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self.path addLineToPoint:currentPoint];
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    for (UIBezierPath *path in self.pathArray) {
        path.lineWidth = self.lineWidth;
        [self.lineColor set];
        [path stroke];
    }
    
}

- (void)pc_cleanSignature {
    [self.pathArray removeAllObjects];
    [self setNeedsDisplay];
}

- (void)pc_revocationSignature {
    [self.pathArray removeLastObject];
    [self setNeedsDisplay];
}

- (UIImage *)pc_configSignature {
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:ref];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)pc_waterImageWithImage:(UIImage *)image text:(NSString *)text textRect:(CGRect)textRect attribute:(NSDictionary *)attribute {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    [text drawInRect:textRect withAttributes:attribute];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)pc_waterImageWithImage:(UIImage *)image waterImage:(UIImage *)waterImage rect:(CGRect)rect {
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    [waterImage drawInRect:rect];;
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
}

@end
