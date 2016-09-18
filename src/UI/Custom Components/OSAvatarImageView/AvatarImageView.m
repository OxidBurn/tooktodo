//
//  AvatarImageView.m
//  GeneratingImage
//
//  Created by Nikolay Chaban on 8/14/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AvatarImageView.h"
#import "AvatarGenerator.h"

IB_DESIGNABLE

@interface AvatarImageView()

// properties

@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;

// methods

@end

@implementation AvatarImageView


#pragma mark - Designable -

- (void) setCornerRadius: (CGFloat) cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
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
