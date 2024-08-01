require 'webrick'
require 'erb'
require 'json'


module RootingViews

    class BaseView < WEBrick::HTTPServlet::AbstractServlet

        PATH = nil

        def self.my_path
            if self::PATH.nil? then 
                "/#{name.split('::').last.downcase}"
            else
                self::PATH
            end
        end

        
       

    end


    class RootView  < BaseView

        PATH = '/'

        def set_value_for_html(target_html_path,locals={})
            template_html_file = File.read(target_html_path)
            ERB.new(template_html_file).result_with_hash(locals)
        end

        def do_GET(req,res)
            res['Content-Type'] = "text/html"
            return_file_path = File.join('statics','index.html')
            res.body=set_value_for_html(return_file_path,{name:'saku'})
        
            req.query.each do |key,value| 
                puts "key-> #{key} value->#{value}"
            end
        end

    end

    class BaseApiView < BaseView
        PATH = '/api'

        def POST(request_data_json)
            puts request_data_json
            {message: 'ポストされました。'}
        end

        def GET(query)
            {message: 'invoked get method!'}.to_json
        end

        def do_GET(rep,res)
            puts 'called do_get'
            res['Content-Type'] = 'application/json'
            res.body = GET(req.query)
        end

        def do_POST(req,res)
            data = JSON.parse(req.body)
            res['Content-Type'] = 'application/json'
            response_json = POST(data)
            if response_json.nil? then
                res.body= {}.to_json
            else
                res.body = response_json.to_json
            end
        end
    end
end
