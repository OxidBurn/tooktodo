//
//  CustomTabBar.m
//  TookTODO
//
//  Created by Nikolay Chaban on 17.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "CustomTabBar.h"

typedef NS_ENUM(NSUInteger, ButtonTag) {
    
    FeedTabButton         = 0,
    TaskTabButton         = 1,
    AddTabButton          = 2,
    DocumentsTabButton    = 3,
    TeamTabButton         = 4,
    TasksOnPlanTabButton  = 5,
    AboutProjectTabButton = 6,
    
};

@interface CustomTabBar()

// properties

@property (strong, nonatomic) UIView* grayView;

@property (strong, nonatomic) UILongPressGestureRecognizer* tasksLongTapGesture;

@property (strong, nonatomic) UILongPressGestureRecognizer* teamLongTapGesture;

@property (strong, nonatomic) UILongPressGestureRecognizer* tasksOnPlanLongTapGesture;

@property (strong, nonatomic) UILongPressGestureRecognizer* aboutProjectLongTapGesture;

@property (strong, nonatomic) NSArray* items;

@property (strong, nonatomic) NSArray* selectedControllerID;

@property (assign, nonatomic) NSUInteger tappedButtonTag;

@property (assign, nonatomic) NSUInteger choosenButtonTag;

// outlets

@property (weak, nonatomic) IBOutlet UIButton* feedTab;

@property (weak, nonatomic) IBOutlet UIButton* tasksTab;

@property (weak, nonatomic) IBOutlet UIButton* addTab;

@property (weak, nonatomic) IBOutlet UIButton* documentsTab;

@property (weak, nonatomic) IBOutlet UIButton* teamTab;

@property (weak, nonatomic) IBOutlet UIButton* tasksOnPlanTab;

@property (weak, nonatomic) IBOutlet UIButton* aboutProjectTab;

// methods

- (IBAction) didSelectedFeed: (UIButton*) sender;

- (void) createGesrures;

@end

@implementation CustomTabBar

#pragma mark - Initialization -

- (instancetype) initWithCoder: (NSCoder*) aDecoder
{
    if ( self = [super initWithCoder: aDecoder] )
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self didSelectFirstMenuItem];
            
            [self createGesrures];
            
        });
    }
    
    return self;
}

#pragma mark - Properties -

- (NSArray*) items
{
    if ( _items == nil )
    {
        _items = @[self.feedTab,
                   self.tasksTab,
                   self.addTab,
                   self.documentsTab,
                   self.teamTab,
                   self.tasksOnPlanTab,
                   self.aboutProjectTab];
    }
    
    return _items;
}

- (NSArray*) selectedControllerID
{
    if ( _selectedControllerID == nil )
    {
        _selectedControllerID = @[@"ShowFeeds",
                                  @"ShowTasks",
                                  @"",
                                  @"ShowDocuments",
                                  @"ShowTeamInfoID",
                                  @"",
                                  @"ShowAboutProject"];
    }
    
    return _selectedControllerID;
}

#pragma mark - Public methods -

- (void) didSelectFirstMenuItem
{
    [self didSelectedFeed: self.feedTab];
}


#pragma mark - Internal methods -

- (void) updateSelectedItem: (NSUInteger) index
{
    [self.items enumerateObjectsUsingBlock: ^(UIButton*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.selected = (idx == index);
        
    }];
    
    NSString* showedControllerID = self.selectedControllerID[index];
    
    //TODO: Delete second expression, when add button controller will be done
    if ( [self.delegate respondsToSelector: @selector(showControllerWithSegueID:)] && showedControllerID.length > 0 )
        [self.delegate showControllerWithSegueID: showedControllerID];
}

#pragma mark - Actions -

- (IBAction) didSelectedFeed: (UIButton*) sender
{
    [self updateSelectedItem: sender.tag];
    
    NSLog(@"didSelectedFeed");
}

- (IBAction) didSelectedTasks: (UIButton*) sender
{
   [self updateSelectedItem: sender.tag];
    
    if (self.grayView)
    {
        [self dismissGrayView];
    }
    
    NSLog(@"didSelectedTasks");
}

- (IBAction) didSelectedAdd: (UIButton*) sender
{
    
    [self updateSelectedItem: sender.tag];
    
    NSLog(@"didSelectedAdd");
}

