using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using NaughtyAttributes;
using UnityEngine.Events;

public class EventBase : MonoBehaviour
{
    protected enum Shape
    {
        box,
        sphere
    }
    [SerializeField]
    protected bool global = false;
    [SerializeField, ShowIf("globalInvert")]
    protected Shape shape = default;

    [SerializeField, ShowIf(ConditionOperator.And, "globalInvert", "shapeBox")]
    protected Vector3 size = Vector3.one;
    [SerializeField, ShowIf(ConditionOperator.And, "globalInvert", "shapeSphere")]
    protected float radius = 1;

    protected bool globalInvert() => !global;
    protected bool shapeBox() => shape == Shape.box;
    protected bool shapeSphere() => shape == Shape.sphere;

    protected bool InRange;

    protected virtual void Start()
    {
        if (shape == Shape.box)
        {
            BoxCollider box = (BoxCollider)gameObject.AddComponent(typeof(BoxCollider));
            box.size = size;
            box.isTrigger = true;
        }
        else if (shape == Shape.sphere)
        {
            SphereCollider sphere = (SphereCollider)gameObject.AddComponent(typeof(SphereCollider));
            sphere.radius = radius;
            sphere.isTrigger = true;
        }
    }


    void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            InRange = true;
        }
    }

    void OnTriggerExit(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            InRange = false;
        }
    }

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.cyan;

        if (shape == Shape.box)
        {
            Gizmos.DrawWireCube(transform.position, size);
        }
        else if (shape == Shape.sphere)
        {
            Gizmos.DrawWireSphere(transform.position, radius);
        }
    }
}
