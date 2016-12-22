//
//  TaskDescriptionCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskDescriptionCell.h"

@interface TaskDescriptionCell()

// outlets
@property (weak, nonatomic) IBOutlet UILabel* taskDescriptionLabel;

// properties


// methods


@end

@implementation TaskDescriptionCell

#pragma mark - Public -

- (void) fillCellWithContent: (TaskRowContent*) content
{
    self.taskDescriptionLabel.text = content.taskDescription? content.taskDescription : @"Описание отсутствует";
}

@end
