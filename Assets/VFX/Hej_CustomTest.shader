// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hej_CustomTest"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		_MaskStrenght("MaskStrenght", Float) = -0.56
		[IntRange]_Steps("Steps", Range( 1 , 200)) = 1
		_OffsetVal("OffsetVal", Float) = 0

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
			
			uniform float _Steps;
			uniform float _OffsetVal;
			uniform float _MaskStrenght;
			float4 MyCustomExpression87( sampler2D Tex , float Steps , float2 UV , float Offset , float Mask )
			{
				float4 result;
				float4 a;
				float4 b;
				float4 offsetDir;
				float totalOffset;
				float2 test;
				for(int i = 0; i < Steps; ++i)
				{
				totalOffset += Offset /Steps;
				test = (((float2(-0.5,-0.5) +  (UV - float2( 0,0 )) * (float2( 0.5,0.5 ) - float2( -0.5,-0.5 )) / (float2( 1,1 ) - float2( 0,0 ))) * (1+(Offset*(i/Steps))))+ float2( 0.5,0.5 ) );
								
				offsetDir += tex2D(Tex, lerp(UV, test,Mask));
				result =offsetDir / Steps;
				}
				float4 reg = tex2D(Tex, UV);
				//return lerp(reg,result,Mask);
				return result;
			}
			


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
				sampler2D Tex87 = _MainTex;
				float Steps87 = _Steps;
				float2 uv0_MainTex = i.uv.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 UV87 = uv0_MainTex;
				float Offset87 = _OffsetVal;
				float Mask87 = saturate( ( length( (float2( -1,-1 ) + (uv0_MainTex - float2( 0,0 )) * (float2( 1,1 ) - float2( -1,-1 )) / (float2( 1,1 ) - float2( 0,0 ))) ) + _MaskStrenght ) );
				float4 localMyCustomExpression87 = MyCustomExpression87( Tex87 , Steps87 , UV87 , Offset87 , Mask87 );
				

				finalColor = localMyCustomExpression87;

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=17800
2086;401;1843;714;870.3738;696.9675;1;True;False
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;2;-686.489,-836.2928;Inherit;False;0;0;_MainTex;Shader;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-1226.636,-232.8248;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;92;-727.185,-1312.805;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;-1,-1;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LengthOpNode;93;-505.322,-1323.618;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;91;-674.494,-993.308;Inherit;False;Property;_MaskStrenght;MaskStrenght;2;0;Create;True;0;0;False;0;-0.56;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;90;-298.0011,-1186.707;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;-0.38;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-309.6167,-601.3616;Inherit;False;Property;_Steps;Steps;3;1;[IntRange];Create;True;0;0;False;0;1;0;1;200;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;64;-152.1746,-421.0853;Inherit;False;Property;_OffsetVal;OffsetVal;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;89;-50.29231,-1192.107;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;411.0433,-372.8757;Inherit;False;Constant;_Float3;Float 3;4;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;84;845.1578,-249.7168;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;72;-153.5667,-135.4714;Inherit;False;Constant;_Float2;Float 2;5;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;495.1137,-183.3361;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CustomExpressionNode;61;199.4412,-627.0336;Inherit;False;float4 result@$float4 a@$float4 b@$float4 offsetDir@$float totalOffset@$float2 test@$for(int i = 0@ i < iterations@ ++i)${$float time = i/iterations@$$totalOffset += offset * 0.01@$test = float2(UV * totalOffset)@$offsetDir += tex2D(Tex, (UV + test ))@$$//result += (offsetDir +(i/iterations))@$$a = offsetDir / iterations@$//result *= offsetDir +(i/iterations)@$$}$$for(int z = 0@ z < iterations@ ++z)${$float time = i/iterations@$$totalOffset += offset * 0.01@$test = float2(UV * totalOffset)@$offsetDir += tex2D(Tex, (UV - test ))@$$b = offsetDir / iterations@$$}$$result = (a + b)/2@$return result@;4;False;4;True;Tex;SAMPLER2D;0,0,0,0;In;;Float;False;True;iterations;FLOAT;0;In;;Float;False;True;UV;FLOAT2;0,0;In;;Float;False;True;offset;FLOAT;0;In;;Float;False;My Custom Expression;True;False;0;4;0;SAMPLER2D;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TFHCRemapNode;19;-863.5016,236.8822;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;-0.5,-0.5;False;4;FLOAT2;0.5,0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;14;-276.3393,369.01;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;88;455.1501,-693.3654;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.OneMinusNode;59;-256.584,105.082;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;9;-1501.589,-163.1029;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;-1,-1;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;18;-663.326,487.8421;Inherit;False;Constant;_Vector0;Vector 0;4;0;Create;True;0;0;False;0;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;77;476.5808,-311.2365;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;80.15857,-225.1157;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;78;233.8563,-162.6264;Inherit;False;float4 result@$float4 BW@$float4 BW2@$float totalOffset@$float2 test@$for(int i = 0@ i < iterations@ ++i)${$totalOffset += offset * 0.01@$test = float2(UV * totalOffset)@$BW = tex2D(Tex, (UV + test))@$BW2 = tex2D(Tex, (UV - test))@$$result += clamp(BW +(i/iterations),0,1)@$}$$result /= iterations@$$return result@;4;False;4;True;Tex;SAMPLER2D;0,0,0,0;In;;Float;False;True;iterations;FLOAT;0;In;;Float;False;True;UV;FLOAT2;0,0;In;;Float;False;True;offset;FLOAT;0;In;;Float;False;My Custom Expression;True;False;0;4;0;SAMPLER2D;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CustomExpressionNode;87;203.5276,-854.8595;Inherit;False;float4 result@$float4 a@$float4 b@$float4 offsetDir@$float totalOffset@$float2 test@$for(int i = 0@ i < Steps@ ++i)${$$$totalOffset += Offset /Steps@$$test = (((float2(-0.5,-0.5) +  (UV - float2( 0,0 )) * (float2( 0.5,0.5 ) - float2( -0.5,-0.5 )) / (float2( 1,1 ) - float2( 0,0 ))) * (1+(Offset*(i/Steps))))+ float2( 0.5,0.5 ) )@$				$offsetDir += tex2D(Tex, lerp(UV, test,Mask))@$$$$result =offsetDir / Steps@$$}$$float4 reg = tex2D(Tex, UV)@$//return lerp(reg,result,Mask)@$return result@;4;False;5;True;Tex;SAMPLER2D;;In;;Float;False;True;Steps;FLOAT;0;In;;Float;False;True;UV;FLOAT2;0,0;In;;Float;False;True;Offset;FLOAT;0;In;;Float;False;True;Mask;FLOAT;0;In;;Float;False;My Custom Expression;True;False;0;5;0;SAMPLER2D;;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-508.0461,346.8931;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LengthOpNode;8;-812.9365,-422.8356;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;49;-480.5294,-20.33709;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-1116.298,508.2542;Inherit;False;Property;_Pinch;Pinch;0;0;Create;True;0;0;False;0;1;0.95;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-529.1834,-683.218;Inherit;False;Property;_Strenght;Strenght;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;96;-371.7289,-858.3682;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;58;-71.48755,67.58325;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;80;622.7592,-308.4179;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SaturateNode;16;-88.50904,347.9437;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;47;-691.3581,-46.94199;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;-0.38;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1098.501,-704.9549;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;797.2838,-649.8634;Float;False;True;-1;2;ASEMaterialInspector;0;2;Hej_CustomTest;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;True;2;False;-1;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;0
WireConnection;4;2;2;0
WireConnection;92;0;4;0
WireConnection;93;0;92;0
WireConnection;90;0;93;0
WireConnection;90;1;91;0
WireConnection;89;0;90;0
WireConnection;84;0;80;0
WireConnection;83;0;61;0
WireConnection;83;1;78;0
WireConnection;61;0;2;0
WireConnection;61;1;62;0
WireConnection;61;2;4;0
WireConnection;61;3;64;0
WireConnection;19;0;4;0
WireConnection;14;0;13;0
WireConnection;14;1;18;0
WireConnection;88;1;87;0
WireConnection;59;0;49;0
WireConnection;9;0;4;0
WireConnection;77;0;61;0
WireConnection;77;1;78;0
WireConnection;85;0;64;0
WireConnection;85;1;72;0
WireConnection;78;0;2;0
WireConnection;78;1;62;0
WireConnection;78;2;4;0
WireConnection;78;3;85;0
WireConnection;87;0;2;0
WireConnection;87;1;62;0
WireConnection;87;2;4;0
WireConnection;87;3;64;0
WireConnection;87;4;89;0
WireConnection;13;0;19;0
WireConnection;13;1;12;0
WireConnection;8;0;9;0
WireConnection;49;0;47;0
WireConnection;58;0;4;0
WireConnection;58;1;16;0
WireConnection;58;2;59;0
WireConnection;80;0;61;0
WireConnection;80;1;86;0
WireConnection;16;0;14;0
WireConnection;47;0;8;0
WireConnection;47;1;48;0
WireConnection;1;0;2;0
WireConnection;1;1;4;0
WireConnection;0;0;87;0
ASEEND*/
//CHKSM=B9947C3A09CCE1DED570EF7F6EA5912EA5A56F58