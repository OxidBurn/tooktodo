//
//  AvatarGenerator.h
//  GeneratingImage
//
//  Created by Nikolay Chaban on 8/14/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvatarGenerator : UIImage

// methods

- (instancetype) initWithText: (NSString*) text
          withBackgroundColor: (UIColor*)  color
                     withSize: (CGSize)    avatarSize;

@end
