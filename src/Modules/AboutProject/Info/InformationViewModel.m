//
//  InformationViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 02.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "InformationViewModel.h"

// Classes
#import "AboutProjectModel.h"
#import "AboutProjectCellsFactory.h"

typedef NS_ENUM(NSUInteger, SectionNumber) {
    
    SectionOne,
    SectionTwo,
    SectionThree,
    
};

@interface InformationViewModel()

// properties
@property (strong, nonatomic) AboutProjectModel* model;

@end

@implementation InformationViewModel

#pragma mark - Properties -

- (AboutProjectModel*) model
{
    if ( _model == nil )
    {
        _model = [AboutProjectModel new];
    }
    
    return _model;
}

#pragma mark - Table view datasource methods -

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return [self.model getNumberOfSections];
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return [self.model getNumberOfRowsForSection: section];
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    UITableViewCell* cell = [UITableViewCell new];
    
    AboutProjectCellsFactory* factory = [AboutProjectCellsFactory new];
    
    NSString* cellTitle = [self.model getCellTitleForIndexPath: indexPath];
    
    NSString* cellDetail = [self.model getCellDetailForIndexPath: indexPath];
    
    switch ( indexPath.section )
    {
        case SectionOne:
        case SectionTwo:
        {
            cell = [factory returnRightDetailCellWithTitle: cellTitle
                                                withDetail: cellDetail
                                              forTableView: tableView];
        }
            
            break;
        
        case SectionThree:
        {
            cell = [factory returnRightDetailCellWithTitle: cellTitle
                                                withDetail: cellDetail
                                              forTableView: tableView];
//            cell = [factory returnMapViewCellWithTitle: cellTitle
//                                       withCoordinates: cellDetail
//                                          forTableView: tableView];
        }
            
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

#pragma mark - TableView Delegate methods -

//- (CGFloat)             tableView: (UITableView*) tableView
//estimatedHeightForHeaderInSection: (NSInteger)    section
//{
//    if (section == 0)
//    {
//        return 0;
//    }
//    else
//    {
//        return 1.f;
//    }
//}

#pragma mark - Public -

- (void) updateProjectInfo
{
    [self.model updateProjectInfo];
}

@end
