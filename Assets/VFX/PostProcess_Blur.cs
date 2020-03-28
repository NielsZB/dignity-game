using UnityEngine;

[ExecuteInEditMode]
public class PostProcess_Blur : MonoBehaviour
{
	public Material PostProcessMat;
	public float maskStrenght;
	public float offsetVal;
	private void Awake()
	{
		if( PostProcessMat == null )
		{
			enabled = false;
		}
		else
		{
			// This is on purpose ... it prevents the know bug
			// https://issuetracker.unity3d.com/issues/calling-graphics-dot-blit-destination-null-crashes-the-editor
			// from happening
			PostProcessMat.mainTexture = PostProcessMat.mainTexture;
		}

	}

	void Update()
	{
		PostProcessMat.SetFloat("_MaskStrenght", maskStrenght);
		PostProcessMat.SetFloat("_OffsetVal", offsetVal);
	}

	void OnRenderImage( RenderTexture src, RenderTexture dest )
	{
		Graphics.Blit( src, dest, PostProcessMat );
	}
}
