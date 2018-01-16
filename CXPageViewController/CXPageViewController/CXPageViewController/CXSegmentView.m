//
//  CXSegmentView.m
//  CXPageViewController
//
//  Created by xiaoma on 2018/1/15.
//  Copyright © 2018年 CX. All rights reserved.
//

#import "CXSegmentView.h"

@interface CXSegmentView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

// segment view
@property (nonatomic, strong) UICollectionView *segmentView;

// data sources
@property (nonatomic, strong) NSMutableArray *dataSources;

// line
@property (nonatomic, strong) UIView *line;

@end

@implementation CXSegmentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _bgColor = [UIColor whiteColor];
        _selectedColor = [UIColor darkTextColor];
        _normalColor = [UIColor colorWithRed:170/255.0 green:176/255.0 blue:187/255.0 alpha:1.0];
        _fontSize = 13.0;
        _indicatorColor = _selectedColor;
        
        [self.segmentView registerClass:[CXSegmentCell class] forCellWithReuseIdentifier:@"CXSegmentCellID"];
    }
    
    return self;
}

#pragma mark - layoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.segmentView.frame = self.bounds;
    
    CXSegmentModel *model = [self.dataSources firstObject];
    
    self.line.frame = CGRectMake(4, CGRectGetHeight(self.frame) - 2, model.width, 2);
    
    [self setSelectedIndex:self.selectedIndex animation:NO];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSources.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CXSegmentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CXSegmentCellID" forIndexPath:indexPath];
    
    cell.bgColor = _bgColor;
    cell.selectedColor = _selectedColor;
    cell.normalColor = _normalColor;
    cell.fontSize = _fontSize;
    
    CXSegmentModel *model = [self.dataSources objectAtIndex:indexPath.row];
    cell.title = model.title;
    cell.isSelected = model.isSelected;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    [self setSelectedIndex:indexPath.row animation:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentView:didSelectedIndex:)]) {
        [self.delegate segmentView:self didSelectedIndex:indexPath.row];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = 0.0;
    
    if (self.dataSources.count > 4) {
        CXSegmentModel *model = [self.dataSources objectAtIndex:indexPath.row];
        width = model.width;
    } else {
        width = self.frame.size.width / self.dataSources.count;
    }
    return CGSizeMake(width, 30);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 4, 0, 4);
}

#pragma mark - private
// CXSegmentCell选中
- (void)setSelectedIndex:(NSInteger)selectedIndex animation:(BOOL)animation {
    _selectedIndex = selectedIndex;
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    
    [self moveLineToIndexPath:path animation:NO];
    
    [self.segmentView scrollToItemAtIndexPath:path atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:animation];
    
    for (CXSegmentModel *model in self.dataSources) {
        model.isSelected = NO;
    }
    
    CXSegmentModel *model = [self.dataSources objectAtIndex:selectedIndex];
    model.isSelected = YES;
    
    [self.segmentView reloadData];
}

// 移动横线
- (void)moveLineToIndexPath:(NSIndexPath *)indexPath animation:(BOOL)animation {
    
    CXSegmentCell *cell = (CXSegmentCell *)[self.segmentView cellForItemAtIndexPath:indexPath];
    
    CGRect lineBounds = self.line.bounds;
    lineBounds.size.width = cell.bounds.size.width;
    
    CGPoint lineCenter = self.line.center;
    lineCenter.x = cell.center.x;
    
    if (animation) {
        
        [UIView animateWithDuration:0.1 animations:^{
            
            self.line.bounds = lineBounds;
            self.line.center = lineCenter;
        }];
    } else {
        
        self.line.bounds = lineBounds;
        self.line.center = lineCenter;
    }
}

#pragma mark - settters
- (void)setTitles:(NSArray<NSString *> *)titles {
    _titles = titles;
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    BOOL isDefault = YES;
    for (NSString *str in titles) {
        CXSegmentModel *model = [[CXSegmentModel alloc] init];
        model.title = str;
        
        model.fontSize = _fontSize;
        
        if (isDefault) {
            model.isSelected = YES;
            isDefault = NO;
        }
        [tmpArray addObject:model];
    }
    
    self.dataSources = [NSMutableArray arrayWithArray:tmpArray];
    
    [self.segmentView reloadData];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    
    [self setSelectedIndex:selectedIndex animation:YES];
}

- (void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    
    self.segmentView.backgroundColor = bgColor;
}

- (void)setIndicatorColor:(UIColor *)indicatorColor {
    _indicatorColor = indicatorColor;
    self.line.backgroundColor = indicatorColor;
}

- (UICollectionView *)segmentView {
    if (_segmentView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 4;
        
        UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collection.delegate = self;
        collection.dataSource = self;
        collection.backgroundColor = self.backgroundColor;
        collection.showsVerticalScrollIndicator = NO;
        collection.showsHorizontalScrollIndicator = NO;
        [self addSubview:collection];
        
        _segmentView = collection;
    }
    
    return _segmentView;
}

- (UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = _indicatorColor;
        
        [self.segmentView addSubview:_line];
    }
    
    return _line;
}

@end




/**************************************************************/


#pragma mark CXSegmentCell
@interface CXSegmentCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CXSegmentCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.backgroundColor = self.bgColor;
    self.titleLabel.frame = self.bounds;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:self.fontSize];
        
        [self addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    
    self.titleLabel.textColor = isSelected ? _selectedColor : _normalColor;
}


@end

#pragma mark CXSegmentModel
@interface CXSegmentModel ()

@end

@implementation CXSegmentModel

- (CGFloat)width {
    if (_width <= 0) {
        CGFloat width = [self.title boundingRectWithSize:CGSizeMake(0, 40) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:self.fontSize]} context:nil].size.width;
        
        _width = width + 10;
    }
    
    return _width;
}

@end



















