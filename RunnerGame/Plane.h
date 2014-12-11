//
//  Plane.h
//  RunnerGame
//
//  Created by Admin on 11.12.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "Mesh.h"

@interface Plane : Mesh

- (id)init;
- (id)initWithWidth:(float)width height:(float)height widthSegments:(int)widthSegments heightSegments:(int)heightSegments;

@end
