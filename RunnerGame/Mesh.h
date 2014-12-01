//
//  Mesh.h
//  RunnerGame
//
//  Created by Admin on 01.12.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface Mesh : NSObject

- (id)initWithName:(NSString *)name position:(GLfloat *)position rotation:(GLfloat *)rotation scaling:(GLfloat *)scaling vertices:(GLfloat *)vertices normals:(GLfloat *)normals textures:(GLfloat *)textures indices:(GLuint *)indices indicesCount:(GLuint)indicesCount;

- (void)loadTexture:(NSString *)name;

- (void)drawWithHandles:(NSDictionary *)handles viewMatrix:(GLKMatrix4)viewMatrix projectionMatrix:(GLKMatrix4)projectionMatrix;

- (void)drawWireframeWithHandles:(NSDictionary *)handles viewMatrix:(GLKMatrix4)viewMatrix projectionMatrix:(GLKMatrix4) projectionMatrix;

@property GLfloat *position;
@property GLfloat *rotation;
@property GLfloat *scaling;

@end
