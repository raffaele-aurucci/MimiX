import 'dart:convert';

class FaceDetectionResult {
    final List<FaceLandmark>? faceLandmarks;
    final FaceBlendshapes? faceBlendshapes;

    FaceDetectionResult({
        this.faceLandmarks,
        this.faceBlendshapes,
    });

    factory FaceDetectionResult.fromRawJson(String str) => FaceDetectionResult.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FaceDetectionResult.fromJson(Map<String, dynamic> json) => FaceDetectionResult(
        faceLandmarks: json["face_landmarks"] == null ? [] : List<FaceLandmark>.from(json["face_landmarks"]!.map((x) => FaceLandmark.fromJson(x))),
        faceBlendshapes: json["face_blendshapes"] == null ? null : FaceBlendshapes.fromJson(json["face_blendshapes"]),
    );

    Map<String, dynamic> toJson() => {
        "face_landmarks": faceLandmarks == null ? [] : List<dynamic>.from(faceLandmarks!.map((x) => x.toJson())),
        "face_blendshapes": faceBlendshapes?.toJson(),
    };
}

class FaceBlendshapes {
    final List<Category>? categories;
    final int? headIndex;
    final dynamic headName;

    FaceBlendshapes({
        this.categories,
        this.headIndex,
        this.headName,
    });

    factory FaceBlendshapes.fromRawJson(String str) => FaceBlendshapes.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FaceBlendshapes.fromJson(Map<String, dynamic> json) => FaceBlendshapes(
        categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
        headIndex: json["headIndex"],
        headName: json["headName"],
    );

    Map<String, dynamic> toJson() => {
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "headIndex": headIndex,
        "headName": headName,
    };
}

class Category {
    final int? index;
    final double? score;
    final String? categoryName;
    final dynamic displayName;

    Category({
        this.index,
        this.score,
        this.categoryName,
        this.displayName,
    });

    factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        index: json["index"],
        score: json["score"]?.toDouble(),
        categoryName: json["categoryName"],
        displayName: json["displayName"],
    );

    Map<String, dynamic> toJson() => {
        "index": index,
        "score": score,
        "categoryName": categoryName,
        "displayName": displayName,
    };
}

class FaceLandmark {
    final double? x;
    final double? y;
    final double? z;

    FaceLandmark({
        this.x,
        this.y,
        this.z,
    });

    factory FaceLandmark.fromRawJson(String str) => FaceLandmark.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FaceLandmark.fromJson(Map<String, dynamic> json) => FaceLandmark(
        x: json["x"]?.toDouble(),
        y: json["y"]?.toDouble(),
        z: json["z"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
        "z": z,
    };
}
