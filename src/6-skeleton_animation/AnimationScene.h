#ifndef ANIMATIONSCENE_H
#define ANIMATIONSCENE_H

#include <glad/glad.h>

#include <GLFW/glfw3.h>
#include <glm/glm.hpp>

#include <assimp/Importer.hpp>
#include <assimp/postprocess.h> // Post processing fla
#include <assimp/scene.h>       // Output data structure

#include "QuatCamera.h"
#include "SkeletalModel.h"
#include "glslprogram.h"

using glm::mat4;

class AnimationScene {
private:
  GLSLProgram *prog; //!< Shader program

  int width, height;

  bool m_animate;

  mat4 model; // Model matrix

  SkeletalModel *m_AnimatedModel; //!< The skeletal model

  void setMatrices(QuatCamera camera); // Set the camera matrices

  void compileAndLinkShader(); // Compile and link the shader

public:
  AnimationScene(); // Constructor

  void setLightParams(QuatCamera camera); // Setup the lighting

  void initScene(QuatCamera camera); // Initialise the scene

  void update(long long f_startTime, float f_Interval); // Update the scene

  void render(QuatCamera camera); // Render the scene

  void resize(QuatCamera camera, int, int); // Resize

  void animate(bool value) { m_animate = value; }
  bool animating() { return m_animate; }
};

#endif
