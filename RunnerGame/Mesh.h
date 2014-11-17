//
//  Mesh.h
//  RunnerGame
//
//  Created by Admin on 17.11.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/glext.h>

@interface Mesh : NSObject {
    //GLfloat x, y, z;
    //GLfloat rx, ry, rz;
    //GLfloat sx, sy, sz;
    
    //GLfloat vertices[1];

@private
    GLuint verticesBuffer;
    GLuint normalsBuffer;
    GLuint texturesBuffer;
    
}

- (void)setVertices: (GLfloat*) vertices;
- (void)setNormals: (GLfloat*) normals;
- (void)setTextures: (GLfloat*) textures;
- (void)draw;

@property GLfloat x;
@property GLfloat y;
@property GLfloat z;

@property GLfloat rx;
@property GLfloat ry;
@property GLfloat rz;

@property GLfloat sx;
@property GLfloat sy;
@property GLfloat sz;

@property GLuint indicesCount;
@property GLuint* indices;

@end
