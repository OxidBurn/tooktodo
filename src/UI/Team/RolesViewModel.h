//
//  RolesViewModel.h
//  TookTODO
//
//  Created by Lera on 29.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RolesViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

- (NSString*) getSelectedItem;

@end
