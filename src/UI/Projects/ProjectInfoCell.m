//
//  ProjectInfoCell.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ProjectInfoCell.h"

@interface ProjectInfoCell()

// properties

@property (weak, nonatomic) IBOutlet UILabel  *projectTitle;
@property (weak, nonatomic) IBOutlet UILabel  *projectDetail;
@property (weak, nonatomic) IBOutlet UILabel  *lastSyncDateLabel;

@property (strong, nonatomic) NSNumber* projectID;

// methods

- (IBAction) onSyncProject: (UIButton*) sender;

@end

@implementation ProjectInfoCell

#pragma mark - Public methods -

- (void) fillContent: (ProjectInfo*) info
{
    self.projectTitle.text  = info.title;
    self.projectDetail.text = [NSString stringWithFormat: @"%@ %@ %@", (info.street) ? info.street : @"", (info.building) ? info.building : @"", (info.apartment) ? info.apartment : @""];
    
    self.projectID = info.projectID;
}


#pragma mark - Actions -

- (IBAction) onSyncProject: (UIButton*) sender
{
    if ( self.didSelectedProject )
    {
        self.didSelectedProject(self.projectID);
    }
}

@end
