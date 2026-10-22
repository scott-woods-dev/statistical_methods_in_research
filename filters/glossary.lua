-- Glossary links and anchors.
--
-- Reads the glossary table at build time and:
--   1. links bolded terms in the prose to their glossary entries;
--   2. adds stable anchors to the glossary table;
--   3. adds the A-to-Z navigation and filter controls to the glossary page.
--
-- HTML gets a hover/focus preview through includes/glossary.html. PDF gets
-- ordinary internal links.

local is_html = FORMAT:match('html') ~= nil
local is_epub = FORMAT:match('epub') ~= nil
local is_latex = FORMAT:match('latex') ~= nil
local in_quarto = quarto ~= nil

local function warn(message)
  if quarto and quarto.log and quarto.log.warning then
    quarto.log.warning(message)
  else
    io.stderr:write('glossary filter: ' .. message .. '\n')
  end
end

local function read_file(path)
  local handle = io.open(path, 'r')
  if not handle then
    return nil
  end
  local text = handle:read('*a')
  handle:close()
  return text
end

local transliterations = {
  -- Latin letters with diacritics
  ['á'] = 'a', ['à'] = 'a', ['â'] = 'a', ['ä'] = 'a', ['ã'] = 'a', ['å'] = 'a', ['ā'] = 'a',
  ['é'] = 'e', ['è'] = 'e', ['ê'] = 'e', ['ë'] = 'e', ['ē'] = 'e',
  ['í'] = 'i', ['ì'] = 'i', ['î'] = 'i', ['ï'] = 'i', ['ī'] = 'i',
  ['ó'] = 'o', ['ò'] = 'o', ['ô'] = 'o', ['ö'] = 'o', ['õ'] = 'o', ['ō'] = 'o',
  ['ú'] = 'u', ['ù'] = 'u', ['û'] = 'u', ['ü'] = 'u', ['ū'] = 'u',
  ['ç'] = 'c', ['ñ'] = 'n', ['ý'] = 'y', ['ÿ'] = 'y',
  ['æ'] = 'ae', ['œ'] = 'oe', ['ß'] = 'ss',
  ['Á'] = 'a', ['À'] = 'a', ['Â'] = 'a', ['Ä'] = 'a', ['Ã'] = 'a', ['Å'] = 'a', ['Ā'] = 'a',
  ['É'] = 'e', ['È'] = 'e', ['Ê'] = 'e', ['Ë'] = 'e', ['Ē'] = 'e',
  ['Í'] = 'i', ['Ì'] = 'i', ['Î'] = 'i', ['Ï'] = 'i', ['Ī'] = 'i',
  ['Ó'] = 'o', ['Ò'] = 'o', ['Ô'] = 'o', ['Ö'] = 'o', ['Õ'] = 'o', ['Ō'] = 'o',
  ['Ú'] = 'u', ['Ù'] = 'u', ['Û'] = 'u', ['Ü'] = 'u', ['Ū'] = 'u',
  ['Ç'] = 'c', ['Ñ'] = 'n', ['Ý'] = 'y',
  -- Punctuation that should not split lookup keys
  ['’'] = "'", ['‘'] = "'", ['\u{2013}'] = '-', ['\u{2014}'] = '-',
  -- Greek letters
  ['α'] = 'alpha', ['β'] = 'beta', ['γ'] = 'gamma', ['δ'] = 'delta', ['ε'] = 'epsilon',
  ['ζ'] = 'zeta', ['η'] = 'eta', ['θ'] = 'theta', ['ι'] = 'iota', ['κ'] = 'kappa',
  ['λ'] = 'lambda', ['μ'] = 'mu', ['ν'] = 'nu', ['ξ'] = 'xi', ['ο'] = 'o', ['π'] = 'pi',
  ['ρ'] = 'rho', ['σ'] = 'sigma', ['τ'] = 'tau', ['υ'] = 'upsilon', ['φ'] = 'phi',
  ['χ'] = 'chi', ['ψ'] = 'psi', ['ω'] = 'omega',
  ['Α'] = 'alpha', ['Β'] = 'beta', ['Γ'] = 'gamma', ['Δ'] = 'delta', ['Ε'] = 'epsilon',
  ['Ζ'] = 'zeta', ['Η'] = 'eta', ['Θ'] = 'theta', ['Ι'] = 'iota', ['Κ'] = 'kappa',
  ['Λ'] = 'lambda', ['Μ'] = 'mu', ['Ν'] = 'nu', ['Ξ'] = 'xi', ['Ο'] = 'o', ['Π'] = 'pi',
  ['Ρ'] = 'rho', ['Σ'] = 'sigma', ['Τ'] = 'tau', ['Υ'] = 'upsilon', ['Φ'] = 'phi',
  ['Χ'] = 'chi', ['Ψ'] = 'psi', ['Ω'] = 'omega',
  -- Superscripts used in R-squared style terms
  ['²'] = '2', ['³'] = '3',
}

