//
//  ViewController.m
//  CXPageViewController
//
//  Created by xiaoma on 2018/1/15.
//  Copyright © 2018年 CX. All rights reserved.
//

#import "ViewController.h"

#import "CXSegmentView.h"


@interface ViewController () <CXSegmentViewDelegate>

@property (nonatomic, strong) CXSegmentView *segmentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *titles = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 10; i++) {

        NSString *str = [NSString stringWithFormat:@"第 %d 页", i+1];

        [titles addObject:str];
    }
    
    self.segmentView.titles = titles;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.segmentView.frame = CGRectMake(0, 60, self.view.frame.size.width, 30);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CXSegmentView *)segmentView {
    if (_segmentView == nil) {
        _segmentView = [[CXSegmentView alloc] init];
        _segmentView.delegate = self;
        _segmentView.fontSize = 12;
        
        [self.view addSubview:_segmentView];
    }
    
    return _segmentView;
}

- (void)segmentView:(CXSegmentView *)view didSelectedIndex:(NSInteger)index {
    NSLog(@"index: %ld", (long)index);
}

@end
