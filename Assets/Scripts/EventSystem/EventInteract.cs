using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using NaughtyAttributes;
public class EventInteract : EventBase
{
    [Space(10)]

    [SerializeField]
    UnityEvent responseEvent;

    private void OnMouseDown()
    {
        if (InRange)
        {
            responseEvent.Invoke();
        }
    }
}
