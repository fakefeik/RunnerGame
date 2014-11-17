//
//  JsonModelLoader.m
//  RunnerGame
//
//  Created by Admin on 17.11.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "JsonModelLoader.h"

@implementation JsonModelLoader

+ (Mesh *) load:(NSString *)file {
    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:file] options:kNilOptions error:nil];
    NSArray* position = dict[@"position"];
    NSArray* rotation = dict[@"rotation"];
    NSArray* scaling = dict[@"scaling"];
    
    Mesh* mesh = [[Mesh alloc] init];
    
    mesh.x = [[position objectAtIndex:0] floatValue];
    mesh.y = [[position objectAtIndex:1] floatValue];
    mesh.z = [[position objectAtIndex:2] floatValue];
    
    mesh.rx = [[rotation objectAtIndex:0] floatValue];
    mesh.ry = [[rotation objectAtIndex:1] floatValue];
    mesh.rz = [[rotation objectAtIndex:2] floatValue];
    
    mesh.sx = [[scaling objectAtIndex:0] floatValue];
    mesh.sy = [[scaling objectAtIndex:1] floatValue];
    mesh.sz = [[scaling objectAtIndex:2] floatValue];
    
    NSArray* vertices = dict[@"vertices"];
    NSArray* normals = dict[@"normals"];
    NSArray* textures = dict[@"textures"];
    NSArray* indices = dict[@"indices"];
    
    NSUInteger verticesCount = [vertices count];
    GLfloat mesh_vertices[verticesCount];
    for (int i = 0; i < verticesCount; i++) {
        mesh_vertices[i] = [vertices[i] floatValue];
    }
    
    NSUInteger normalsCount = [normals count];
    GLfloat mesh_normals[normalsCount];
    for (int i = 0; i < normalsCount; i++) {
        mesh_normals[i] = [normals[i] floatValue];
    }
    
    NSUInteger texturesCount = [textures count];
    GLfloat mesh_textures[texturesCount];
    for (int i = 0; i < texturesCount; i++) {
        mesh_textures[i] = [textures[i] floatValue];
    }
    
    NSUInteger indicesCount = [indices count];
    GLuint mesh_indices[indicesCount];
    for (int i = 0; i < indicesCount; i++) {
        mesh_indices[i] = [indices[i] unsignedIntegerValue];
    }
    mesh.indicesCount = indicesCount;
    [mesh setVertices: mesh_vertices];
    [mesh setNormals: mesh_normals];
    [mesh setTextures: mesh_textures];
    [mesh setIndices: mesh_indices];
    
    return [[Mesh alloc] init];
}

@end
