part of '../gpt_meal_data_repo.dart';

final _responseSchema = Schema.object(
  requiredProperties: [
    'calories',
    'protein',
    'carbs',
    'fats',
    'water',
    'rejection_message',
    'meal_name',
  ],
  properties: {
    'calories': Schema.number(
      nullable: false,
      description:
          'Estimated in kcal, 0 if unknown. Rounded to ONE decimal (e.g. 0.4 not 0.400)',
    ),
    'protein': Schema.number(
      nullable: false,
      description:
          'Grams of protein, 0 if unknown. Rounded to ONE decimal (e.g. 0.4 not 0.400)',
    ),
    'carbs': Schema.number(
      nullable: false,
      description:
          'Grams of carbs, 0 if unknown. Rounded to ONE decimal (e.g. 0.4 not 0.400)',
    ),
    'fats': Schema.number(
      nullable: false,
      description:
          'Grams of fats, 0 if unknown. Rounded to ONE decimal (e.g. 0.4 not 0.400)',
    ),
    'water': Schema.number(
      nullable: false,
      description:
          'Liters of water content, 0 if unknown. Rounded to ONE decimal (e.g. 0.4 not 0.400)',
    ),
    'rejection_message': Schema.string(
      nullable: true,
      description: 'Rejection reason or null if accepted',
    ),
    'meal_name': Schema.string(
      nullable: false,
      description: 'Name of the meal like Chilly Cheese',
    ),
  },
);
