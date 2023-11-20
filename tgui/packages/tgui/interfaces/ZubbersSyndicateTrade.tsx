import { classes } from 'common/react';
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
      class="theme_syndicate_window"
      theme="syndicate">
      <Window.Content>
        <div class="theme_syndicate_menu">
          <div class="theme_syndicate_folder">
            <div>
              <FolderButton>UNSELECTED</FolderButton>
              <FolderButton folder_selected={true}>SELECTED MENU</FolderButton>
            </div>
          </div>
        </div>
      </Window.Content>
    </Window>
  );
};

export const FolderButton = (props) => {
  const { children, folder_selected, assigned_folder } = props;
  return (
    <Button
      className={classes([
        'syndicate_mbutton',
        folder_selected && 'syndicate_mbutton--selected',
        !folder_selected && 'syndicate_mbutton--unselected',
      ])}>
      {children}
    </Button>
  );
};
