//
//  MarkedRightDetailCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 9/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSMarkedRightDetailCell.h"

@interface OSMarkedRightDetailCell()

// properties
@property (weak, nonatomic) IBOutlet UILabel*            detailLabel;
@property (weak, nonatomic) IBOutlet UIImageView*        markImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* markImageHorizontalToDetailConstraint;
@property (weak, nonatomic) IBOutlet UILabel*            titleLabel;

// methods


@end

@implementation OSMarkedRightDetailCell

#pragma mark - Public -

- (void) fillCellWithTitle: (NSString*) titleText
             withMarkImage: (UIImage*)  markImage
                withDetail: (NSString*) detailText
{
    self.titleLabel.text     = titleText;
    self.markImageView.image = markImage;
    self.detailLabel.text    = detailText;
}

@end
