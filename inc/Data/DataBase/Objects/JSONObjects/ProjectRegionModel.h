//
//  ProjectRegion.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ProjectRegionModel : JSONModel

@property (nonatomic, strong) NSString* regionID;

@property (nonatomic, strong) NSString* name;

@end
