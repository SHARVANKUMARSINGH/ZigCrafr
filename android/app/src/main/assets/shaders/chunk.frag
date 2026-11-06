#version 300 es
precision highp float;
in vec2 vUv;
in float vLight;
out vec4 FragColor;

uniform sampler2D uTextureAtlas;

void main() {
    vec4 texColor = texture(uTextureAtlas, vUv);
    if (texColor.a < 0.1) discard;
    FragColor = vec4(texColor.rgb * vLight, texColor.a);
}
