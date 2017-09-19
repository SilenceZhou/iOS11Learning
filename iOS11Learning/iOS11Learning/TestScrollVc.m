//
//  TestScrollVc.m
//  iOS11Learning
//
//  Created by SilenceZhou on 2017/9/19.
//  Copyright © 2017年 silence. All rights reserved.
//


#import "TestScrollVc.h"

@interface TestScrollVc ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *bottomBtn;

@end

// 测试
@implementation TestScrollVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.bottomBtn];
    
    // 安全区域 （让滚动区域调整）
    self.additionalSafeAreaInsets = UIEdgeInsetsMake(-20, 0, 0, 0);
}

- (UIButton *)bottomBtn
{
    if (!_bottomBtn) {
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 80, [UIScreen mainScreen].bounds.size.width, 80)];
        _bottomBtn.backgroundColor = [UIColor redColor];
        [_bottomBtn addTarget:self
                       action:@selector(bottomBtnClick)
             forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _bottomBtn;
}

- (void)bottomBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100)];
        _scrollView.backgroundColor = [UIColor blueColor];
        _scrollView.contentSize = CGSizeMake(0, [UIScreen mainScreen].bounds.size.height);
    }
    return _scrollView;
}




@end
