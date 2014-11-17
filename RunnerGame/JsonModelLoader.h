//
//  JsonModelLoader.h
//  RunnerGame
//
//  Created by Admin on 17.11.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mesh.h"

@interface JsonModelLoader : NSObject

+ (Mesh *)load:(NSString *)file;

@end
