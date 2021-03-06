// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hej_Pinch"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		_Pinch("Pinch", Range( 0 , 2)) = 1
		_Strenght("Strenght", Float) = 0
		_Float1("Float 1", Range( 0 , 1)) = 0
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
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
			
			uniform float _Pinch;
			uniform float _Float1;
			uniform sampler2D _TextureSample2;
			uniform float _Speed;
			uniform float GlobalSpeedVal;
			uniform float GlobalAmountVal;
			uniform float _Strenght;


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
				float2 panner66 = ( ( _Speed * _Time.y * GlobalSpeedVal ) * float2( 0.5,0.25 ) + float2( 0,0 ));
				float temp_output_67_0 = ( _Float1 * tex2D( _TextureSample2, panner66 ).r * GlobalAmountVal );
				float lerpResult62 = lerp( 1.0 , _Pinch , temp_output_67_0);
				float2 temp_output_14_0 = ( ( (float2( -0.5,-0.5 ) + (uv0_MainTex - float2( 0,0 )) * (float2( 0.5,0.5 ) - float2( -0.5,-0.5 )) / (float2( 1,1 ) - float2( 0,0 ))) * lerpResult62 ) + float2( 0.5,0.5 ) );
				float temp_output_49_0 = saturate( ( length( (float2( -1,-1 ) + (uv0_MainTex - float2( 0,0 )) * (float2( 1,1 ) - float2( -1,-1 )) / (float2( 1,1 ) - float2( 0,0 ))) ) + _Strenght ) );
				float4 lerpResult60 = lerp( tex2D( _MainTex, uv0_MainTex ) , tex2D( _MainTex, temp_output_14_0 ) , temp_output_49_0);
				

				finalColor = lerpResult60;

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=17800
236;384;1522;674;1826.003;-211.8813;1.675932;True;False
Node;AmplifyShaderEditor.SimpleTimeNode;71;-1185.085,971.1198;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;73;-1266.279,1131.071;Inherit;False;Global;GlobalSpeedVal;GlobalSpeedVal;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-1366.085,838.1198;Inherit;False;Property;_Speed;Speed;4;0;Create;True;0;0;False;0;1;5;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;-1040.967,901.4727;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;66;-858.7227,887.2242;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.5,0.25;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;64;-1119.01,667.9824;Inherit;False;Property;_Float1;Float 1;2;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;65;-578.2328,1045.631;Inherit;True;Property;_TextureSample2;Texture Sample 2;3;0;Create;True;0;0;False;0;-1;None;ee200f7f49ef75a44a1bceddf22c0b15;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;74;-859.4426,736.6049;Inherit;False;Global;GlobalAmountVal;GlobalAmountVal;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;2;-1232.844,-589.8705;Inherit;False;0;0;_MainTex;Shader;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;12;-1116.298,508.2542;Inherit;False;Property;_Pinch;Pinch;0;0;Create;True;0;0;False;0;1;0.9;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;-612.4695,610.4208;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-466.2217,528.4922;Inherit;False;Constant;_Float0;Float 0;2;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-854.5212,-308.1942;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;19;-948.705,279.484;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;-0.5,-0.5;False;4;FLOAT2;0.5,0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;62;-266.6576,470.928;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;9;-1160.742,-178.1403;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;-1,-1;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-1079.551,79.35671;Inherit;False;Property;_Strenght;Strenght;1;0;Create;True;0;0;False;0;0;-0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;18;-663.326,487.8421;Inherit;False;Constant;_Vector0;Vector 0;4;0;Create;True;0;0;False;0;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.LengthOpNode;8;-895.0789,-90.05327;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-533.5143,255.9347;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;47;-691.3581,-46.94199;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;-0.38;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;14;-278.1585,316.2542;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;49;-425.7679,74.44264;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-28.00045,-430.1259;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;61;-10.75164,-196.0638;Inherit;True;Property;_TextureSample1;Texture Sample 1;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;59;-256.584,105.082;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;16;-88.50904,347.9437;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;58;170.9514,189.7725;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;60;465.6472,-191.3;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;-297.5837,613.0207;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;779.4258,-266.2132;Float;False;True;-1;2;ASEMaterialInspector;0;2;Hej_Pinch;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;True;2;False;-1;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;0
WireConnection;69;0;70;0
WireConnection;69;1;71;0
WireConnection;69;2;73;0
WireConnection;66;1;69;0
WireConnection;65;1;66;0
WireConnection;67;0;64;0
WireConnection;67;1;65;1
WireConnection;67;2;74;0
WireConnection;4;2;2;0
WireConnection;19;0;4;0
WireConnection;62;0;63;0
WireConnection;62;1;12;0
WireConnection;62;2;67;0
WireConnection;9;0;4;0
WireConnection;8;0;9;0
WireConnection;13;0;19;0
WireConnection;13;1;62;0
WireConnection;47;0;8;0
WireConnection;47;1;48;0
WireConnection;14;0;13;0
WireConnection;14;1;18;0
WireConnection;49;0;47;0
WireConnection;1;0;2;0
WireConnection;1;1;14;0
WireConnection;61;0;2;0
WireConnection;61;1;4;0
WireConnection;59;0;49;0
WireConnection;16;0;14;0
WireConnection;58;0;4;0
WireConnection;58;1;16;0
WireConnection;58;2;59;0
WireConnection;60;0;61;0
WireConnection;60;1;1;0
WireConnection;60;2;49;0
WireConnection;68;0;67;0
WireConnection;68;1;64;0
WireConnection;0;0;60;0
ASEEND*/
//CHKSM=89EE83FE693F00D6A64F5C957421329F4F2834C4