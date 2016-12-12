//
//  OSFlexibleTextFieldCell.m
//  TookTODO
//
//  Created by Nikolay Chaban on 21.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSFlexibleTextFieldCell.h"

// Classes
#import "AddTaskViewModel.h"
#import "NSString+Utils.h"
#import "UITextView+PlaceHolder.h"

@interface OSFlexibleTextFieldCell() <UITextViewDelegate>

// properties

@property (weak, nonatomic) IBOutlet UITextView* textView;

@property (strong, nonatomic) UIColor* steelColor;

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
             withDelegate: (id)        delegate
{
    if ( textContent.length > 0 )
        self.textView.text = textContent;
    
    self.textView.delegate = self;
    
    self.delegate = delegate;
    
    self.textView.placeHolder = @"Название задачи";
    
    self.textView.placeHolderColor = self.steelColor;
}

- (void) resetCellContent
{
    self.textView.text = @"";
}

- (void) makeTextViewFirstResponder
{
    [self.textView becomeFirstResponder];
}

#pragma mark - UITextViewDelegate methods -

- (void) textViewDidBeginEditing: (UITextView*) textView
{
    if ([self.delegate respondsToSelector:@selector(getViewModel)])
    {
        AddTaskViewModel* viewModel = [self.delegate getViewModel];
        
        RAC(viewModel, taskNameText) = [self.textView.rac_textSignal takeUntil: self.rac_prepareForReuseSignal];
    }
}

- (void) textViewDidEndEditing: (UITextView*) textView
{
    if ( [self.delegate respondsToSelector: @selector(updateFlexibleTextFieldCellWithText:)] )
    {
        [self.delegate updateFlexibleTextFieldCellWithText: [NSString getStringWithoutWhiteSpacesAndNewLines: self.textView.text]];
    }
}

- (BOOL)       textView: (UITextView*) textView
shouldChangeTextInRange: (NSRange)     range
        replacementText: (NSString*)   text
{
    if ( [text isEqualToString: @"\n"])
    {
        [textView resignFirstResponder];
        
        return NO;
    }
    else
    {
        BOOL shouldReturn = YES;
        
        if ( textView.text.length > 149 && text.length > 0)
        {
            text = @"";
            
            shouldReturn = NO;
        } else
        {
            if ( [self.delegate respondsToSelector: @selector(updateFlexibleTextFieldCellFrame)] )
                [self.delegate updateFlexibleTextFieldCellFrame];
        }
        
        return shouldReturn;
    }
}

@end
