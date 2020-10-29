//
//  Shader.metal
//  BasicMetal2
//
//  Created by Appnap WS01 on 28/10/20.
//

#include <metal_stdlib>
using namespace metal;

struct Constants {
    float animateBy;
};

vertex float4 vertex_shader(const device packed_float3 *vertices [[buffer(0)]], uint vertexId [[vertex_id]], constant Constants &move [[buffer(1)]]) {
    float4 position = float4(vertices[vertexId],1);
    
    if(position.y < 0)position.y +=move.animateBy/2;
    if(position.y>0)position.y -=move.animateBy/2;


    return position;
}

fragment half4 fragment_shader() {
    return half4(0.2,0.1,0.7,1);
}
