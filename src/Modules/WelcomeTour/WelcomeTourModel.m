//
//  WelcomeTourModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 10.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "WelcomeTourModel.h"

@interface WelcomeTourModel()

// properties
@property (strong, nonatomic) NSArray* pagesContent;

// methods

/**
 *  Methods which check if it was first install of the app
 */
- (void) checkIfItWasFirstInstall;

@end

@implementation WelcomeTourModel

- (instancetype) init
{
    if ( self = [super init] )
    {
        [self checkIfItWasFirstInstall];
    }
    
    return self;
}

#pragma mark - Properties -

- (NSArray*) pagesContent
{
    if ( _pagesContent == nil )
    {
        _pagesContent = @[@"WelcomeScreen1",
                          @"WelcomeScreen2",
                          @"WelcomeScreen3",
                          @"WelcomeScreen4",
                          @"WelcomeScreen5",
                          @"WelcomeScreen6"];
    }
    
    return _pagesContent;
}

#pragma mark - Public -

- (NSArray*) returnPagesContent;
{
    return self.pagesContent;
}

- (ConfigurationBlock) configurateContent
{
    return ^UIView* (PowerfulBannerView* banner, id item, UIView* reusableView) {
        
        UIImageView* view = (UIImageView*)reusableView;
        
        if ( view == nil )
        {
            view = [[UIImageView alloc] initWithFrame: CGRectZero];
            
            view.contentMode     = UIViewContentModeScaleAspectFit;
            view.clipsToBounds   = YES;
            view.backgroundColor = [UIColor colorWithRed: 0.22f green: 0.7f blue: 0.72 alpha: 1];
        }
        
        view.image = [UIImage imageNamed: item];
        
        return view;
    };
}


#pragma mark - Internal methods -

- (void) checkIfItWasFirstInstall
{
    if ( [UserDefaults boolForKey: @"isViewedWelcomeTour"] == NO )
    {
        [UserDefaults setBool: YES
                       forKey: @"isViewedWelcomeTour"];
    }
}

@end
