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
    Transform point = default;
    [SerializeField, Range(0,180)]
    float angle = 10f;

    [SerializeField]
    UnityEvent response = default;

    Transform lookTransform;

    bool triggered = false;
    protected override void Start()
    {
        base.Start();
        lookTransform = Camera.main.transform;
        if (point == null)
        {
            point = transform;
        }
    }

    private void Update()
    {
        if (InRange && !triggered)
        {
            Vector3 direction = point.position - lookTransform.position;
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
