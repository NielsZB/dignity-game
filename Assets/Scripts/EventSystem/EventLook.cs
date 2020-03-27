using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using NaughtyAttributes;
public class EventLook : EventBase
{
    enum TriggerMode
    {
        OnVisible,
        OnInvisible,
        Angle
    }

    [SerializeField]
    TriggerMode mode;

    enum lookType
    {
        At,
        Away
    }

    [SerializeField, ShowIf("lookAngle")]
    lookType look = default;

    [SerializeField, ShowIf("lookAngle")]
    float angle;


    [SerializeField]
    bool broadcast = false;
    [SerializeField, Dropdown("MethodNames"), ShowIf("broadcast")]
    string responseMethod = default;
    [SerializeField]
    bool triggerEvent = false;
    [SerializeField, ShowIf("triggerEvent")]
    UnityEvent responseEvent = default;


    string[] MethodNames = new string[] { "OnResponse", "Play", "Pause", "Stop" };

    Transform lookTransform;

    bool visible() => mode == TriggerMode.OnVisible;
    bool invisible() => mode == TriggerMode.OnInvisible;
    bool lookAngle() => mode == TriggerMode.Angle;

    protected override void Start()
    {
        base.Start();
        lookTransform = Camera.main.transform;
    }

    private void Update()
    {
        if (InRange)
        {
            if (mode == TriggerMode.Angle)
            {
                Vector3 direction = transform.position - lookTransform.position;
                float currentAngle = Vector3.Angle(lookTransform.forward, direction);

                if(look == lookType.At)
                {
                    if(currentAngle <= angle)
                    {
                        if (broadcast)
                        {
                            SendMessage(responseMethod, SendMessageOptions.DontRequireReceiver);
                        }

                        if (triggerEvent)
                        {
                            responseEvent.Invoke();
                        }
                    }
                }
                else
                {
                    if (currentAngle >= angle)
                    {
                        if (broadcast)
                        {
                            SendMessage(responseMethod, SendMessageOptions.DontRequireReceiver);
                        }

                        if (triggerEvent)
                        {
                            responseEvent.Invoke();
                        }
                    }
                }
            }
        }
    }

}