local function transliterate(text)
  for from, to in pairs(transliterations) do
    text = text:gsub(from, to)
  end
  return text
end

local function lower(text)
  if pandoc.text and pandoc.text.lower then
    return pandoc.text.lower(text)
  end
  return text:lower()
end

local function normalize(text)
  local value = lower(text)
  value = transliterate(value)
  value = value:gsub('%s+', ' ')
  value = value:gsub('^%s+', ''):gsub('%s+$', '')
  value = value:gsub('[%.,;:!?]+$', '')
  return value
end

local function to_plain(inlines)
  local doc = pandoc.Pandoc({ pandoc.Plain(inlines) })
  local ok, text = pcall(pandoc.write, doc, 'plain')
  if not ok then
    return pandoc.utils.stringify(inlines)
  end
  text = text:gsub('\r\n', '\n')
  text = text:gsub('%s+', ' ')
  text = text:gsub('^%s+', ''):gsub('%s+$', '')
  return text
end

local function slugify(text)
  local value = lower(text)
  value = transliterate(value)
  value = value:gsub('[^%w]+', '-')
  value = value:gsub('^%-+', ''):gsub('%-+$', '')
  if value == '' then
    value = 'term'
  end
  return value
end

local function base_keys(text)
  local key = normalize(text)
  local keys = { key }
  local seen = { [key] = true }

  local function add(value)
    if value and value ~= '' and not seen[value] then
      seen[value] = true
      table.insert(keys, value)
    end
  end

  add(key:gsub('%s*%-%s*', ' '))
  add(key:gsub('%s*%-%s*', '-'))
  add(key:gsub('&', ' and '):gsub('%s+', ' '):gsub('^%s+', ''):gsub('%s+$', ''))
  add(key:gsub('[^%w%s]', ''):gsub('%s+', ' '):gsub('^%s+', ''):gsub('%s+$', ''))

  return keys
end

local function make_lookup(by_key)
  return function(text)
    local keys = base_keys(text)

    for _, key in ipairs(keys) do
      if by_key[key] then
        return by_key[key]
      end
    end

    -- A bold label may include an acronym or symbol in parentheses.
    for _, key in ipairs(keys) do
      local base = key:match('^(.-)%s*%b()%s*$')
      if base and base ~= '' and by_key[base] then
        return by_key[base]
      end
    end

    -- A bolded plural should find its singular glossary entry.
    for _, key in ipairs(keys) do
      local candidates = {}
      if key:match('s$') then
        table.insert(candidates, (key:gsub('s$', '')))
        table.insert(candidates, (key:gsub('es$', '')))
      else
        table.insert(candidates, key .. 's')
        table.insert(candidates, key .. 'es')
      end
      for _, candidate in ipairs(candidates) do
        if by_key[candidate] then
          return by_key[candidate]
        end
      end
    end

    return nil
  end
end

