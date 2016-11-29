//
//  FilterBarButton.m
//  TookTODO
//
//  Created by Nikolay Chaban on 11/29/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterBarButton.h"

IB_DESIGNABLE

@interface FilterBarButton()

// properties

@property (nonatomic, strong) IBInspectable UILabel* countLabel;

// methods


@end

@implementation FilterBarButton


#pragma mark - Initialization -

- (void) awakeFromNib
{
    [super awakeFromNib];
    
    [self setupCountLabel];
}


#pragma mark - Public methods -

- (void) updateFilterParametersCount: (NSUInteger) count
{
    self.countLabel.hidden = (count == 0);
    self.countLabel.text   = [NSString stringWithFormat: @"%ld", count];
}


#pragma mark - Internal methods -

- (void) setupCountLabel
{
    self.countLabel = [[UILabel alloc] initWithFrame: CGRectMake(21, 4, 16, 16)];
    
    self.countLabel.backgroundColor    = [UIColor whiteColor];
    self.countLabel.textColor          = [UIColor colorWithRed:0.22 green:0.74 blue:0.72 alpha:1.00];
    self.countLabel.layer.cornerRadius = 8.0f;
    self.countLabel.hidden             = YES;
    self.countLabel.textAlignment      = NSTextAlignmentCenter;
    self.countLabel.clipsToBounds      = YES;
    self.countLabel.font               = [UIFont fontWithName: @"SFUIText-Regular"
                                                         size: 11.0f];
    
    [self addSubview: self.countLabel];
}

@end
