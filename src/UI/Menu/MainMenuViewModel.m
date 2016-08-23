//
//  MainMenuViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "MainMenuViewModel.h"
#import "MainMenuModel.h"
#import "MenuProjectCell.h"
#import "ProjectInfo.h"


@interface MainMenuViewModel()

// properties

@property (strong, nonatomic) MainMenuModel* model;

@property (nonatomic, strong) NSArray* projectsContent;

// methods


@end

@implementation MainMenuViewModel


#pragma mark - Properties -

- (MainMenuModel*) model
{
    if ( _model == nil )
    {
        _model = [MainMenuModel new];
    }
    
    return _model;
}


#pragma mark - Public methods -

- (NSString*) fullUserName
{
    return [self.model getFullUserName];
}

- (UIImage*) userAvatar
{
    return [self.model getUserAvatarImage];
}

- (RACSignal*) loadProjectsList
{
    return [self.model loadProjectsList];
}

- (void) updateProjectsContent
{
    self.projectsContent = [self.model getProjects];
}

#pragma mark - Commands -

- (RACCommand*) supportActionCommand
{
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
       
        return [RACSignal empty];
        
    }];
}

- (RACCommand*) reviewActionCommand
{
    return [[RACCommand alloc] initWithSignalBlock: ^RACSignal *(id input) {
       
        return [self.model sendReviewSignal];
        
    }];
}


#pragma mark - Table view data source methods -

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return 1;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return self.projectsContent.count;
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    MenuProjectCell* cell = (MenuProjectCell*)[tableView dequeueReusableCellWithIdentifier: @"ProjectCellID"];
    
    ProjectInfo* info = self.projectsContent[indexPath.row];
    
    [cell fillInfo: info];
    
    return cell;
}


#pragma mark - UITableView delegate methods -

- (void)       tableView: (UITableView*) tableView
 didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
}


@end
