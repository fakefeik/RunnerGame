//
//  Mesh.h
//  RunnerGame
//
//  Created by Admin on 01.12.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface Mesh : NSObject {
    @protected
    NSString *_name;
    GLfloat *_position;
    GLfloat *_rotation;
    GLfloat *_scaling;
    
    GLfloat *_vertices;
    GLfloat *_normals;
    GLfloat *_textures;
    GLuint *_indices;
    GLuint _indicesCount;
    GLuint *_linesIndices;
    GLuint _linesIndicesCount;
    GLuint _textureId;
    
    GLKMatrix4 mModelMatrix;
    GLKMatrix4 mMVPMatrix;
}

- (id)initWithName:(NSString *)name position:(GLfloat *)position rotation:(GLfloat *)rotation scaling:(GLfloat *)scaling vertices:(GLfloat *)vertices normals:(GLfloat *)normals textures:(GLfloat *)textures indices:(GLuint *)indices indicesCount:(GLuint)indicesCount;

- (void)loadTexture:(NSString *)name;

- (void)drawWithHandles:(NSDictionary *)handles viewMatrix:(GLKMatrix4)viewMatrix projectionMatrix:(GLKMatrix4)projectionMatrix;

- (void)drawWireframeWithHandles:(NSDictionary *)handles viewMatrix:(GLKMatrix4)viewMatrix projectionMatrix:(GLKMatrix4) projectionMatrix;

// This should've been protected
- (void)setLineIndices;

@property GLfloat *position;
@property GLfloat *rotation;
@property GLfloat *scaling;

@end
