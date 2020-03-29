using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using NaughtyAttributes;
public class EventInteract : EventBase
{
    [Space(10)]

    [SerializeField]
    UnityEvent response;

    private void OnMouseDown()
    {
        if (InRange)
        {
            response.Invoke();
        }
    }

    private void OnMouseEnter()
    {
        
    }

    private void OnMouseExit()
    {

    }

    float t;
    float transitionDuration;

}
