function! gtagsomnicomplete#Complete(findstart, base)
python << PYTHONEOF

debug_level = 2

import vim

def debug(*args):
   if len(args) == 1:
      level = 1
      msg = args[0]
   elif len(args) == 2:
      level = args[0]
      msg = args[1]
   else:
      raise ValueError('Requires arguments: [<level>], message')

   import syslog
   if level <= debug_level: syslog.syslog(msg)

def vimreturn(value):
   debug('Returning %s' % value)
   vim.command('return %s' % value)

def get_tag_type(tag):

    return ""


def completion(word, menu = None, abbr = None, info = None, kind = None,
      dup = None, empty = None, icase = None):
   data = {'word' : word}
   if menu != None: data['menu'] = menu
   if info != None: data['info'] = info
   if kind != None: data['kind'] = kind
   if dup != None: data['dup'] = dup
   if empty != None: data['empty'] = empty
   if icase != None: data['icase'] = icase
   return data


#####################################
def do_findstart(completion_context):

   if (completion_context == ""):
       return -1
   debug('findstart with completion context: "%s"' % completion_context)
   print ('findstart with completion context: "%s"' % completion_context)
   import re
   m = re.match(r'^(.*)\b\w+$', completion_context)
   if not m:
       return -1
       return len(completion_context)
   return len(m.group(1))

######################
def do_complete(base):

   debug("Base = %s" % str(base))
   completions = []
   if base is None or not base:
      return completions

   if (len(base) < 4):
      return completions

   import subprocess
   p = subprocess.Popen(["global", "-c", base], stdout=subprocess.PIPE)
   s = p.communicate()
   if s[1] is not None or s[0] is None:
      return completions

   match_list = s[0].split('\n')
   if (len(match_list) == 0):
      return completions
   num = 0;
   completions = []
   for item in match_list:
      if item is None or not item:
         continue;
      if (num%3 == 0):
         completions.append(completion(item, kind='f'))
      if (num%3 == 1):
         completions.append(completion(item, kind='t'))
      if (num%3 == 2):
         completions.append(completion(item, kind='d'))
      num = num + 1
   return completions


########################################
findstart = int(vim.eval('a:findstart'))
base = vim.eval('a:base')
row, col = vim.current.window.cursor
line = vim.current.buffer[row - 1]
completion_context = line[:col]

if findstart == 1:
   ret = do_findstart(completion_context)
   vimreturn(ret)

res = do_complete(base)
debug("Result = %s" % str(res))
vim.command('silent let l:completions = %s' % repr(res))
PYTHONEOF
return l:completions
echo l:completions
endfunction
