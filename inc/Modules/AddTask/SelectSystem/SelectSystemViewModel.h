//
//  SelectSystemViewModel.h
//  TookTODO
//
//  Created by Lera on 30.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

//Classes
#import "ProjectSystem+CoreDataClass.h"

@interface SelectSystemViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

//Methods
- (ProjectSystem*) getSelectedSystem;

- (void) fillSelectedSystem: (ProjectSystem*) system;

@end
