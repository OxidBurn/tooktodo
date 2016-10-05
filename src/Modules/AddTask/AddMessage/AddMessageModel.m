//
//  AddMessageModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 28.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddMessageModel.h"

@interface AddMessageModel()

// properties
@property (strong, nonatomic) NSString* textViewContent;

@property (strong, nonatomic) UIColor* placeholderColor;

// methods

@end

@implementation AddMessageModel

#pragma mark - Properties -

- (UIColor*) placeholderColor
{
    if ( _placeholderColor == nil )
    {
        CGFloat red   = 38.0/256;
        CGFloat green = 45.0/256;
        CGFloat blue  = 55.0/256;
        
        _placeholderColor = [UIColor colorWithRed: red green: green blue: blue alpha: 0.5f];
    }
    
    return _placeholderColor;
}

#pragma mark - Public -

- (void) fillText: (NSString*) textContent
{
    self.textViewContent = textContent;
}

- (UIColor*) getPlacelderColor
{
    return self.placeholderColor;
}

- (NSString*) getDescriptionText
{
    return self.textViewContent;
}

@end
