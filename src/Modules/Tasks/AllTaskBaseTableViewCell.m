//
//  AllTaskBaseTableViewCell.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AllTaskBaseTableViewCell.h"

@implementation AllTaskBaseTableViewCell


#pragma mark - Initialization -

- (void) awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}


#pragma mark - Delegate methods -

- (void) setSelected: (BOOL) selected
            animated: (BOOL) animated
{
    [super setSelected: selected
              animated: animated];

    // Configure the view for the selected state
    
}


#pragma mark - Public methods -

- (void) fillInfoForCell: (id) info
{
    
}

- (CGFloat) getHeightForCell
{
    return 0;
}

@end
