//
//  UIImage+AvatarGenerator.m
//  GeneratingImage
//
//  Created by Nikolay Chaban on 8/14/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "UIImage+AvatarGenerator.h"

@implementation UIImage (AvatarGenerator)

- (UIImage*) imageWithColor: (UIColor*) color
              withImageSize: (CGSize)   size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage*) drawTextOnImage: (NSString*) text
{
    UIColor* textColor = [UIColor whiteColor];
    UIFont* font       = [UIFont fontWithName: @"SFUIText-Regular"
                                         size: self.size.height / 2.5];
    
    // Compute rect to draw the text inside
    CGSize imageSize = self.size;
    
    NSDictionary* attr = @{NSForegroundColorAttributeName: textColor,
                           NSFontAttributeName:            font};
    
    CGSize textSize = [text sizeWithAttributes: attr];
    CGRect textRect = CGRectMake((imageSize.width - textSize.width) / 2, (imageSize.height - textSize.height) / 2, textSize.width, textSize.height);
    
    // Create the image
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    
    [self drawInRect: CGRectMake(0, 0, imageSize.width, imageSize.height)];
    
    [text drawInRect: CGRectIntegral(textRect)
      withAttributes: attr];
    
    UIImage* resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
}

@end
