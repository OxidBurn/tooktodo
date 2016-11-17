//
//  StatusMarkerComponent.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/26/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "StatusMarkerComponent.h"
#import "ProjectsEnumerations.h"

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
    
    self.componentImage.layer.cornerRadius = self.componentImage.width / 2;
    self.componentImage.clipsToBounds = YES;
    
    [self addSubview: self.componentImage];
    
    // Value label
    self.componentString = [[UILabel alloc] initWithFrame: CGRectMake(11, 0, 78, 13)];
    
    UIFont* customFont            = [UIFont fontWithName: @"SFUIText-Light"
                                                    size: 11.0f];
    
    self.componentString.font                                      = customFont;
    self.componentString.textColor                                 = [UIColor colorWithRed:0.349 green:0.3922 blue:0.4431 alpha:1.0];
    self.componentString.textAlignment                             = NSTextAlignmentLeft;
    self.componentString.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview: self.componentString];
    
    // Setup constraints
    NSLayoutConstraint* rightConstraint = [NSLayoutConstraint constraintWithItem: self.componentString
                                                                       attribute: NSLayoutAttributeRight
                                                                       relatedBy: NSLayoutRelationEqual
                                                                          toItem: self
                                                                       attribute: NSLayoutAttributeRight
                                                                      multiplier: 1.0f
                                                                        constant: 0.0f];
    NSLayoutConstraint* topConstraint = [NSLayoutConstraint constraintWithItem: self.componentString
                                                                     attribute: NSLayoutAttributeTop
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: self
                                                                     attribute: NSLayoutAttributeTop
                                                                    multiplier: 1.0f
                                                                      constant: 0.0f];
    NSLayoutConstraint* leftConstraint = [NSLayoutConstraint constraintWithItem: self.componentString
                                                                      attribute: NSLayoutAttributeLeft
                                                                      relatedBy: NSLayoutRelationEqual
                                                                         toItem: self
                                                                      attribute: NSLayoutAttributeLeft
                                                                     multiplier: 1.0f
                                                                       constant: 15.0f];
    
    [self addConstraint: rightConstraint];
    [self addConstraint: topConstraint];
    [self addConstraint: leftConstraint];
}

#pragma mark - Public methods -

- (void) setStatusString: (NSString*) status
                withType: (TaskType) type
{
    // Set marker values
    self.componentImage.backgroundColor = [self getColorForType: type];
    self.componentString.text  = [self getTaskTypeDescription: type];
}


#pragma mark - Internal methods -

- (UIColor*) getColorForType: (TaskType) type
{
    UIColor* typeColor = [UIColor clearColor];
    
    switch (type)
    {
        case TaskWorkType:
            typeColor = [UIColor colorWithRed: 0.310 green: 0.773 blue: 0.176 alpha: 1.000];
            break;
            
        case TaskAgreementType:
            typeColor = [UIColor colorWithRed: 0.424 green: 0.663 blue: 0.792 alpha: 1.000];
            break;
            
        case TaskObservationType:
            typeColor = [UIColor colorWithRed: 1.00 green: 0.89 blue: 0.27 alpha: 1.00];
            break;
            
        case TaskRemarkType:
            typeColor = [UIColor colorWithRed: 0.961 green: 0.651 blue: 0.137 alpha: 1.000];
            break;
    }
    
    return typeColor;
}

- (NSString*) getTaskTypeDescription: (TaskType) type
{
    NSString* typeDescription = @"";
    
    switch (type)
    {
        case TaskWorkType:
            typeDescription = @"Работа";
            break;
            
        case TaskAgreementType:
            typeDescription = @"Согласование";
            break;
            
        case TaskObservationType:
            typeDescription = @"Наблюдение";
            break;
            
        case TaskRemarkType:
            typeDescription = @"Замечание";
            break;
    }
    
    return typeDescription;
}

@end
