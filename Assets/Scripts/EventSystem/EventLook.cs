using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using NaughtyAttributes;
public class EventLook : MonoBehaviour
{
    enum TriggerMode
    {
        OnVisible,
        OnInvisible,
        LookAngle
    }

    [SerializeField]
    TriggerMode mode;
    [SerializeField, ShowIf("look")]
    float angle;
    [SerializeField,ShowIf("look")]
    bool inverse = false;
    [SerializeField]
    float distance = 1f;
    [SerializeField]
    bool broadcast = false;
    [SerializeField, Dropdown("MethodNames"), ShowIf("broadcast")]
    string methodName = default;
    [SerializeField]
    bool triggerEvent = false;
    [SerializeField, ShowIf("triggerEvent")]
    UnityEvent response = default;


    string[] MethodNames = new string[] { "OnResponse", "Play", "Pause", "Stop" };

    Transform lookTransform;

    bool visible() => mode == TriggerMode.OnVisible;
    bool invisible() => mode == TriggerMode.OnInvisible;
    bool look() => mode == TriggerMode.LookAngle;


    bool inRange;

    private void Start()
    {
        if (!triggerEvent & !broadcast)
        {
            Debug.LogError("InteractEvent has no response enable either Trigger Event or Broadcast", gameObject);
        }



        lookTransform = Camera.main.transform;
    }

    private void Update()
    {
        if(inRange)
        {
            Vector3 direction = transform.position - lookTransform.position;
            float currentAngle = Vector3.Angle(lookTransform.forward, direction);

            Debug.Log(currentAngle);
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if(other.CompareTag("Player"))
        {
            inRange = true;
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            inRange = false;
        }
    }

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.cyan;

        Gizmos.DrawWireSphere(transform.position, distance);
        Gizmos.DrawLine(transform.position, lookTransform.position);
    }
}
