//
//  ZHTabBarButton.h
//  自定义Button
//
//  Created by Mokyz on 16/4/1.
//  Copyright © 2016年 Mokyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHTabBarButton : UIButton

@property (nonatomic, assign) BOOL isShowTitle;

@property (nonatomic, strong) UITabBarItem *item;

@end
