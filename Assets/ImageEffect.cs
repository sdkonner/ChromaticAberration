using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class ImageEffect : MonoBehaviour
{
    [SerializeField, Range(0, 0.01f)] float redChannel = 0;
    [SerializeField, Range(0, 0.01f)] float greenChannel = 0;
    [SerializeField, Range(0, 0.01f)] float blueChannel = 0;

    private Material material;

    private int redChannelID;
    private int greenChannelID;
    private int blueChannelID;

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if(material == null)
        {
            material = new Material(Shader.Find("Hidden/ChromaticEffect"));
            redChannel = Shader.PropertyToID("_RedChannelExtractor");
            greenChannel = Shader.PropertyToID("_GreenChannelExtractor");
            blueChannel = Shader.PropertyToID("_BlueChannelExtractor");
        }

        UpdateMaterialProperties();

        Graphics.Blit(source, destination, material);
    }

    private void UpdateMaterialProperties()
    {
        material.SetFloat("_RedChannelExtractor", redChannel);
        material.SetFloat("_GreenChannelExtractor", greenChannel);
        material.SetFloat ("_BlueChannelExtractor", blueChannel);
    }
}
