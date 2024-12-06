declare global {
  interface Window { FaceDetection: any; }
}

import { FaceLandmarker, FilesetResolver, DrawingUtils } from "@mediapipe/tasks-vision";

let faceLandmarker:any;
let runningMode: "IMAGE" | "VIDEO" = "IMAGE";
let webcamRunning: Boolean = false;

const video = document.getElementById("webcam") as HTMLVideoElement;
const canvasElement = document.getElementById("output_canvas") as HTMLCanvasElement;
const canvasCtx = canvasElement.getContext("2d");


// Send specific face blendshape to Flutter.
function sendDataToFlutter(data:any):void {

  const categoriesName = ['browDownLeft', 'browDownRight', 'browOuterUpLeft', 'browOuterUpRight',
    'eyeBlinkLeft', 'eyeBlinkRight', 'jawOpen', 'mouthSmileLeft', 'mouthSmileRight', 'mouthPucker', 'mouthShrugLower']

  let categoryMap: { [key: string]: number } = {};

  if(window.FaceDetection !== undefined) {
      var categories = data['categories'];

      for (let i = 0; i < categories.length; i++) {
        if (categoriesName.includes(categories[i].categoryName)) {
          // Arrotonda lo score a 3 cifre decimali
          let roundedScore = parseFloat(categories[i].score.toFixed(3));
          // Aggiungi alla mappa
          categoryMap[categories[i].categoryName] = roundedScore;
        }
      }

      // console.log(categoryMap)
      window.FaceDetection?.postMessage(JSON.stringify({data: categoryMap}));
  }

}

// Setup model.
async function setupFaceLandmarker() {
  const filesetResolver = await FilesetResolver.forVisionTasks(
      "/assets/js/wasm"
  );
  faceLandmarker = await FaceLandmarker.createFromOptions(filesetResolver, {
    baseOptions: {
      modelAssetPath: `/assets/modelAsset/face_landmarker.task`,
      delegate: "GPU"
    },
    outputFaceBlendshapes: true,
    runningMode,
    numFaces: 1
  });

}

// Check if webcam access is supported.
function hasGetUserMedia() {
  return !!(navigator.mediaDevices && navigator.mediaDevices.getUserMedia);
}


// Enable the live webcam view and start detection
function enableWebcam() {
  if (!faceLandmarker) {
    console.log("Wait! FaceLandmarker not loaded yet.");
    return;
  }

  if (webcamRunning === true)
    webcamRunning = false;
  else
    webcamRunning = true;

  // getUsermedia parameters
  const constraints = {
    video: true
  };

  // Activate the webcam stream
  navigator.mediaDevices.getUserMedia(constraints).then((stream) => {
    video.srcObject = stream;
    video.addEventListener("loadeddata", predictWebcam);
  });
}


let lastVideoTime = -1;
let results:any = undefined;
const drawingUtils = new DrawingUtils(canvasCtx);

async function predictWebcam() {
  canvasElement.style.width = window.innerWidth + "px";
  canvasElement.style.height = video.clientHeight  + "px";
  canvasElement.width = video.videoWidth;
  canvasElement.height = video.videoHeight;

  // Now let's start detecting the stream.
  if (runningMode === "IMAGE") {
    runningMode = "VIDEO";
    await faceLandmarker.setOptions({ runningMode: runningMode });
  }

  let startTimeMs = performance.now();

  if (lastVideoTime !== video.currentTime) {
    lastVideoTime = video.currentTime;
    results = faceLandmarker.detectForVideo(video, startTimeMs);
  }
  if (results.faceLandmarks) {

    if (results.faceBlendshapes[0])
      sendDataToFlutter(results.faceBlendshapes[0])

    for (const landmarks of results.faceLandmarks) {
      drawingUtils.drawConnectors(
          landmarks,
          FaceLandmarker.FACE_LANDMARKS_TESSELATION,
          { color: "#C0C0C0", lineWidth: 1 }
      );
      drawingUtils.drawConnectors(
          landmarks,
          FaceLandmarker.FACE_LANDMARKS_RIGHT_EYE,
          { color: "#003659" }
      );
      drawingUtils.drawConnectors(
          landmarks,
          FaceLandmarker.FACE_LANDMARKS_RIGHT_EYEBROW,
          { color: "#003659" }
      );
      drawingUtils.drawConnectors(
          landmarks,
          FaceLandmarker.FACE_LANDMARKS_LEFT_EYE,
          { color: "#003659" }
      );
      drawingUtils.drawConnectors(
          landmarks,
          FaceLandmarker.FACE_LANDMARKS_LEFT_EYEBROW,
          { color: "#003659" }
      );
      drawingUtils.drawConnectors(
          landmarks,
          FaceLandmarker.FACE_LANDMARKS_FACE_OVAL,
          { color: "#FFFFFF" }
      );
      drawingUtils.drawConnectors(
          landmarks,
          FaceLandmarker.FACE_LANDMARKS_LIPS,
          { color: "#003659" }
      );
      drawingUtils.drawConnectors(
          landmarks,
          FaceLandmarker.FACE_LANDMARKS_RIGHT_IRIS,
          { color: "#003659" }
      );
      drawingUtils.drawConnectors(
          landmarks,
          FaceLandmarker.FACE_LANDMARKS_LEFT_IRIS,
          { color: "#003659" }
      );
    }
  }

  // Call this function again to keep predicting when the browser is ready.
  if (webcamRunning === true) {
    window.requestAnimationFrame(predictWebcam);
  }
}


window.addEventListener("load", () => {

  setupFaceLandmarker().then(() => {
    if (hasGetUserMedia()) {
      enableWebcam();
    }
  });
});


// Controls the change visibility of page, such as when the user puts the app in background.
document.addEventListener("visibilitychange", async () => {

  if (document.hidden) {
    webcamRunning = false;
    const stream = video.srcObject;

    // Stop all tracks in the stream, releasing resources.
    if (stream && stream instanceof MediaStream) {
      stream.getTracks().forEach(track => track.stop());
    }

    video.removeEventListener("loadeddata", predictWebcam);
  } else {
    // Check if the model has loaded, for example when the user puts the app in background before the model is loading.
    if (faceLandmarker && !webcamRunning) {
      await enableWebcam();
    } else if (!faceLandmarker) {
      await setupFaceLandmarker().then(() => {
        if (hasGetUserMedia()) {
          enableWebcam();
        }
      });
    }
  }
});
