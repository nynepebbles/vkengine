#version 450

layout(location = 0) in vec3 inPosition;
layout(location = 1) in vec3 inColor;
layout(location = 2) in vec3 inNormal;
layout(location = 3) in vec2 inUv;

layout(location = 0) out vec3 outFragColor;
layout(location = 1) out vec3 outFragPosWorld;
layout(location = 2) out vec3 outFragNormalWorld;

layout(set = 0, binding = 0) uniform GlobalUbo {
  mat4 projection;
  mat4 view;
  vec4 ambientLightColor; // w is intensity
  vec3 lightPosition;
  vec4 lightColor;
  vec4 cameraPosition;
} ubo;

layout(push_constant) uniform Push {
  mat4 modelMatrix;
  mat4 normalMatrix;
} push;

void main()
{
  vec4 worldVertPos = push.modelMatrix * vec4(inPosition, 1.0);
  gl_Position = ubo.projection * ubo.view * worldVertPos;

  outFragColor = inColor;
  outFragPosWorld = worldVertPos.xyz;
  outFragNormalWorld = normalize(mat3(push.normalMatrix) * inNormal);
}
