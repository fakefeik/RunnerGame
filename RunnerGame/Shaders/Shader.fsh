//
//  Shader.fsh
//  RunnerGame
//
//  Created by Admin on 17.11.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
