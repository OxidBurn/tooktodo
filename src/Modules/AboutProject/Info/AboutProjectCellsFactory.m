//
//  AboutProjectCellsFactory.m
//  TookTODO
//
//  Created by Глеб on 28.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AboutProjectCellsFactory.h"

// Classes
#import "AboutProjectMapCell.h"

static NSString* RightDetailcellID = @"InformationCellID";
static NSString* MapViewCellID     = @"AboutProjectMapCellId";

@interface AboutProjectCellsFactory()

// properties


// methods


@end

@implementation AboutProjectCellsFactory

#pragma mark - Public -

- (UITableViewCell*) returnMapViewCellWithTitle: (NSString*)    title
                                withCoordinates: (NSString*)    coordinates
                                   forTableView: (UITableView*) tableView
{
    AboutProjectMapCell* cell = [tableView dequeueReusableCellWithIdentifier: MapViewCellID];
    
    [cell fillCellWithTitle: title
            withCoordinates: coordinates];
    
    return cell;
}

- (UITableViewCell*) returnRightDetailCellWithTitle: (NSString*)    title
                                         withDetail: (NSString*)    detail
                                       forTableView: (UITableView*) tableView
                                      withIndexPath: (NSIndexPath*) indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: RightDetailcellID
                                                            forIndexPath: indexPath];
    
    UIFont* customFont = nil;
    
    UIFont* detailFont = nil;
    
    if ( indexPath.section == 0 && indexPath.row == 0 )
    {
        customFont = [UIFont fontWithName: @"SFUIText-Regular"
                                     size: 17.0f];
    }
    else
    {
        customFont = [UIFont fontWithName: @"SFUIText-Regular"
                                     size: 15.0f];
        detailFont = [UIFont fontWithName: @"SFUIText-Regular"
                                     size: 13.0f];
    }
    cell.detailTextLabel.font = detailFont;
    cell.textLabel.font       = customFont;
    
    cell.textLabel.text       = title;
    cell.detailTextLabel.text = detail;
    
    if ([detail isEqualToString: @"нет"])
    {
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    else
    {
        cell.detailTextLabel.textColor = [UIColor blackColor];
    }
    return cell;
}

@end
