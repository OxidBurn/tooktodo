//
//  CustomTabBarIPad.m
//  TookTODO
//
//  Created by Глеб on 21.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "CustomTabBarIPad.h"

typedef NS_ENUM(NSUInteger, ButtonTag) {
    
    FeedTabButton         = 0,
    TaskTabButton         = 1,
    TasksOnPlanTabButton  = 2,
    DocumentsTabButton    = 3,
    TeamTabButton         = 4,
    AboutProjectTabButton = 5,
    AddTabButton          = 6,
    
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
    if (!isReplaced)
    {
        isReplaced = YES;
        
        CustomTabBarIPad* replaced = [[[NSBundle mainBundle] loadNibNamed: @"TabBarForIPad"
                                                                    owner: nil
                                                                  options: nil] lastObject];
        
        replaced.frame                                     = self.frame;
        replaced.translatesAutoresizingMaskIntoConstraints = NO;

        return replaced;
    }
    
    isReplaced = NO;
    
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
                                  @"ShowAboutProjectID"];
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

#pragma mark - Internal methods -

- (void) updateSelectedItem: (NSUInteger) index
{
    [self.items enumerateObjectsUsingBlock: ^(UIButton*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.selected = (idx == index);
        
    }];
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
    
    NSLog(@"didSelectedTeam");
}

- (IBAction) didSelectTasksOnPlan: (UIButton*) sender
{
    [self updateSelectedItem: sender.tag];
    
    NSLog(@"didSelectTasksOnPlan");
}


- (IBAction) didSelectProjectInfo: (UIButton*) sender
{
    [self updateSelectedItem: sender.tag];
    
    NSLog(@"didSelectProjectInfo");
}

@end
