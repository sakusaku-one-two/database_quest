require 'webrick'
require 'erb'
require 'json'


module RootingViews

    class BaseView < WEBrick::HTTPServlet::AbstractServlet
        def self.my_path
            "/#{name.split('::').last.downcase}"
        end

        
        def set_value_for_html(target_html_path,locals={})
            template_html_file = File.read(target_html_path)
            ERB.new(template_html_file).result_with_hash(locals)
        end

    end


    class TestView  < BaseView
        def do_GET(req,res)
            res['Content-Type'] = "text/html"
            return_file_path = File.join('statics','index.html')
            res.body=set_value_for_html(return_file_path,{name:'saku'})
        
            req.query.each do |key,value| 
                puts "key-> #{key} value->#{value}"
            end
        end

    end

    class ApiView < BaseView
        def do_GET(rep,res)
            res['Content-Type'] = 'application/json'
            res.body = { message: 'test_message' }.to_json
        end
    end
end
