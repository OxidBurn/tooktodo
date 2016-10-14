//
//  CellWithBackground.m
//  TookTODO
//
//  Created by Nikolay Chaban on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "CellWithBackground.h"

@interface CellWithBackground()

// properties
@property (weak, nonatomic) IBOutlet UILabel *statusNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;

@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;


// methods


@end

@implementation CellWithBackground


- (void) fillCellWithStatusName: (NSString*) name
                          image: (UIImage*)  image
                     background: (UIColor*)  background
                     arrowState: (BOOL)      isHiddenArrow
{
    self.statusNameLabel.text   = name;
    if (image)
         self.statusImageView.image  = image;
    self.backgroundColor        = background;
    self.arrowImage.hidden      = isHiddenArrow;
}

@end
