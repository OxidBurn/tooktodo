//
//  UIImage+AvatarGenerator.h
//  GeneratingImage
//
//  Created by Nikolay Chaban on 8/14/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Avatar)

/**
 *  Generate image with color
 *
 *  @param color background image color
 *  @param size size of the new generated image
 *
 *  @return generated image component with parameter color
 */
- (UIImage*) imageWithColor: (UIColor*) color
              withImageSize: (CGSize)   size;

/**
 *  Adding text to the image
 *
 *  @param text string text value
 *
 *  @return generated new image with added text
 */
- (UIImage*) drawTextOnImage: (NSString*) text;

@end
