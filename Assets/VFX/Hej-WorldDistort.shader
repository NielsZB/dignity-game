// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hej-WorldDistort"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		_RenderTex("RenderTex", 2D) = "white" {}
		_Distort("Distort", Float) = 0
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
			
			uniform sampler2D _RenderTex;
			uniform float _Speed;
			uniform float GlobalSpeedVal;
			uniform float4 _RenderTex_ST;
			uniform float _Distort;
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
				float2 uv0_RenderTex = i.uv.xy * _RenderTex_ST.xy + _RenderTex_ST.zw;
				float2 panner71 = ( ( _Speed * _Time.y * GlobalSpeedVal ) * float2( 0.1,-0.3 ) + uv0_RenderTex);
				float4 tex2DNode58 = tex2D( _RenderTex, panner71 );
				float2 appendResult65 = (float2(tex2DNode58.r , tex2DNode58.g));
				float2 temp_output_52_0 = ( uv0_MainTex + ( (float2( -1,-1 ) + (appendResult65 - float2( 0,0 )) * (float2( 1,1 ) - float2( -1,-1 )) / (float2( 1,1 ) - float2( 0,0 ))) * _Distort * saturate( ( length( (float2( -1,-1 ) + (uv0_MainTex - float2( 0,0 )) * (float2( 1,1 ) - float2( -1,-1 )) / (float2( 1,1 ) - float2( 0,0 ))) ) + _MaskStrenght ) ) * GlobalAmountVal ) );
				

				finalColor = tex2D( _MainTex, saturate( temp_output_52_0 ) );

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=17800
236;384;1522;674;2192.028;-28.86783;1;True;False
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;2;-1090.206,-557.9776;Inherit;False;0;0;_MainTex;Shader;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;80;-1787.131,473.1967;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-1594.01,611.597;Inherit;False;Global;GlobalSpeedVal;GlobalSpeedVal;4;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;78;-1840.86,275.2751;Inherit;False;Property;_Speed;Speed;3;0;Create;True;0;0;False;0;1;5;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;72;-1673.747,-4.694371;Inherit;False;0;58;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;79;-1286.013,365.5494;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-895.2437,-347.986;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;71;-1398.409,90.36187;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.1,-0.3;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;73;-900.9385,362.0149;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;-1,-1;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;58;-1134.65,-49.23587;Inherit;True;Property;_RenderTex;RenderTex;0;0;Create;True;0;0;False;0;-1;f9bd85ea2601b824c87556c13e852933;ee200f7f49ef75a44a1bceddf22c0b15;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;75;-824.3335,713.2434;Inherit;False;Property;_MaskStrenght;MaskStrenght;2;0;Create;True;0;0;False;0;0;-0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;74;-669.3805,433.0492;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;65;-782.5688,18.86795;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;76;-517.1865,547.8193;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;-0.38;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;62;-582.9675,123.564;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;-1,-1;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;77;-165.0716,440.9002;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-578.6809,311.9776;Inherit;False;Property;_Distort;Distort;1;0;Create;True;0;0;False;0;0;0.01;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;82;-474.8275,404.9749;Inherit;False;Global;GlobalAmountVal;GlobalAmountVal;4;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;-349.6151,121.1396;Inherit;True;4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;52;-200.5039,-118.7214;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;64;31.61353,65.07376;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;59;-725.3137,-52.99896;Inherit;False;FLOAT2;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;70;-2498.272,149.7312;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;63;10.15656,-137.0064;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;68;-2472.077,-17.11378;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;248.5722,-322.7951;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;69;-2293.837,131.8223;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;67;-2669.077,289.8863;Inherit;False;True;True;True;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GrabScreenPosition;66;-2752.077,-37.11375;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;738.6296,-127.1351;Float;False;True;-1;2;ASEMaterialInspector;0;2;Hej-WorldDistort;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;True;2;False;-1;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;0
WireConnection;79;0;78;0
WireConnection;79;1;80;0
WireConnection;79;2;81;0
WireConnection;4;2;2;0
WireConnection;71;0;72;0
WireConnection;71;1;79;0
WireConnection;73;0;4;0
WireConnection;58;1;71;0
WireConnection;74;0;73;0
WireConnection;65;0;58;1
WireConnection;65;1;58;2
WireConnection;76;0;74;0
WireConnection;76;1;75;0
WireConnection;62;0;65;0
WireConnection;77;0;76;0
WireConnection;60;0;62;0
WireConnection;60;1;61;0
WireConnection;60;2;77;0
WireConnection;60;3;82;0
WireConnection;52;0;4;0
WireConnection;52;1;60;0
WireConnection;64;0;52;0
WireConnection;59;0;58;0
WireConnection;70;0;66;2
WireConnection;63;0;52;0
WireConnection;68;0;66;1
WireConnection;68;1;70;0
WireConnection;1;0;2;0
WireConnection;1;1;64;0
WireConnection;69;0;68;0
WireConnection;0;0;1;0
ASEEND*/
//CHKSM=B63987DD344DFCB4C8EBF1295093FE7758984310