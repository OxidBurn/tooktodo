//
//  FilterSubtasksCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 12.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterSubtasksCell.h"

//Extentions
#import "BaseMainViewController+Popover.h"

@interface FilterSubtasksCell()

// outlets
@property (weak, nonatomic) IBOutlet UIButton*    addTaskBtn;

@property (weak, nonatomic) IBOutlet UIButton*    filterTasksBtn;

@property (weak, nonatomic) IBOutlet UIButton*    canceledTasksBtn;

@property (weak, nonatomic) IBOutlet UIButton*    doneTasksBtn;

@property (weak, nonatomic) IBOutlet UIImageView* doneTasksCheckbox;

@property (weak, nonatomic) IBOutlet UIImageView* canceledTasksCheckbox;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint* addSubtaskBtnWidthConstraint;
@property (weak, nonatomic) IBOutlet UIImageView*        addPlusImageView;
@property (weak, nonatomic) IBOutlet UILabel*            addLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* addPlusImageViewWidthConstraint;
// properties


// methods
- (IBAction) onAddTaskBtn: (UIButton*) sender;

- (IBAction) onFilterTaskBtn: (UIButton*) sender;

- (IBAction) onCanceledTasksBtn: (UIButton*) sender;

- (IBAction) onDoneTasksBtn: (UIButton*) sender;


@end

@implementation FilterSubtasksCell


#pragma mark - Initialization -

- (void) awakeFromNib
{
    [super awakeFromNib];
    
    if ( IS_IPHONE_5  || IS_IPHONE_4_OR_LESS )
    {
        self.addSubtaskBtnWidthConstraint.constant = 28;
        
        self.addPlusImageView.image                   = [UIImage imageNamed: @"AddSubTask"];
        self.addPlusImageViewWidthConstraint.constant = 28;
        
        [self.addLabel removeFromSuperview];
        self.addLabel         = nil;
    }
}



#pragma mark - Actions -


- (IBAction) onAddTaskBtn: (UIButton*) sender
{
    if ([self.delegate respondsToSelector:@selector(performSegueToAddSubtaskWithID:)])
    {
        [self.delegate performSegueToAddSubtaskWithID: @"ShowAddSubtask"];
    }
}

- (IBAction) onFilterTaskBtn: (UIButton*) sender
{
    if ([self.delegate respondsToSelector: @selector(showSortingPopoverWithFrame:)])
    {
        [self.delegate showSortingPopoverWithFrame: sender.frame];
    }
}

- (IBAction) onCanceledTasksBtn: (UIButton*) sender
{
    
}

- (IBAction) onDoneTasksBtn: (UIButton*) sender
{
    
}


#pragma mark - Public -

- (void) fillCellWithContent: (TaskRowContent*) content
{
    
}

@end
