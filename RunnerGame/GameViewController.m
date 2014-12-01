//
//  GameViewController.m
//  RunnerGame
//
//  Created by Admin on 27.11.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "GameViewController.h"
#import <OpenGLES/ES2/glext.h>
#import "Mesh.h"
#import "JsonModelLoader.h"


@interface GameViewController ()

@property (strong, nonatomic) EAGLContext *context;

- (void)setupGL;
- (void)tearDownGL;

@end

@implementation GameViewController {
    NSMutableDictionary *handles;
    GLKMatrix4 mViewMatrix;
    GLKMatrix4 mProjectionMatrix;
    GLKMatrix4 mModelMatrix;
    GLKMatrix4 mMVPMatrix;
    
    GLfloat *mCubeVerticesData;
    GLfloat *mCubeTexturesData;
    GLuint *mCubeIndicesData;
    GLuint mCubeIndicesCount;
    GLuint mCubeTextureId;
    float rotationAngle;
    
    Mesh *mesh;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    handles = [[NSMutableDictionary alloc] init];
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];

    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    [self setupGL];
}

- (void)dealloc {
    [self tearDownGL];
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    if ([self isViewLoaded] && ([[self view] window] == nil)) {
        self.view = nil;
        
        [self tearDownGL];
        
        if ([EAGLContext currentContext] == self.context) {
            [EAGLContext setCurrentContext:nil];
        }
        self.context = nil;
    }

    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)setupGL {
    [EAGLContext setCurrentContext:self.context];
    glClearColor(0.5f, 0.5f, 0.5f, 1.0f);
    
    const GLchar *vertexShader = (GLchar *)[[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"simple_shader" ofType:@"vs"] encoding:NSUTF8StringEncoding error:nil] UTF8String];
    const GLchar *fragmentShader = (GLchar *)[[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"simple_shader" ofType:@"fs"] encoding:NSUTF8StringEncoding error:nil] UTF8String];
    
    GLuint vertexShaderHandle = glCreateShader(GL_VERTEX_SHADER);
    if (vertexShaderHandle == 0)
        [NSException raise:@"fail" format:@"fail"];
    glShaderSource(vertexShaderHandle, 1,  &vertexShader, NULL);
    glCompileShader(vertexShaderHandle);
    // here must be some debug info log
    
    GLuint fragmentShaderHandle = glCreateShader(GL_FRAGMENT_SHADER);
    if (fragmentShaderHandle == 0)
        [NSException raise:@"fragmentfail" format:@"fail"];
    glShaderSource(fragmentShaderHandle, 1, &fragmentShader, NULL);
    glCompileShader(fragmentShaderHandle);
    
    GLuint programHandle = glCreateProgram();
    if (programHandle == 0)
        [NSException raise:@"programfail" format:@"fail"];
    glAttachShader(programHandle, vertexShaderHandle);
    glAttachShader(programHandle, fragmentShaderHandle);
    glBindAttribLocation(programHandle, 0, "a_Position");
    glBindAttribLocation(programHandle, 1, "a_Color");
    glBindAttribLocation(programHandle, 2, "a_TexCoordinate");
    glLinkProgram(programHandle);
    
    [handles setValue:[NSNumber numberWithInt:glGetUniformLocation(programHandle, "u_MVPMatrix")] forKey:@"u_MVPMatrix"];
    [handles setValue:[NSNumber numberWithInt:glGetUniformLocation(programHandle, "u_Texture")] forKey:@"u_Texture"];
    [handles setValue:[NSNumber numberWithInt:glGetAttribLocation(programHandle, "a_Position")] forKey:@"a_Position"];
    [handles setValue:[NSNumber numberWithInt:glGetAttribLocation(programHandle, "a_Color")] forKey:@"a_Color"];
    [handles setValue:[NSNumber numberWithInt:glGetAttribLocation(programHandle, "a_TexCoordinate")] forKey:@"a_TexCoordinate"];
    glUseProgram(programHandle);
    
    mesh = [JsonModelLoader loadFromFile:@"yoba"];
    [mesh loadTexture:@"yoba.png"];
    mesh.position[0] = mesh.position[1] = mesh.position[2] = 0;
    mesh.scaling[0] = mesh.scaling[1] = mesh.scaling[2] = 0.5f;
}

- (void)tearDownGL {
    [EAGLContext setCurrentContext:self.context];
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)update {
    glViewport(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    const float ratio = fabsf(self.view.bounds.size.width / self.view.bounds.size.height);
    const float left = -ratio;
    const float right = ratio;
    const float bottom = -1.0f;
    const float top = 1.0f;
    const float near = 1.0f;
    const float far = 10.0f;
    mProjectionMatrix = GLKMatrix4MakeFrustum(left, right, bottom, top, near, far);
    rotationAngle += self.timeSinceLastUpdate;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glFrontFace(GL_CCW);
    glEnable(GL_CULL_FACE);
    glCullFace(GL_FRONT);
    
    mViewMatrix = GLKMatrix4MakeLookAt(0.0f, 0.0f, 1.5f, 0.0f, 0.0f, -5.0f, 0.0f, 1.0f, 0.0f);
    mesh.rotation[0] = mesh.rotation[1] = mesh.rotation[2] = rotationAngle;
    
    mesh.position[0] = -0.7f;
    [mesh drawWithHandles:handles viewMatrix:mViewMatrix projectionMatrix:mProjectionMatrix];
    
    mesh.position[0] = 0.7f;
    [mesh drawWireframeWithHandles:handles viewMatrix:mViewMatrix projectionMatrix:mProjectionMatrix];
    
}

@end
