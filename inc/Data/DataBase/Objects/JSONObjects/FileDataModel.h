//
//  FileDataModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 11/17/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface FileDataModel : JSONModel

@property (nonatomic, strong) NSString* extension;
@property (nonatomic, strong) NSString* virtualPath;
@property (nonatomic, strong) NSString* downloadPath;
@property (nonatomic, strong) NSNumber* fileSize;
@property (nonatomic, strong) NSString* mimeType;
@property (nonatomic, strong) NSNumber* fileType;

@end
