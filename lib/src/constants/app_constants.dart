// ignore_for_file: constant_identifier_names

enum Environment { dev, prod }

enum TtsState { initial, playing, paused, stopped }

const ADMOB = {
  'android': {
    'dev': {
      'test_unit': 'ca-app-pub-3940256099942544/6300978111',
    },
    'prod': {
      'app_open_unit': '',
      'recipe_unit': 'ca-app-pub-5730938617062130/3703550793',
      'recipe_view_unit': '',
      'cook_unit': '',
      'cook_view_unit': '',
    }
  },
  'ios': {
    'dev': {
      'test_unit': 'ca-app-pub-3940256099942544/6300978111',
    },
    'prod': {
      'app_open_unit': '',
      'recipe_unit': '',
      'recipe_view_unit': '',
      'cook_unit': '',
      'cook_view_unit': '',
    }
  }
};
