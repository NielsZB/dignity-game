using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using NaughtyAttributes;
public class EventInteract : EventBase
{
    [SerializeField]
    bool broadcast = false;
    [SerializeField, Dropdown("MethodNames"), ShowIf(ConditionOperator.And, "broadcast")]
    string responseMethod = default;

    string[] MethodNames = new string[] { "OnResponse", "Play", "Pause", "Stop" };


    [SerializeField]
    bool triggerEvent = false;
    [SerializeField, ShowIf(ConditionOperator.And, "triggerEvent")]
    UnityEvent responseEvent;

    private void OnMouseDown()
    {
        if (InRange)
        {
            if(broadcast)
            {
                SendMessage(responseMethod, SendMessageOptions.DontRequireReceiver);
            }

            if(triggerEvent)
            {
                responseEvent.Invoke();
            }
        }
    }
}
