using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using NaughtyAttributes;
public class EventInteract : MonoBehaviour
{
    [SerializeField]
    float distance = 1.5f;
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

    Camera cameraMain;


    private void Start()
    {
        if(!triggerEvent & !broadcast)
        {
            Debug.LogError("InteractEvent has no response enable either Trigger Event or Broadcast", gameObject);
        }
    }

    private void OnMouseDown()
    {
        if (cameraMain == null)
        {
            cameraMain = Camera.main;
        }

        Ray ray = cameraMain.ScreenPointToRay(Input.mousePosition);

        if (Physics.Raycast(ray, out RaycastHit hit))
        {
            if (hit.distance < distance)
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

        Gizmos.DrawWireSphere(transform.position, distance);
    }
}
