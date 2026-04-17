{{flutter_js}}
{{flutter_build_config}}

_flutter.loader.load({
  config: {
    // Workaround for CanvasKit context-loss crashes during web hot restart.
    // This keeps Flutter on CPU-only rendering and avoids WebGL surface churn.
    canvasKitForceCpuOnly: true,
    canvasKitMaximumSurfaces: 1,
  }
});
