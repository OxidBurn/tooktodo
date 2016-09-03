//
//  AvatarGenerator.m
//  GeneratingImage
//
//  Created by Nikolay Chaban on 8/14/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AvatarGenerator.h"
#import "UIImage+AvatarGenerator.h"

@implementation AvatarGenerator


- (instancetype) initWithText: (NSString*) text
          withBackgroundColor: (UIColor*)  color
                     withSize: (CGSize)    avatarSize
{
    if ( self = [super init] )
    {
        self = (AvatarGenerator*)[[self imageWithColor: color
                                         withImageSize: avatarSize] drawTextOnImage: text];
    }
    
    return self;
}



@end
