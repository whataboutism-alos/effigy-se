import { useBackend } from '../backend';
import { Box, Button, Section } from '../components';
import { Window } from '../layouts';

export const KeycardAuth = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    // EFFIGY EDIT CHANGE: height 125 -> 190, eng override/firing pin
    <Window width={375} height={190}>
      <Window.Content>
        <Section>
          <Box>
            {data.waiting === 1 && (
              <span>Waiting for another device to confirm your request...</span>
            )}
          </Box>
          <Box>
            {data.waiting === 0 && (
              <>
                {!!data.auth_required && (
                  <Button
                    icon="check-square"
                    color="red"
                    textAlign="center"
                    lineHeight="60px"
                    fluid
                    onClick={() => act('auth_swipe')}
                    content="Authorize"
                  />
                )}
                {data.auth_required === 0 && (
                  <>
                    <Button
                      icon="exclamation-triangle"
                      fluid
                      onClick={() => {
                        return act('red_alert');
                      }}
                      content="Red Alert"
                    />
                    <Button
                      icon="id-card-o"
                      fluid
                      onClick={() => act('emergency_maint')}
                      content="Emergency Maintenance Access"
                    />
                    {/* EFFIGY EDIT ADD START - Engineering Override */}
                    <Button
                      icon="wrench"
                      fluid
                      onClick={() => act('eng_override')}
                      content="Engineering Override Access"
                    />
                    {/* EFFIGY EDIT ADD END */}
                    <Button
                      icon="meteor"
                      fluid
                      onClick={() => act('bsa_unlock')}
                      content="Bluespace Artillery Unlock"
                    />
                    {/* EFFIGY EDIT ADD START - Permit Pins */}
                    {!!data.permit_pins && (
                      <Button
                        icon="key"
                        fluid
                        onClick={() => act('pin_unrestrict')}
                        content="Permit-Locked Firing Pin Unrestriction"
                      />
                    )}
                    {/* EFFIGY EDIT ADD END */}
                    <Button
                      icon="key"
                      fluid
                      onClick={() => act('give_janitor_access')}
                      content="Grant Janitor Access"
                    />
                  </>
                )}
              </>
            )}
          </Box>
        </Section>
      </Window.Content>
    </Window>
  );
};
