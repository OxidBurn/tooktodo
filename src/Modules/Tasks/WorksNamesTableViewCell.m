//
//  WorksNamesTableViewCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/26/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "WorksNamesTableViewCell.h"

@interface WorksNamesTableViewCell()

// properties

@property (weak, nonatomic) IBOutlet UILabel* titleWorkNamesLabel;
@property (weak, nonatomic) IBOutlet UILabel* amountTasksLabel;
@property (weak, nonatomic) IBOutlet UILabel* unreadTasksLabel;
@property (weak, nonatomic) IBOutlet UIImageView* arrowImage;

// methods


@end

@implementation WorksNamesTableViewCell

- (void) awakeFromNib
{
    [super awakeFromNib];
}

- (void) setSelected: (BOOL) selected
            animated: (BOOL) animated
{
    [super setSelected: selected
              animated: animated];
}

@end
