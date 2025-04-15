part of '../gpt_meal_data_repo.dart';

final _responseSchema = Schema.object(
  properties: {
    'calories': Schema.number(
      nullable: true,
      description: 'Estimated in kcal, null if unknown',
    ),
    'protein': Schema.number(
      nullable: true,
      description: 'Grams of protein, null if unknown',
    ),
    'carbohydrates': Schema.number(
      nullable: true,
      description: 'Grams of carbs, null if unknown',
    ),
    'fats': Schema.number(
      nullable: true,
      description: 'Grams of fats, null if unknown',
    ),
    'water': Schema.number(
      nullable: true,
      description: 'Liters of water content, null if unknown',
    ),
    'rejection_message': Schema.string(
      nullable: true,
      description: 'Rejection reason or null if accepted',
    ),
  },
);
