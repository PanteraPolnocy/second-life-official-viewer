/** 
 * @file shadowAlphaMaskV.glsl
 *
 * $LicenseInfo:firstyear=2011&license=viewerlgpl$
 * Second Life Viewer Source Code
 * Copyright (C) 2011, Linden Research, Inc.
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation;
 * version 2.1 of the License only.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 * 
 * Linden Research, Inc., 945 Battery Street, San Francisco, CA  94111  USA
 * $/LicenseInfo$
 */

uniform mat4 texture_matrix0;
uniform mat4 modelview_projection_matrix;
uniform float shadow_target_width;

ATTRIBUTE vec3 position;
ATTRIBUTE vec4 diffuse_color;
ATTRIBUTE vec2 texcoord0;

#if defined(SEMI_TRANSPARENT_SHADOWS)
VARYING vec4 post_pos;
VARYING float target_pos_x;
#endif
VARYING vec4 vertex_color;
VARYING vec2 vary_texcoord0;

void passTextureIndex();

void main()
{
	//transform vertex
	vec4 pos = modelview_projection_matrix * vec4(position.xyz, 1.0);

#if defined(SEMI_TRANSPARENT_SHADOWS)
	target_pos_x = 0.5 * (shadow_target_width - 1.0) * pos.x;
	post_pos = pos;
#endif

	gl_Position = pos;
	
	passTextureIndex();

	vary_texcoord0 = (texture_matrix0 * vec4(texcoord0,0,1)).xy;
	vertex_color = diffuse_color;
}
