uniform mat4 u_MVPMatrix;

attribute vec4 a_Position;
attribute vec4 a_Color;
attribute vec2 a_TexCoordinate;

varying vec4 v_Color;
varying vec2 v_TexCoordinate;

void main() {
    v_Color = a_Color;
    v_TexCoordinate = a_TexCoordinate;
    gl_Position = u_MVPMatrix * a_Position;
}
