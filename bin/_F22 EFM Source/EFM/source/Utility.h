#pragma once

//#include "stdafx.h"
#include <math.h>
#include <stdio.h>
#include <string>
#include <algorithm>
#include <cstddef>
#include <utility>
// This file contains useful functions, mostly math.

// Convert number from degrees to radians
inline double rad(double x)
{
	return x / 57.295779513082320876798154814105;
};

// Convert number from radians to degrees
inline double deg(double x)
{
	return x * 57.295779513082320876798154814105;
};

// Simple actuator
inline double actuator(double value, double target, double down_speed, double up_speed)
{
	if ((value + up_speed) < target)
	{
		return value += up_speed;
	}

	else if ((value + down_speed) > target)
	{
		return value += down_speed;
	}

	else
	{
		return target;
	}
};

// Simple upper and lower limiter
inline double limit(double input, double lower_limit, double upper_limit)
{
	if (input > upper_limit)
	{
		return upper_limit;
	}
	else if (input < lower_limit)
	{
		return lower_limit;
	}
	else
	{
		return input;
	}
};

// Rescales a -1 to +1 scale to different minima/maxima. Example: -1 to +1 -> -10 to +15
// inline double rescale(double input, double min, double max)
//{
//	if (input >= 0.0)
//		return input * fabs(max);
//	if (input < 0.0)
//		return input * fabs(min);
//};

inline double rescale(double input, double min_in, double max_in, double min_out = -1.0, double max_out = 1.0)
{
	if (max_in - min_in == 0) return min_out; // Avoid divide-by-zero
	return min_out + (max_out - min_out) * (input - min_in) / (max_in - min_in);
}






// 3D vector structure,
// In DCS coordinates linear: x = forward/back, y = up/down, z = left/right
// Angular: x = roll, y = yaw, z = pitch
struct Vec3
{
	inline Vec3(double x_ = 0, double y_ = 0, double z_ = 0) :x(x_), y(y_), z(z_) {}
	double x;
	double y;
	double z;
};


struct Vec3
{
	inline Vec3(double x_ = 0, double y_ = 0, double z_ = 0) : x(x_), y(y_), z(z_) {}
	Vec3(const Vec3 & other) : x(other.x), y(other.y), z(other.z) {} // Copy constructor
	double x;
	double y;
	double z;
};

// Addition operator for Vec3
inline Vec3 operator+(const Vec3 & a, const Vec3 & b)
{
	return Vec3(a.x + b.x, a.y + b.y, a.z + b.z);
}

// Subtraction operator for Vec3
inline Vec3 operator-(const Vec3 & a, const Vec3 & b)
{
	return Vec3(a.x - b.x, a.y - b.y, a.z - b.z);
}

// Multiplication operator for Vec3 by a scalar
inline Vec3 operator*(const Vec3 & a, double b)
{
	return Vec3(a.x * b, a.y * b, a.z * b);
}

// Division operator for Vec3 by a scalar
inline Vec3 operator/(const Vec3 & a, double b)
{
	if (b == 0.0) return Vec3(0, 0, 0); // Avoid division by zero
	return Vec3(a.x / b, a.y / b, a.z / b);
}

// Dot product for Vec3
inline double dot(const Vec3 & a, const Vec3 & b)
{
	return a.x * b.x + a.y * b.y + a.z * b.z;
}

// Cross product for Vec3
inline Vec3 cross(const Vec3 & a, const Vec3 & b)
{
	return Vec3(
		a.y * b.z - a.z * b.y,
		a.z * b.x - a.x * b.z,
		a.x * b.y - a.y * b.x
	);
}

// Magnitude (length) of a Vec3
inline double magnitude(const Vec3 & v)
{
	return sqrt(v.x * v.x + v.y * v.y + v.z * v.z);
}

// Normalize a Vec3 (make it unit length)
inline Vec3 normalize(const Vec3 & v)
{
	double mag = magnitude(v);
	if (mag == 0.0) return Vec3(0, 0, 0); // Avoid division by zero
	return Vec3(v.x / mag, v.y / mag, v.z / mag);
}

// Calculate the angle between two Vec3 vectors in radians
inline double angle_between(const Vec3 & a, const Vec3 & b)
{
	double dot_product = dot(a, b);
	double mag_a = magnitude(a);
	double mag_b = magnitude(b);
	if (mag_a == 0.0 || mag_b == 0.0) return 0.0; // Avoid division by zero
	return acos(dot_product / (mag_a * mag_b));
}

// Calculate the distance between two Vec3 points
inline double distance(const Vec3 & a, const Vec3 & b)
{
	return magnitude(a - b);
}

// Calculate the distance between two Vec3 points, squared (for performance)
inline double distance_squared(const Vec3 & a, const Vec3 & b)
{
	double dx = a.x - b.x;
	double dy = a.y - b.y;
	double dz = a.z - b.z;
	return dx * dx + dy * dy + dz * dz;
}

// Calculate the angle between two Vec3 vectors in degrees
inline double angle_between_degrees(const Vec3 & a, const Vec3 & b)
{
	return deg(angle_between(a, b));
}

// Calculate the angle between two Vec3 vectors in radians, with a limit to avoid NaN
inline double angle_between_limited(const Vec3 & a, const Vec3 & b)
{
	double angle = angle_between(a, b);
	if (angle < 0.0 || angle > M_PI) return 0.0; // Avoid NaN
	return angle;
}

// Calculate the angle between two Vec3 vectors in degrees, with a limit to avoid NaN
inline double angle_between_degrees_limited(const Vec3 & a, const Vec3 & b)
{
	double angle = angle_between(a, b);
	if (angle < 0.0 || angle > M_PI) return 0.0; // Avoid NaN
	return deg(angle);
}

// Calculate the angle between two Vec3 vectors in radians, with a limit to avoid NaN
inline double angle_between_limited(const Vec3 & a, const Vec3 & b)
{
	double angle = angle_between(a, b);
	if (angle < 0.0 || angle > M_PI) return 0.0; // Avoid NaN
	return angle;
}



// Linear interpolation
inline double lerp(const double* x, const double* f, size_t sz, double t)
{
	if (sz == 0) return 0.0;
	if (sz == 1) return f[0];

	for (size_t i = 0; i < sz; i++)
	{
		if (t <= x[i])
		{
			if (i > 0)
			{
				double dx = x[i] - x[i - 1];
				if (dx == 0.0) return f[i - 1];
				return ((f[i] - f[i - 1]) / dx * t +
					(x[i] * f[i - 1] - x[i - 1] * f[i]) / dx);
			}
			return f[0];
		}
	}
	return f[sz - 1];
}

/*	
	This takes two tables and makes a sort of "virtual graph".
	The x value makes the x axis, the f value makes the y axis.
	It's important that the number of entries (size) in both tables are exactly the same.
	The t value is the "driver" that determines the output value.
	In most cases here, the x table is mach values, f table is aerodynamics coefficients, 
	and t is the aircraft's current mach number.

	This can be used for other stuff, like the throttle response curve.
*/

// Linear interpolation smoothing function
double smooth_lerp(double current, double target, double t)
{
	return current + (target - current) * t;
};

//Slew Rate Limiter
inline double slew_rate_limit(double current, double target, double rate, double dt) {
	double delta = target - current;
	double max_change = rate * dt;
	return current + std::clamp(delta, -max_change, max_change);
}