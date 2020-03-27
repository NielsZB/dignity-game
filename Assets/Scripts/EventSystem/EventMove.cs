using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using NaughtyAttributes;

public class EventMove : EventBase
{
    enum TriggerMode
    {
        Enter,
        Exit,
        EnterExit
    }
    [SerializeField]
    TriggerMode triggerOn = default;


    [SerializeField]
    bool broadcast = false;
    [SerializeField, Dropdown("MethodNames"), ShowIf(ConditionOperator.And, "broadcast", "enter")]
    string enterMethod = default;
    [SerializeField, Dropdown("MethodNames"), ShowIf(ConditionOperator.And, "broadcast", "exit")]
    string exitMethod = default;


    [SerializeField]
    bool triggerEvent = false;
    [SerializeField, ShowIf(ConditionOperator.And, "triggerEvent", "enter")]
    UnityEvent enterEvent = default;
    [SerializeField, ShowIf(ConditionOperator.And, "triggerEvent", "exit")]
    UnityEvent exitEvent = default;


    string[] MethodNames = new string[] { "OnResponse", "Play", "Pause", "Stop" };

    bool enter() => triggerOn != TriggerMode.Exit;

    bool exit() => triggerOn != TriggerMode.Enter;

    void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            if (triggerOn == TriggerMode.Enter || triggerOn == TriggerMode.EnterExit)
            {
                if (triggerEvent)
                    enterEvent.Invoke();

                if (broadcast)
                    SendMessage(enterMethod);
            }
        }
    }

    void OnTriggerExit(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            if (triggerOn == TriggerMode.Exit || triggerOn == TriggerMode.EnterExit)
            {
                if (triggerEvent)
                    exitEvent.Invoke();

                if (broadcast)
                    SendMessage(exitMethod);
            }
        }
    }
}
