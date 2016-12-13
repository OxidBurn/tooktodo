//
//  UIViewController+Utils.m
//  TookTODO
//
//  Created by Nikolay Chaban on 10/7/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "UIViewController+Utils.h"

@implementation UIViewController (Utils)

+ (UIViewController*) topMostController
{
    UIViewController* topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController)
    {
        topController = topController.presentedViewController;
    }
    
    return topController;
}

@end
