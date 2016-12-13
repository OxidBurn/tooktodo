//
//  AvatarImageView.h
//  GeneratingImage
//
//  Created by Nikolay Chaban on 8/14/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvatarImageView : UIImageView

// properties


// methods

/**
 *  Set avatar with text and background color
 *
 *  @param text  string avatar text
 *  @param color background avatar color
 */
- (void) setAvatarWithText: (NSString*) text
               withBgColor: (UIColor*)  color;


@end
