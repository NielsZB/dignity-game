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
    [SerializeField]
    float delay = 0;
    [SerializeField, ShowIf("enter")]
    UnityEvent enterResponse = default;
    [SerializeField, ShowIf("exit")]
    UnityEvent exitResponse = default;


    bool enter() => triggerOn != TriggerMode.Exit;

    bool exit() => triggerOn != TriggerMode.Enter;

    bool enterTriggered = false;
    bool exitTriggered = false;

    IEnumerator ResponseDelayed(UnityEvent response)
    {
        float t = 0;
        while (t < 1)
        {
            t += Time.deltaTime / delay;
            yield return null;
        }

        response.Invoke();
    }

    void OnTriggerEnter(Collider other)
    {
        if (!enterTriggered && other.CompareTag("Player"))
        {
            if (triggerOn == TriggerMode.Enter || triggerOn == TriggerMode.EnterExit)
            {
                if (delay > 0)
                {
                    StartCoroutine(ResponseDelayed(enterResponse));
                }
                else
                {
                    enterResponse.Invoke();
                }

                enterTriggered = true;
            }
        }
    }

    void OnTriggerExit(Collider other)
    {
        if (!exitTriggered && other.CompareTag("Player"))
        {
            if (triggerOn == TriggerMode.Exit || triggerOn == TriggerMode.EnterExit)
            {
                if (delay > 0)
                {
                    StartCoroutine(ResponseDelayed(exitResponse));
                }
                else
                {
                    exitResponse.Invoke();
                }

                exitTriggered = true;
            }
        }
    }
}
