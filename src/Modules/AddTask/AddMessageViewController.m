//
//  AddMessageViewController.m
//  TookTODO
//
//  Created by Lera on 27.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddMessageViewController.h"

@interface AddMessageViewController()

@property (weak, nonatomic) IBOutlet UITextView* textView;

@end

@implementation AddMessageViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction) onBack: (UIBarButtonItem*) sender
{
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction) onReady: (id) sender
{
    [self.delegate setTaskDescription: self.textView.text];
    
    [self.navigationController popViewControllerAnimated: YES];
   
}

@end
