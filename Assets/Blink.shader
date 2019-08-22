Shader "Custom/Blink"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_MaskTex("Mask", 2D) = "white" {}
		_RampTex("Ramp", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Lambert
        #pragma target 3.0

        sampler2D _MainTex;
		sampler2D _MaskTex;
		sampler2D _RampTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			fixed4 mask = tex2D(_MaskTex, IN.uv_MainTex);
			fixed4 ramp = tex2D(_RampTex, float2(_Time.y, 0.5));
            o.Albedo = c.rgb;
			o.Emission = c.rgb * mask.g * ramp.r + c.rgb * mask.r * ramp.g;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
