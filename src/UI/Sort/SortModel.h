//
//  SortModel.h
//  TookTODO
//
//  Created by Глеб on 23.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;


typedef NS_ENUM (NSUInteger, SortDataType) {
    
    AllProgects,
};

@interface SortModel : NSObject <UITableViewDelegate, UITableViewDataSource>

- (CGSize) returnPopoverSizeForDataType: (SortDataType) dataType;

@end