- (IBAction) didSelectedDocuments: (UIButton*) sender
{
    [self updateSelectedItem: sender.tag];
    
    NSLog(@"didSelectedDocuments");
}

- (IBAction) didSelectedTeam: (UIButton*) sender
{
    [self updateSelectedItem: sender.tag];
    
    if (self.grayView)
    {
        [self dismissGrayView];
    }
    
    NSLog(@"didSelectedTeam");
}

//actions for new buttons
- (IBAction) didSelectTasksOnPlan: (UIButton*) sender
{
   // [self updateSelectedItem: sender.tag];
    
    if (self.grayView)
    {
        [self dismissGrayView];
    }
    
    
    NSLog(@"didSelectTasksOnPlan");
}


- (IBAction) didSelectProjectInfo: (UIButton*) sender
{
   // [self updateSelectedItem: sender.tag];
    
    if (self.grayView)
    {
        [self dismissGrayView];
    }
    
    NSLog(@"didSelectProjectInfo");
}

#pragma mark - Helpers -

- (void) createGesrures
{
    //hiding buttons, later could be done in storyboard
    self.tasksOnPlanTab.hidden  = YES;
    self.aboutProjectTab.hidden = YES;
    
    if ( self.tasksLongTapGesture == nil )
    {
        UILongPressGestureRecognizer* longPressForTasks = [[UILongPressGestureRecognizer alloc]
                                                            initWithTarget: self
                                                                    action: @selector(handleLongGestureForTasks:)];
        self.tasksLongTapGesture = longPressForTasks;
        
        [self.tasksTab addGestureRecognizer: longPressForTasks];
        
    }
    
    if ( self.teamLongTapGesture == nil)
    {
    UILongPressGestureRecognizer* longPressForTeam = [[UILongPressGestureRecognizer alloc]
                                                        initWithTarget: self
                                                                action: @selector(handleLongGestureForTeam:)];
        self.teamLongTapGesture = longPressForTeam;
    
    [self.teamTab addGestureRecognizer: longPressForTeam];
    }
    
    if ( self.tasksOnPlanLongTapGesture == nil )
    {
        UILongPressGestureRecognizer* longPressForTasksOnPlan = [[UILongPressGestureRecognizer alloc] initWithTarget: self
                                                                                                              action: @selector(handleLongGestureForTasksOnPlan:)];
        self.tasksOnPlanLongTapGesture = longPressForTasksOnPlan;
        
        [self.tasksOnPlanTab addGestureRecognizer: longPressForTasksOnPlan];
    }
    
    if ( self.aboutProjectLongTapGesture == nil)
    {
        UILongPressGestureRecognizer* longPressForAboutProject = [[UILongPressGestureRecognizer alloc] initWithTarget: self
                                                                                                               action: @selector(handleLongGestureForAboutProject:)];
        
        self.aboutProjectLongTapGesture = longPressForAboutProject;
        
        [self.aboutProjectTab addGestureRecognizer: longPressForAboutProject];
    }
}



// methods that handle gestures

- (void) handleLongGestureForTasks: (UILongPressGestureRecognizer*) longTap
{
    UIImage* btnBackgroundImage = [UIImage imageNamed: @"TasksOnThePlan"];

    [self putButtonOnGrayView: self.tasksOnPlanTab
                  aboveButton: self.tasksTab
                    withImage: btnBackgroundImage
                  withGesture: self.tasksLongTapGesture];
    
    NSLog(@"Tasks long tap gesture called");

}

- (void) handleLongGestureForTeam: (UILongPressGestureRecognizer*) longTap
{
    UIImage* btnBackgroundImage = [UIImage imageNamed: @"AboutProject"];

    [self putButtonOnGrayView: self.aboutProjectTab
                  aboveButton: self.teamTab
                    withImage: btnBackgroundImage
                  withGesture: self.teamLongTapGesture];
    
    NSLog(@"Tema long tap gesture called");

}

