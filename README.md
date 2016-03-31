# ZHTabBar
自定义tabBar和tabBarButton，两种点击动画，动画原型参考Google Design guidelines - Components - Bottom navigation，比较简单的方法实现，仅供参考。

# 效果
ZHTabBarAnimationStyleScale

ZHTabBarAnimationStyleTranslation

# 使用
创建，替换默认tabBar，style共有两种，`ZHTabBarAnimationStyleScale` 和 `ZHTabBarAnimationStyleTranslation`
``` objective-c
    ZHTabBar *tabBar = [[ZHTabBar alloc] initWithFrame:self.tabBar.bounds style:ZHTabBarAnimationStyleScale];
    tabBar.backgroundColor = [UIColor whiteColor];
    tabBar.delegate = self;
    // 所有子控制的tabBarItem
    tabBar.items = self.items; 
    [self.tabBar addSubview:tabBar];
```
代理方法，点击button时调用
``` objective-c
    #pragma ZHTabBarDelegate
    -(void)tabBar:(ZHTabBar *)tabBar didSelectedItemFrom:(NSInteger)from to:(NSInteger)to
    {
       self.selectedIndex = to;
    }
```
