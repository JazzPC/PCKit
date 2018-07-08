//
//  Signature View.h
//  signatureDemo
//
//  Created by panchuang on 2018/7/6.
//  Copyright © 2018年 panchuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PC_SignatureView : UIView

/**
 线条颜色  默认为黑色
 */
@property (nonatomic, strong) UIColor *lineColor;

/**
 线条宽度  默认为3.0
 */
@property (nonatomic, assign) CGFloat lineWidth;

/**
 清除签名
 */
- (void)pc_cleanSignature;

/**
 撤销上一步
 */
- (void)pc_revocationSignature;

/**
 确认签名

 @return 返回签名image
 */
- (UIImage *)pc_configSignature;

/**
 添加文字水印

 @param image 原始image
 @param text 文字内容
 @param textRect 文字添加区域
 @param attribute 文字样式
 @return 加水印后的图片
 */
- (UIImage *)pc_waterImageWithImage:(UIImage *)image text:(NSString *)text textRect:(CGRect)textRect attribute:(NSDictionary *)attribute;

/**
 添加图片水印

 @param image 原始image
 @param waterImage 水印image
 @param rect 水印图片添加区域
 @return 加水印后的图片
 */
- (UIImage *)pc_waterImageWithImage:(UIImage *)image waterImage:(UIImage *)waterImage rect:(CGRect)rect;
@end
