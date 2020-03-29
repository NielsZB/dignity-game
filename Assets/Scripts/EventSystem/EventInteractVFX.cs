using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(EventInteract))]
public class EventInteractVFX : MonoBehaviour
{
    [SerializeField]
    GameObject objectToHighlight = null;

    [SerializeField]
    float duration = 1;
    [SerializeField]
    AnimationCurve highlight = AnimationCurve.EaseInOut(0, 0, 1, 1);
    [SerializeField]
    AnimationCurve dehighlight = AnimationCurve.EaseInOut(0, 0, 1, 1);

    float t = 0;
    float previousValue = 0;
    float value = 0;


    bool mouseOver = false;


    Renderer[] renderers;

    MaterialPropertyBlock propertyBlock;

    private void Start()
    {
        if (objectToHighlight == null)
        {
            objectToHighlight = gameObject;
        }

        renderers = objectToHighlight.GetComponentsInChildren<Renderer>();

        propertyBlock = new MaterialPropertyBlock();
    }

    void UpdateRendererProperty(float value)
    {
        if (renderers.Length > 0)
        {
            for (int i = 0; i < renderers.Length; i++)
            {
                renderers[i].GetPropertyBlock(propertyBlock);

                propertyBlock.SetFloat("_PROPERTY", value);

                renderers[i].SetPropertyBlock(propertyBlock);
            }
        }
    }




    private void Update()
    {
        previousValue = value;

        if (mouseOver)
        {
            if (t < 1)
            {
                t += Time.deltaTime / duration;
            }
            else
            {
                t = 1;
            }

            value = highlight.Evaluate(t);
        }
        else
        {

            if (t > 0)
            {
                t -= Time.deltaTime / duration;
            }
            else
            {
                t = 0;
            }

            value = dehighlight.Evaluate(1 - t);
        }

        if (value != previousValue)
        {
            UpdateRendererProperty(value);
            previousValue = value;
        }
    }


    private void OnMouseEnter()
    {
        mouseOver = true;
    }

    private void OnMouseExit()
    {
        mouseOver = false;
    }
}
