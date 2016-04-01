//
//  ZHTabBar.h
//  自定义Tabbar
//
//  Created by Mokyz on 16/4/1.
//  Copyright © 2016年 Mokyz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZHTabBarAnimation)
{
    ZHTabBarAnimationStyleScale,
    ZHTabBarAnimationStyleTranslation
};

@class ZHTabBar;

@protocol ZHTabBarDelegate <NSObject>

@optional
- (void)tabBar:(ZHTabBar *)tabBar didSelectedItemFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface ZHTabBar : UIView

/** 子控制器的tabBarItem数组*/
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, weak) id<ZHTabBarDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame style:(ZHTabBarAnimation)style;

@end
