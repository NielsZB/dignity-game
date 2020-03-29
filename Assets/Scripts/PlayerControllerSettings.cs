using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityStandardAssets.Characters.FirstPerson;

public class PlayerControllerSettings : MonoBehaviour
{
    public bool movementEnabled = true;
    public float speed = 4f;
    public float lookSpeed = 4f;

    FirstPersonController controller;

    bool prevMovementEnabled;
    private void Start()
    {
        controller = GetComponent<FirstPersonController>();
        prevMovementEnabled = movementEnabled;
    }

    public void DisableMovement()
    {
        movementEnabled = false;
        controller.enabled = false;
    }

    public void EnableMovement()
    {
        movementEnabled = true;
        controller.enabled = true;
    }

    private void Update()
    {
        if (prevMovementEnabled != movementEnabled)
        {
            controller.enabled = movementEnabled;
            prevMovementEnabled = movementEnabled;
        }
    }
}
