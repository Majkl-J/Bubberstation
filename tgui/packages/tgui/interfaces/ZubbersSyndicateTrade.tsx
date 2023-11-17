import { Window } from 'tgui/layouts';
import { Button } from '../components';

// Themes importing
import '../styles/themes/zubbers_syndicate.scss';

export const ZubbersSyndicateTrade = (props, context) => {
  return (
    <Window name={'Syndicate Trade Network'} width={600} height={600}>
      <Window.Content>
        <div class="theme_syndicate_menu">
          <Button>Test</Button>
        </div>
      </Window.Content>
    </Window>
  );
};
