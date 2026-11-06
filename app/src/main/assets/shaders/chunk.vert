#version 300 es
precision highp float;
layout(location = 0) in vec3 aPos;
layout(location = 1) in vec2 aUv;
layout(location = 2) in vec3 aNormal;
layout(location = 3) in float aAo;
layout(location = 4) in float aLight;

uniform mat4 uModel;
uniform mat4 uView;
uniform mat4 uProjection;
uniform vec3 uSunDirection;

out vec2 vUv;
out float vLight;

void main() {
    vUv = aUv;
    float diffuse = max(dot(aNormal, normalize(uSunDirection)), 0.25);
    vLight = aLight * aAo * diffuse;
    gl_Position = uProjection * uView * uModel * vec4(aPos, 1.0);
}
