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
    [Space(10)]
    [SerializeField]
    TriggerMode triggerOn = default;

    [SerializeField, ShowIf("enter")]
    UnityEvent enterResponse = default;
    [SerializeField, ShowIf("exit")]
    UnityEvent exitResponse = default;


    bool enter() => triggerOn != TriggerMode.Exit;

    bool exit() => triggerOn != TriggerMode.Enter;

    void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            if (triggerOn == TriggerMode.Enter || triggerOn == TriggerMode.EnterExit)
            {
                enterResponse.Invoke();
            }
        }
    }

    void OnTriggerExit(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            if (triggerOn == TriggerMode.Exit || triggerOn == TriggerMode.EnterExit)
            {
                exitResponse.Invoke();
            }
        }
    }
}
