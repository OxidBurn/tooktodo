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
    
    [self checkIfDescriptionExists];
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
            [self.delegate setTaskDescription: [NSString getStringWithoutWhiteSpacesAndNewLines: self.textView.text]];
        
        [self.navigationController popViewControllerAnimated: YES];
        
    }];
}

#pragma mark - Public -

- (void) updateDescription: (NSString*) descriptionText
          andReturnToModel: (id)        model
{
    [self.model fillText: descriptionText];
    
    self.delegate = model;
}

#pragma mark - UITextFieldDelegate methods -

- (void) textViewDidBeginEditing: (UITextView*) textView
{
    if ( [textView.text isEqualToString: @"Введите описание задачи"] )
    {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    
    [textView becomeFirstResponder];
}

- (void) textViewDidEndEditing: (UITextView*) textView
{
    if ([textView.text isEqualToString:@""])
    {
        textView.text = @"Введите описание задачи";
        textView.textColor = [self.model getPlacelderColor];
    }
    
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

- (void) checkIfDescriptionExists
{
    if ( [self.model getDescriptionText] )
    {
        self.textView.text = [self.model getDescriptionText];
        
        self.textView.textColor = [UIColor blackColor];
    }
}

- (void) dissmissKeyboardWithCompletion: (CompletionWithSuccess) completion
{
    [self.textView endEditing: YES];
    
    if (completion)
        completion(YES);
}

@end
