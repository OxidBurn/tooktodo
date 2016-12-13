//
//  DefaultCollectionCell.m
//  TookTODO
//
//  Created by Nikolay Chaban on 05.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DefaultCollectionCell.h"

@interface DefaultCollectionCell()

// outlets
@property (weak, nonatomic) IBOutlet UILabel* titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView* disclosureImageView;

@property (weak, nonatomic) IBOutlet UILabel* detailLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint* titleWidthConstraint;

@end

@implementation DefaultCollectionCell

#pragma mark - Public -

- (void) fillCellWithContent: (TaskCollectionCellsContent*) content
{
    self.titleLabel.text = content.cellTitle;
    
    self.detailLabel.text = content.cellDetail;
    
    UIFont* titleFont = [UIFont fontWithName: @"SFUIText-Light"
                                        size: 11.f];
    
    CGRect frame = [content.cellTitle boundingRectWithSize: CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                                   options: NSStringDrawingUsesLineFragmentOrigin
                                                attributes: @{ NSFontAttributeName: titleFont }
                                                   context: nil];
    
    self.titleWidthConstraint.constant = frame.size.width;
}

@end
