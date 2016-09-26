//
//  OSFlexibleTextFieldCell.m
//  TookTODO
//
//  Created by Глеб on 21.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSFlexibleTextFieldCell.h"
#import "AddTaskViewModel.h"

@interface OSFlexibleTextFieldCell() <UITextFieldDelegate>

// properties

@property (weak, nonatomic) IBOutlet UILabel*     taskNameLabel;
@property (weak, nonatomic) IBOutlet UITextField* taskNamtTextField;

@property (strong, nonatomic) UIColor* steelColor;

@property (assign, nonatomic) BOOL isEditedByUser;

// methods


@end

@implementation OSFlexibleTextFieldCell

#pragma mark - Properties -

- (UIColor*) steelColor
{
    if ( _steelColor == nil )
    {
        CGFloat red   = 120.0/256;
        CGFloat green = 133.0/256;
        CGFloat blue  = 148.0/256;
        
        _steelColor = [UIColor colorWithRed: red green: green blue:blue alpha: 1.0];
    }
    
    return _steelColor;
}


#pragma mark - Public -

- (void) fillCellWithText: (NSString*) textContent
{
    if ( textContent.length > 0 )
    self.taskNameLabel.text = textContent;
    
    if ([self.delegate respondsToSelector:@selector(getViewModel)])
    {
       AddTaskViewModel* viewModel = [self.delegate getViewModel];
        
        RAC(viewModel, taskNameText) = self.taskNamtTextField.rac_textSignal;
        
      
        
        self.taskNameLabel.text = self.taskNamtTextField.text;
    }
    
    [self.taskNamtTextField.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"x %@", x);
    }];
    
}

- (void) editTextLabel
{
    if ( !self.isEditedByUser )
    {
        self.taskNameLabel.text      = @"";
        self.isEditedByUser = YES;
    }
    self.taskNameLabel.textColor = [UIColor blackColor];
    
    self.taskNameLabel.hidden = YES;
    self.taskNamtTextField.hidden = NO;
    
    self.taskNamtTextField.text = self.taskNameLabel.text;
    
    [self.taskNamtTextField becomeFirstResponder];
}

#pragma mark - UITextFieldDelegate methods -

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    self.isEditedByUser = YES;
    
    self.taskNameLabel.hidden = NO;
    self.taskNamtTextField.hidden = YES;
    
    self.taskNameLabel.text = self.taskNamtTextField.text;
    
    if ( [self.taskNameLabel.text isEqualToString: @"Название задачи"]  ||
         [self.taskNameLabel.text isEqualToString: @""] )
    {
        self.taskNameLabel.textColor = self.steelColor;
        
        self.isEditedByUser = NO;
    }
    
    if ( [self.delegate respondsToSelector: @selector(updateFlexibleTextFieldCellWithText:)] )
    {
         [self.delegate updateFlexibleTextFieldCellWithText: self.taskNamtTextField.text];
    }
}

- (BOOL) textFieldShouldReturn: (UITextField*) textField
{
    self.taskNameLabel.hidden = NO;
    self.taskNamtTextField.hidden = YES;
    
    self.taskNameLabel.text = self.taskNamtTextField.text;
    
    if ( [self.delegate respondsToSelector: @selector(updateFlexibleTextFieldCellWithText:)] )
    {
         [self.delegate updateFlexibleTextFieldCellWithText: self.taskNamtTextField.text];
    }
    return YES;
}

- (BOOL)            textField: (UITextField*) textField
shouldChangeCharactersInRange: (NSRange)      range
            replacementString: (NSString*)    string
{
    BOOL shouldReturn = YES;
    
    if ( textField.text.length > 149 && string.length > 0)
    {
        string = @"";
        
        shouldReturn = NO;
    }
        
    return shouldReturn;
}
@end
