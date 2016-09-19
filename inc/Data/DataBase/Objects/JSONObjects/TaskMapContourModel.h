//
//  TaskMapContourModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface TaskMapContourModel : JSONModel

@property (strong, nonatomic) NSString   * geoJson;
@property (assign, nonatomic) NSUInteger mapContourID;
@property (strong, nonatomic) NSString   * previewImage;
@property (assign, nonatomic) NSUInteger roomId;

@end
