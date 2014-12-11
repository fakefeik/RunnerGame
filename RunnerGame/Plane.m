//
//  Plane.m
//  RunnerGame
//
//  Created by Admin on 11.12.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "Plane.h"

@implementation Plane

- (id)init {
    return [self initWithWidth:1 height:1 widthSegments:1 heightSegments:1];
}

- (id)initWithWidth:(float)width height:(float)height widthSegments:(int)widthSegments heightSegments:(int)heightSegments {
    if (self = [super init]) {
        _vertices = (GLfloat *)malloc(sizeof(GLfloat) * (widthSegments + 1) * (heightSegments + 1) * 3);
        _indices = (GLuint *)malloc(sizeof(GLuint) * (widthSegments + 1) * (heightSegments + 1) * 6);
        _indicesCount = (widthSegments + 1) * (heightSegments + 1) * 6;
        
        float xOffset = width / -2;
        float yOffset = height / -2;
        float xWidth = width / widthSegments;
        float yHeight = height / heightSegments;
        int currentVertex = 0;
        int currentIndex = 0;
        int w = widthSegments + 1;
        for (int y = 0; y < heightSegments + 1; y++)
            for (int x = 0; x < widthSegments + 1; x++) {
                _vertices[currentVertex] = xOffset + x * xWidth;
                _vertices[currentVertex + 1] = yOffset + y * yHeight;
                _vertices[currentVertex + 2] = 0;
                currentVertex += 3;
                int n = y * (widthSegments + 1) + x;
                if (y < heightSegments && x < widthSegments) {
                    _indices[currentIndex] = n;
                    _indices[currentIndex + 1] = n + 1;
                    _indices[currentIndex + 2] = n + w;
                    
                    _indices[currentIndex + 3] = n + 1;
                    _indices[currentIndex + 4] = n + 1 + w;
                    _indices[currentIndex + 5] = n + 1 + w - 1;
                    currentIndex += 6;
                }
            }
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
