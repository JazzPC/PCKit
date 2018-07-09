//
//  MenuViewController.m
//  signatureDemo
//
//  Created by panchuang on 2018/7/9.
//  Copyright © 2018年 panchuang. All rights reserved.
//

#import "MenuViewController.h"
#import "PC_MenuView.h"
@interface MenuViewController ()<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) PC_MenuView *menuView;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"icons_underArrow"] forState:UIControlStateNormal];
    button.frame = CGRectMake(200, 100, 50, 50);
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
//    [self disp]
//    self.navigationItem.rightBarButtonItem =
    // Do any additional setup after loading the view from its nib.
}

- (void)buttonClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self rotationImageWithImageView:sender.imageView radian:M_PI complete:^(UIImage *image) {
            [sender setImage:image forState:UIControlStateNormal];
        }];
        [self.menuView pc_showMenu];
    }else {
        [self rotationImageWithImageView:sender.imageView radian:2 * M_PI complete:^(UIImage *image) {
            [sender setImage:image forState:UIControlStateNormal];
        }];
        [self.menuView pc_hiddenMenu];
    }
    
}

/**
 旋转图片

 @param imageView 需要旋转的imageview
 @param radian 旋转弧度
 @param complete 旋转完成后的回调
 */
- (void)rotationImageWithImageView:(UIImageView *)imageView radian:(CGFloat)radian complete:(void (^)(UIImage * image))complete{
    __block UIImage *image;
    [UIView animateWithDuration:0.2f animations:^{
        imageView.transform = CGAffineTransformMakeRotation(radian);
    } completion:^(BOOL finished) {
        UIGraphicsBeginImageContextWithOptions(imageView.image.size, NO, 0);
        [imageView drawRect:CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        complete(image);
    }];
}

- (PC_MenuView *)menuView {
    if (_menuView == nil) {
        _menuView = [[PC_MenuView alloc] initWithFrame:CGRectMake(200, 150, 200, 300)];
        _menuView.dataArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"];
        _menuView.textColor = [UIColor whiteColor];
        _menuView.groundColor = [UIColor blueColor];
        _menuView.angleLocation = AngleLeft;
        [self.view addSubview:self.menuView];
        _menuView.didselected = ^(NSUInteger index) {
            NSLog(@"%ld",index);
        };
    }
    return _menuView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
