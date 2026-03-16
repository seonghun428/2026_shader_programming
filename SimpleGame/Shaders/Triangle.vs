#version 330

uniform float u_Time;

in vec3 a_Position;

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
	float pi = 3.1415926535897932384626433832795;
	vec4 newPosition;
	vec3 translation = vec3(t, 0.5 * sin(t * 2.0 * pi), 0.0);
	newPosition = vec4(a_Position + translation, 1);
	gl_Position = newPosition;
}

void sin2()
{
	float t = mod(u_Time*5, 2.0);
	float pi = 3.1415926535897932384626433832795;
	vec4 newPosition;
	vec3 translation = vec3(t-1, 0.5 * sin(t * 2.0 * pi), 0.0);
	newPosition = vec4(a_Position + translation, 1);
	gl_Position = newPosition;
}

void sin3()
{
	float t = mod(u_Time*5, 2.0);
	float pi = 3.1415926535897932384626433832795;
	vec4 newPosition;
	vec3 translation = vec3(t-1, 0.5 * sin(t * 4.0 * pi), 0.0);
	newPosition = vec4(a_Position + translation, 1);
	gl_Position = newPosition;
}

void circular()
{
	float t = mod(u_Time*5, 2.0);
	float pi = 3.1415926535897932384626433832795;
	float rad = 0.7;
	vec4 newPosition;
	vec3 translation = vec3(-rad * cos(t * 2.0 * pi), rad * sin(t * 2.0 * pi), 0.0);
	newPosition = vec4(a_Position + translation, 1);
	gl_Position = newPosition;
}

void star()
{
	float t = mod(u_Time, 1.0);
    vec4 newPosition;
    float pi = 3.1415926535897932384626433832795;

    vec3 translation = vec3(sin(t * 2.0 * pi), sin(t * 2.0 * pi), 0.0);
    
    newPosition = vec4(a_Position + translation, 1.0);
    gl_Position = newPosition;
}

void main()
{
	star();
}
