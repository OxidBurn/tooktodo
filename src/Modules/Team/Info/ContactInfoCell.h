//
//  ContactInfoCell.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/6/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactInfoCell : UITableViewCell

// methods

- (void) fillCellWithContactInfo: (NSString*)    contactValue
                    withBtnImage: (UIImage*)     btnImage
                    forIndexPath: (NSIndexPath*) indexPath;
@end
