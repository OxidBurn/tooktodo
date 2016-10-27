//
//  BaseMainViewController+NavigationTitle.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/25/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "BaseMainViewController+NavigationTitle.h"

#import "UIViewController+Helper.h"

@implementation BaseMainViewController (NavigationTitle)

- (void) setupNavigationTitleWithTwoLinesWithMainTitleText: (NSString*) title
                                              withSubTitle: (NSString*) subTitle
{
    UIFont* customFont            = [UIFont fontWithName: @"SFUIText-Regular"
                                                    size: 14.0f];
    UIFont* customFontForSubTitle = [UIFont fontWithName: @"SFUIText-Regular"
                                                    size: 13.0f];
    
    UILabel* titleLabel        = [[UILabel alloc] initWithFrame: CGRectMake(0, 2, 0, 14)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor       = [UIColor whiteColor];
    titleLabel.font            = customFont;
    titleLabel.textAlignment   = NSTextAlignmentCenter;
    titleLabel.text            = title;
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    UILabel* subTitleLabel        = [[UILabel alloc] initWithFrame: CGRectMake(0, 20, 0, 13)];
    subTitleLabel.backgroundColor = [UIColor clearColor];
    subTitleLabel.textColor       = [UIColor whiteColor];
    subTitleLabel.font            = customFontForSubTitle;
    subTitleLabel.textAlignment   = NSTextAlignmentCenter;
    subTitleLabel.text            = subTitle;
    subTitleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    UIView* twoLineTitleView = [[UIView alloc] initWithFrame: self.navigationController.navigationBar.bounds];
    
    twoLineTitleView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [twoLineTitleView addSubview: titleLabel];
    [twoLineTitleView addSubview: subTitleLabel];
    
    titleLabel.width    = twoLineTitleView.width;
    subTitleLabel.width = twoLineTitleView.width;
    
    self.navigationItem.titleView = twoLineTitleView;
}

- (UIBarButtonItem*) determineMenuBtnToBackBtnWithSelectorForiPhone: (SEL) iPhoneSelector
                                                    andSelectoriPad: (SEL) iPadSelector
{
    SEL selector = nil;
    
    NSString* buttonImageName = @"";
    
    if ( IS_PHONE )
    {
        buttonImageName = @"Menu1";
        selector        = iPhoneSelector;
    }
    else
    {
        buttonImageName = @"Back";
        selector        = iPadSelector;
    }
    
    UIBarButtonItem* button = [self setupBarButtonItemWithImageName: buttonImageName
                                                       withSelector: selector];
    
    return button;
}

@end
