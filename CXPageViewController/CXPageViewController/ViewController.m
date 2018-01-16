//
//  ViewController.m
//  CXPageViewController
//
//  Created by xiaoma on 2018/1/15.
//  Copyright © 2018年 CX. All rights reserved.
//

#import "ViewController.h"

#import "CXSegmentViewController.h"

#import "ContentViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSMutableArray *titles = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *vcs = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 10; i++) {
        
        ContentViewController *vc = [[ContentViewController alloc] init];
        
        [vcs addObject:vc];
        
        NSString *str = [NSString stringWithFormat:@"第 %d 页", i+1];
        vc.titleStr = str;
        [titles addObject:str];
    }
    
    CGRect frame = self.view.frame;
    frame.origin.y += 20;
    frame.size.height -= 20;
    
    CXSegmentViewController *segmentVC = [[CXSegmentViewController alloc] init];
    segmentVC.childViewControllers = vcs;
    segmentVC.titles = titles;

    segmentVC.view.frame = frame;
    
    segmentVC.bgColor = [UIColor colorWithRed:253/255.0 green:166/255.0 blue:57/255.0 alpha:1.0];
    segmentVC.selectedColor = [UIColor redColor];
    segmentVC.normalColor = [UIColor whiteColor];
    segmentVC.indicatorColor = [UIColor redColor];
    
    segmentVC.selectedIndex = 4;
    
    [self addChildViewController:segmentVC];
    [self.view addSubview:segmentVC.view];
}





@end
