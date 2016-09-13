//
//  TasksProjectTitleView.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/13/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TasksProjectTitleView.h"

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
    self.countOfTasksLabel.text   = [NSString stringWithFormat: @"%ld", info.tasks.count];
    
    [self updateExpandedState: info.isExpanded];
}



#pragma mark - Actions -

- (IBAction) onShowTasks: (UIButton*) sender
{
    
}


#pragma mark - Internal methods -

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
    
    self.expandedStateImage.image = expandedStateImage;
}

@end
