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


#pragma mark - Public methods -

- (void) setTypeTitle: (NSString*) title
        withTypeColor: (UIColor*)  color
{
    self.taskTypeDescriptionTitle.text          = title;
    self.taskTypeColorIndicator.backgroundColor = color;
}

- (void) markCellAsSelected: (BOOL) isSelected
{
    self.taskTypeSelectedCheckmark.hidden = !isSelected;
}

@end
