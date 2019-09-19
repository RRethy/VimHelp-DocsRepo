require 'net/http'
require 'uri'
require 'fileutils'

FileUtils.mkdir_p 'neovim/'
FileUtils.rm Dir.glob('neovim/*.html')

doc_names = %w(
api arabic autocmd change channel cmdline debug deprecated develop diff digraph
editing eval filetype fold ft_ada ft_rust ft_sql gui hebrew help helphelp
if_cscop if_lua if_pyth if_ruby indent index insert intro job_control map mbyte
message mlang motion msgpack_rpc nvim nvim_terminal_emulator options pattern
pi_gzip pi_health pi_msgpack pi_netrw pi_paren pi_spec pi_tar pi_tutor pi_zip
print provider quickfix quickref recover remote remote_plugin repeat rileft
russian scroll sign spell starting syntax tabpage tagsrch term tips uganda ui
undo usr_01 usr_02 usr_03 usr_04 usr_05 usr_06 usr_07 usr_08 usr_09 usr_10
usr_11 usr_12 usr_20 usr_21 usr_22 usr_23 usr_24 usr_25 usr_26 usr_27 usr_28
usr_29 usr_30 usr_31 usr_32 usr_40 usr_41 usr_42 usr_43 usr_44 usr_45 usr_toc
various vi_diff vim_diff visual windows
)

doc_names.each do |doc|
  puts "Downloading #{doc}"
  uri = URI.parse("https://neovim.io/doc/user/#{doc}.html")
  response = Net::HTTP.get_response(uri)

  if response.is_a?(Net::HTTPSuccess)
    File.open("neovim/#{doc}.html", 'w') do |file|
      file.puts response.body
    end
  else
    puts "ERROR: unable to download #{doc}"
  end
end
