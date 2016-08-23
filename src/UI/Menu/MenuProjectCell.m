//
//  MenuProjectCell.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "MenuProjectCell.h"

@interface MenuProjectCell()

// properties

@property (weak, nonatomic) IBOutlet UILabel* titleLabel;

@property (weak, nonatomic) IBOutlet UILabel* descriptionLabel;


// methods


@end

@implementation MenuProjectCell

#pragma mark - Public methods -

- (void) fillInfo: (ProjectInfo*) info
{
    self.titleLabel.text       = info.title;
    self.descriptionLabel.text = [NSString stringWithFormat: @"%@ %@ %@", (info.street) ? info.street : @"", (info.building) ? info.building : @"", (info.apartment) ? info.apartment : @""];
}

@end
