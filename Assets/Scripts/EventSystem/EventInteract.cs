using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using NaughtyAttributes;
public class EventInteract : EventBase
{
    [Space(10)]

    [SerializeField]
    float delay = 0;
    [SerializeField]
    UnityEvent response = default;

    bool triggered = false;

    IEnumerator ResponseDelayed
    {
        get
        {
            float t = 0;
            while (t < 1)
            {
                t += Time.deltaTime / delay;
                yield return null;
            }

            response.Invoke();
        }
    }
    private void OnMouseDown()
    {
        if (!triggered && InRange)
        {
            if (delay > 0)
            {
                StartCoroutine(ResponseDelayed);
            }
            else
            {
                response.Invoke();
            }
            triggered = true;
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
