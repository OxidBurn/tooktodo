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
#import "NSString+Utils.h"
#import "OSRightDetailCellFactory.h"

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
            if ( indexPath.row == 8)
            {
                cell = (OSRightDetailCell*)cell;

                OSRightDetailCellFactory* factory = [OSRightDetailCellFactory new];
                
                BOOL isSelected = [cellTitle isEqualToString: @"нет"] ? NO : YES;
                
                cell = [factory returnAboutProjectCommentCellWithComment: cellDetail
                                                       withSelectedState: isSelected
                                                            forTableView: tableView];
            }
            else
                cell = [factory returnRightDetailCellWithTitle: cellTitle
                                                    withDetail: cellDetail
                                                  forTableView: tableView
                                                 withIndexPath: indexPath];
        }
            
            break;
        
        case SectionThree:
        {
            cell = [factory returnMapViewCellWithTitle: cellTitle
                                       withCoordinates: cellDetail
                                          forTableView: tableView];
        }
            
            break;
            
        default:
            break;
    }
    
    [cell setSelectionStyle: UITableViewCellSelectionStyleNone];

    return cell;
}

- (CGFloat)    tableView: (UITableView*) tableView
heightForHeaderInSection: (NSInteger)    section
{
    CGFloat height = 0.f;
    
    if ( section == SectionOne )
        height = 0;
    else
        height = 10;
    
    return height;
}

- (CGFloat)   tableView: (UITableView*) tableView
heightForRowAtIndexPath: (NSIndexPath*) indexPath
{
    if ( indexPath.section == 1 && indexPath.row == 8 )
    {
        return [self.model countHeightForCommentCellWithWidth: tableView.frame.size.width/2];
    }
    else
        if (indexPath.section == 0 || indexPath.section == 1)
        {
            return 43;
        }
        else
            if ( indexPath.section == 2)
            {
                return 160.f;
            }
    return 0;
}

- (UIView*)  tableView: (UITableView*) tableView
viewForHeaderInSection: (NSInteger)    section
{
    CGRect rect = CGRectMake(0, 0, CGRectGetMaxX(tableView.frame), 10);
    
    UIView* view = [[UIView alloc] initWithFrame: rect];
    
    view.backgroundColor = [UIColor colorWithRed: 230.0/256
                                           green: 232.0/256
                                            blue: 234.0/256
                                           alpha: 1.f];
    
    return view;
}
#pragma mark - TableView Delegate methods -


#pragma mark - Public -

- (void) updateProjectInfoWithCompletion: (CompletionWithSuccess) completion
{
    [self.model updateProjectInfoWithCompletion: completion];
}

@end
