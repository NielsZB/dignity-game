// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Blood_Subtle"
{
	Properties
	{
		_TessValue( "Max Tessellation", Range( 1, 32 ) ) = 1
		_MainTex("MainTex", 2D) = "white" {}
		_Color("Color", Color) = (0,0,0,0)
		_Smoothness("Smoothness", Range( 0 , 1)) = 1
		_Normal("Normal", 2D) = "bump" {}
		_Alpha("Alpha", Range( 0 , 1)) = 1
		_ErosionTex("ErosionTex", 2D) = "white" {}
		_Erosion_Val("Erosion_Val", Range( 0 , 1)) = 0
		_DistortTex("DistortTex", 2D) = "white" {}
		_Float1("Float 1", Range( 0 , 1)) = 0
		_Norm_Polar("Norm_Polar", Vector) = (0,0,0,0)
		_Depth("Depth", Float) = 0
		_ChangeVal("ChangeVal", Range( 0 , 1)) = 1
		[Toggle(_USEPOLAR_ON)] _UsePolar("UsePolar", Float) = 0
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Float3("Float 3", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityCG.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 5.0
		#pragma shader_feature_local _USEPOLAR_ON
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
			float4 screenPos;
		};

		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float _Float3;
		uniform float _ChangeVal;
		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform float4 _Norm_Polar;
		uniform sampler2D _DistortTex;
		uniform float _Float1;
		uniform float4 _Color;
		uniform float _Smoothness;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform sampler2D _ErosionTex;
		uniform float4 _ErosionTex_ST;
		uniform float _Erosion_Val;
		uniform float _Alpha;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _Depth;
		uniform float _TessValue;

		float4 tessFunction( )
		{
			return _TessValue;
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float3 ase_vertexNormal = v.normal.xyz;
			float2 uv0_TextureSample0 = v.texcoord.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float4 tex2DNode38 = tex2Dlod( _TextureSample0, float4( uv0_TextureSample0, 0, 0.0) );
			float temp_output_40_0 = sin( ( ( _Time.y + tex2DNode38.r ) * 12.0 ) );
			v.vertex.xyz += ( ase_vertexNormal * saturate( ( temp_output_40_0 * tex2DNode38.r ) ) * _Float3 * _ChangeVal );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			float3 tex2DNode75 = UnpackNormal( tex2D( _Normal, uv_Normal ) );
			float2 uv0_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			float2 CenteredUV15_g1 = ( uv0_Normal - float2( 0.5,0.5 ) );
			float2 break17_g1 = CenteredUV15_g1;
			float2 appendResult23_g1 = (float2(( length( CenteredUV15_g1 ) * _Norm_Polar.x * 2.0 ) , ( atan2( break17_g1.x , break17_g1.y ) * _Norm_Polar.y * ( 1.0 / 6.28318548202515 ) )));
			float2 appendResult63 = (float2(_Norm_Polar.z , _Norm_Polar.w));
			float2 panner58 = ( 1.0 * _Time.y * appendResult63 + float2( 0,0 ));
			#ifdef _USEPOLAR_ON
				float2 staticSwitch64 = ( appendResult23_g1 + panner58 );
			#else
				float2 staticSwitch64 = uv0_Normal;
			#endif
			float2 panner22 = ( 1.0 * _Time.y * float2( 0.05,0.05 ) + i.uv_texcoord);
			float4 tex2DNode23 = tex2D( _DistortTex, panner22 );
			float2 appendResult24 = (float2(tex2DNode23.rg));
			float2 temp_output_27_0 = ( (float2( -1,-1 ) + (appendResult24 - float2( 0,0 )) * (float2( 1,1 ) - float2( -1,-1 )) / (float2( 1,1 ) - float2( 0,0 ))) * _Float1 );
			float3 lerpResult77 = lerp( tex2DNode75 , BlendNormals( tex2DNode75 , UnpackNormal( tex2D( _Normal, ( staticSwitch64 + temp_output_27_0 ) ) ) ) , _ChangeVal);
			o.Normal = lerpResult77;
			o.Albedo = _Color.rgb;
			o.Smoothness = _Smoothness;
			float2 uv0_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 uv_ErosionTex = i.uv_texcoord * _ErosionTex_ST.xy + _ErosionTex_ST.zw;
			float4 tex2DNode14 = tex2D( _ErosionTex, uv_ErosionTex );
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth34 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth34 = abs( ( screenDepth34 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _Depth ) );
			float temp_output_36_0 = saturate( distanceDepth34 );
			o.Alpha = ( ( tex2D( _MainTex, ( uv0_MainTex + temp_output_27_0 ) ).r * saturate( ( tex2DNode14.r - (-1.0 + (_Erosion_Val - -1.0) * (1.0 - -1.0) / (1.0 - -1.0)) ) ) ) * _Alpha * i.vertexColor.a * temp_output_36_0 );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float4 screenPos : TEXCOORD3;
				float4 tSpace0 : TEXCOORD4;
				float4 tSpace1 : TEXCOORD5;
				float4 tSpace2 : TEXCOORD6;
				half4 color : COLOR0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.screenPos = ComputeScreenPos( o.pos );
				o.color = v.color;
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.screenPos = IN.screenPos;
				surfIN.vertexColor = IN.color;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17800
2261;352;1522;594;1195.08;103.7185;2.576826;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;21;-3094.006,192.8338;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;22;-2821.494,300.8487;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.05,0.05;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;62;-2435.719,-239.1262;Inherit;False;Property;_Norm_Polar;Norm_Polar;15;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;47;-829.6079,1326.06;Inherit;False;0;38;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;23;-2803.651,65.77858;Inherit;True;Property;_DistortTex;DistortTex;13;0;Create;True;0;0;False;0;-1;4d441829284fc924a8483ae911b4389e;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;16;-2460.477,-323.5746;Inherit;False;0;5;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;63;-2156.612,-135.6838;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;59;-1899.543,-460.0333;Inherit;True;Polar Coordinates;-1;;1;7dab8e02884cf104ebefaa2e788e4162;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;58;-1936.837,-219.93;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0.29,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;38;-381.4602,1575.883;Inherit;True;Property;_TextureSample0;Texture Sample 0;19;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;39;-227.6634,982.503;Inherit;True;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;24;-2366.57,153.1949;Inherit;False;FLOAT2;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;41;120.1538,1072.041;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;46;378.1902,1479.836;Inherit;False;Constant;_Float0;Float 0;12;0;Create;True;0;0;False;0;12;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-1750.155,1004.242;Inherit;False;Property;_Erosion_Val;Erosion_Val;12;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-2166.972,416.119;Inherit;False;Property;_Float1;Float 1;14;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;25;-2211.643,109.986;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;-1,-1;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;60;-1490.38,-324.2452;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;64;-1468.809,-132.5921;Inherit;False;Property;_UsePolar;UsePolar;18;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;14;-1517.267,469.3609;Inherit;True;Property;_ErosionTex;ErosionTex;11;0;Create;True;0;0;False;0;-1;None;ead51f3d4eb04bd4c8e35c1b31ce4eba;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-1948.644,265.5858;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;199.9532,1138.398;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-1555.599,195.8374;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;11;-1289.563,866.0465;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;18;-1350.199,225.7374;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;12;-983.4758,784.8284;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-729.8852,363.9799;Inherit;False;Property;_Depth;Depth;16;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;40;469.1247,1052.968;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-1233.975,-91.77692;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;75;-714.5203,-418.0073;Inherit;True;Property;_TextureSample1;Texture Sample 1;8;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;True;Instance;5;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;5;-985.9444,-46.4447;Inherit;True;Property;_Normal;Normal;8;0;Create;True;0;0;False;0;-1;None;a39b9c51c34d0074cbb60524ea468047;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DepthFade;34;-528.3853,246.9799;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;15;-779.89,695.8981;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;1017.642,1121.288;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1223.102,203.7408;Inherit;True;Property;_MainTex;MainTex;5;0;Create;True;0;0;False;0;-1;None;1d0e3bcaebe294c488568d6c9bdf3b13;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;76;1563.538,1163.358;Inherit;False;Property;_ChangeVal;ChangeVal;17;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-582.9384,673.1923;Inherit;False;Property;_Alpha;Alpha;10;0;Create;True;0;0;False;0;1;0.75;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;33;-459.2476,821.3499;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendNormalsNode;65;315.5251,-123.1068;Inherit;True;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalVertexDataNode;55;1177.218,659.6603;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;36;-249.009,282.3099;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;52;1255.853,949.1823;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;57;1506.058,1004.585;Inherit;False;Property;_Float3;Float 3;20;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-664.9384,490.6902;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;310.286,378.3773;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2.94;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;9;-2225.347,896.5493;Inherit;False;1;0;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;1556.098,750.8062;Inherit;True;4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;2;716.9841,-215.7714;Inherit;False;Property;_Color;Color;6;0;Create;True;0;0;False;0;0,0,0,0;0.246351,0.2701521,0.3018868,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;50;-446.9686,1355.751;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;-1,-1;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-247.0032,505.6429;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;49;-195.1039,1188.463;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1871.62,142.5316;Inherit;False;Property;_NormalStrenght;NormalStrenght;9;0;Create;True;0;0;False;0;0;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;68;-144.9569,15.66262;Inherit;False;Constant;_Vector2;Vector 2;16;0;Create;True;0;0;False;0;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SaturateNode;48;795.9006,1085.25;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;37;-121.9334,198.5238;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-1220.378,730.9945;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;70;239.8479,247.1385;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.7;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;29;-1614.087,748.2036;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-463.4699,142.3148;Inherit;False;Property;_Smoothness;Smoothness;7;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;61;-2190.279,-89.97228;Inherit;False;Constant;_Vector1;Vector 1;14;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.OneMinusNode;51;103.38,562.1769;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;44;754.6129,842.5297;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;10;-1889.565,809.173;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;77;928.2239,192.6165;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1951.863,396.9017;Float;False;True;-1;7;ASEMaterialInspector;0;0;Standard;Blood_Subtle;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;1;False;-1;3;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;1;1;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;22;0;21;0
WireConnection;23;1;22;0
WireConnection;63;0;62;3
WireConnection;63;1;62;4
WireConnection;59;1;16;0
WireConnection;59;3;62;1
WireConnection;59;4;62;2
WireConnection;58;2;63;0
WireConnection;38;1;47;0
WireConnection;24;0;23;0
WireConnection;41;0;39;0
WireConnection;41;1;38;1
WireConnection;25;0;24;0
WireConnection;60;0;59;0
WireConnection;60;1;58;0
WireConnection;64;1;16;0
WireConnection;64;0;60;0
WireConnection;27;0;25;0
WireConnection;27;1;26;0
WireConnection;45;0;41;0
WireConnection;45;1;46;0
WireConnection;11;0;32;0
WireConnection;18;0;20;0
WireConnection;18;1;27;0
WireConnection;12;0;14;1
WireConnection;12;1;11;0
WireConnection;40;0;45;0
WireConnection;17;0;64;0
WireConnection;17;1;27;0
WireConnection;5;1;17;0
WireConnection;34;0;35;0
WireConnection;15;0;12;0
WireConnection;43;0;40;0
WireConnection;43;1;38;1
WireConnection;1;1;18;0
WireConnection;65;0;75;0
WireConnection;65;1;5;0
WireConnection;36;0;34;0
WireConnection;52;0;43;0
WireConnection;13;0;1;1
WireConnection;13;1;15;0
WireConnection;69;0;38;1
WireConnection;56;0;55;0
WireConnection;56;1;52;0
WireConnection;56;2;57;0
WireConnection;56;3;76;0
WireConnection;50;0;47;0
WireConnection;7;0;13;0
WireConnection;7;1;8;0
WireConnection;7;2;33;4
WireConnection;7;3;36;0
WireConnection;49;0;50;0
WireConnection;48;0;44;0
WireConnection;37;0;36;0
WireConnection;31;0;14;1
WireConnection;31;1;23;1
WireConnection;70;0;51;0
WireConnection;29;0;23;1
WireConnection;29;1;10;0
WireConnection;51;0;49;0
WireConnection;44;0;40;0
WireConnection;10;0;9;0
WireConnection;77;0;75;0
WireConnection;77;1;65;0
WireConnection;77;2;76;0
WireConnection;0;0;2;0
WireConnection;0;1;77;0
WireConnection;0;4;4;0
WireConnection;0;9;7;0
WireConnection;0;11;56;0
ASEEND*/
//CHKSM=D7DD900D8BB7E1A278756C89021DF01A3AEA7958