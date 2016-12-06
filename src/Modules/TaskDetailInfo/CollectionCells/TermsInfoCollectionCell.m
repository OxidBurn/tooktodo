//
//  TermsInfoCollectionCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TermsInfoCollectionCell.h"

@interface TermsInfoCollectionCell()

// outlets
@property (weak, nonatomic) IBOutlet UILabel* termsTypeLabel;

@property (weak, nonatomic) IBOutlet UILabel* termsLabel;

// properties


// methods


@end

@implementation TermsInfoCollectionCell

#pragma mark - Public -

- (void) fillCellWithContent: (TaskCollectionCellsContent*) content
{
    self.termsTypeLabel.text = content.cellTitle;
    
    self.termsLabel.text     = content.cellDetail;
}
@end
