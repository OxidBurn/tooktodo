//
//  TaskMarker.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface TaskMarkerModel : JSONModel

@property (assign, nonatomic) NSUInteger y;
@property (assign, nonatomic) NSUInteger x;
@property (assign, nonatomic) NSUInteger markerID;
@property (assign, nonatomic) NSUInteger roomLevelId;
@property (assign, nonatomic) NSUInteger mapId;

@end
