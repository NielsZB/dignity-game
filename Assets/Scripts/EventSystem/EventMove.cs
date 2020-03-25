using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using NaughtyAttributes;

public class EventMove : MonoBehaviour
{
    enum Shape
    {
        box,
        sphere
    }

    enum TriggerMode
    {
        Enter,
        Exit,
        EnterExit
    }

    [SerializeField]
    TriggerMode triggerOn = default;
    [Space(10)]
    [SerializeField]
    Shape shape = default;
    [SerializeField,ShowIf("sphere")]
    float radius = 1f;
    [SerializeField, ShowIf("box")]
    Vector3 size = Vector3.one;
    [Space(10)]
    [SerializeField]
    bool broadcast = false;
    [SerializeField, Dropdown("MethodNames"), ShowIf("broadcast")]
    string methodName = default;
    [SerializeField]
    bool triggerEvent = false;
    [SerializeField, ShowIf("triggerEvent")]
    UnityEvent response = default;


    string[] MethodNames = new string[] { "OnResponse", "Play", "Pause", "Stop" };

    bool box() => shape == Shape.box;
    bool sphere() => shape == Shape.sphere;

    private void Start()
    {
        if(TryGetComponent(out Collider initialCollider))
        {
            Destroy(initialCollider);
            Debug.Log($"A {initialCollider.GetType()} has been removed from {name}", gameObject);

        }

        if (shape == Shape.box)
        {
            BoxCollider col = (BoxCollider)gameObject.AddComponent(typeof(BoxCollider));
            col.size = size;
            col.isTrigger = true;
        }
        else if(shape == Shape.sphere)
        {
            SphereCollider col = (SphereCollider)gameObject.AddComponent(typeof(SphereCollider));
            col.radius = radius;
            col.isTrigger = true;
        }

        if (!triggerEvent & !broadcast)
        {
            Debug.LogError("InteractEvent has no response enable either Trigger Event or Broadcast", gameObject);
        }
    }


    private void OnValidate()
    {
        if (!triggerEvent & !broadcast)
        {
            Debug.LogError("InteractEvent has no response enable either Trigger Event or Broadcast", gameObject);
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if(other.CompareTag("Player"))
        {
            if(triggerOn == TriggerMode.Enter || triggerOn == TriggerMode.EnterExit)
            {
                if (triggerEvent)
                    response.Invoke();

                if (broadcast)
                    SendMessage(methodName);
            }
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            if (triggerOn == TriggerMode.Exit || triggerOn == TriggerMode.EnterExit)
            {
                if (triggerEvent)
                    response.Invoke();

                if (broadcast)
                    SendMessage(methodName);
            }
        }
    }

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.cyan;

        if(shape == Shape.box)
        {
            Gizmos.DrawWireCube(transform.position, size);
        }
        else if(shape == Shape.sphere)
        {
            Gizmos.DrawWireSphere(transform.position, radius);
        }
    }
}
