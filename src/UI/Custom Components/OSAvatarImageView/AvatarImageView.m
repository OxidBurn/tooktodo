//
//  AvatarImageView.m
//  GeneratingImage
//
//  Created by Nikolay Chaban on 8/14/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AvatarImageView.h"
#import "AvatarGenerator.h"

@interface AvatarImageView()

// properties


// methods

- (void) setupDefaults;

@end

@implementation AvatarImageView


#pragma mark - Initialization -

- (instancetype) initWithCoder: (NSCoder*) aDecoder
{
    if ( self = [super initWithCoder: aDecoder] )
    {
        [self setupDefaults];
    }
    
    return self;
}

#pragma mark - Defaults -

- (void) setupDefaults
{
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.clipsToBounds      = YES;
}


#pragma mark - Public -

- (void) setAvatarWithText: (NSString*) text
               withBgColor: (UIColor*)  color
{
    self.image = [[AvatarGenerator alloc] initWithText: text
                                   withBackgroundColor: color
                                              withSize: self.frame.size];
}

@end
