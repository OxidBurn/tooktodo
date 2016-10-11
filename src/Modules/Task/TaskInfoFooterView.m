//
//  SubTaskInfoView.m
//  TookTODO
//
//  Created by Глеб on 10.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskInfoFooterView.h"

typedef NS_ENUM(NSUInteger, ButtonTag) {

    SubTaskBtnTag,
    AttachmentsBtnTag,
    CommentsBtnTag,
    LogsBtnTag,
    
};

@interface TaskInfoFooterView()

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

@property (strong, nonatomic) UIColor* blackColor;

@property (strong, nonatomic) UIColor* grayColor;

// methods
- (IBAction) onSubTasksBtn: (UIButton*) sender;

- (IBAction) onAttachmentsBtn: (UIButton*) sender;

- (IBAction) onCommentsBtn: (UIButton*) sender;

- (IBAction) onLogsBtn: (UIButton*) sender;

@end

@implementation TaskInfoFooterView

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

- (UIColor*) blackColor
{
    if ( _blackColor == nil )
    {
        _blackColor = [UIColor colorWithRed: 38.0/256
                                      green: 45.0/256
                                       blue: 55.0/256
                                      alpha: 1.f];
    }
    
    return _blackColor;
}

- (UIColor*) grayColor
{
    if ( _grayColor == nil )
    {
        _grayColor = [UIColor colorWithRed: 38.0/256
                                     green: 45.0/256
                                      blue: 55.0/256
                                     alpha: 0.3f];
    }
    
    return _grayColor;
}

#pragma mark - Public -

- (void) fillViewWithInfo: (NSArray*) infoArray
             withDelegate: (id)       delegate
{
    self.subTasksNumberLabel.text    = [self returnStringFromNumber: infoArray[SubTaskBtnTag]];
    self.attachmentsNumberLabel.text = [self returnStringFromNumber: infoArray[AttachmentsBtnTag]];
    self.commentsNumberLabel.text    = [self returnStringFromNumber: infoArray[CommentsBtnTag]];
    self.logsNumberLabel.text        = [self returnStringFromNumber: infoArray[LogsBtnTag]];
    
    self.delegate = delegate;
}


#pragma mark - Actions -

- (IBAction) onSubTasksBtn: (UIButton*) sender
{
    [self handleSectionSelectionForButtonWithTag: sender.tag];
}

- (IBAction) onAttachmentsBtn: (UIButton*) sender
{
    [self handleSectionSelectionForButtonWithTag: sender.tag];
}

- (IBAction) onCommentsBtn: (UIButton*) sender
{
    [self handleSectionSelectionForButtonWithTag: sender.tag];
}

- (IBAction) onLogsBtn: (UIButton*) sender
{
    [self handleSectionSelectionForButtonWithTag: sender.tag];
}

#pragma mark - Helpers -

- (NSString*) returnStringFromNumber: (NSNumber*) number
{
    return [NSString stringWithFormat: @"%@", number];
}

- (void) handleSectionSelectionForButtonWithTag: (NSUInteger) tag
{
    [self.allButtons enumerateObjectsUsingBlock: ^(UIButton* button, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [button setTitleColor: self.grayColor forState: UIControlStateNormal];
        
        if ( idx == tag )
            [button setTitleColor: self.blackColor forState: UIControlStateNormal];
        
    }];
    
    [self.allLabels enumerateObjectsUsingBlock: ^(UILabel* label, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [label setTextColor: self.grayColor];
        
        if ( idx == tag )
            [label setTextColor: self.blackColor];
    }];
    
    if ( [self.delegate respondsToSelector: @selector(updateSecondSectionContentType:)] )
         [self.delegate updateSecondSectionContentType: tag];
}

@end
