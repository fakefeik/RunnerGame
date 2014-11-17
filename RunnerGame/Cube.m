//
//  Cube.m
//  RunnerGame
//
//  Created by Admin on 17.11.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "Cube.h"

@implementation Cube

- (id)init {
    if (self == [super init]) {
        const GLfloat height = 1;
        const GLfloat width = 1;
        const GLfloat depth = 1;
        
        GLfloat vertices[] = {
            -width, -height, -depth,
            width, -height, -depth,
            width, height, -depth,
            -width, height, -depth,
            -width, -height, depth,
            width, -height, depth,
            width, height, depth,
            -width, height, depth
            
        };
        
        GLuint indices[] = {
            0, 4, 5,
            0, 5, 1,
            1, 5, 6,
            1, 6, 2,
            2, 6, 7,
            2, 7, 3,
            3, 7, 4,
            3, 4, 0,
            4, 7, 6,
            4, 6, 5,
            3, 0, 1,
            3, 1, 2
        };
        [self setVertices:vertices];
        self.indices = indices;
    }
    return self;
}

@end
