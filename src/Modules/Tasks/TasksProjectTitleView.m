//
//  TasksProjectTitleView.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/13/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TasksProjectTitleView.h"

// Classes
#import "ProjectTask+CoreDataClass.h"

@interface TasksProjectTitleView()

// properties

@property (weak, nonatomic) IBOutlet UIImageView *expandedStateImage;
@property (weak, nonatomic) IBOutlet UILabel *projectNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *countOfTasksLabel;
@property (weak, nonatomic) IBOutlet UILabel *countOfExpiredTasksLabel;

// methods

- (IBAction) onShowTasks: (UIButton*) sender;


@end

@implementation TasksProjectTitleView


#pragma mark - Public methods -

- (void) fillInfo: (ProjectInfo*) info
{
    self.projectNameLabel.text    = info.title;
    self.projectAddressLabel.text = info.address;
    self.countOfTasksLabel.text   = [NSString stringWithFormat: @"%lu", info.tasks.count];
    
    NSUInteger countOfExpiredTasks = [self getCountOfExpiredTasks: info.tasks.allObjects];
    
    if ( countOfExpiredTasks > 0 )
    {
        self.countOfExpiredTasksLabel.hidden = NO;
        self.countOfExpiredTasksLabel.text   = [NSString stringWithFormat: @"%ld", (unsigned long)countOfExpiredTasks];
    }
    else
    {
        self.countOfExpiredTasksLabel.hidden = YES;
    }
    
    [self updateExpandedState: info.isExpanded.boolValue];
}



#pragma mark - Actions -

- (IBAction) onShowTasks: (UIButton*) sender
{
    if ( self.didChangeExpandState )
        self.didChangeExpandState(self.tag);
}


#pragma mark - Internal methods -

- (void) updateExpandedState: (BOOL) isExpanded
{
    UIImage* expandedStateImage = nil;
    
    if ( isExpanded )
    {
        self.countOfTasksLabel.backgroundColor   = [UIColor clearColor];
        self.countOfTasksLabel.layer.borderColor = [UIColor colorWithRed:0.349 green:0.3922 blue:0.4431 alpha:1.0].CGColor;
        self.countOfTasksLabel.layer.borderWidth = 1.0f;
        expandedStateImage                       = [UIImage imageNamed: @"ArrowHorizontaly"];
        self.backgroundColor                     = [UIColor colorWithRed:0.902 green:0.9098 blue:0.9176 alpha:1.0];
    }
    else
    {
        self.countOfTasksLabel.backgroundColor   = [UIColor colorWithRed:0.8235 green:0.8902 blue:0.8824 alpha:1.0];
        self.countOfTasksLabel.layer.borderColor = [UIColor clearColor].CGColor;
        self.countOfTasksLabel.layer.borderWidth = 0.0f;
        expandedStateImage                       = [UIImage imageNamed: @"ArrowVertical"];
        self.backgroundColor                     = [UIColor whiteColor];
    }
    
    self.expandedStateImage.image = expandedStateImage;
}

- (NSUInteger) getCountOfExpiredTasks: (NSArray*) tasks
{
    __block NSUInteger count = 0;
    
    [tasks enumerateObjectsUsingBlock:^(ProjectTask* task, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ( task.isExpired.boolValue )
            count++;
        
    }];
    
    return count;
}


@end
