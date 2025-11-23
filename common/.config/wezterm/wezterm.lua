-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This enalbles hyperlink on git-grep
local rules = wezterm.default_hyperlink_rules()

-- Enhanced regex that handles paths with spaces and various separators
-- This matches file paths (with or without spaces) followed by a colon and line info
table.insert(rules, {
  regex = [[\b([^\r\n\t:]+):(\d+):.*]],
  format = 'file://$1#$2'
})

-- Match simple file:line patterns
table.insert(rules, {
  regex = [[\b([^\s:]+):(\d+)\b]],
  format = 'file://$1#$2'
})

-- Match file extensions without line numbers
table.insert(rules, {
  regex = [[\b([^\s:]+\.[a-zA-Z]{1,5})\b]],
  format = 'file://$1'
})

config.hyperlink_rules = rules

-- For example, changing the initial geometry for new windows:
config.initial_cols = 220
config.initial_rows = 60

-- or, changing the font size and color scheme.
config.font = wezterm.font("MesloLGS NF")
-- font = wezterm.font_with_fallback({"MesloLGS NF", "JetBrains Mono"})
config.font_size = 16
config.color_scheme = 'OneHalfDark'

config.keys = {
    { key = 'q',mods = 'CTRL', action = wezterm.action.ActivateTabRelative(1),},
    { key = 'h', mods = 'CTRL', action = wezterm.action.ActivatePaneDirection('Next'), },
    { key = 'h', mods = 'CTRL', action = wezterm.action.ActivatePaneDirection('Prev'), },
    { key = 'Tab', mods = 'CTRL', action = wezterm.action.ActivatePaneDirection('Prev'), },
    { key = 'Enter',mods = 'OPT', action = wezterm.action.DisableDefaultAssignment, },
   -- { key = 'c',mods = 'CMD', action = wezterm.action.SendKey { key = 'c', mods = 'SUPER'}, }
}

-- scrollback
config.scrollback_lines = 1000000

-- Finally, return the configuration to wezterm:
local act = wezterm.action

local function is_shell(foreground_process_name)
  local shell_names = { 'bash', 'zsh', 'fish', 'sh', 'ksh', 'dash' }
  local process = string.match(foreground_process_name, '[^/\\]+$')
    or foreground_process_name
  for _, shell in ipairs(shell_names) do
    if process == shell then
      return true
    end
  end
  return false
end

wezterm.on('open-uri', function(window, pane, uri)
    -- leave extra space. for some reason in `pager` mode first character is dropped off
    local editor = ' nvim'

    -- Only handle file URIs - REMOVE the alt screen check for pager compatibility
    if (uri:find('^file:') or uri:find('^file:/')) then

    -- Extract file path and fragment from URI
    -- Handle both file://path, file:/path and file://path#fragment formats
    local file_path, fragment

    if uri:find('^file://') then
      file_path, fragment = uri:match('^file://([^#]+)#?(.*)$')
    elseif uri:find('^file:/') then
      file_path, fragment = uri:match('^file:/([^#]+)#?(.*)$')
    end

    if not file_path then
      wezterm.log_info('Failed to extract file path from URI')
      return
    end


    -- Convert fragment to line number if present
    local line_number = nil
    if fragment and fragment ~= '' then
      line_number = tonumber(fragment)
    end

    -- Resolve relative paths - handle userdata CWD properly
    if not file_path:match('^/') then
      local cwd_obj = pane:get_current_working_dir()

      -- Convert userdata CWD to string
      local cwd_str = tostring(cwd_obj)

      if cwd_str and cwd_str ~= 'nil' and cwd_str:find('file://') then
        -- Clean the CWD - remove file:// and any hostname
        local clean_cwd = cwd_str:gsub('^file://[^/]*', '')

        -- Resolve the full path
        file_path = clean_cwd .. '/' .. file_path
      else
        -- Fallback: try to get PWD from environment or use shell command
        local success, pwd_output = wezterm.run_child_process({'pwd'})
        if success and pwd_output then
          local clean_pwd = pwd_output:gsub('%s+$', '') -- trim whitespace
          file_path = clean_pwd .. '/' .. file_path
        else
          wezterm.log_info('Could not resolve relative path, keeping as-is: ' .. file_path)
        end
      end
    end

    -- Get current process info
    local process_name = pane:get_foreground_process_name() or ''

    -- Check if we're in a pager (more comprehensive detection)
    local in_pager = process_name:find('less') or
                     process_name:find('more') or
                     process_name:find('pager') or
                     pane:is_alt_screen_active()  -- Alt screen usually means pager/editor

    if in_pager then
      -- Try multiple ways to quit the pager
      pane:send_text('q')  -- quit less/more

      -- Also try Escape and Ctrl+C as fallbacks
      wezterm.time.call_after(0.1, function()
        pane:send_text('\x1b')  -- ESC key
      end)

      -- Wait longer and then open the file
      wezterm.time.call_after(0.8, function()
        -- Make sure we're back in a shell before sending commands
        local current_process = pane:get_foreground_process_name() or ''

        if line_number then
          pane:send_text(editor .. ' +' .. line_number .. ' "' .. file_path .. '"\r')
        else
          pane:send_text(editor .. ' "' .. file_path .. '"\r')
        end
      end)
      return false

    -- Check if we have a shell
    elseif is_shell(process_name) then
      -- First check if file exists
      local test_success, test_output = wezterm.run_child_process({
        'test', '-f', file_path
      })

      if test_success then
        if line_number then
          pane:send_text(editor .. ' +' .. line_number .. ' "' .. file_path .. '"\r')
        else
          pane:send_text(editor .. ' "' .. file_path .. '"\r')
        end
      else
        -- Try to check if it's a directory
        local dir_success = wezterm.run_child_process({'test', '-d', file_path})
        if dir_success then
          pane:send_text('cd "' .. file_path .. '"\r')
          pane:send_text('ls -la\r')
        else
          pane:send_text(editor .. ' "' .. file_path .. '"\r')
        end
      end
      return false

    else
      -- Fallback for SSH or other environments
      if line_number then
        pane:send_text('test -f "' .. file_path .. '" && ' .. editor .. ' +' .. line_number .. ' "' .. file_path .. '"\r')
      else
        pane:send_text('test -f "' .. file_path .. '" && ' .. editor .. ' "' .. file_path .. '"\r')
      end
      return false
    end
    end

    -- Let wezterm handle other URIs normally
end)


return config
