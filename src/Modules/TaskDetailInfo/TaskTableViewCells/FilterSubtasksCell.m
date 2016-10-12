//
//  FilterSubtasksCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 12.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterSubtasksCell.h"

@interface FilterSubtasksCell()

// outlets
@property (weak, nonatomic) IBOutlet UIButton*    addTaskBtn;

@property (weak, nonatomic) IBOutlet UIButton*    filterTasksBtn;

@property (weak, nonatomic) IBOutlet UIButton*    canceledTasksBtn;

@property (weak, nonatomic) IBOutlet UIButton*    doneTasksBtn;

@property (weak, nonatomic) IBOutlet UIImageView* doneTasksCheckbox;

@property (weak, nonatomic) IBOutlet UIImageView* canceledTasksCheckbox;

// properties


// methods


@end

@implementation FilterSubtasksCell

#pragma mark - Public -

- (void) fillCellWithContent: (TaskRowContent*) content
{
    
}

@end
