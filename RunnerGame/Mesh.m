//
//  Mesh.m
//  RunnerGame
//
//  Created by Admin on 01.12.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "Mesh.h"
#import <GLKit/GLKit.h>

@implementation Mesh

@synthesize position = _position;
@synthesize rotation = _rotation;
@synthesize scaling = _scaling;

- (id)initWithName:(NSString *)name position:(GLfloat *)position rotation:(GLfloat *)rotation scaling:(GLfloat *)scaling vertices:(GLfloat *)vertices normals:(GLfloat *)normals textures:(GLfloat *)textures indices:(GLuint *)indices indicesCount:(GLuint)indicesCount {
    if (self = [super init]) {
        _name = name;
        _position = position;
        _rotation = rotation;
        _scaling = scaling;
        
        _vertices = vertices;
        _normals = normals;
        _textures = textures;
        _indices = indices;
        _indicesCount = indicesCount;
        [self setLineIndices];
    }
    return self;
}

- (void)setLineIndices {
    _linesIndicesCount = _indicesCount * 2;
    _linesIndices = (GLuint *)malloc(sizeof(GLuint) * _linesIndicesCount);
    int j = 0;
    for (int i = 0; i < _linesIndicesCount; i += 6) {
        _linesIndices[i] = _indices[j];
        _linesIndices[i + 1] = _indices[j + 1];
        _linesIndices[i + 2] = _indices[j + 1];
        _linesIndices[i + 3] = _indices[j + 2];
        _linesIndices[i + 4] = _indices[j + 2];
        _linesIndices[i + 5] = _indices[j];
        j += 3;
    }
}

- (void)loadTexture:(NSString *)name {
    CGImageRef imageRef = [[UIImage imageNamed:name] CGImage];
    GLKTextureInfo *texInfo = [GLKTextureLoader textureWithCGImage:imageRef options:nil error:NULL];
    _textureId = texInfo.name;
    
    glBindTexture(GL_TEXTURE_2D, texInfo.name);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
}

- (void)drawWithHandles:(NSDictionary *)handles viewMatrix:(GLKMatrix4)viewMatrix projectionMatrix:(GLKMatrix4)projectionMatrix {
    glEnableVertexAttribArray([[handles valueForKey:@"a_Position"] intValue]);
    glVertexAttribPointer([[handles valueForKey:@"a_Position"] intValue], 3, GL_FLOAT, false, 12, _vertices);
    
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, _textureId);
    glUniform1i([[handles valueForKey:@"u_Texture"] intValue], 0);
    glEnable(GL_TEXTURE_2D);
    glEnableVertexAttribArray([[handles valueForKey:@"a_TexCoordinate"] intValue]);
    glVertexAttribPointer([[handles valueForKey:@"a_TexCoordinate"] intValue], 2, GL_FLOAT, false, 8, _textures);
    
    mModelMatrix = GLKMatrix4Identity;
    mModelMatrix = GLKMatrix4Translate(mModelMatrix, _position[0], _position[1], _position[2]);
    mModelMatrix = GLKMatrix4Rotate(mModelMatrix, _rotation[0], 1.0f, 0.0f, 0.0f);
    mModelMatrix = GLKMatrix4Rotate(mModelMatrix, _rotation[1], 0.0f, 1.0f, 0.0f);
    mModelMatrix = GLKMatrix4Rotate(mModelMatrix, _rotation[2], 0.0f, 0.0f, 1.0f);
    mModelMatrix = GLKMatrix4Scale(mModelMatrix, _scaling[0], _scaling[1], _scaling[2]);
    
    mMVPMatrix = GLKMatrix4Multiply(viewMatrix, mModelMatrix);
    mMVPMatrix = GLKMatrix4Multiply(projectionMatrix, mMVPMatrix);
    
    glUniformMatrix4fv([[handles valueForKey:@"u_MVPMatrix"] intValue], 1, false, mMVPMatrix.m);
    glDrawElements(GL_TRIANGLES, _indicesCount, GL_UNSIGNED_INT, _indices);
    
    glDisableVertexAttribArray([[handles valueForKey:@"a_Position"] intValue]);
    glDisableVertexAttribArray([[handles valueForKey:@"a_TexCoordinate"] intValue]);
    glDisable(GL_TEXTURE_2D);
}

- (void)drawWireframeWithHandles:(NSDictionary *)handles viewMatrix:(GLKMatrix4)viewMatrix projectionMatrix:(GLKMatrix4)projectionMatrix {
    glEnableVertexAttribArray([[handles valueForKey:@"a_Position"] intValue]);
    glVertexAttribPointer([[handles valueForKey:@"a_Position"] intValue], 3, GL_FLOAT, false, 12, _vertices);
    
    mModelMatrix = GLKMatrix4Identity;
    mModelMatrix = GLKMatrix4Translate(mModelMatrix, _position[0], _position[1], _position[2]);
    mModelMatrix = GLKMatrix4Rotate(mModelMatrix, _rotation[0], 1.0f, 0.0f, 0.0f);
    mModelMatrix = GLKMatrix4Rotate(mModelMatrix, _rotation[1], 0.0f, 1.0f, 0.0f);
    mModelMatrix = GLKMatrix4Rotate(mModelMatrix, _rotation[2], 0.0f, 0.0f, 1.0f);
    mModelMatrix = GLKMatrix4Scale(mModelMatrix, _scaling[0], _scaling[1], _scaling[2]);
    
    mMVPMatrix = GLKMatrix4Multiply(viewMatrix, mModelMatrix);
    mMVPMatrix = GLKMatrix4Multiply(projectionMatrix, mMVPMatrix);
    
    glUniformMatrix4fv([[handles valueForKey:@"u_MVPMatrix"] intValue], 1, false, mMVPMatrix.m);
    glDrawElements(GL_LINES, _linesIndicesCount, GL_UNSIGNED_INT, _linesIndices);
}

@end
