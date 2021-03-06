//
//  StageTitleView.m
//  TookTODO
//
// Created by Nikolay Chaban on 28.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "StageTitleView.h"

//Classes
#import "ProjectTask+CoreDataClass.h"


@interface StageTitleView()

@property (weak, nonatomic) IBOutlet UIImageView *expandedStateImage;
@property (weak, nonatomic) IBOutlet UILabel *stageNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countOfTasksLabel;
@property (weak, nonatomic) IBOutlet UILabel *countOfExpiredTasksLabel;

// methods

- (IBAction) onShowTasks: (UIButton*) sender;

@end

@implementation StageTitleView

#pragma mark - Public methods -

- (void)    fillInfo: (ProjectTaskStage*) info
 withStagesTasksList: (NSArray*)          tasks
     withSearchState: (NSUInteger)        state
{
    self.stageNameLabel.text       = info.title;
    NSUInteger countOfExpiredTasks = 0;
    
    switch (state)
    {
        case 0:
        {
            self.countOfTasksLabel.text = [NSString stringWithFormat: @"%lu", info.tasks.array.count];
            countOfExpiredTasks         = [self getCountOfExpiredTasks: info.tasks.array];
            
            [self updateExpandedState: info.isExpanded.boolValue];
        }
            break;
        case 1:
        {
            if ( tasks.count > 0 )
            {
                self.countOfTasksLabel.text = [NSString stringWithFormat: @"%lu", tasks.count];
                countOfExpiredTasks         = [self getCountOfExpiredTasks: tasks];
            }
            else
            {
                self.countOfTasksLabel.text = [NSString stringWithFormat: @"%lu", tasks.count];
                countOfExpiredTasks         = [self getCountOfExpiredTasks: tasks];
            }
            
            [self updateExpandedState: YES];
        }
            break;
        default:
            break;
    }
    
    
    
    if ( countOfExpiredTasks > 0 )
    {
        self.countOfExpiredTasksLabel.hidden = NO;
        self.countOfExpiredTasksLabel.text   = [NSString stringWithFormat: @"%ld", (unsigned long)countOfExpiredTasks];
    }
    else
    {
        self.countOfExpiredTasksLabel.hidden = YES;
    }
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
    
    [tasks enumerateObjectsUsingBlock: ^(ProjectTask* task, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ( task.isExpired.boolValue )
            count++;
        
    }];
    
    return count;
}


@end
