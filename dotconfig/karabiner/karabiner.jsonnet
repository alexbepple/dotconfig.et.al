local citrix = {
  bundle_identifiers: ['^com\\.citrix\\.receiver\\.icaviewer\\.mac$'],
  type: 'frontmost_application_if',
};

local manipulator(x) = x { type: 'basic' };

local from_to(modifierOrModifiers, from, to, optional=['any'],) = {
  local mandatory = if std.isArray(modifierOrModifiers) then modifierOrModifiers else [modifierOrModifiers],
  description: std.join(' ', [std.join('+', mandatory), '+', from, '=>', to]),
  manipulators: [manipulator({
    from: { key_code: from, modifiers: { mandatory: mandatory, optional: optional } },
    to: [{ key_code: to }],
  })],
};

// Requirement: combine function keys with modifiers inside IJ
// Attempt 1: media keys default + function keys with 'frontmost_application_if' did not work, as it did not pass the modifies
// Attempt 2: function keys as default + media key with 'frontmost_application_unless'
//   disadvantage vs attempt 1: need to explicitly choose media key
local outside_intellij(fnKey, mediaKey) = {
  description: fnKey + ' outside IntelliJ: ' + mediaKey,
  manipulators: [manipulator({
    conditions: [{
      bundle_identifiers: ['com.jetbrains.intellij'],
      type: 'frontmost_application_unless',
    }],
    from: { key_code: fnKey },
    to: [{ key_code: mediaKey }],
  })],
};

local complexModifications = {
  parameters: {
    'basic.simultaneous_threshold_milliseconds': 50,
    'basic.to_delayed_action_delay_milliseconds': 500,
    'basic.to_if_alone_timeout_milliseconds': 1000,
    'basic.to_if_held_down_threshold_milliseconds': 50,
    'mouse_motion_to_scroll.speed': 100,
  },
  rules: [
    from_to('left_option', 'h', 'left_arrow'),
    // cmd+alt+j is Alfred Snippets for me – unless I have to, I do not want to abandon it
    from_to('left_option', 'j', 'down_arrow', optional=[]),
    from_to('left_option', 'k', 'up_arrow'),
    from_to('left_option', 'l', 'right_arrow'),
    from_to('left_option', 'd', 'page_down'),
    from_to('left_option', 'u', 'page_up'),

    outside_intellij('f1', 'display_brightness_decrement'),
    outside_intellij('f2', 'display_brightness_increment'),
    outside_intellij('f10', 'mute'),
    outside_intellij('f11', 'volume_decrement'),
    outside_intellij('f12', 'volume_increment'),

    {
      description: 'Citrix: Left Cmd = Left Alt + Left Cmd (coupled with Citrix setting for Alt)',
      manipulators: [manipulator({
        conditions: [citrix],
        from: { key_code: 'left_command' },
        to: [{ key_code: 'left_command', modifiers: ['left_option'] }],
      })],
    },

    /*
     * Simplify typing combinations with option key.
     *
     * The right-hand combination has proven tricky so far
     * (using `to_if_held_down`) with German words like 'möchte'/'nächste' (ç) etc.
     *
     * The basic template is https://karabiner-elements.pqrs.org/docs/json/typical-complex-modifications-examples/#post-escape-if-left_control-is-pressed-alone
     */
    // ongoing refactoring: if possible,
    // harmonize how left-hand and right-hand helpers are defined
    {
      description: 'caps_lock => left_option in combination | escape if alone',
      manipulators: [manipulator({
        from: { key_code: 'caps_lock', modifiers: { optional: ['any'] } },
        // why do I need hold_down_milliseconds?
        to: [{ hold_down_milliseconds: 2, key_code: 'left_option', lazy: true }],
        to_if_alone: [{ key_code: 'escape' }],
      })],
    },
    {
      description: 'ö => left_option in combination with 5 & 6',

      // Emulation facilities are for typing both brackets while keeping ö pressed.
      local turnOptEmulationOn = { sticky_modifier: { left_option: 'on' } },
      local turnOptEmulationOff = { sticky_modifier: { left_option: 'off' } },

      local leftBracket = { modifiers: ['left_option'], key_code: '5' },
      local rightBracket = { modifiers: ['left_option'], key_code: '6' },

      manipulators: [
        manipulator({
          parameters: { 'basic.simultaneous_threshold_milliseconds': 500 },
          from: {
            simultaneous: [{ key_code: 'semicolon' }, { key_code: '5' }],
            simultaneous_options: { key_down_order: 'strict' },
          },
          to: [leftBracket, turnOptEmulationOn],
          to_delayed_action: { to_if_invoked: [turnOptEmulationOff] },
        }),
        manipulator({
          // type ] with ö freshly pressed
          parameters: { 'basic.simultaneous_threshold_milliseconds': 500 },
          from: {
            simultaneous: [{ key_code: 'semicolon' }, { key_code: '6' }],
            simultaneous_options: { key_down_order: 'strict' },
          },
          to: [rightBracket],
        }),
      ],
    },
  ],
};

