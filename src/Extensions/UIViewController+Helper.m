//
//  UIViewController+Helper.m
//  TookTODO
//
//  Created by Nikolay Chaban on 10/27/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "UIViewController+Helper.h"

@implementation UIViewController (Helper)

- (UIBarButtonItem*) setupBarButtonItemWithImageName: (NSString*) imageName
                                        withSelector: (SEL)       selector
{
    // Setup custom content view for bar button item
    // custom content uibutton element
    UIImage* buttonImage = [UIImage imageNamed: imageName];
    
    // Calculate size of the button image and if it less than 44, set width to 44 point
    CGSize buttonSize   = buttonImage.size;
    CGFloat buttonWidth = (buttonSize.width < 44) ? 44 : buttonSize.width;
    
    UIButton* contentBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    
    contentBtn.frame = CGRectMake(0, 0, buttonWidth, 44);
    
    [contentBtn addTarget: self
                   action: selector
         forControlEvents: UIControlEventTouchUpInside];
    [contentBtn setImage: [UIImage imageNamed: imageName]
                forState: UIControlStateNormal];
    
    // bar button item with custom view
    UIBarButtonItem* barBtn = [[UIBarButtonItem alloc] initWithCustomView: contentBtn];
    
    return barBtn;
}

@end
