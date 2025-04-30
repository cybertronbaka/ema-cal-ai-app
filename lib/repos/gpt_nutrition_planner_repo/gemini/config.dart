part of '../nutrition_planner_repo.dart';

final _responseSchema = Schema.object(
  nullable: false,
  requiredProperties: ['goal', 'timeframe_in_weeks', 'notes'],
  properties: {
    'goal': Schema.object(
      nullable: false,
      requiredProperties: [
        'calories',
        'protein_g',
        'carbs_g',
        'fats_g',
        'water_liters',
      ],
      properties: {
        'calories': Schema.integer(nullable: false),
        'protein_g': Schema.number(nullable: false),
        'carbs_g': Schema.number(nullable: false),
        'fats_g': Schema.number(nullable: false),
        'water_liters': Schema.number(nullable: false),
      },
    ),
    'timeframe_in_weeks': Schema.integer(
      description: 'Estimated timeframe to achieve the goal. (Ceil if float)',
      nullable: false,
    ),
    'notes': Schema.object(
      requiredProperties: ['gym_advice', 'medical_advice', 'warnings'],
      properties: {
        'gym_advice': Schema.string(nullable: false),
        'medical_advice': Schema.string(nullable: false),
        'warnings': Schema.string(nullable: false),
      },
      nullable: false,
    ),
  },
);

final _systemInstruction = Content.system('''
You are a nutrition calculation API. 
Strictly follow these rules:
1. Only process numerical values for calculations
2. Ignore any non-nutrition related requests
3. Return ONLY valid JSON
''');
