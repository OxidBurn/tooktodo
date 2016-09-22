//
//  AddContactViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/24/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddContactViewController.h"

// Classes
#import "AddContactViewModel.h"
#import "RolesViewController.h"
#import "InviteInfo.h"
#import "TeamInfoViewController.h"
#import "ProjectRoles.h"

// Categories
#import "UITextView+PlaceHolder.h"

@interface AddContactViewController () <RolesViewControllerDelegate, UITableViewDelegate>

// Properties

@property (weak, nonatomic) IBOutlet UITextField     *lastnameTextField;
@property (weak, nonatomic) IBOutlet UITextField     *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField     *emailTextField;
@property (weak, nonatomic) IBOutlet UILabel         *roleLabel;
@property (weak, nonatomic) IBOutlet UITextView      *messageTextView;
@property (weak, nonatomic) IBOutlet UITextField     *emailLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *readyBtn;

@property (nonatomic, strong) AddContactViewModel * addContactViewModel;
@property (nonatomic, strong) InviteInfo          * filledInfo;
@property (nonatomic, assign) BOOL                firstCheck;


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
    
    [self bindViewModel];
    
    self.firstCheck = YES;
    
    // Setup message text view placeholder
    [self setupMessageTextView];
}


#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Internal method -

- (void) setupMessageTextView
{
    self.messageTextView.placeHolder      = @"Личное сообщение";
    self.messageTextView.placeHolderColor = [UIColor colorWithRed:0.74 green:0.75 blue:0.76 alpha:1.00];
    self.messageTextView.placeHolderFont  = [UIFont fontWithName: @"SFUIText-Regular"
                                                            size: 15];
}

- (void) bindViewModel
{
    RAC(self.addContactViewModel, lastnameText) = self.lastnameTextField.rac_textSignal;
    RAC(self.addContactViewModel, nameText)     = self.nameTextField.rac_textSignal;
    RAC(self.addContactViewModel, emailText)    = [self.emailTextField.rac_textSignal distinctUntilChanged];
    RAC(self.addContactViewModel, messageText)  = self.messageTextView.rac_textSignal;
    
    self.nameTextField.delegate     = self.addContactViewModel;
    self.lastnameTextField.delegate = self.addContactViewModel;
    self.emailTextField.delegate    = self.addContactViewModel;
    
    @weakify(self) 
    
    [self.addContactViewModel.readyCommand.executionSignals subscribeNext: ^(RACSignal* signal) {
        
        [signal subscribeCompleted:^{
            
            @strongify(self)
            
            [self.navigationController popViewControllerAnimated: YES];
            
        }];
        
    }];
    
    [self.addContactViewModel.readyCommand.errors subscribeNext: ^(NSError* error) {
        
        UIAlertController* errorAlert = [UIAlertController alertControllerWithTitle: @"Ошибка"
                                                                            message: error.localizedDescription
                                                                     preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction* action = [UIAlertAction actionWithTitle: @"Попробуйте еще раз"
                                                         style: UIAlertActionStyleDefault
                                                       handler: nil];
        [errorAlert addAction: action];
        
        [self presentViewController: errorAlert
                           animated: YES
                         completion: nil];

        
    }];
    
    //связь кнопки и команды, которая за нее отвечает
    self.readyBtn.rac_command = self.addContactViewModel.readyCommand;
    
    // Show warning about incorrect email value
    __weak typeof(self) blockSelf = self;
    
    self.addContactViewModel.showValidEmailWarning = ^( NSString* text){
        
        blockSelf.emailLabel.text = text;
        
    };
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
    subTitleLabel.text            = @"УЧАСТНИКА";
    
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

- (void) prepareForSegue: (UIStoryboardSegue*) segue
                  sender: (id)                 sender
{
    [super prepareForSegue: segue
                    sender: sender];
    
    
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


#pragma mark - RolesViewControllerDelegate methods -

- (void) didSelectRole: (ProjectRoles*) value
{
    self.roleLabel.text             = value.title;
    self.addContactViewModel.roleID = value.sort;
}

//- (void) didSelectRole: (ProjectRoleType*) value
//{
//    self.roleLabel.text             = value.title;
//    self.addContactViewModel.roleID = value.roleTypeID;
//}

- (void) tableView: (UITableView*)     tableView
   willDisplayCell: (UITableViewCell*) cell
 forRowAtIndexPath: (NSIndexPath*)     indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector: @selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset: UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector: @selector(setPreservesSuperviewLayoutMargins:)])
    {
        [cell setPreservesSuperviewLayoutMargins: NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector: @selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins: UIEdgeInsetsZero];
    }
}

@end
