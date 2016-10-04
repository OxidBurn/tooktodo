//
//  RoomLevelMapModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 10/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import <JSONModel/JSONModel.h>

// Classes
#import "TaskMapContourModel.h"

@interface RoomLevelMapModel : JSONModel

@property (strong, nonatomic) id<Optional> marker;
@property (strong, nonatomic) NSArray<TaskMapContourModel, Optional>* mapContours;
@property (strong, nonatomic) NSNumber* hasMarkers;
@property (strong, nonatomic) NSNumber* mapId;
@property (strong, nonatomic) NSString* originalImage;
@property (strong, nonatomic) NSNumber* originalImageWidth;
@property (strong, nonatomic) NSNumber* originalImageHeight;
@property (strong, nonatomic) NSString* previewImage;

@end
