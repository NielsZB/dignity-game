// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hej"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		_Float0("Float 0", Range( 0 , 1)) = 0
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
		_MaskStrenght("MaskStrenght", Float) = 0
		_Speed("Speed", Range( 0 , 5)) = 1

	}

	SubShader
	{
		LOD 0

		
		
		ZTest Always
		Cull Off
		ZWrite Off

		
		Pass
		{ 
			CGPROGRAM 

			

			#pragma vertex vert_img_custom 
			#pragma fragment frag
			#pragma target 3.0
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"


			struct appdata_img_custom
			{
				float4 vertex : POSITION;
				half2 texcoord : TEXCOORD0;
				
			};

			struct v2f_img_custom
			{
				float4 pos : SV_POSITION;
				half2 uv   : TEXCOORD0;
				half2 stereoUV : TEXCOORD2;
		#if UNITY_UV_STARTS_AT_TOP
				half4 uv2 : TEXCOORD1;
				half4 stereoUV2 : TEXCOORD3;
		#endif
				
			};

			uniform sampler2D _MainTex;
			uniform half4 _MainTex_TexelSize;
			uniform half4 _MainTex_ST;
			
			uniform sampler2D _TextureSample2;
			uniform float _Speed;
			uniform float GlobalSpeedVal;
			uniform float _Float0;
			uniform float _MaskStrenght;
			uniform float GlobalAmountVal;


			v2f_img_custom vert_img_custom ( appdata_img_custom v  )
			{
				v2f_img_custom o;
				
				o.pos = UnityObjectToClipPos( v.vertex );
				o.uv = float4( v.texcoord.xy, 1, 1 );

				#if UNITY_UV_STARTS_AT_TOP
					o.uv2 = float4( v.texcoord.xy, 1, 1 );
					o.stereoUV2 = UnityStereoScreenSpaceUVAdjust ( o.uv2, _MainTex_ST );

					if ( _MainTex_TexelSize.y < 0.0 )
						o.uv.y = 1.0 - o.uv.y;
				#endif
				o.stereoUV = UnityStereoScreenSpaceUVAdjust ( o.uv, _MainTex_ST );
				return o;
			}

			half4 frag ( v2f_img_custom i ) : SV_Target
			{
				#ifdef UNITY_UV_STARTS_AT_TOP
					half2 uv = i.uv2;
					half2 stereoUV = i.stereoUV2;
				#else
					half2 uv = i.uv;
					half2 stereoUV = i.stereoUV;
				#endif	
				
				half4 finalColor;

				// ase common template code
				float2 uv0_MainTex = i.uv.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 panner67 = ( ( _Speed * _Time.y * GlobalSpeedVal ) * float2( 0.35,-0.4 ) + float2( 0,0 ));
				float4 temp_cast_0 = (tex2D( _TextureSample2, panner67 ).r).xxxx;
				float4 lerpResult35 = lerp( tex2D( _MainTex, uv0_MainTex ) , temp_cast_0 , ( _Float0 * saturate( ( length( (float2( -1,-1 ) + (uv0_MainTex - float2( 0,0 )) * (float2( 1,1 ) - float2( -1,-1 )) / (float2( 1,1 ) - float2( 0,0 ))) ) + _MaskStrenght ) ) * GlobalAmountVal ));
				

				finalColor = lerpResult35;

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=17800
236;384;1522;674;636.1478;-223.697;1.465381;True;False
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;2;-381.8018,-122.8666;Inherit;False;0;0;_MainTex;Shader;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-331.3414,87.95044;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;69;-609.428,225.0517;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;-1,-1;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-364.5847,521.3819;Inherit;False;Property;_MaskStrenght;MaskStrenght;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;71;-343.765,313.1386;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;77;-33.87646,993.0219;Inherit;False;Global;GlobalSpeedVal;GlobalSpeedVal;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;74;-342.8409,717.0786;Inherit;False;Property;_Speed;Speed;3;0;Create;True;0;0;False;0;1;5;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;76;-161.8409,850.0786;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;75;-17.72238,780.4316;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;72;-140.0441,356.2495;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;-0.38;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;65;311.6625,438.2213;Inherit;False;Property;_Float0;Float 0;0;0;Create;True;0;0;False;0;0;0.05;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;73;29.5646,400.8496;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;67;117.245,689.7209;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.35,-0.4;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;78;820.4407,833.2953;Inherit;False;Global;GlobalAmountVal;GlobalAmountVal;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;851.3342,551.1984;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;68;329.645,599.4209;Inherit;True;Property;_TextureSample2;Texture Sample 2;1;0;Create;True;0;0;False;0;-1;ee200f7f49ef75a44a1bceddf22c0b15;ee200f7f49ef75a44a1bceddf22c0b15;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;162.3673,-96.19594;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;35;886.072,209.4608;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;64;507.8391,198.2382;Inherit;False;Constant;_Color0;Color 0;0;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;1451.946,435.2874;Float;False;True;-1;2;ASEMaterialInspector;0;2;Hej;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;True;2;False;-1;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;0
WireConnection;4;2;2;0
WireConnection;69;0;4;0
WireConnection;71;0;69;0
WireConnection;75;0;74;0
WireConnection;75;1;76;0
WireConnection;75;2;77;0
WireConnection;72;0;71;0
WireConnection;72;1;70;0
WireConnection;73;0;72;0
WireConnection;67;1;75;0
WireConnection;66;0;65;0
WireConnection;66;1;73;0
WireConnection;66;2;78;0
WireConnection;68;1;67;0
WireConnection;1;0;2;0
WireConnection;1;1;4;0
WireConnection;35;0;1;0
WireConnection;35;1;68;1
WireConnection;35;2;66;0
WireConnection;0;0;35;0
ASEEND*/
//CHKSM=095D11390CADF57AF4D8319DAB585C78EE57D49F