{
  global: {
    check_for_updates_on_startup: true,
    show_in_menu_bar: true,
    show_profile_name_in_menu_bar: false,
    unsafe_ui: false,
  },
  profiles: [
    {
      complex_modifications: complexModifications,
      devices: [
        {
          disable_built_in_keyboard_if_exists: false,
          fn_function_keys: [],
          identifiers: {
            is_keyboard: true,
            is_pointing_device: false,
            product_id: 835,
            vendor_id: 1452,
          },
          ignore: false,
          manipulate_caps_lock_led: true,
          simple_modifications: [],
          treat_as_built_in_keyboard: false,
        },
        {
          disable_built_in_keyboard_if_exists: false,
          fn_function_keys: [],
          identifiers: {
            is_keyboard: false,
            is_pointing_device: true,
            product_id: 835,
            vendor_id: 1452,
          },
          ignore: true,
          manipulate_caps_lock_led: false,
          simple_modifications: [],
          treat_as_built_in_keyboard: false,
        },
      ],
      fn_function_keys: [
        {
          from: { key_code: 'f1' },
          to: [{ consumer_key_code: 'display_brightness_decrement' }],
        },
        {
          from: { key_code: 'f2' },
          to: [{ consumer_key_code: 'display_brightness_increment' }],
        },
        {
          from: { key_code: 'f3' },
          to: [{ key_code: 'mission_control' }],
        },
        {
          from: { key_code: 'f4' },
          to: [{ key_code: 'launchpad' }],
        },
        {
          from: { key_code: 'f5' },
          to: [{ key_code: 'illumination_decrement' }],
        },
        {
          from: { key_code: 'f6' },
          to: [{ key_code: 'illumination_increment' }],
        },
        {
          from: { key_code: 'f7' },
          to: [{ consumer_key_code: 'rewind' }],
        },
        {
          from: { key_code: 'f8' },
          to: [{ consumer_key_code: 'play_or_pause' }],
        },
        {
          from: { key_code: 'f9' },
          to: [{ consumer_key_code: 'fastforward' }],
        },
        {
          from: { key_code: 'f10' },
          to: [{ consumer_key_code: 'mute' }],
        },
        {
          from: { key_code: 'f11' },
          to: [{ consumer_key_code: 'volume_decrement' }],
        },
        {
          from: { key_code: 'f12' },
          to: [{ consumer_key_code: 'volume_increment' }],
        },
      ],
      name: 'Default',
      parameters: {
        delay_milliseconds_before_open_device: 1000,
      },
      selected: true,
      simple_modifications: [],
      virtual_hid_keyboard: {
        caps_lock_delay_milliseconds: 0,
        country_code: 0,
        indicate_sticky_modifier_keys_state: true,
        keyboard_type: '',
        mouse_key_xy_scale: 100,
      },
    },
  ],
}
