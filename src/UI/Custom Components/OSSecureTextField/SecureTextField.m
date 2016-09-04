//
//  SecureTextField.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SecureTextField.h"

@implementation SecureTextField

- (void) drawTextInRect: (CGRect) rect
{
    if ( self.isSecureTextEntry )
    {
        NSMutableParagraphStyle* paragraphStyle = [NSMutableParagraphStyle new];
        
        paragraphStyle.alignment = self.textAlignment;
        
        NSMutableDictionary* attributes = [NSMutableDictionary dictionary];
        
        [attributes setValue: self.font
                      forKey: NSFontAttributeName];
        [attributes setValue: self.textColor
                      forKey: NSForegroundColorAttributeName];
        [attributes setValue: paragraphStyle
                      forKey: NSParagraphStyleAttributeName];
        
        CGSize textSize = [self.text sizeWithAttributes: attributes];
        
        rect          = CGRectInset(rect, 0, (CGRectGetHeight(rect) - textSize.height) * 0.5);
        rect.origin.y = floorf(rect.origin.y);
        
        NSMutableString* redactedText = [NSMutableString new];
        
        while (redactedText.length < self.text.length)
        {
            [redactedText appendString: @"\u2022"];
        }
        
        [redactedText drawInRect: rect
                  withAttributes: attributes];
    }
    else
    {
        [super drawTextInRect: rect];
    }
}



@end
