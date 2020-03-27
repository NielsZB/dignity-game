// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hej"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		_Float1("Float 1", Float) = 0

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
			
			uniform float _Float1;


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
				float2 temp_output_30_0 = ( uv0_MainTex + _Float1 );
				float2 temp_output_50_0 = ( temp_output_30_0 + _Float1 );
				float2 temp_output_51_0 = ( temp_output_50_0 + _Float1 );
				float2 temp_cast_0 = (_Float1).xx;
				float2 temp_output_57_0 = ( uv0_MainTex - temp_cast_0 );
				float2 temp_cast_1 = (_Float1).xx;
				float2 temp_cast_2 = (_Float1).xx;
				float2 temp_output_58_0 = ( temp_output_57_0 - temp_cast_2 );
				float2 temp_cast_3 = (_Float1).xx;
				float2 temp_cast_4 = (_Float1).xx;
				float2 temp_cast_5 = (_Float1).xx;
				float2 temp_output_59_0 = ( temp_output_58_0 - temp_cast_5 );
				float2 temp_cast_6 = (_Float1).xx;
				float2 temp_cast_7 = (_Float1).xx;
				float2 temp_cast_8 = (_Float1).xx;
				float2 temp_cast_9 = (_Float1).xx;
				float temp_output_8_0 = length( (float2( -1,-1 ) + (uv0_MainTex - float2( 0,0 )) * (float2( 1,1 ) - float2( -1,-1 )) / (float2( 1,1 ) - float2( 0,0 ))) );
				float4 lerpResult35 = lerp( tex2D( _MainTex, uv0_MainTex ) , ( ( ( tex2D( _MainTex, temp_output_30_0 ) + tex2D( _MainTex, temp_output_50_0 ) + tex2D( _MainTex, temp_output_51_0 ) + tex2D( _MainTex, ( temp_output_51_0 + _Float1 ) ) ) + ( tex2D( _MainTex, temp_output_57_0 ) + tex2D( _MainTex, temp_output_58_0 ) + tex2D( _MainTex, temp_output_59_0 ) + tex2D( _MainTex, ( temp_output_59_0 - temp_cast_9 ) ) ) ) / 8.0 ) , temp_output_8_0);
				

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
296;679;1522;540;294.0307;-623.5509;1;True;True
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;2;-1253.421,-184.914;Inherit;False;0;0;_MainTex;Shader;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;29;-877.9669,169.5677;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;36;-1159.262,996.3845;Inherit;False;Property;_Float1;Float 1;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;-482.3977,411.0703;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;57;-420.9672,1400.169;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;58;-429.2935,1647.824;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;50;-473.2698,644.4829;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;59;-428.4267,1889.313;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;51;-424.5013,861.5804;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;60;-415.777,2103.44;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;52;-429.182,1125.488;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;39;-263.8264,1126.921;Inherit;True;Property;_TextureSample6;Texture Sample 6;1;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;26;-295.4451,632.1572;Inherit;True;Property;_TextureSample5;Texture Sample 5;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;54;-261.1679,1372.379;Inherit;True;Property;_TextureSample8;Texture Sample 8;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;25;-271.8437,877.8666;Inherit;True;Property;_TextureSample4;Texture Sample 4;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;56;-270.2313,1628.149;Inherit;True;Property;_TextureSample10;Texture Sample 10;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;55;-246.6299,1873.858;Inherit;True;Property;_TextureSample9;Texture Sample 9;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;53;-253.8945,2110.178;Inherit;True;Property;_TextureSample7;Texture Sample 7;1;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;23;-286.3817,376.3872;Inherit;True;Property;_TextureSample2;Texture Sample 2;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;61;326.3234,1173.636;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-1437.672,19.37471;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;62;331.3097,951.3489;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;9;-1881.765,105.09;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;-1,-1;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;28;380.0154,693.9388;Inherit;False;Constant;_2;2;5;0;Create;True;0;0;False;0;8;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;63;579.5461,948.1843;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;1;162.3673,-96.19594;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;27;695.5518,543.764;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;4;False;1;COLOR;0
Node;AmplifyShaderEditor.LengthOpNode;8;-1316.954,196.3897;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-1425.574,811.0305;Inherit;False;Property;_Float0;Float 0;0;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;-1244.688,766.215;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;-719.4838,449.2444;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;35;887.9766,209.4608;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;49;-1011.012,481.5968;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;3;-1120.68,-7.879998;Inherit;False;FLOAT2;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;7;-672.3375,-53.81099;Inherit;True;Property;_TextureSample1;Texture Sample 1;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;24;-186.5717,102.851;Inherit;True;Property;_TextureSample3;Texture Sample 3;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;1451.946,435.2874;Float;False;True;-1;2;ASEMaterialInspector;0;2;Hej;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;True;2;False;-1;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;0
WireConnection;29;2;2;0
WireConnection;30;0;29;0
WireConnection;30;1;36;0
WireConnection;57;0;29;0
WireConnection;57;1;36;0
WireConnection;58;0;57;0
WireConnection;58;1;36;0
WireConnection;50;0;30;0
WireConnection;50;1;36;0
WireConnection;59;0;58;0
WireConnection;59;1;36;0
WireConnection;51;0;50;0
WireConnection;51;1;36;0
WireConnection;60;0;59;0
WireConnection;60;1;36;0
WireConnection;52;0;51;0
WireConnection;52;1;36;0
WireConnection;39;0;2;0
WireConnection;39;1;52;0
WireConnection;26;0;2;0
WireConnection;26;1;50;0
WireConnection;54;0;2;0
WireConnection;54;1;57;0
WireConnection;25;0;2;0
WireConnection;25;1;51;0
WireConnection;56;0;2;0
WireConnection;56;1;58;0
WireConnection;55;0;2;0
WireConnection;55;1;59;0
WireConnection;53;0;2;0
WireConnection;53;1;60;0
WireConnection;23;0;2;0
WireConnection;23;1;30;0
WireConnection;61;0;54;0
WireConnection;61;1;56;0
WireConnection;61;2;55;0
WireConnection;61;3;53;0
WireConnection;4;2;2;0
WireConnection;62;0;23;0
WireConnection;62;1;26;0
WireConnection;62;2;25;0
WireConnection;62;3;39;0
WireConnection;9;0;4;0
WireConnection;63;0;62;0
WireConnection;63;1;61;0
WireConnection;1;0;2;0
WireConnection;1;1;4;0
WireConnection;27;0;63;0
WireConnection;27;1;28;0
WireConnection;8;0;9;0
WireConnection;45;0;44;0
WireConnection;45;1;49;0
WireConnection;41;0;49;0
WireConnection;41;1;36;0
WireConnection;35;0;1;0
WireConnection;35;1;27;0
WireConnection;35;2;8;0
WireConnection;49;0;8;0
WireConnection;3;0;4;0
WireConnection;7;0;2;0
WireConnection;7;1;3;0
WireConnection;24;0;2;0
WireConnection;24;1;29;0
WireConnection;0;0;35;0
ASEEND*/
//CHKSM=8881B529CE582752F9E18C6ACC7C6BCF16B70690