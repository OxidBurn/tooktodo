//
//  InformationViewModel.h
//  TookTODO
//
//  Created by Lera on 02.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "ProjectInfo+CoreDataClass.h"

@interface InformationViewModel : NSObject <UITableViewDataSource, UITableViewDelegate>

- (void) updateProjectInfo;

@end
