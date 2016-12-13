//
//  CustomTabBar.h
//  TookTODO
//
//  Created by Nikolay Chaban on 17.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBar.h"

@protocol CustomTabBarDelegate;

@interface CustomTabBar : MainTabBar

@property (nonatomic, weak) id<CustomTabBarDelegate> taskDelegate;

@end

@protocol CustomTabBarDelegate <NSObject>

- (void) showTaskOptions;

@end