local function parse_glossary(path)
  local text = read_file(path)
  if not text then
    return nil
  end

  local ok, doc = pcall(pandoc.read, text, 'markdown')
  if not ok then
    warn('could not parse ' .. path)
    return nil
  end

  local table_block = nil
  for _, block in ipairs(doc.blocks) do
    if block.t == 'Table' then
      table_block = block
      break
    end
  end
  if not table_block then
    warn('no glossary table found in ' .. path)
    return nil
  end

  local entries = {}
  local used_slugs = {}

  local bodies = table_block.bodies or { table_block.body }
  for _, body in ipairs(bodies) do
    local rows = body.body or body
    for _, row in ipairs(rows) do
      if #row.cells >= 2 then
        local term_inlines = pandoc.utils.blocks_to_inlines(row.cells[1].contents)
        local definition_inlines = pandoc.utils.blocks_to_inlines(row.cells[2].contents)
        local term_text = pandoc.utils.stringify(term_inlines):gsub('^%s+', ''):gsub('%s+$', '')
        local definition_text = to_plain(definition_inlines)

        if term_text ~= '' and definition_text ~= '' then
          local slug = slugify(term_text)
          local base_slug = slug
          local suffix = 2
          while used_slugs[slug] do
            slug = base_slug .. '-' .. suffix
            suffix = suffix + 1
          end
          used_slugs[slug] = true

          local entry = {
            term_text = term_text,
            definition_text = definition_text,
            slug = slug,
            anchor = 'glossary-term-' .. slug,
            term_keys = base_keys(term_text),
            aliases = {},
          }

          local before, inside = term_text:match('^(.-)%s*%(([^()]+)%)%s*$')
          if before and inside then
            for _, key in ipairs(base_keys(before)) do
              table.insert(entry.aliases, key)
            end
            for _, key in ipairs(base_keys(inside)) do
              table.insert(entry.aliases, key)
            end
          end

          table.insert(entries, entry)
        end
      end
    end
  end

  local by_key = {}
  -- Full terms win over aliases when both could claim the same key.
  for _, entry in ipairs(entries) do
    for _, key in ipairs(entry.term_keys) do
      if not by_key[key] then
        by_key[key] = entry
      end
    end
  end
  for _, entry in ipairs(entries) do
    for _, key in ipairs(entry.aliases) do
      if not by_key[key] then
        by_key[key] = entry
      end
    end
  end

  return {
    entries = entries,
    by_key = by_key,
    lookup = make_lookup(by_key),
  }
end

local function find_glossary_path(input)
  for _, path in ipairs(PANDOC_STATE.input_files or {}) do
    if path:match('appendix%-glossary%.md$') and read_file(path) then
      return path
    end
  end

  local candidates = {}
  if quarto and quarto.doc and type(quarto.doc.project_dir) == 'string' then
    table.insert(candidates, quarto.doc.project_dir .. '/chapters/appendix-glossary.md')
  end

  local directory = input:match('^(.*)[/\\]') or '.'
  table.insert(candidates, directory .. '/appendix-glossary.md')
  table.insert(candidates, 'chapters/appendix-glossary.md')
  table.insert(candidates, 'appendix-glossary.md')

  local seen = {}
  for _, path in ipairs(candidates) do
    if not seen[path] then
      seen[path] = true
      if read_file(path) then
        return path
      end
    end
  end

  return nil
end

local function project_root_from(path)
  local directory = path:match('^(.*)[/\\][^/\\]+$') or '.'
  for _ = 1, 8 do
    if read_file(directory .. '/_quarto.yml') then
      return directory
    end
    if directory == '.' then
      break
    end
    local parent = directory:match('^(.*)[/\\][^/\\]+$')
    directory = parent or '.'
  end
  if read_file('./_quarto.yml') then
    return '.'
  end
  return nil
end

local function split_path(path)
  local parts = {}
  for part in path:gmatch('[^/]+') do
    if part ~= '.' then
      table.insert(parts, part)
    end
  end
  return parts
