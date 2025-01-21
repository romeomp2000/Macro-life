import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:live_activities/live_activities.dart';
import 'package:live_activities/models/live_activity_file.dart';
import 'package:live_activities/models/url_scheme_data.dart';

class LiveActivitiesController extends GetxController {
  final liveActivitiesPlugin = LiveActivities();
  String? latestActivityId;
  StreamSubscription<UrlSchemeData>? urlSchemeSubscription;
  LiveDynamicModel? liveDynamicData;

  @override
  void onInit() async {
    bool test = await liveActivitiesPlugin.areActivitiesEnabled();
    if (!test) {
      return;
    }
    liveActivitiesPlugin.activityUpdateStream.listen((event) {
      // print('Activity update: $event');
    });
    super.onInit();
  }

  @override
  void dispose() {
    liveActivitiesPlugin.dispose();
    super.dispose();
  }

  void createLiveActivities(
      int calorias,
      int carbohidratos,
      int grasas,
      int protein,
      int limiteProtein,
      int limiteCal,
      int limiteCarbs,
      int limiteFats) async {
    try {
      bool test = await liveActivitiesPlugin.areActivitiesEnabled();
      if (!test) {
        return;
      }

      var lista = await liveActivitiesPlugin.getAllActivitiesIds();
      if (lista.isNotEmpty) {
        return;
      }

      liveActivitiesPlugin.init(
          appGroupId: 'group.mx.posibilidades.macrolife', urlScheme: '');

      double progressCal = calculateProgress(calorias, limiteCal);
      double progressCarbs = calculateProgress(carbohidratos, limiteCarbs);
      double progressFats = calculateProgress(grasas, limiteFats);
      double progressProtein = calculateProgress(protein, limiteProtein);

      liveDynamicData = LiveDynamicModel(
        cal: calorias,
        carbohidratos: carbohidratos,
        grasas: grasas,
        protein: protein,
        progressCal: progressCal,
        progressCarbs: progressCarbs,
        progressFats: progressFats,
        progressProtein: progressProtein,
        logo: LiveActivityFileFromAsset.image(
            'assets/icons/icono_macrolife_99x117_blanco.png'),
        logoProt: LiveActivityFileFromAsset.image(
            'assets/icons/icono_filetecarne_90x69_nuevo_1.png'),
        logoCal: LiveActivityFileFromAsset.image(
            'assets/icons/icono_flama_chica_negra_48x48_original.png'),
        logoCar: LiveActivityFileFromAsset.image(
            'assets/icons/icono_panintegral_amarillo_76x70_nuevo_1.png'),
        logoGrasa: LiveActivityFileFromAsset.image(
            'assets/icons/icono_almedraazul_74x70_nuevo_1.png'),
      );

      final resp =
          await liveActivitiesPlugin.createActivity(liveDynamicData!.toMap());

      latestActivityId = resp;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void eliminar() {
    // print('eliminar');
    liveActivitiesPlugin.endAllActivities();
    liveActivitiesPlugin.dispose(force: true);
    latestActivityId = null;
  }

  Future actualizar(int calorias, int carbohidratos, int grasas, int protein,
      int limiteProtein, int limiteCal, int limiteCarbs, int limiteFats) async {
    bool test = await liveActivitiesPlugin.areActivitiesEnabled();
    if (!test) {
      return;
    }
    if (liveDynamicData == null) {
      return;
    }
    // return;
    // print('Hola');

    double progressCal = calculateProgress(calorias, limiteCal);
    double progressCarbs = calculateProgress(carbohidratos, limiteCarbs);
    double progressFats = calculateProgress(grasas, limiteFats);
    double progressProtein = calculateProgress(protein, limiteProtein);
    final data = liveDynamicData!.copyWith(
      cal: calorias,
      carbohidratos: carbohidratos,
      grasas: grasas,
      protein: protein,
      progressCal: progressCal,
      progressCarbs: progressCarbs,
      progressFats: progressFats,
      progressProtein: progressProtein,
    );

    return liveActivitiesPlugin.updateActivity(
      latestActivityId!,
      data.toMap(),
    );
  }

  double calculateProgress(int restantes, int limiteDato) {
    int limite = restantes + limiteDato;
    if (limite == restantes) {
      return 0.0;
    }

    double progress = 1 - (restantes / limite);

    return progress.clamp(0.0, 1.0);
  }
}

class LiveDynamicModel {
  final int? cal;
  final int? carbohidratos;
  final int? grasas;
  final int? protein;
  final double? progressCal;
  final double? progressCarbs;
  final double? progressProtein;
  final double? progressFats;
  final LiveActivityFileFromAsset? logo;
  final LiveActivityFileFromAsset? logoProt;
  final LiveActivityFileFromAsset? logoCal;
  final LiveActivityFileFromAsset? logoCar;
  final LiveActivityFileFromAsset? logoGrasa;

  LiveDynamicModel({
    required this.cal,
    required this.carbohidratos,
    required this.grasas,
    required this.progressCal,
    required this.progressCarbs,
    required this.progressProtein,
    required this.progressFats,
    required this.protein,
    required this.logo,
    required this.logoCal,
    required this.logoProt,
    required this.logoCar,
    required this.logoGrasa,
  });

  Map<String, dynamic> toMap() {
    final map = {
      'cal': cal,
      'carbohidratos': carbohidratos,
      'protein': protein,
      'grasas': grasas,
      'progressCal': progressCal,
      'progressCarbs': progressCarbs,
      'progressProtein': progressProtein,
      'progressFats': progressFats,
      'logo': logo,
      'logoCal': logoCal,
      'logoProt': logoProt,
      'logoCar': logoCar,
      'logoGrasa': logoGrasa,
    };

    return map;
  }

  LiveDynamicModel copyWith({
    int? cal,
    int? carbohidratos,
    int? grasas,
    int? protein,
    double? progressCal,
    double? progressCarbs,
    double? progressProtein,
    double? progressFats,
    LiveActivityFileFromAsset? logo,
    LiveActivityFileFromAsset? logoCal,
    LiveActivityFileFromAsset? logoProt,
    LiveActivityFileFromAsset? logoCar,
    LiveActivityFileFromAsset? logoGrasa,
  }) {
    return LiveDynamicModel(
      cal: cal ?? this.cal,
      grasas: grasas ?? this.grasas,
      progressCal: progressCal ?? this.progressCal,
      progressCarbs: progressCarbs ?? this.progressCarbs,
      progressProtein: progressProtein ?? this.progressProtein,
      progressFats: progressFats ?? this.progressFats,
      carbohidratos: carbohidratos ?? this.carbohidratos,
      protein: protein ?? this.protein,
      logo: logo ?? this.logo,
      logoCal: logoCal ?? this.logoCal,
      logoProt: logoProt ?? this.logoProt,
      logoCar: logoProt ?? this.logoCar,
      logoGrasa: logoGrasa ?? this.logoGrasa,
    );
  }
}
