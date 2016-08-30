//
//  TaskMarkComponent.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/25/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskMarkerComponent.h"
//#import "UIView+Utils.h"

@interface TaskMarkerComponent()

// properties

@property (strong, nonatomic) UIImageView* componentImage;
@property (strong, nonatomic) UILabel* componentValue;

// methods

- (void) setupUI;

@end

@implementation TaskMarkerComponent

#pragma mark - Initialization -

- (instancetype) initWithFrame: (CGRect) frame
{
    if ( self = [super initWithFrame: frame] )
    {
        [self setupUI];
    }
    
    return self;
}

- (instancetype) initWithCoder: (NSCoder*) aDecoder
{
    if ( self = [super initWithCoder: aDecoder] )
    {
        [self setupUI];
    }
    
    return self;
}

#pragma mark - Setup UI -

- (void) setupUI
{
    // Marker image
    self.componentImage = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 19, 17)];
    
    self.componentImage.contentMode = UIViewContentModeScaleAspectFit;
    
    [self addSubview: self.componentImage];
    
    // Value label
    self.componentValue = [[UILabel alloc] initWithFrame: CGRectMake(22, 0, 16, 17)];
    
    UIFont* customFont            = [UIFont fontWithName: @"SFUIText-Regular"
                                                    size: 14.0f];
    
    self.componentValue.font          = customFont;
    self.componentValue.textColor     = [UIColor colorWithRed:0.349 green:0.3922 blue:0.4431 alpha:1.0];
    self.componentValue.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview: self.componentValue];
}

#pragma mark - Public methods -

- (void) setValue: (NSUInteger)              value
         withType: (TaskMarkerComponentType) type
{
    // Setup opacity level
    [self setOpacityLevel: value];
    
    // Set marker values
    self.componentImage.image = [self getImageForType: type];
    self.componentValue.text  = [NSString stringWithFormat: @"%ld", value];
}

#pragma mark - Internal methods -

- (void) setOpacityLevel: (NSUInteger) value
{
    self.componentImage.alpha = (value == 0) ? 0.5f : 1.0f;
    self.componentValue.alpha = (value == 0) ? 0.5f : 1.0f;
}

- (UIImage*) getImageForType: (TaskMarkerComponentType) type
{
    UIImage* markerImage = nil;
    
    switch (type)
    {
        case TaskMarkerSubtaskType:
        {
//            self.componentImage.frame.size.width = 19;
            markerImage = [UIImage imageNamed: @"TaskMarker"];
            break;
        }
        case TaskMarkerAttachmentsType:
        {
            markerImage =  [UIImage imageNamed: @"AttachmentsMarker"];
            break;
        }
        case TaskMarkerCommentsType:
        {
            markerImage =  [UIImage imageNamed: @"CommentsMarker"];
            break;
        }
    }
    
    return markerImage;
}

@end
