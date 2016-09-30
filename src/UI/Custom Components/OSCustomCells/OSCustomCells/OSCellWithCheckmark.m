//
//  OSCellWithCheckmark.m
//  TookTODO
//
//  Created by Lera on 30.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSCellWithCheckmark.h"

@interface OSCellWithCheckmark ()

@property (weak, nonatomic) IBOutlet UIImageView *checkmarkImg;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation OSCellWithCheckmark

- (void) fillCellWithTitle: (NSString*) title
{
    self.nameLabel.text = title;
//    self.checkmarkImg.hidden = stage ? NO : YES;
}

@end
