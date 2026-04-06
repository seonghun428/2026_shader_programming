#version 330

layout(location=0) out vec4 FragColor;

uniform float u_Time;

in vec2 v_UV;

const float pi = 3.1415926535;

const vec4 c_Points[2] = vec4[](
	vec4(0.5, 0.5, 0, 0.5),
	vec4(0.5, 0.7, 0.5, 1)
);

void RainDrop()
{
	float accum = 0;

	for(int i = 0; i < 2; i++)
	{
		float s_Time = c_Points[i].z;
		float lifeTime = c_Points[i].w;
		float newTime = u_Time - s_Time;

		if(newTime > 0)
		{
			float t = fract(newTime / lifeTime);
			float oneMinus = 1 - t;
			t = t* lifeTime;

			vec2 center = c_Points[i].xy;
			vec2 currPos = v_UV;
			float count = 5;
			float range = t/5;

			float d = distance(currPos, center);
			float fade = (1/range) * clamp(range - d, 0, 1);
			float grey = pow(abs(sin(d * 4 * pi * count - t * 20)), 4);

			accum += grey * fade * oneMinus;
		}
	}

	FragColor = vec4(accum);
}

void main()
{
	RainDrop();
}
