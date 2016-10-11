//
//  SubtaskFilterView.m
//  TookTODO
//
//  Created by Глеб on 10.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SubtaskFilterView.h"

@interface SubtaskFilterView()


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

@implementation SubtaskFilterView

#pragma mark - Public -

- (void) fillCellWithContent: (TaskRowContent*) content
{
    
}

@end
