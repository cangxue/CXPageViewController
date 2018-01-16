//
//  ContentViewController.m
//  CXPageViewController
//
//  Created by xiaoma on 2018/1/16.
//  Copyright © 2018年 CX. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1.0];
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 100 )/ 2, (CGRectGetHeight(self.view.frame) - 40) / 2, 100, 40)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    label.text = titleStr;
}

@end
