//
//  FilterTagParameterInfo.m
//  TookTODO
//
//  Created by Nikolay Chaban on 11/28/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterTagParameterInfo.h"

// Classes
#import "Utils.h"

static CGFloat kTagViewHeight = 20.0f;
static CGFloat kPaddingValue  = 20.0f;
static CGFloat kMaxWidthValue = 200.0f;

@implementation FilterTagParameterInfo


#pragma mark - Initialization -

- (instancetype) initWithTitle: (NSString*)              title
             withParameterType: (FilterTagParameterType) type
              withParameterTag: (NSUInteger)             tag
                     withValue: (NSNumber*)              value
{
    if ( self = [super init] )
    {
        self.title          = title;
        self.parameterTag   = tag;
        self.parameterType  = type;
        self.parameterValue = value;
        
        [self calculateTagSize];
    }
    
    return self;
}


#pragma mark - Properties -

- (UIFont*) titleFont
{
    return [UIFont fontWithName: @"SFUIText-Regular"
                           size: 12.0f];
}


#pragma mark - Public methods -

- (void) updatedTagIndex: (NSUInteger) tag
{
    self.parameterTag = tag;
}


#pragma mark - Internal methods -

- (void) calculateTagSize
{
    CGSize textSize = [Utils getTextSizeForText: self.title
                                   havingHeight: kTagViewHeight
                                   withMaxWidth: kMaxWidthValue
                                       withFont: [self titleFont]];
    
    self.tagParamterFrame = CGRectMake(0, 0, textSize.width + kTagViewHeight + kPaddingValue, kTagViewHeight);
}


#pragma mark - Description -

- (NSString*) description
{
    return [NSString stringWithFormat: @"Title: %@, type: %lu, value: %@", self.title, self.parameterTag, self.parameterValue];
}

@end
