//
//  CustomTabBarIPad.m
//  TookTODO
//
//  Created by Глеб on 21.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "CustomTabBarIPad.h"

// Classes
#import "ProjectsControllersDelegate.h"

typedef NS_ENUM(NSUInteger, ButtonTag) {
    
    FeedTabButton         = 0,
    TaskTabButton         = 1,
    AddTabButton          = 2,
    DocumentsTabButton    = 3,
    TeamTabButton         = 4,
    TasksOnPlanTabButton  = 5,
    AboutProjectTabButton = 6,
    
};

static BOOL isReplaced = NO;

@interface CustomTabBarIPad()

// outlets

@property (weak, nonatomic) IBOutlet UIButton* feedTab;

@property (weak, nonatomic) IBOutlet UIButton* tasksTab;

@property (weak, nonatomic) IBOutlet UIButton* addTab;

@property (weak, nonatomic) IBOutlet UIButton* documentsTab;

@property (weak, nonatomic) IBOutlet UIButton* teamTab;

@property (weak, nonatomic) IBOutlet UIButton* tasksOnPlanTab;

@property (weak, nonatomic) IBOutlet UIButton* aboutProjectTab;

@property (weak, nonatomic) IBOutlet UIButton* menuBtn;


// properties

@property (strong, nonatomic) NSArray* items;

@property (strong, nonatomic) NSArray* selectedControllerID;

@property (assign, nonatomic) NSUInteger tappedButtonTag;

@property (assign, nonatomic) NSUInteger choosenButtonTag;

// methods


@end

@implementation CustomTabBarIPad


#pragma mark - Initialization -

- (id) awakeAfterUsingCoder: (NSCoder*) aDecoder
{
    if ( isReplaced )
    {
        [DefaultNotifyCenter addObserver: self
                                selector: @selector(updateMainMenuSelectedState:)
                                    name: @"UpdateiPadMainMenuState"
                                  object: nil];
        
        return self;
    }
    else
    {
        isReplaced = YES;
        
        NSArray* views = [[NSBundle mainBundle] loadNibNamed: @"TabBarForIPad"
                                                       owner: nil
                                                     options: nil];
        
        CustomTabBarIPad* replaced = [views lastObject];
        
        replaced.frame                                     = self.frame;
        replaced.translatesAutoresizingMaskIntoConstraints = NO;
        
        isReplaced = NO;

        return replaced;
    }
}


#pragma mark - Memory managment -

- (void) dealloc
{
    [DefaultNotifyCenter removeObserver: self
                                   name: @"UpdateiPadMainMenuState"
                                 object: nil];
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
                                  @"ShowAboutProjectIDiPad"];
    }
    
    return _selectedControllerID;
}

#pragma mark - Public methods -

- (void) didSelectFirstMenuItem
{
    [self didSelectedFeed: self.feedTab];
}

- (void) setSelectedItemAtIndex: (NSUInteger) index
{
    [self.items enumerateObjectsUsingBlock: ^(UIButton*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.selected = (idx == index);
        
    }];
}

- (void) updateMainMenuSelectedState: (NSNotification*) notification
{
    NSNumber* selectedStateInObject = notification.object;
    
    self.menuBtn.selected = selectedStateInObject.boolValue;
}

#pragma mark - Internal methods -

- (void) updateSelectedItem: (NSUInteger) index
{
    [self.items enumerateObjectsUsingBlock: ^(UIButton*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.selected = (idx == index);
        
    }];
    
    [super setSelectedItemAtIndex: index];
}

#pragma mark - Actions -

- (IBAction) didSelectMenu: (UIButton*) sender
{
    if ( sender.selected )
    {
        if ( [self.delegate respondsToSelector: @selector(hideMainMenu)] )
        {
            [self.delegate hideMainMenu];
        }
    }
    else
    {
        if ( [self.delegate respondsToSelector: @selector(showMainMenu)] )
        {
            [self.delegate showMainMenu];
        }
    }
}

- (IBAction) didSelectedFeed: (UIButton*) sender
{
    [self updateSelectedItem: sender.tag];
}

- (IBAction) didSelectedTasks: (UIButton*) sender
{
    [self updateSelectedItem: sender.tag];
}

- (IBAction) didSelectedAdd: (UIButton*) sender
{
    [self updateSelectedItem: sender.tag];
}

- (IBAction) didSelectedDocuments: (UIButton*) sender
{
    [self updateSelectedItem: sender.tag];
}

- (IBAction) didSelectedTeam: (UIButton*) sender
{
    [self updateSelectedItem: sender.tag];
}

- (IBAction) didSelectTasksOnPlan: (UIButton*) sender
{
    [self updateSelectedItem: sender.tag];
}

- (IBAction) didSelectProjectInfo: (UIButton*) sender
{
    [self updateSelectedItem: sender.tag];
}

@end
