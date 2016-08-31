//
//  StatusMarkerComponent.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/26/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "StatusMarkerComponent.h"

@interface StatusMarkerComponent()

// properties

@property (strong, nonatomic) UIImageView* componentImage;

@property (strong, nonatomic) UILabel* componentString;

// methods

- (void) setupUI;

@end

@implementation StatusMarkerComponent

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
    self.componentImage = [[UIImageView alloc] initWithFrame: CGRectMake(0, 1, 10, 10)];
    
    self.componentImage.contentMode = UIViewContentModeScaleAspectFit;
    
    [self addSubview: self.componentImage];
    
    // Value label
    self.componentString = [[UILabel alloc] initWithFrame: CGRectMake(11, 0, 78, 13)];
    
    UIFont* customFont            = [UIFont fontWithName: @"SFUIText-Light"
                                                    size: 11.0f];
    
    self.componentString.font          = customFont;
    self.componentString.textColor     = [UIColor colorWithRed:0.349 green:0.3922 blue:0.4431 alpha:1.0];
    self.componentString.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview: self.componentString];
}

#pragma mark - Public methods -

- (void) setStatusString: (NSString*) status
                withType: (StatusMarkerComponentType) type
{
    // Set marker values
    self.componentImage.image = [self getImageForType: type];
    self.componentString.text  = [NSString stringWithFormat: @"%@", status];
}

- (UIImage*) getImageForType: (StatusMarkerComponentType) type
{
    UIImage* markerImage = nil;
    
    switch (type)
    {
        case StatusMarkerBlueType:
        {
            markerImage = [UIImage imageNamed:@"Orange"];
            break;
        }
        case StatusMarkerOrangeType:
        {
            markerImage =  [UIImage imageNamed:@"Blue"];
            break;
        }
    }
    
    return markerImage;
}

@end