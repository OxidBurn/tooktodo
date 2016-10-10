//
//  SubTaskInfoView.m
//  TookTODO
//
//  Created by Глеб on 10.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SubTaskInfoView.h"

typedef NS_ENUM(NSUInteger, ButtonTag) {

    SubTaskBtnTag,
    AttachmentsBtnTag,
    CommentsBtnTag,
    LogsBtnTag,
    
};

@interface SubTaskInfoView()

// outlets
@property (weak, nonatomic) IBOutlet UIButton* subTasksBtn;
@property (weak, nonatomic) IBOutlet UIButton* attachmentsBtn;
@property (weak, nonatomic) IBOutlet UIButton* commentsBtn;
@property (weak, nonatomic) IBOutlet UIButton* logsBtn;

@property (weak, nonatomic) IBOutlet UILabel* subTasksNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel* attachmentsNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel* commentsNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel* logsNumberLabel;

// properties
@property (strong, nonatomic) NSArray* allButtons;

@property (strong, nonatomic) NSArray* allLabels;

// methods
- (IBAction) onSubTasksBtn: (UIButton*) sender;

- (IBAction) onAttachmentsBtn: (UIButton*) sender;

- (IBAction) onCommentsBtn: (UIButton*) sender;

- (IBAction) onLogsBtn: (UIButton*) sender;

@end

@implementation SubTaskInfoView

#pragma mark - Properties -

- (NSArray*) allButtons
{
    if ( _allButtons == nil )
    {
        _allButtons = @[ self.subTasksBtn,
                         self.attachmentsBtn,
                         self.commentsBtn,
                         self.logsBtn];
    }
    
    return _allButtons;
}

- (NSArray*) allLabels
{
    if ( _allLabels == nil )
    {
        _allLabels = @[ self.subTasksNumberLabel,
                        self.attachmentsNumberLabel,
                        self.commentsNumberLabel,
                        self.logsNumberLabel];
    }
    
    return _allLabels;
}

#pragma mark - Public -

- (void) fillViewWithInfo: (NSArray*) infoArray
{
    self.subTasksNumberLabel.text    = [self returnStringFromNumber: infoArray[SubTaskBtnTag]];
    self.attachmentsNumberLabel.text = [self returnStringFromNumber: infoArray[AttachmentsBtnTag]];
    self.commentsNumberLabel.text    = [self returnStringFromNumber: infoArray[CommentsBtnTag]];
    self.logsNumberLabel.text        = [self returnStringFromNumber: infoArray[LogsBtnTag]];
}


#pragma mark - Actions -

- (IBAction) onSubTasksBtn: (UIButton*) sender
{
    
}

- (IBAction) onAttachmentsBtn: (UIButton*) sender
{
    
}

- (IBAction) onCommentsBtn: (UIButton*) sender
{
    
}

- (IBAction) onLogsBtn: (UIButton*) sender
{
    
}

#pragma mark - Helpers -

- (NSString*) returnStringFromNumber: (NSNumber*) number
{
    return [NSString stringWithFormat: @"%@", number];
}


@end
