using System.Collections;
using System.Collections.Generic;
using UnityEngine;



[ExecuteInEditMode]
public class GlobalScreenEffectController : MonoBehaviour
{

    [Range(0,1)]
    public float effectStrenghtVal;
    [Range(0, 1)]
    public float effectSpeedVal;
    
 
    // Update is called once per frame
    void Update()
    {
        Shader.SetGlobalFloat("GlobalAmountVal", effectStrenghtVal);
        Shader.SetGlobalFloat("GlobalSpeedVal", effectSpeedVal);
    }
}
