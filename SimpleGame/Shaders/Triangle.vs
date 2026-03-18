#version 330

uniform float u_Time;

in vec3 a_Position;
in float a_Mass;
in vec2 a_Vel;
in float a_RV;

const float c_PI = 3.1415926535897932384626433832795;
const vec2 c_Gravity = vec2(0.0, -9.81);

void basic()
{
	float t = mod(u_Time, 1.0);
	vec4 newPosition;
	vec3 translation = vec3(t, 0.0, 0.0);
	newPosition = vec4(a_Position + translation, 1);
	gl_Position = newPosition;
}

void sin1()
{
	float t = mod(u_Time, 1.0);
	vec4 newPosition;
	vec3 translation = vec3(t, 0.5 * sin(t * 2.0 * c_PI), 0.0);
	newPosition = vec4(a_Position + translation, 1);
	gl_Position = newPosition;
}

void sin2()
{
	float t = mod(u_Time*5, 2.0);
	vec4 newPosition;
	vec3 translation = vec3(t-1, 0.5 * sin(t * 2.0 * c_PI), 0.0);
	newPosition = vec4(a_Position + translation, 1);
	gl_Position = newPosition;
}

void sin3()
{
	float t = mod(u_Time*5, 2.0);
	vec4 newPosition;
	vec3 translation = vec3(t-1, 0.5 * sin(t * 4.0 * c_PI), 0.0);
	newPosition = vec4(a_Position + translation, 1);
	gl_Position = newPosition;
}

void circular()
{
	float t = mod(u_Time*5, 2.0);
	float rad = 0.7;
	vec4 newPosition;
	vec3 translation = vec3(-rad * cos(t * 2.0 * c_PI), rad * sin(t * 2.0 * c_PI), 0.0);
	newPosition = vec4(a_Position + translation, 1);
	gl_Position = newPosition;
}

void star()
{
	float t = mod(u_Time, 1.0);
    vec4 newPosition;

    vec3 translation = vec3(sin(t * 2.0 * c_PI), sin(t * 2.0 * c_PI), 0.0);
    
    newPosition = vec4(a_Position + translation, 1.0);
    gl_Position = newPosition;
}

void falling()
{
	float t = mod(u_Time * 5, 1.0);
	float tt = t*t;

	float initPosX = a_Position.x + cos(a_RV * 2.0 * c_PI);
	float initPosY = a_Position.y + sin(a_RV * 2.0 * c_PI);

	vec4 newPosition;
	newPosition.x = initPosX + a_Vel.x * t + 0.5 * c_Gravity.x * tt;
	newPosition.y = initPosY + a_Vel.y * t + 0.5 * c_Gravity.y * tt;
	newPosition.z = 0;
	newPosition.w = 1;

	gl_Position = newPosition;
}

void main()
{
	falling();
}
