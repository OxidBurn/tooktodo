//
//  WorksNamesTableViewCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/26/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "WorksNamesTableViewCell.h"

// Classes
#import "ProjectTask+CoreDataClass.h"

// Categories
#import "ProjectTaskStage+CoreDataClass.h"

@interface WorksNamesTableViewCell()

// properties

@property (weak, nonatomic) IBOutlet UILabel* titleWorkNamesLabel;
@property (weak, nonatomic) IBOutlet UILabel* amountTasksLabel;
@property (weak, nonatomic) IBOutlet UILabel* unreadTasksLabel;
@property (weak, nonatomic) IBOutlet UIImageView* arrowImage;

// methods


@end

@implementation WorksNamesTableViewCell


#pragma mark - Initialization -

- (void) awakeFromNib
{
    [super awakeFromNib];
    
    [self setupLabels];
    
    self.cellType = AllTasksStageCellType;
}


#pragma mark - Public methods -

- (void) fillInfoForCell: (id) info
{
    ProjectTaskStage* stageInfo = (ProjectTaskStage*) info;
    
    NSString* countOfTasks         = [NSString stringWithFormat: @"%u", stageInfo.tasks.count];
    NSUInteger countOfExpiredTasks = [self getCountOfExpiredTasks: stageInfo.tasks.allObjects];
    
    self.titleWorkNamesLabel.text = stageInfo.title;
    self.amountTasksLabel.text    = countOfTasks;
    
    
    if ( countOfExpiredTasks > 0 )
    {
        NSString* expiredCountString  = [NSString stringWithFormat: @"%ld", (unsigned long)countOfExpiredTasks];
        self.unreadTasksLabel.text    = expiredCountString;
        self.unreadTasksLabel.hidden  = NO;
    }
    else
    {
        self.unreadTasksLabel.hidden = YES;
    }
    
    [self updateExpandedState: stageInfo.isExpanded.boolValue];
}

- (CGFloat) getHeightForCell
{
    return 55;
}


#pragma mark - Internal methods -

- (NSUInteger) getCountOfExpiredTasks: (NSArray*) tasks
{
    __block NSUInteger count = 0;
    
    [tasks enumerateObjectsUsingBlock:^(ProjectTask* task, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ( task.isExpired.boolValue )
            count++;
        
    }];
    
    return count;
}

- (void) updateExpandedState: (BOOL) isExpanded
{
    UIImage* expandedStateImage = nil;
    
    if ( isExpanded )
    {
        expandedStateImage = [UIImage imageNamed: @"ArrowHorizontaly"];
        
    }
    else
    {
        expandedStateImage = [UIImage imageNamed: @"ArrowVertical"];
        
    }
    
    self.arrowImage.image = expandedStateImage;
}

- (void) setupLabels
{
    self.unreadTasksLabel.layer.cornerRadius = 8.0f;
    self.unreadTasksLabel.clipsToBounds      = YES;
    self.amountTasksLabel.backgroundColor   = [UIColor clearColor];
    self.amountTasksLabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.amountTasksLabel.layer.borderWidth = 1;
}
@end
