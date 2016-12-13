//
//  AddMessageViewController.m
//  TookTODO
//
// Created by Nikolay Chaban on 27.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddMessageViewController.h"

// Classes
#import "AddMessageModel.h"
#import "NSString+Utils.h"
#import "UITextView+PlaceHolder.h"

@interface AddMessageViewController() <UITextFieldDelegate>

// outlets

@property (weak, nonatomic) IBOutlet UITextView* textView;

// properties

@property (strong, nonatomic) AddMessageModel* model;



@end

@implementation AddMessageViewController

#pragma mark - Lyfe cycle -

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.textView.text = [self.model getDescriptionText];
    
    self.textView.placeHolderColor = [self.model getPlacelderColor];
    self.textView.placeHolder      = @"Описание задачи";
}

#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Properties -

- (AddMessageModel*) model
{
    if ( _model == nil )
    {
        _model = [AddMessageModel new];
    }
    
    return _model;
}


#pragma mark - Actions -

- (IBAction) onBack: (UIBarButtonItem*) sender
{    
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction) onReady: (id) sender
{
    [self dissmissKeyboardWithCompletion: ^(BOOL isSuccess) {
        
        if ( [self.delegate respondsToSelector: @selector(setTaskDescription:)] )
        {
            NSString* description = [NSString getStringWithoutWhiteSpacesAndNewLines: self.textView.text];
            
            if ( [description isEqualToString: @""] )
                description = @"Описание задачи";
            
            [self.delegate setTaskDescription: description];
        }
        
        [self.navigationController popViewControllerAnimated: YES];
        
    }];
}

#pragma mark - Public -

- (void) updateDescription: (NSString*) descriptionText
          andReturnToModel: (id)        model
{
    if ( [descriptionText isEqualToString: @"Описание задачи"] )
    {
        descriptionText = @"";
    }
    
    [self.model fillText: descriptionText];
    
    self.delegate = model;
}

#pragma mark - UITextFieldDelegate methods -

- (void) textViewDidBeginEditing: (UITextView*) textView
{
    [textView becomeFirstResponder];
}

- (void) textViewDidEndEditing: (UITextView*) textView
{
    [textView resignFirstResponder];
}

- (BOOL)       textView: (UITextView*) textView
shouldChangeTextInRange: (NSRange)     range
        replacementText: (NSString*)   text
{
    BOOL shouldReturn = YES;
    
    if ( textView.text.length > 1999 && text.length > 0)
    {
        text = @"";
        
        shouldReturn = NO;
    }
    
    return shouldReturn;
}


#pragma mark - Helpers -

- (void) dissmissKeyboardWithCompletion: (CompletionWithSuccess) completion
{
    [self.textView endEditing: YES];
    
    if (completion)
        completion(YES);
}

@end
