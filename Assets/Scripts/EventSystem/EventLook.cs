using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using NaughtyAttributes;
public class EventLook : EventBase
{
    enum lookType
    {
        At,
        Away
    }
    [Space(10)]
    [SerializeField]
    lookType look = default;

    [SerializeField]
    float angle;

    [SerializeField]
    UnityEvent response = default;

    Transform lookTransform;

    bool triggered = false;
    protected override void Start()
    {
        base.Start();
        lookTransform = Camera.main.transform;
    }

    private void Update()
    {
        if (InRange && !triggered)
        {
            Vector3 direction = transform.position - lookTransform.position;
            float currentAngle = Vector3.Angle(lookTransform.forward, direction);

            
            if (look == lookType.At)
            {
                if (currentAngle <= angle)
                {
                    response.Invoke();
                    triggered = true;

                }
            }
            else
            {
                if (currentAngle >= angle)
                {
                    response.Invoke();
                    triggered = true;

                }
            }
        }
    }

}
