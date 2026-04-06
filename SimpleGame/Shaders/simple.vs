#version 330

in vec3 a_Pos;
in vec2 a_UV;

out vec2 v_UV;

void main()
{
	vec4 newPosition;
	newPosition = vec4(a_Pos, 1);
	v_UV = a_UV;
	gl_Position = newPosition;
}
