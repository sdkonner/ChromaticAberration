Shader "Hidden/ChromaticEffect"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _RedChannelExtractor("Red Channel Extractor", float) = 0
        _GreenChannelExtractor("Green Channel Extractor", float) = 0
        _BlueChannelExtractor("Blue Channel Extractor", float) = 0
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        Pass
        {
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
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            float _RedChannelExtractor;
            float _GreenChannelExtractor;
            float _BlueChannelExtractor;

            fixed4 frag(v2f i) : SV_Target
            {
                float2 redUV = i.uv;
                float2 greenUV = i.uv;
                float2 blueUV = i.uv;

                redUV += float2(-_RedChannelExtractor, _RedChannelExtractor);
                greenUV += float2(_GreenChannelExtractor, _GreenChannelExtractor);
                blueUV += float2(_BlueChannelExtractor, -_BlueChannelExtractor);

                fixed redChannel    = tex2D(_MainTex, redUV).r;
                fixed greenChannel  = tex2D(_MainTex, greenUV).g;
                fixed blueChannel   = tex2D(_MainTex, blueUV).b;

                fixed4 col = fixed4(redChannel, greenChannel, blueChannel, 1);
                return col;
            }
            ENDCG
        }
    }
}
