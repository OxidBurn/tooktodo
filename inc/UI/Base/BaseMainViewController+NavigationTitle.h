//
//  BaseMainViewController+NavigationTitle.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/25/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "BaseMainViewController.h"

@interface BaseMainViewController (NavigationTitle)

- (void) setupNavigationTitleWithTwoLinesWithMainTitleText: (NSString*) title
                                              withSubTitle: (NSString*) subTitle;

- (UIBarButtonItem*) determineMenuBtnToBackBtnWithSelectorForiPhone: (SEL) iPhoneSelector
                                                    andSelectoriPad: (SEL) iPadSelector;

@end
