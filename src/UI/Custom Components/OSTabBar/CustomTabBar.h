//
//  CustomTabBar.h
//  TookTODO
//
//  Created by Nikolay Chaban on 17.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectsControllersDelegate.h"

@interface CustomTabBar : UIView

@property (weak, nonatomic) id<ProjectsControllersDelegate> delegate;

- (void) didSelectFirstMenuItem;

@end
