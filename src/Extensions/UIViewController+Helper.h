//
//  UIViewController+Helper.h
//  TookTODO
//
//  Created by Nikolay Chaban on 10/27/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Helper)

- (UIBarButtonItem*) setupBarButtonItemWithImageName: (NSString*) imageName
                                        withSelector: (SEL)       selector;

@end
