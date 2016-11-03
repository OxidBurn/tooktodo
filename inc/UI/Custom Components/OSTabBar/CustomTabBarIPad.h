//
//  CustomTabBarIPad.h
//  TookTODO
//
//  Created by Глеб on 21.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "MainTabBar.h"

@protocol CustomTabBarIPadDelegate;

@interface CustomTabBarIPad : MainTabBar

@property (nonatomic, weak) id<CustomTabBarIPadDelegate> taskDelegateIPad;

@end

@protocol CustomTabBarIPadDelegate <NSObject>

- (void) showTaskOptionsIPad;

@end
