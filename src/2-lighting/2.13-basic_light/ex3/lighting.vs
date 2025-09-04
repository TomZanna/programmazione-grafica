#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aNormal;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform vec3 lightPos;
uniform vec3 viewPos;
uniform vec3 objectColor;
uniform vec3 lightColor;

out vec3 vertexColor; // Gouraud shading

void main()
{
    // to world-space
    vec3 FragPos = vec3(model * vec4(aPos, 1.0));
    vec3 Normal = normalize(transpose(inverse(mat3(model))); * aNormal);

    // ambient
    float ambientStrength = 0.1;
    vec3 ambient = ambientStrength * lightColor;

    // diffuse
    vec3 lightDir = normalize(lightPos - FragPos);
    float diff = max(dot(Normal, lightDir), 0.0);
    vec3 diffuse = diff * lightColor;

    // specular
    float specularStrength = 0.5;
    vec3 viewDir = normalize(viewPos - FragPos);
    // I - 2.0 * dot(N, I) * N
    vec3 reflectDir = reflect(-lightDir, Normal);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), 32);
    vec3 specular = specularStrength * spec * lightColor;

    vertexColor = (ambient + diffuse + specular) * objectColor;

    gl_Position = projection * view * vec4(FragPos, 1.0);
}
