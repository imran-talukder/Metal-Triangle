//
//  Shader.metal
//  BasicMetal2
//
//  Created by Appnap WS01 on 28/10/20.
//

#include <metal_stdlib>
using namespace metal;


vertex float4 vertex_shader(const device packed_float3 *vertices [[buffer(0)]], uint vertexId [[vertex_id]]) {
    return float4(vertices[vertexId],1);
}

fragment half4 fragment_shader() {
    return half4(0.2,0.1,0.7,1);
}
