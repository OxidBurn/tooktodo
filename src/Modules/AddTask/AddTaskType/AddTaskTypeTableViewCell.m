//
//  AddTaskTypeTableViewCell.m
//  TookTODO
//
//  Created by Nikolay Chaban on 10/7/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddTaskTypeTableViewCell.h"

@interface AddTaskTypeTableViewCell()

// properties

@property (weak, nonatomic) IBOutlet UIView *taskTypeColorIndicator;
@property (weak, nonatomic) IBOutlet UILabel *taskTypeDescriptionTitle;
@property (weak, nonatomic) IBOutlet UIImageView *taskTypeSelectedCheckmark;

// methods


@end

@implementation AddTaskTypeTableViewCell


#pragma mark - Initialization -

- (void) awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}


#pragma mark - Public methods -




#pragma mark - Delegate methods -

- (void) setSelected: (BOOL) selected
            animated: (BOOL) animated
{
    [super setSelected: selected
              animated: animated];

    // Configure the view for the selected state
}

@end
