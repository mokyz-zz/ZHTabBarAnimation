//
//  ZHTabBarController.m
//  ZHTabBarDemo
//
//  Created by Mokyz on 16/4/1.
//  Copyright © 2016年 Mokyz. All rights reserved.
//

#import "ZHTabBarController.h"
#import "ZHTabBar.h"

@interface ZHTabBarController () <ZHTabBarDelegate>

/** 所有子控制器的tabBarItem*/
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation ZHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.items = [NSMutableArray array];
    
    // 添加子控制器
    [self setUpAllChildViewController];
    
    // 设置tabBar
    [self setUpTabBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 删除系统自带的tabBarButton
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if (![tabBarButton isKindOfClass:[ZHTabBar class]]) {
            [tabBarButton removeFromSuperview];
        }
    }
}

- (void)setUpAllChildViewController
{
    UIViewController *news = [[UIViewController alloc] init];
    news.view.backgroundColor = [UIColor redColor];
    [self setOneChildViewController:news withImage:[UIImage imageNamed:@"tab_icon_news_normal"] selectedImage:[UIImage imageNamed:@"tab_icon_news_press"] title:@"新闻"];
    
    UIViewController *friends = [[UIViewController alloc] init];
    friends.view.backgroundColor = [UIColor whiteColor];
    [self setOneChildViewController:friends withImage:[UIImage imageNamed:@"tab_icon_friend_normal"] selectedImage:[UIImage imageNamed:@"tab_icon_friend_press"] title:@"好友"];
    
    UIViewController *quiz = [[UIViewController alloc] init];
    quiz.view.backgroundColor = [UIColor purpleColor];
    [self setOneChildViewController:quiz withImage:[UIImage imageNamed:@"tab_icon_quiz_normal"] selectedImage:[UIImage imageNamed:@"tab_icon_quiz_press"] title:@"发现"];
    
    UIViewController *more = [[UIViewController alloc] init];
    more.view.backgroundColor = [UIColor grayColor];
    [self setOneChildViewController:more withImage:[UIImage imageNamed:@"tab_icon_more_normal"] selectedImage:[UIImage imageNamed:@"tab_icon_more_press"] title:@"我"];
}

- (void)setOneChildViewController:(UIViewController *)viewController withImage:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    viewController.title = title;
    
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = image;
    viewController.tabBarItem.selectedImage = selectedImage;
    
    [self.items addObject:viewController.tabBarItem];
    
    UINavigationController *nvg = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    [self addChildViewController:nvg];
    
}

- (void)setUpTabBar
{
    ZHTabBar *tabBar = [[ZHTabBar alloc] initWithFrame:self.tabBar.bounds style:ZHTabBarAnimationStyleTranslation];
    
    tabBar.delegate = self;
    
    tabBar.items = self.items;
    
    [self.tabBar addSubview:tabBar];
}
@end
