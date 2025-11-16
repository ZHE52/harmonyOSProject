import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';

const DOMAIN = 0x0000;

export default class FoodAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    console.log('FoodAbility onCreate')
    console.log(JSON.stringify(want.parameters))
  }

  onDestroy(): void {
    console.log('FoodAbility onDestroy')
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    console.log('FoodAbility onWindowStageCreate')

    windowStage.loadContent('pages/food/FoodPage', (err) => {
      if (err.code) {
        hilog.error(DOMAIN, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err));
        return;
      }
      hilog.info(DOMAIN, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    console.log('FoodAbility onWindowStageDestroy')
  }

  onForeground(): void {
    // Ability has brought to foreground
    console.log('FoodAbility onForeground')
  }

  onBackground(): void {
    // Ability has back to background
    console.log('FoodAbility onBackground')
  }
}
