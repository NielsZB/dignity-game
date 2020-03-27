using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using NaughtyAttributes;
public class EventBase : MonoBehaviour
{
    protected enum Shape
    {
        box,
        sphere,
    }


    [SerializeField]
    protected Shape shape = default;

    [SerializeField, ShowIf("shapeBox")]
    protected Vector3 size;
    [SerializeField, ShowIf("shapeSphere")]
    protected float radius;

    bool shapeBox() => shape == Shape.box;
    bool shapeSphere() => shape == Shape.sphere;


    protected enum TriggerMode
    {
        Enter,
        Exit,
        EnterExit
    }
    [SerializeField]
    protected TriggerMode triggerOn = default;



    bool triggerOnEnter() => triggerOn == TriggerMode.Enter;
    bool triggerOnExit() => triggerOn == TriggerMode.Exit;

    private void Start()
    {
        if(shape == Shape.box)
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
}
