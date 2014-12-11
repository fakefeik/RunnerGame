//
//  SimplePlane.m
//  RunnerGame
//
//  Created by Admin on 11.12.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "SimplePlane.h"

@implementation SimplePlane

- (id)initWithWidth:(float)width height:(float)height textureCoordinates:(int)coordinates {
    if (self = [super init]) {
        width /= 2;
        height /= 2;
        _textures = (GLfloat *)malloc(sizeof(GLfloat) * 8);
        _textures[0] = 0.0f; _textures[1] = coordinates;
        _textures[2] = coordinates; _textures[3] = coordinates;
        _textures[4] = 0.0f; _textures[5] = 0.0f;
        _textures[6] = coordinates; _textures[7] = 0.0f;
        
        _indices = (GLuint *)malloc(sizeof(GLuint) * 6);
        _indices[0] = 0; _indices[1] = 1; _indices[2] = 2;
        _indices[3] = 1; _indices[4] = 3; _indices[5] = 2;
        _indicesCount = 6;
        
        _vertices = (GLfloat *)malloc(sizeof(GLfloat) * 12);
        _vertices[0] = -width; _vertices[1] = -height; _vertices[2] = 0.0f;
        _vertices[3] = width; _vertices[4] = -height; _vertices[5] = 0.0f;
        _vertices[6] = -width; _vertices[7] = height; _vertices[8] = 0.0f;
        _vertices[9] = width; _vertices[10] = height; _vertices[11] = 0.0f;
        
        [self setLineIndices];
        
        _position = (GLfloat *)malloc(sizeof(GLfloat) * 3);
        _rotation = (GLfloat *)malloc(sizeof(GLfloat) * 3);
        _scaling = (GLfloat *)malloc(sizeof(GLfloat) * 3);
        _position[0] = _position[1] = _position[2] = 0;
        _rotation[0] = _rotation[1] = _rotation[2] = 0;
        _scaling[0] = _scaling[1] = _scaling[2] = 1;
        
    }
    return self;
}

@end
