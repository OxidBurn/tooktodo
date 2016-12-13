//
//  BaseNavigationBar.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/14/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "BaseNavigationBar.h"

IB_DESIGNABLE

@interface BaseNavigationBar()

// properties


// methods

- (void) setupDefaultsAppearance;

@end

@implementation BaseNavigationBar

- (instancetype) initWithCoder: (NSCoder*) aDecoder
{
    if ( self = [super initWithCoder: aDecoder] )
    {
        [self setupDefaultsAppearance];
    }
    
    return self;
}


#pragma mark - Defaults -

- (void) setupDefaultsAppearance
{
    [self setBackgroundImage: [[UIImage alloc] init]
              forBarPosition: UIBarPositionAny
                  barMetrics: UIBarMetricsDefault];
    [self setBackgroundColor: RGB(57, 189, 183)];
    
    [self setShadowImage: [[UIImage alloc] init]];
    
//    // Hide menu button on navigation bar if user use iPad
//    if ( IS_PHONE == NO )
//    {
//        self.items.firstObject.leftBarButtonItem = nil;
//    }
}

/**
 *  Rewrited getting shadow image for removing shadow from the navigation bar
 *
 *  @return nil shadow image
 */
- (UIImage*) shadowImage
{
    return [UIImage new];
}

@end
