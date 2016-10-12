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

// properties

// methods


@end


@implementation DetailCollectionCell

#pragma mark - Public -

- (void) fillCellWithContent: (TaskCollectionCellsContent*) content
{
    self.roomNameLabel.text = [NSString stringWithFormat: @"%ld", content.roomNumber];
}


@end