- (void) handleLongGestureForTasksOnPlan: (UILongPressGestureRecognizer*) longTap
{
    UIImage* btnBackgroundImage = [UIImage imageNamed: @"Tasks"];
    
    [self putButtonOnGrayView: self.tasksTab
                  aboveButton: self.tasksOnPlanTab
                    withImage: btnBackgroundImage
                  withGesture: self.tasksOnPlanLongTapGesture];
    
    NSLog(@"Tasks on plan long tap gesture called");
}

- (void) handleLongGestureForAboutProject: (UILongPressGestureRecognizer*) longTap
{
    UIImage* btnBackgroundImage = [UIImage imageNamed: @"Team"];
    
    [self putButtonOnGrayView: self.teamTab
                  aboveButton: self.aboutProjectTab
                    withImage: btnBackgroundImage
                  withGesture: self.aboutProjectLongTapGesture];
    
    NSLog(@"About project long tap gesture called");
}



// method that creates gray view with temp button
// temp button will be created above button on tabbar which we want to change and dealloc after user select it
// after selecting temp button we switch buttons on tab bar: one becomes hiddes, and the other - not

- (void) putButtonOnGrayView: (UIButton*) button
                 aboveButton: (UIButton*) tappedButton
                   withImage: (UIImage*)  image
                 withGesture: (UILongPressGestureRecognizer*) gesture
{
    UIButton* buttonOnGrayView = [UIButton buttonWithType: UIButtonTypeCustom];
    
    if ( gesture.state == UIGestureRecognizerStateBegan )
    {
        
        if (self.grayView == nil)
        {
            CGRect tappedButtonFrame = tappedButton.frame;
            
            self.grayView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, CGRectGetWidth(self.superview.frame), CGRectGetHeight(self.superview.frame) - CGRectGetHeight(self.frame))];
            
            self.grayView.backgroundColor = [UIColor colorWithRed:0.149 green:0.176 blue:0.216 alpha:0.8];
            
            [self.superview addSubview: self.grayView];
            
            CGRect buttonRect = CGRectMake (tappedButtonFrame.origin.x,
                                            CGRectGetHeight(self.superview.frame) - CGRectGetHeight(self.frame) - 80,
                                            CGRectGetWidth(tappedButtonFrame),
                                            CGRectGetHeight(tappedButtonFrame));
            
            [buttonOnGrayView setFrame: buttonRect];
            
            [buttonOnGrayView setImage: image
                              forState: UIControlStateNormal];
            
            self.tappedButtonTag = tappedButton.tag;
            
            self.choosenButtonTag = button.tag;
            
            [buttonOnGrayView addTarget: self
                                 action: @selector(didSelectButtonOnGrayViewAboveButton)
                       forControlEvents: UIControlEventTouchUpInside];
            
            [self.grayView addSubview: buttonOnGrayView];
            
            
            NSLog(@"Gesture began");
            
        }
    }
}

- (void) didSelectButtonOnGrayViewAboveButton
{
    [self switchButtonForTag: self.tappedButtonTag];
    
    [self dismissGrayView];
    
    [self updateSelectedItem: self.choosenButtonTag];
    
    self.tappedButtonTag = -1;
    
    self.choosenButtonTag = -1;
    
    NSLog(@"Did select button on gray view");
}


#pragma mark - Helpers -

- (void) dismissGrayView
{
    [self.grayView removeFromSuperview];
    self.grayView = nil;
}

- (void) switchButtonForTag: (NSUInteger) buttonsTag
{
    switch ( buttonsTag )
    {
        case TaskTabButton:
            
            self.tasksTab.hidden       = YES;
            self.tasksOnPlanTab.hidden = NO;
            
            NSLog(@"Switched tasks to tasks on plan");
            
            
            break;
            
        case TasksOnPlanTabButton:
            
            self.tasksTab.hidden       = NO;
            self.tasksOnPlanTab.hidden = YES;
            
            NSLog(@"Switched tasks on plan to tasks");
            
            break;
            
        case TeamTabButton:
            
            self.teamTab.hidden         = YES;
            self.aboutProjectTab.hidden = NO;
            
            NSLog(@"Switched team to about projects");
            
            break;
            
        case AboutProjectTabButton:
            
            self.teamTab.hidden         = NO;
            self.aboutProjectTab.hidden = YES;
            
            NSLog(@"Switched about projects to team");

            break;
            
        default:
            break;
    }
}


@end
