let s:channel = 0

" --------------------------------------------------------------------- # Init #

function! iris#api#vim8#init()
  if v:version < 800 | throw 'version' | endif
  if ! has('job') | throw 'job' | endif
  if ! has('channel') | throw 'channel' | endif

  let options = {
    \'mode': 'nl',
    \'callback': function('s:handle_data'),
    \'close_cb': function('s:handle_close'),
  \}

  let s:channel = ch_open(iris#api(), options)
  if ch_status(s:channel) != 'open' | throw 0 | endif
endfunction

" -------------------------------------------------------------- # Handle data #

function! s:handle_data(channel, raw_data)
  return iris#api#handle_data(a:raw_data)
endfunction

" ------------------------------------------------------------- # Handle close #

function! s:handle_close(channel)
  return iris#api#handle_close()
endfunction

" --------------------------------------------------------------------- # Send #

function! iris#api#vim8#send(data)
  if ch_status(s:channel) != 'open' | return | endif
  return ch_sendraw(s:channel, json_encode(a:data))
endfunction