//
//  ZHTabBarButton.m
//
//
//  Created by Mokyz on 16/4/1.
//  Copyright © 2016年 Mokyz. All rights reserved.
//

#import "ZHTabBarButton.h"

@interface ZHTabBarButton ()

@end

@implementation ZHTabBarButton

- (void)setHighlighted:(BOOL)highlighted {}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        // 图片，文字居中
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        // 字体
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    
    return self;
}

// 传递UITabBarItem给UITabBarButton进行内容赋值，使用KVO
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    // 清空监听的内容
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
    // 使用KVC模式监听UITabBarItem的值的变化
    // 观察者：self(UITabBarButton)，只要UITabBarItem的值发生变化，就通知UITabBarButton修改相应控件的值
    /**
     *  给item添加观察者self
     *
     *  @param observer NSObject 观察者
     *  @param keyPath NSString 要监听的属性的名称
     *  @param options NSKeyValueObservingOptions 监听值变化的方式
     *  @param context 上下文
     */
    [item addObserver:self forKeyPath:@"title"
              options:NSKeyValueObservingOptionNew
              context:nil];
    [item addObserver:self forKeyPath:@"image"
              options:NSKeyValueObservingOptionNew
              context:nil];
    [item addObserver:self forKeyPath:@"selectedImage"
              options:NSKeyValueObservingOptionNew
              context:nil];
}

// 只要监听到有属性有新值，就会调用该方法
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context
{
    [self setTitle:_item.title forState:UIControlStateNormal];
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
}

// 重写来自定义布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat imageRatio = 0.7;
    
    CGFloat imgX = 0;
    CGFloat imgY = 0;
    CGFloat imgW = CGRectGetWidth(self.frame);
    CGFloat imgH = (self.isSelected || _isShowTitle) ? CGRectGetHeight(self.frame) * imageRatio : CGRectGetHeight(self.frame);
    self.imageView.frame = CGRectMake(imgX, imgY, imgW, imgH);
    
    CGFloat ttlY = CGRectGetHeight(self.frame) * imageRatio;
    CGFloat ttlW = CGRectGetWidth(self.frame);
    CGFloat ttlH = CGRectGetHeight(self.frame) * 0.2;

    if (_isShowTitle) {
        self.titleLabel.frame = CGRectMake(0, 0, ttlW, ttlH);
    }
    
    self.titleLabel.center = CGPointMake(ttlW/2.f, ttlY + ttlH/2.f);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.titleLabel.alpha = _isShowTitle || self.isSelected;
    }];
    
}

- (void)setSelected:(BOOL)selected
{
    if (_isShowTitle) {
        [self selectedScaleAnimation:selected];
    } else {
        [self selectedTranslationAnimation:selected];
    }
    
    [super setSelected:selected];
}

- (void)selectedScaleAnimation:(BOOL)selected
{
    [UIView animateWithDuration:0.3 animations:^{
        if (selected) {
            self.imageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
            self.titleLabel.transform = CGAffineTransformMakeScale(1.1, 1.1);
            self.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        } else {
            self.imageView.transform = CGAffineTransformIdentity;
            self.titleLabel.transform = CGAffineTransformIdentity;
            self.titleLabel.font = [UIFont systemFontOfSize:12];
        }
    }];
}

- (void)selectedTranslationAnimation:(BOOL)selected
{
    // TODO:
}
@end
