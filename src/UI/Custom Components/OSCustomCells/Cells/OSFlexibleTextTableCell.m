//
//  FlexibleTextTableCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 9/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSFlexibleTextTableCell.h"

@interface OSFlexibleTextTableCell()

//Properties
@property (weak, nonatomic) IBOutlet UILabel* flexibleTextLabel;

//Metods

@end

@implementation OSFlexibleTextTableCell

#pragma mark - Public -

- (void) fillCellWithText: (NSString*) textContent
{
    self.flexibleTextLabel.text = textContent;
}

@end
