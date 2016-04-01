//
//  ZHTabBar.m
//
//
//  Created by Mokyz on 16/4/1.
//  Copyright © 2016年 Mokyz. All rights reserved.
//

#import "ZHTabBar.h"
#import "ZHTabBarButton.h"

@interface ZHTabBar ()

/** tabBar点击动画风格*/
@property (nonatomic, assign) ZHTabBarAnimation style;

/** buttonItems，有多少控制器就有多少*/
@property (nonatomic, strong) NSMutableArray *buttons;

/** 当前选中的buttonItem*/
@property (nonatomic, weak) UIButton *selectedButton;

@end

@implementation ZHTabBar

- (instancetype)initWithFrame:(CGRect)frame style:(ZHTabBarAnimation)style
{
    self = [super initWithFrame:frame];
    if (self) {
        _style = style;
    }
    return self;
}

#pragma mark - setter&getter
- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

// 设置tabBar对应的Item模型
- (void)setItems:(NSArray *)items
{
    _items = items;
    
    // 根据items的数量创建button
    for (UITabBarItem *item in items) {
        ZHTabBarButton *button = [ZHTabBarButton buttonWithType:UIButtonTypeCustom];

        if (_style == ZHTabBarAnimationStyleScale) {
            button.isShowTitle = YES;
        }
        
        [button setTitleColor:[UIColor purpleColor] forState:UIControlStateSelected];
        
        button.item = item;
        
        button.tag = self.buttons.count;
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (button.tag == 0) {
            [self buttonClick:button];
        }
        
        [self addSubview:button];
        
        [self.buttons addObject:button];
    }
    
    [self layoutSubviewsAnimated:NO];
}

- (void)buttonClick:(UIButton *)button
{
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectedItemFrom:to:)]) {
        [_delegate tabBar:self didSelectedItemFrom:self.selectedButton.tag to:button.tag];
    }
    
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    
    [self layoutSubviewsAnimated:YES];
}

// 执行布局动画
- (void)layoutSubviewsAnimated:(BOOL)animated
{
    // 计算每个tabBarButton的frame
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGFloat btnX = 0;
    CGFloat btnW = w / self.buttons.count;
    
    CGFloat minW = w / (self.buttons.count + 0.5);
    
    ZHTabBarButton *lastView = nil;
    for (ZHTabBarButton *subView in self.buttons) {
        
        if (_style == ZHTabBarAnimationStyleTranslation) {
            btnW = subView.isSelected ? minW * 1.5 : minW;
        }
        
        btnX = CGRectGetMaxX(lastView.frame);
        
        if (animated) {
            [UIView animateWithDuration:0.3 animations:^{
                subView.frame = CGRectMake(btnX, 0, btnW, h);
            }];
        } else {
            subView.frame = CGRectMake(btnX, 0, btnW, h);
        }
        
        lastView = subView;
    }
    
    
}

@end
