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
    
    NSString *name = dict[@"name"];
    GLfloat *position = [self getFloatArray:dict[@"position"]];
    GLfloat *rotation = [self getFloatArray:dict[@"rotation"]];
    GLfloat *scaling = [self getFloatArray:dict[@"scaling"]];
    
    GLfloat *vertices = [self getFloatArray:dict[@"vertices"]];
    GLfloat *normals = [self getFloatArray:dict[@"normals"]];
    GLfloat *textures = [self getFloatArray:dict[@"textures"]];
    NSArray *jsonIndices = dict[@"indices"];
    GLuint *indices = [self getIntArray:jsonIndices];
    GLuint indicesCount = (GLuint)[jsonIndices count];
    
    return [[Mesh alloc] initWithName:name position:position rotation:rotation scaling:scaling vertices:vertices normals:normals textures:textures indices:indices indicesCount:indicesCount];
}

+ (GLfloat *)getFloatArray:(NSArray *)jsonArray {
    NSUInteger arrayCount = [jsonArray count];
    GLfloat *floatArray = (GLfloat *)malloc(sizeof(GLfloat) * arrayCount);
    for (int i = 0; i < arrayCount; i++) {
        floatArray[i] = [jsonArray[i] floatValue];
    }
    return floatArray;
}

+ (GLuint *)getIntArray:(NSArray *)jsonArray {
    NSUInteger arrayCount = [jsonArray count];
    GLuint *intArray = (GLuint *)malloc(sizeof(GLuint) * arrayCount);
    for (int i = 0; i < arrayCount; i++) {
        intArray[i] = [jsonArray[i] unsignedIntValue];
    }
    return intArray;
}

@end
