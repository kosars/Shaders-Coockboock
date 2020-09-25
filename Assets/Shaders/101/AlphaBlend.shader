// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Shaders101/AlphaBlend"
{
    Properties
    {
        _MainTex("Texture",2D) = "white" {}
        _Color("Color", Color) = (1, 1, 1, 1)
        _SecondTex("Second Texture",2D) = "white" {}
        _Slider("Slider", Range(0,1)) = 0
        _TexturesNum("_TexturesNum", Range(1,10)) = 0

    }
    SubShader
    {
        Tags
        {
            "Queue" = "Transparent"
        }

        Pass
        {
             Blend SrcAlpha OneMinusSrcAlpha // Traditional transparency

             CGPROGRAM
             #pragma vertex vert 
             #pragma fragment frag

             #include "UnityCG.cginc"

             struct appdata
             {
                 float4 vertex : POSITION;
                 float2 uv : TEXCOORD0;
             };

            struct v2f 
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;

            };

            v2f vert(appdata v) 
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }
            sampler2D _MainTex;
            sampler2D _SecondTex;
            float _Slider;
            float _TexturesNum;
            fixed4 _Color;

            float4 frag(v2f i) : SV_Target
            {
                float4 color = ((tex2D(_MainTex , i.uv * _TexturesNum) * (1 - _Slider)) + 
                                (tex2D(_SecondTex , i.uv * _TexturesNum) * _Slider)) * _Color * float4(i.uv.r,i.uv.g,1,1);
                return color;
            }
            ENDCG
        }
    } 
}
