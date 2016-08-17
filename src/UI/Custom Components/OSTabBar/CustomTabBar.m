//
//  CustomTabBar.m
//  TookTODO
//
//  Created by Глеб on 17.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "CustomTabBar.h"

@interface CustomTabBar()

// propertie

@property (weak, nonatomic) IBOutlet UIButton* feedTab;

@property (weak, nonatomic) IBOutlet UIButton* tasksTab;

@property (weak, nonatomic) IBOutlet UIButton* addTab;

@property (weak, nonatomic) IBOutlet UIButton* documentsTab;

@property (weak, nonatomic) IBOutlet UIButton* teamTab;

@property (strong, nonatomic) NSArray* items;

@property (strong, nonatomic) NSArray* selectedControllerID;

// methods

- (IBAction) didSelectedFeed: (UIButton*) sender;

@end

@implementation CustomTabBar

#pragma mark - Properties -

- (NSArray*) items
{
    if ( _items == nil )
    {
        _items = @[self.feedTab,
                   self.tasksTab,
                   self.addTab,
                   self.documentsTab,
                   self.teamTab];
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
                                  @"ShowTeams"];
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

@end
