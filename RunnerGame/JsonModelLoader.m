//
//  JsonModelLoader.m
//  RunnerGame
//
//  Created by Admin on 01.12.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "JsonModelLoader.h"


@implementation JsonModelLoader

+ (Mesh *)loadFromFile:(NSString *)filename {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:filename ofType:@"jm"]] options:kNilOptions error:nil];
    NSArray *position = dict[@"position"];
    NSArray *rotation = dict[@"rotation"];
    NSArray *scaling = dict[@"scaling"];
    
    NSArray *vertices = dict[@"vertices"];
    NSArray *normals = dict[@"normals"];
    NSArray *textures = dict[@"textures"];
    NSArray *indices = dict[@"indices"];
    
    NSString *mName = dict[@"name"];
    GLfloat *mPosition = (GLfloat *)malloc(sizeof(GLfloat) * 3);
    GLfloat *mRotation = (GLfloat *)malloc(sizeof(GLfloat) * 3);
    GLfloat *mScaling = (GLfloat *)malloc(sizeof(GLfloat) * 3);
    
    for (int i = 0; i < 3; i++) {
        mPosition[i] = [position[i] floatValue];
        mRotation[i] = [rotation[i] floatValue];
        mScaling[i] = [scaling[i] floatValue];
    }
    
    NSUInteger verticesCount = [vertices count];
    GLfloat *mVertices = (GLfloat *)malloc(sizeof(GLfloat) * verticesCount);
    for (int i = 0; i < verticesCount; i++) {
        mVertices[i] = [vertices[i] floatValue];
    }
    
    NSUInteger normalsCount = [normals count];
    GLfloat *mNormals = (GLfloat *)malloc(sizeof(GLfloat) * normalsCount);
    for (int i = 0; i < normalsCount; i++) {
        mNormals[i] = [normals[i] floatValue];
    }
    
    NSUInteger texturesCount = [textures count];
    GLfloat *mTextures = (GLfloat *)malloc(sizeof(GLfloat) * texturesCount);
    for (int i = 0; i < texturesCount; i++) {
        mTextures[i] = [textures[i] floatValue];
    }
    
    GLuint mIndicesCount = (GLuint)[indices count];
    GLuint *mIndices = (GLuint *)malloc(sizeof(GLuint) * mIndicesCount);
    for (int i = 0; i < mIndicesCount; i++) {
        mIndices[i] = [indices[i] unsignedIntValue];
    }
    return [[Mesh alloc] initWithName:mName position:mPosition rotation:mRotation scaling:mScaling vertices:mVertices normals:mNormals textures:mTextures indices:mIndices indicesCount:mIndicesCount];
}

@end
