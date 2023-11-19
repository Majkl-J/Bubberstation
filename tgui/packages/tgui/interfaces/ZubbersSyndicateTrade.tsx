import { Window } from 'tgui/layouts';
import { Button } from '../components';

// Themes importing
import '../styles/themes/zubbers_syndicate.scss';

export const ZubbersSyndicateTrade = (props, context) => {
  return (
    <Window
      title={'Syndicate Trade Network'}
      width={600}
      height={600}
      class="theme_syndicate_window">
      <Window.Content>
        <div class="theme_syndicate_menu">
          <div class="theme_syndicate_folder">
            <div class="theme_syndicate_folder_buttons">
              <Button class="theme_syndicate_button_folder">TEST MENU 1</Button>
              <Button class="theme_syndicate_button_folder">TEST MENU 2</Button>
            </div>
          </div>
        </div>
      </Window.Content>
    </Window>
  );
};
