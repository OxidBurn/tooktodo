//
//  AddContactViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/24/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddContactViewController.h"
#import "AddContactViewModel.h"
#import "RolesViewController.h"
#import "InviteInfo.h"
#import "TeamInfoViewController.h"

@interface AddContactViewController () <RolesViewControllerDelegate, UITableViewDelegate>

// Properties

@property (weak, nonatomic) IBOutlet UITextField *lastnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UILabel *roleLabel;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@property (weak, nonatomic) IBOutlet UITextField *emailLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *readyBtn;

@property (nonatomic, strong) AddContactViewModel* addContactViewModel;
@property (nonatomic, strong) InviteInfo* filledInfo;
@property (nonatomic, assign) BOOL firstCheck;

// Methods

@end

@implementation AddContactViewController

#pragma mark - Properties -

- (AddContactViewModel*) addContactViewModel
{
    if (_addContactViewModel == nil)
    {
        _addContactViewModel = [[AddContactViewModel alloc] init];
    }
    
    return _addContactViewModel;
}

- (InviteInfo*) filledInfo
{
    if (_filledInfo == nil)
    {
        _filledInfo = [[InviteInfo alloc] init];
    }
    
    return _filledInfo;
}


#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    [self twoLineTitleView];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self bindViewModel];
    
    self.firstCheck = YES;
}

#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Internal method -

- (void) bindViewModel
{
    RAC(self.addContactViewModel, lastnameText) = self.lastnameTextField.rac_textSignal;
    RAC(self.addContactViewModel, nameText)     = self.nameTextField.rac_textSignal;
    RAC(self.addContactViewModel, emailText)    = [self.emailTextField.rac_textSignal distinctUntilChanged];
    
    
    RAC(self.addContactViewModel, messageText) = self.messageTextView.rac_textSignal;
    RAC(self.addContactViewModel, roleText)    = RACObserve(self.roleLabel, text);
    
    [RACObserve(self.roleLabel, text) subscribeNext: ^(NSString* x) {
        
        self.filledInfo.role = x;
        
    }];
    
    [self.addContactViewModel.readyCommand.executionSignals subscribeNext: ^(RACSignal* readySignal) {
        
         [[self.addContactViewModel returnInvitationInfo] subscribeNext: ^(InviteInfo* userInfo) {
             
             self.filledInfo = userInfo;
             
         }
                                                     completed: ^{
                                                         
                                                         [self performSegueWithIdentifier: @"ShowTeam"
                                                                                   sender: self];
                                                         
                                                     }];
         
         
     }];
    
    //связь кнопки и команды, которая за нее отвечает
    self.readyBtn.rac_command = self.addContactViewModel.readyCommand;
    
}


- (UIView*) twoLineTitleView
{
    UIFont* customFont         = [UIFont fontWithName: @"SFUIText-Regular"
                                                 size: 14.0f];
    
    UILabel* titleLabel        = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 0, 0)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor       = [UIColor whiteColor];
    titleLabel.font            = customFont;
    titleLabel.textAlignment   = NSTextAlignmentCenter;
    titleLabel.text            = @"ПРИГЛАСИТЬ";
    [titleLabel sizeToFit];
    
    UILabel* subTitleLabel        = [[UILabel alloc] initWithFrame: CGRectMake(0, 17, 0, 0)];
    
    subTitleLabel.backgroundColor = [UIColor clearColor];
    subTitleLabel.textColor       = [UIColor whiteColor];
    subTitleLabel.font            = customFont;
    subTitleLabel.textAlignment   = NSTextAlignmentCenter;
    subTitleLabel.text            = @"УЧАСНИКА";
    
    [subTitleLabel sizeToFit];
    
    UIView* twoLineTitleView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, MAX(subTitleLabel.frame.size.width, titleLabel.frame.size.width), 32)];
    
    [twoLineTitleView addSubview: titleLabel];
    [twoLineTitleView addSubview: subTitleLabel];
    
    float widthDiff = subTitleLabel.frame.size.width - titleLabel.frame.size.width;
    
    if (widthDiff > 0)
    {
        CGRect frame     = titleLabel.frame;
        frame.origin.x   = widthDiff / 2;
        titleLabel.frame = CGRectIntegral(frame);
    }
    else
    {
        CGRect frame        = subTitleLabel.frame;
        frame.origin.x      = fabsf(widthDiff) / 2;
        subTitleLabel.frame = CGRectIntegral(frame);
    }
    
    self.navigationItem.titleView = twoLineTitleView;
    
    return twoLineTitleView;
}

#pragma mark - Segue -

-(void) prepareForSegue: (UIStoryboardSegue*) segue
                 sender: (id)sender
{
    [super prepareForSegue: segue
                    sender: sender];
    
    if ( [segue.identifier isEqualToString: @"ShowTeam"] )
    {
        TeamInfoViewController* teamController = [segue destinationViewController];
        
        [teamController fillInviteInfo: self.filledInfo];
    }
    else
        if ([segue.identifier isEqualToString: @"ShowRoles"])
        {
            RolesViewController* controller = segue.destinationViewController;
            
            [controller setRolesViewControllerDelegate: self];
        }
    
}


#pragma mark - Actions -

- (IBAction) onDismiss: (UIBarButtonItem*) sender
{
    [self.navigationController popViewControllerAnimated: YES];
}

#pragma mark - TextField delegate methods -


- (void) textFieldDidEndEditing: (UITextField*) textField
{
    if (textField == self.emailTextField && self.firstCheck)
    {
        self.firstCheck = NO;
        
        RAC(self.emailLabel, text) = [[self.addContactViewModel getEmailWarningSignal] distinctUntilChanged];
    }
}

#pragma mark - RolesViewControllerDelegate methods -

- (void) didSelectRole: (NSString*) value
{
    self.roleLabel.text = value;
}

@end
