//
//  MainTabBar.h
//  TookTODO
//
//  Created by Nikolay Chaban on 10/25/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Classes
#import "ProjectsControllersDelegate.h"

@interface MainTabBar : UIView

@property (weak, nonatomic) id<ProjectsControllersDelegate> delegate;

- (void) didSelectFirstMenuItem;

- (void) setSelectedItemAtIndex: (NSUInteger) index;

@end
