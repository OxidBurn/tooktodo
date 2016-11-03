//
//  FilterByTermsCell.m
//  TookTODO
//
//  Created by Nikolay Chaban on 01.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByTermsCell.h"

@interface FilterByTermsCell()

// outlets
@property (weak, nonatomic) IBOutlet UILabel* titleLabel;

@property (weak, nonatomic) IBOutlet UILabel* endDateLabel;

@property (weak, nonatomic) IBOutlet UILabel* startDateLabel;

// properties

// methods
- (IBAction) onShowEndDateOptions: (UIButton*) sender;

- (IBAction) onShowStartDateOptions: (UIButton*) sender;


@end

@implementation FilterByTermsCell


#pragma mark - Actions -

- (IBAction) onShowEndDateOptions: (UIButton*) sender
{
    
}

- (IBAction) onShowStartDateOptions: (UIButton*) sender
{
    
}


#pragma mark - Public -

- (void) fillCellWithTitle: (NSString*) titleText
                withDetail: (NSString*) detailText
{
    self.titleLabel.text     = titleText;
    self.endDateLabel.text   = detailText;
    self.startDateLabel.text = detailText;
}

@end
