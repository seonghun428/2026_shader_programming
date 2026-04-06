#version 330

uniform float u_Time;

in vec3 a_Position;
in float a_Mass;
in vec2 a_Vel;
in float a_RV;
in float a_RV1;
in float a_RV2;

out float v_Grey;

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

void circle_falling()
{
	float newTime = u_Time * 5 - a_RV;
	if(newTime > 0)
	{
		float t = mod(newTime, 1.0);
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
	else
	{
		gl_Position = vec4(-100, -100, 0, 1);
	}
}

float PseudoRandom(float n){
    return fract(sin(n) * 43758.5453123);
}

void circle_falling2()
{
	float newTime = u_Time * 10 - a_RV1;
	if(newTime > 0)
	{
		float t = mod(newTime, 1.0);
		float tt = t*t;

		float Scale = a_RV1;

		float initPosX = Scale * a_Position.x + cos(a_RV * 2.0 * c_PI);
		float initPosY = Scale * a_Position.y + sin(a_RV * 2.0 * c_PI);

		vec4 newPosition;
		newPosition.x = initPosX + a_Vel.x * t + 0.5 * c_Gravity.x * tt;
		newPosition.y = initPosY + a_Vel.y * t + 0.5 * c_Gravity.y * tt;
		newPosition.z = 0;
		newPosition.w = 1;

		gl_Position = newPosition;
	}
	else
	{
		gl_Position = vec4(-100, -100, 0, 1);
	}
}

void ai_test()
{
	float t = mod(u_Time + a_RV * 3.0, 1.0);

	vec2 rndpos = vec2(
	    fract(sin(a_Position.x * 12.9898 + a_RV  * 78.233) * 43758.5453),
	    fract(sin(a_Position.y * 93.9898 + a_RV1 * 67.345) * 24634.6345)
	) * 2.0 - 1.0;
	
	vec2 q = rndpos;
	
	q.x *= 0.78;
	q.y *= 0.88;
	
	float cheek = smoothstep(-0.55, 0.00, q.y) * (1.0 - smoothstep(0.00, 0.55, q.y));
	q.x *= 1.0 + cheek * 0.22;
	
	float chin = 1.0 - smoothstep(-0.95, -0.30, q.y);
	q.x *= 1.0 - chin * 0.30;
	
	float earL = max(0.0, 1.0 - abs((q.x + 0.42) / 0.17));
	float earR = max(0.0, 1.0 - abs((q.x - 0.42) / 0.17));
	float earZone = smoothstep(0.12, 0.58, q.y);
	q.y += max(earL, earR) * earZone * 0.62;
	
	q *= 0.55;
	
	vec2 pos = q + a_Vel * t + 0.5 * c_Gravity * t * t;
	
	float swirlAngle = a_RV * c_PI * 2.0 + t * (1.5 + a_RV1 * 2.5);
	float swirlRadius = (0.04 + a_RV1 * 0.10) * (1.0 - t);
	
	pos.x += cos(swirlAngle) * swirlRadius;
	pos.y += sin(swirlAngle * 1.3) * swirlRadius * 0.35;
	pos.x += sin(t * 3.0 + a_RV * 10.0) * (0.03 + a_RV1 * 0.05);
	
	gl_Position = vec4(pos, a_Position.z, 1.0);
}

void circle_falling3()
{
	float newTime = u_Time * 10 - a_RV1;
	if(newTime > 0)
	{
		float lifeTime = a_RV2 * 2.0 + 1.0;
		float t = mod(newTime, lifeTime);
		float tt = t*t;

		float Scale = (lifeTime - t)/lifeTime;

		float initPosX = Scale * a_Position.x + cos(a_RV * 2.0 * c_PI);
		float initPosY = Scale * a_Position.y + sin(a_RV * 2.0 * c_PI);

		vec4 newPosition;
		newPosition.x = initPosX + a_Vel.x * t + 0.5 * c_Gravity.x * tt;
		newPosition.y = initPosY + a_Vel.y * t + 0.5 * c_Gravity.y * tt;
		newPosition.z = 0;
		newPosition.w = 1;

		gl_Position = newPosition;
	}
	else
	{
		gl_Position = vec4(-100, -100, 0, 1);
	}
}

void sin4()
{
	float newTime = u_Time * 5 - a_RV;
	if(newTime > 0)
	{
		float t = mod(newTime, 1.0);

		float amp = (a_RV1 - 0.5) * t;
		float freq = a_RV2;

		vec4 newPosition;
		vec3 translation = vec3(2 * t - 1, amp * sin(freq * t * c_PI), 0.0);
		newPosition = vec4(a_Position + translation, 1);
		gl_Position = newPosition;
	}
	else
	{
		gl_Position = vec4(-100, -100, 0, 1);
	}
}

void torchlight()
{
	float newTime = u_Time * 5 - a_RV;
	if(newTime > 0)
	{
		float t = mod(newTime, 1.0);

		float amp = (2.0 * a_RV1 - 1) * (0.5 - t * 0.5);
		float freq = a_RV2;
		float scale = 1.5 - t;

		vec4 newPosition;
		vec3 translation = vec3(amp * sin(freq * t * c_PI), 2 * t - 1, 0.0);
		newPosition = vec4(a_Position * scale + translation, 1);
		gl_Position = newPosition;
		v_Grey = 1 - t;
	}
	else
	{
		gl_Position = vec4(-100, -100, 0, 1);
		v_Grey = 0;
	}
}

void main()
{
	torchlight();
}