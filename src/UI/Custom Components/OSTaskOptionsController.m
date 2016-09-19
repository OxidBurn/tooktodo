//
//  TaskOptionsController.m
//  TookTODO
//
//  Created by Lera on 12.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSTaskOptionsController.h"

//classes
#import "AddTaskViewController.h"

@interface OSTaskOptionsController ()

// Outlets
@property (weak, nonatomic) IBOutlet UIButton* addComment;
@property (weak, nonatomic) IBOutlet UIButton* addMark;
@property (weak, nonatomic) IBOutlet UIButton* addNewTask;
@property (weak, nonatomic) IBOutlet UIButton* addDocument;
@property (weak, nonatomic) IBOutlet UIButton* addUser;
@property (weak, nonatomic) IBOutlet UIButton* dismiss;

// Actions
- (IBAction) onAddComment:  (UIButton*) sender;

- (IBAction) onAddMark:     (UIButton*) sender;

- (IBAction) onAddNewTask:  (UIButton*) sender;

- (IBAction) onAddDocument: (UIButton*) sender;

- (IBAction) onAddUser:     (UIButton*) sender;

- (IBAction) onDismiss:     (UIButton*) sender;



@end

@implementation OSTaskOptionsController


#pragma mark - Life Cycle -

- (void) loadView
{
    [super loadView];
    
    [self roundButtons];
}


#pragma mark - Actions -

- (IBAction) onAddComment: (UIButton*) sender
{
    NSLog(@"onAddComment");
}


- (IBAction) onAddMark: (UIButton*) sender
{
    NSLog(@"onAddMark");
}


- (IBAction) onAddNewTask: (UIButton*) sender
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName: @"TaskOptionsScreen"
                                                         bundle: nil];
    
    AddTaskViewController* addTaskController = [storyboard instantiateViewControllerWithIdentifier: @"AddTaskControllerID"];
    
    
    [self presentViewController: addTaskController
                       animated: NO
                     completion: nil];

}

- (IBAction) onAddDocument: (UIButton*) sender
{
    NSLog(@"onAddDocument");
}

- (IBAction) onAddUser: (UIButton*) sender
{
   // [self performSegueWithIdentifier: @"" sender: ]
}

- (IBAction) onDismiss: (UIButton*) sender
{
    [self dismissViewControllerAnimated: YES
                             completion: nil];
}

#pragma mark - Helpers -

- (void) roundButtons
{
    self.addComment.layer.cornerRadius  = self.addComment.frame.size.width/2;
    self.addMark.layer.cornerRadius     = self.addMark.frame.size.width/2;
    self.addNewTask.layer.cornerRadius  = self.addNewTask.frame.size.width/2;
    self.addDocument.layer.cornerRadius = self.addDocument.frame.size.width/2;
    self.addUser.layer.cornerRadius     = self.addUser.frame.size.width/2;
    self.dismiss.layer.cornerRadius     = self.dismiss.frame.size.width/2;
}

@end
