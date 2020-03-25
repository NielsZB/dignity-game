using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MouseManager : MonoBehaviour
{
    [SerializeField] bool show = false;
    private void Start()
    {
        Cursor.lockState = CursorLockMode.Locked;

        Cursor.visible = show;
    }
}
