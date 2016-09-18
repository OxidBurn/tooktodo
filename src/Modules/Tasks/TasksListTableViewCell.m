//
//  TasksListTableViewCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/26/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TasksListTableViewCell.h"

// Classes
#import "StatusMarkerComponent.h"
#import "TaskMarkerComponent.h"
#import "ProjectTask+CoreDataClass.h"
#import "ProjectTaskResponsible.h"
#import "ProjectTaskAssignee.h"
#import "NSDate+Helper.h"

// Categories
#import "UIImageView+WebCache.h"

@interface TasksListTableViewCell()

// properties
@property (weak, nonatomic) IBOutlet UILabel* executionDateLabel;
@property (weak, nonatomic) IBOutlet UILabel* roomNumbersLabel;
@property (weak, nonatomic) IBOutlet StatusMarkerComponent* typeTaskMarkerView;
@property (weak, nonatomic) IBOutlet UILabel* systemLabel;
@property (weak, nonatomic) IBOutlet UILabel* titleTaskLabel;
@property (weak, nonatomic) IBOutlet UIImageView* avatarImage;
@property (weak, nonatomic) IBOutlet TaskMarkerComponent* amountTaskMarkerComponent;
@property (weak, nonatomic) IBOutlet TaskMarkerComponent* attachmantsMarkerComponent;
@property (weak, nonatomic) IBOutlet TaskMarkerComponent* commentsMarkerComponent;

// methods


@end

@implementation TasksListTableViewCell


#pragma mark - Initialization -

- (void) awakeFromNib
{
    [super awakeFromNib];
    
    self.cellType = AllTasksTaskCellType;
}


#pragma mark - Delegate methods -

- (void) setSelected: (BOOL) selected
            animated: (BOOL) animated
{
    [super setSelected: selected
              animated: animated];
}


#pragma mark - Public methods -

- (void) fillInfoForCell: (id) info
{
    ProjectTask* taskInfo = (ProjectTask*)info;
    
    self.titleTaskLabel.text = taskInfo.title;
    
    
    // Setting avatar url
    // first time it will be loaded from web and then grab from cache
    ProjectTaskAssignee* assignee = (ProjectTaskAssignee*)taskInfo.responsible.assignee;
    
    [self.avatarImage sd_setImageWithURL: [NSURL URLWithString: assignee.avatarSrc]];
    
}


#pragma mark - Internal methods -

- (NSString*) executionDateString: (ProjectTask*) task
{
//    NSString* startDayString = task.
    
    return @"";
}

@end
