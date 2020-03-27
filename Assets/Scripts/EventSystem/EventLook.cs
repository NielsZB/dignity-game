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
    Transform point = default;
    [SerializeField, Range(0, 180)]
    float angle = 10f;
    [SerializeField]
    float delay = 0;
    [SerializeField]
    UnityEvent response = default;

    Transform lookTransform;

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
    protected override void Start()
    {
        base.Start();

        if (point == null)
        {
            point = transform;
        }

        lookTransform = Camera.main.transform;
    }

    private void Update()
    {
        if (global)
        {
            Vector3 direction = point.position - lookTransform.position;
            float currentAngle = Vector3.Angle(lookTransform.forward, direction);


            if (look == lookType.At)
            {
                if (currentAngle <= angle)
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
            else
            {
                if (currentAngle >= angle)
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
        }
        else
        {
            if (InRange && !triggered)
            {
                Vector3 direction = point.position - lookTransform.position;
                float currentAngle = Vector3.Angle(lookTransform.forward, direction);


                if (look == lookType.At)
                {
                    if (currentAngle <= angle)
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
                else
                {
                    if (currentAngle >= angle)
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
            }
        }
    }


}
