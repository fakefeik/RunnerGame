//
//  Mesh.m
//  RunnerGame
//
//  Created by Admin on 17.11.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "Mesh.h"

@implementation Mesh

- (id)init {
    if (self = [super init]) {
        self.x = 0;
        self.y = 0;
        self.z = 0;
        self.rx = 0;
        self.ry = 0;
        self.rz = 0;
        self.sx = 0;
        self.sy = 0;
        self.sz = 0;
        
    }
    return self;
}

- (void) setVertices:(GLfloat *)vertices {
    glGenBuffers(1, &verticesBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, verticesBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
}

- (void) setNormals:(GLfloat *)normals {
    glGenBuffers(1, &normalsBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, normalsBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(normals), normals, GL_STATIC_DRAW);
}

- (void) setTextures:(GLfloat *)textures {
    glGenBuffers(1, &texturesBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, texturesBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(textures), textures, GL_STATIC_DRAW);
}

- (void)draw {
    glDrawElements(GL_TRIANGLES, 36, GL_FLOAT, indices);
}

@synthesize x, y, z;
@synthesize rx, ry, rz;
@synthesize sx, sy, sz;

@synthesize indices;
@synthesize indicesCount;

@end
