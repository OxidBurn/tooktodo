//
//  MainTabBar.m
//  TookTODO
//
//  Created by Nikolay Chaban on 10/25/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "MainTabBar.h"

@interface MainTabBar()

// properties

@property (strong, nonatomic) NSArray* selectedControllerID;

// methods


@end

@implementation MainTabBar


#pragma mark - Properties -

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


#pragma mark - Public actions -

- (void) didSelectFirstMenuItem
{
    
}

- (void) setSelectedItemAtIndex: (NSUInteger) index
{
    NSString* showedControllerID = self.selectedControllerID[index];
    
    //TODO: Delete second expression, when add button controller will be done
    if ( [self.delegate respondsToSelector: @selector(showControllerWithSegueID:)] && showedControllerID.length > 0 )
        [self.delegate showControllerWithSegueID: showedControllerID];
}

@end