end

local function relative_path(from_directory, to_path)
  local from = split_path(from_directory)
  local to = split_path(to_path)
  local common = 0
  while common < #from and common < #to and from[common + 1] == to[common + 1] do
    common = common + 1
  end

  local parts = {}
  for _ = common + 1, #from do
    table.insert(parts, '..')
  end
  for index = common + 1, #to do
    table.insert(parts, to[index])
  end

  if #parts == 0 then
    return to_path
  end
  return table.concat(parts, '/')
end

local function glossary_href(input, glossary_path)
  local source = input
  if quarto and quarto.doc and type(quarto.doc.input_file) == 'string' then
    source = quarto.doc.input_file
  end
  source = source:gsub('\\', '/')
  glossary_path = glossary_path:gsub('\\', '/')

  local root = project_root_from(source)
  if not root then
    return 'appendix-glossary.html'
  end

  local source_relative = source
  if root ~= '.' and source_relative:sub(1, #root + 1) == root .. '/' then
    source_relative = source_relative:sub(#root + 2)
  end

  local glossary_relative = nil
  if glossary_path:sub(1, 1) == '/' then
    if root ~= '.' and glossary_path:sub(1, #root + 1) == root .. '/' then
      glossary_relative = glossary_path:sub(#root + 2)
    end
  else
    -- Quarto may run the filter from chapters/, so try both the project-root
    -- path and the same path under chapters/.
    local candidates = { glossary_path, 'chapters/' .. glossary_path }
    for _, candidate in ipairs(candidates) do
      local candidate_path = candidate
      if root ~= '.' then
        candidate_path = root .. '/' .. candidate
      end
      if read_file(candidate_path) then
        glossary_relative = candidate
        break
      end
    end
  end

  if not glossary_relative then
    glossary_relative = glossary_path
  end

  local source_directory = source_relative:match('^(.*)/') or '.'
  local href = relative_path(source_directory, glossary_relative):gsub('%.md$', '.html')
  return href
end

local function anchor_inline(identifier)
  if is_html or is_epub then
    return pandoc.RawInline('html', '<span id="' .. identifier .. '"></span>')
  elseif is_latex then
    return pandoc.RawInline('latex', '\\hypertarget{' .. identifier .. '}{}')
  end
  return nil
end

local function link_attributes(entry)
  return pandoc.Attr('', { 'glossary-link' }, {
    ['data-definition'] = entry.definition_text,
    ['data-term'] = entry.term_text,
    ['aria-describedby'] = 'glossary-tooltip',
  })
end

local function contains_link(inlines)
  for _, inline in ipairs(inlines) do
    if inline.t == 'Link' then
      return true
    end
    if inline.content and (inline.t == 'Emph' or inline.t == 'Strong'
        or inline.t == 'Strikeout' or inline.t == 'Superscript'
        or inline.t == 'Subscript' or inline.t == 'SmallCaps'
        or inline.t == 'Span' or inline.t == 'Quoted' or inline.t == 'Cite'
        or inline.t == 'Underline' or inline.t == 'Mark'
        or inline.t == 'Insert' or inline.t == 'Delete') then
      if contains_link(inline.content) then
        return true
      end
    end
  end
  return false
end

local function try_link(strong, glossary, suffix)
  if contains_link(strong.content) then
    return nil
  end

  local term_text = pandoc.utils.stringify(strong)
  local entry = glossary.lookup(term_text)
  if suffix and suffix ~= '' then
    local combined = glossary.lookup(term_text .. ' ' .. suffix)
    if combined then
      entry = combined
    end
  end
  if not entry then
    return nil
  end

  local content = pandoc.Inlines(strong.content)
  if #content == 0 then
    return nil
  end

  -- Keep sentence punctuation outside the link while preserving its bold formatting.
  local trailing = nil
  local last = content[#content]
  if last and last.t == 'Str' then
    local stripped, count = last.text:gsub('([%.,;:!?]+)$', '')
    if count > 0 then
      trailing = last.text:sub(#stripped + 1)
      if stripped == '' then
        table.remove(content, #content)
      else
        content[#content] = pandoc.Str(stripped)
      end
    end
  end

  if #content == 0 then
    return nil
  end

  local link
  if is_html then
    local target = '#' .. entry.anchor
    if glossary.link_prefix and glossary.link_prefix ~= '' then
      target = glossary.link_prefix .. target
    end
    link = pandoc.Link(content, target, '', link_attributes(entry))
  elseif is_latex then
    -- Write the link as \hyperlink so it targets the named \hypertarget.
    -- Pandoc 3.10 turns internal links into \hyperref[label]{...}, which
    -- resolves to the surrounding table instead of the glossary entry.
    local content_doc = pandoc.Pandoc({ pandoc.Plain(content) })
    local content_tex = pandoc.write(content_doc, 'latex')
    content_tex = content_tex:gsub('\r\n', '\n'):gsub('\n+', ' '):gsub('%s+$', '')
    link = pandoc.RawInline(
      'latex',
      '\\hyperlink{' .. entry.anchor .. '}{' .. content_tex .. '}'
    )
  else
    link = pandoc.Link(content, '#' .. entry.anchor)
  end

  if trailing then
    return pandoc.Inlines({ link, pandoc.Strong({ pandoc.Str(trailing) }) })
  end
  return link
end

local process_blocks

local function following_word(inlines, index)
  local position = index + 1
  while position <= #inlines and (inlines[position].t == 'Space'
      or inlines[position].t == 'SoftBreak' or inlines[position].t == 'LineBreak') do
    position = position + 1
  end
  if position <= #inlines and inlines[position].t == 'Str' then
    return lower(inlines[position].text)
  end
  return ''
end

-- In a phrase such as "either Control or Diet", the bolded word is a category
-- label, not a term being defined.
local function is_either_or_label(inlines, index)
  if not following_word(inlines, index):match('^or') then
    return false
  end
  local prefix = {}
  for position = 1, index - 1 do
    prefix[position] = inlines[position]
  end
  local before = pandoc.utils.stringify(pandoc.Inlines(prefix))
  return before:match('either%s*$') ~= nil
end

local function process_inlines(inlines, glossary)
  local output = pandoc.Inlines({})

  for index, inline in ipairs(inlines) do
    local kind = inline.t
    if kind == 'Strong' then
      if is_either_or_label(inlines, index) then
        inline.content = process_inlines(inline.content, glossary)
        output:insert(inline)
      else
        local linked = try_link(inline, glossary, following_word(inlines, index))
        if linked then
          if linked.t then
            output:insert(linked)
          else
            for _, item in ipairs(linked) do
              output:insert(item)
            end
          end
        else
          inline.content = process_inlines(inline.content, glossary)
          output:insert(inline)
        end
      end
    elseif kind == 'Link' or kind == 'Code' or kind == 'Math'
        or kind == 'RawInline' or kind == 'Image' then
      output:insert(inline)
    elseif kind == 'Emph' or kind == 'Strikeout' or kind == 'Superscript'
        or kind == 'Subscript' or kind == 'SmallCaps' or kind == 'Span'
        or kind == 'Quoted' or kind == 'Cite' or kind == 'Underline'
        or kind == 'Mark' or kind == 'Insert' or kind == 'Delete' then
      inline.content = process_inlines(inline.content, glossary)
      output:insert(inline)
    elseif kind == 'Note' then
      inline.content = process_blocks(inline.content, glossary)
      output:insert(inline)
    else
      output:insert(inline)
    end
  end

  return output
end

process_blocks = function(blocks, glossary)
  local output = pandoc.Blocks({})

  for _, block in ipairs(blocks) do
    local kind = block.t
    if kind == 'Para' or kind == 'Plain' then
      block.content = process_inlines(block.content, glossary)
      output:insert(block)
    elseif kind == 'LineBlock' then
      for index, line in ipairs(block.content) do
        block.content[index] = process_inlines(line, glossary)
      end
      output:insert(block)
    elseif kind == 'BlockQuote' or kind == 'Div' then
      block.content = process_blocks(block.content, glossary)
      output:insert(block)
    elseif kind == 'BulletList' or kind == 'OrderedList' then
      for index, item in ipairs(block.content) do
        block.content[index] = process_blocks(item, glossary)
      end
      output:insert(block)
    elseif kind == 'DefinitionList' then
      for _, item in ipairs(block.content) do
        if item.term and item.definitions then
          item.term = process_inlines(item.term, glossary)
          for index, definition in ipairs(item.definitions) do
            item.definitions[index] = process_blocks(definition, glossary)
          end
        else
          item[1] = process_inlines(item[1], glossary)
          for index, definition in ipairs(item[2]) do
            item[2][index] = process_blocks(definition, glossary)
          end
        end
      end
      output:insert(block)
    else
      -- Headers, code blocks, tables, figures, and raw blocks are left alone.
      output:insert(block)
    end
  end

  return output
end

local function build_tools(letter_order)
  local present = {}
  for _, letter in ipairs(letter_order) do
    present[letter] = true
  end

  local nav = {
    '<nav class="glossary-az" aria-label="Jump to a glossary letter">',
    '<span class="glossary-az-label">Jump to:</span>',
  }

  local alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  for index = 1, #alphabet do
    local letter = alphabet:sub(index, index)
    if present[letter] then
      table.insert(nav, string.format(
        '<a href="#glossary-letter-%s" aria-label="Letter %s">%s</a>',
        letter:lower(), letter, letter
      ))
    end
  end

  if present['#'] then
    table.insert(nav, '<a href="#glossary-letter-symbols" aria-label="Numbers and symbols">#</a>')
  end

  table.insert(nav, '</nav>')

  return table.concat({
    '<div class="glossary-tools">',
    '<div class="glossary-filter" id="glossary-filter" hidden>',
    '<label for="glossary-search">Filter glossary</label>',
    '<div class="glossary-filter-row">',
    '<input type="search" id="glossary-search" placeholder="Type a term or definition" autocomplete="off" spellcheck="false" aria-controls="glossary-table">',
    '<button type="button" id="glossary-clear" hidden>Clear</button>',
    '</div>',
    '<p class="glossary-status" id="glossary-status" role="status" aria-live="polite" aria-atomic="true"></p>',
    '</div>',
    table.concat(nav),
    '</div>',
  }, '\n')
end

local function find_glossary_table(doc, glossary)
  for _, block in ipairs(doc.blocks) do
    if block.t == 'Table' then
      local header_matches = false
      local head_rows = block.head and block.head.rows or {}
      if #head_rows > 0 and #head_rows[1].cells >= 2 then
        local first = normalize(pandoc.utils.stringify(
          pandoc.utils.blocks_to_inlines(head_rows[1].cells[1].contents)
        ))
        local second = normalize(pandoc.utils.stringify(
          pandoc.utils.blocks_to_inlines(head_rows[1].cells[2].contents)
        ))
        header_matches = (first == 'term' and second == 'definition')
      end

      local row_count = 0
      local matched = 0
      local bodies = block.bodies or { block.body }
      for _, body in ipairs(bodies) do
        local rows = body.body or body
        for _, row in ipairs(rows) do
          row_count = row_count + 1
          if row_count <= 10 and #row.cells >= 1 then
            local term = pandoc.utils.stringify(
              pandoc.utils.blocks_to_inlines(row.cells[1].contents)
            )
            if glossary.lookup(term) then
              matched = matched + 1
            end
          end
        end
      end

      if row_count >= 50 and (header_matches or matched >= 5) then
        return block
      end
    end
  end
  return nil
end

local function decorate_table(doc, table_block, glossary)
  table_block.attr = table_block.attr or pandoc.Attr()
  table_block.attr.identifier = 'glossary-table'
  local has_class = false
  for _, class in ipairs(table_block.attr.classes) do
    if class == 'glossary-table' then
      has_class = true
    end
  end
  if not has_class then
    table_block.attr.classes:insert('glossary-table')
  end

  local used_slugs = {}
  for _, entry in ipairs(glossary.entries) do
    used_slugs[entry.slug] = true
  end

  local seen_letters = {}
  local letter_order = {}
  local bodies = table_block.bodies or { table_block.body }

  for _, body in ipairs(bodies) do
    local rows = body.body or body
    for _, row in ipairs(rows) do
      if #row.cells >= 2 then
        local cell = row.cells[1]
        local term_inlines = pandoc.utils.blocks_to_inlines(cell.contents)
        local term_text = pandoc.utils.stringify(term_inlines):gsub('^%s+', ''):gsub('%s+$', '')
        local entry = glossary.lookup(term_text)

        local slug
        local anchor
        if entry then
          slug = entry.slug
          anchor = entry.anchor
        else
          slug = slugify(term_text)
          local base_slug = slug
          local suffix = 2
          while used_slugs[slug] do
            slug = base_slug .. '-' .. suffix
            suffix = suffix + 1
          end
          used_slugs[slug] = true
          anchor = 'glossary-term-' .. slug
        end

        local first_character = lower(transliterate(term_text)):sub(1, 1)
        local letter = '#'
        if first_character:match('[a-z]') then
          letter = first_character:upper()
        end

        local letter_anchor = nil
        if not seen_letters[letter] then
          seen_letters[letter] = true
          table.insert(letter_order, letter)
          local identifier = 'glossary-letter-' .. (letter == '#' and 'symbols' or letter:lower())
          letter_anchor = anchor_inline(identifier)
        end

        local term_anchor = anchor_inline(anchor)
        local anchors = {}
        if letter_anchor then
          table.insert(anchors, letter_anchor)
        end
        if term_anchor then
          table.insert(anchors, term_anchor)
        end

        if #anchors > 0 then
          local first_block = cell.contents[1]
          if first_block and (first_block.t == 'Plain' or first_block.t == 'Para') then
            for index = #anchors, 1, -1 do
              first_block.content:insert(1, anchors[index])
            end
          else
            cell.contents:insert(1, pandoc.Plain(anchors))
          end
        end
      end
    end
  end

  if is_html then
    local tools = build_tools(letter_order)
    local output = pandoc.Blocks({})
    local inserted = false
    for _, block in ipairs(doc.blocks) do
      if block.t == 'Table' and block.attr.identifier == 'glossary-table' and not inserted then
        output:insert(pandoc.RawBlock('html', tools))
        inserted = true
      end
      output:insert(block)
    end
    doc.blocks = output
  end

  return doc
end

local function link_terms(doc, glossary)
  doc.blocks = process_blocks(doc.blocks, glossary)
  if is_html then
    doc.blocks:insert(pandoc.RawBlock(
      'html',
      '<div id="glossary-tooltip" class="glossary-tooltip" role="tooltip" hidden></div>'
    ))
  end
  return doc
end

function Pandoc(doc)
  local input = (PANDOC_STATE.input_files and PANDOC_STATE.input_files[1]) or ''
  local glossary_path = find_glossary_path(input)
  if not glossary_path then
    warn('could not find appendix-glossary.md; glossary links were not added')
    return doc
  end

  local glossary = parse_glossary(glossary_path)
  if not glossary then
    return doc
  end

  if is_html and in_quarto then
    glossary.link_prefix = glossary_href(input, glossary_path)
  end

  local table_block = find_glossary_table(doc, glossary)
  if table_block then
    doc = decorate_table(doc, table_block, glossary)
  elseif input:match('appendix%-glossary%.md$') then
    warn('glossary table not found in the glossary page')
  end

  return link_terms(doc, glossary)
end
