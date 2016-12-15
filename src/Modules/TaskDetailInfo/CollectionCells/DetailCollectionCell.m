//
//  DetailCollectionCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DetailCollectionCell.h"

@interface DetailCollectionCell()

// outlets
@property (weak, nonatomic) IBOutlet UILabel* premisesLabel;

@property (weak, nonatomic) IBOutlet UIImageView* disclosureImageView;

@property (weak, nonatomic) IBOutlet UILabel* roomNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel* roomNameLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint* roomLabelWidthConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint* roomNumberToNameHorizontal;

// properties

// methods


@end


@implementation DetailCollectionCell

#pragma mark - Public -

- (void) fillCellWithContent: (TaskCollectionCellsContent*) content
{
    if ( content.roomNumber != 0 )
    {
        self.roomNumberLabel.text = [NSString stringWithFormat: @"%ld", (unsigned long)content.roomNumber];
        
        self.roomNameLabel.text = content.cellDetail;
    }
    else
    {
        self.roomNameLabel.text = @"Не указано";
        
        self.roomLabelWidthConstraint.constant   = 0.f;
        
        self.roomNumberToNameHorizontal.constant = 0.f;
    }
}


@end
