//
//  ViewController.m
//  signatureDemo
//
//  Created by panchuang on 2018/7/6.
//  Copyright © 2018年 panchuang. All rights reserved.
//

#import "ViewController.h"
#import "PC_SignatureView.h"
#import "PC_DrawView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet PC_SignatureView *signatureView;
- (IBAction)senderTouch:(UIButton *)sender;
@property (nonatomic, strong) UIImageView *signatureImageView;
@property (nonatomic, strong) PC_DrawView *signatureDrawView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.signatureDrawView = [[PC_DrawView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.signatureDrawView.rotationEnable = YES;
    self.signatureDrawView.hidden = YES;
    [self.view addSubview:self.signatureDrawView];
    [self.view bringSubviewToFront:self.signatureDrawView];
    
    self.signatureImageView = [[UIImageView alloc] initWithFrame:self.signatureDrawView.bounds];
    self.signatureImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.signatureDrawView addSubview:self.signatureImageView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)senderTouch:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
        {
            //清除
            [self.signatureView pc_cleanSignature];
            
        }
            break;
        case 2:
        {
            //撤销
            [self.signatureView pc_revocationSignature];
        }
            break;
        case 3:
        {
            //确认
            UIImage *image = [self.signatureView pc_configSignature];
            
            UIImage *image1 = [self.signatureView pc_waterImageWithImage:image text:@"微信" textRect:CGRectMake(30, 100, 100, 40) attribute:@{NSFontAttributeName:[UIFont systemFontOfSize:40],NSForegroundColorAttributeName:[UIColor redColor]}];
            self.signatureImageView.image = [self.signatureView pc_waterImageWithImage:image1 waterImage:[UIImage imageNamed:@"icon_weixin_p"] rect:CGRectMake(200, 300, 180, 180)];
            self.signatureDrawView.hidden = NO;
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
