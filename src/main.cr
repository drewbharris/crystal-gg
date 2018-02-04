require "kemal"
require "crinja"

def releases(context)
    env = Crinja::Environment.new
    env.loader = Crinja::Loader::FileSystemLoader.new("templates/")
    template = env.get_template("layout.html.j2")
    return template.render({
        "page" => "releases"
    })
end

def about(context)
    env = Crinja::Environment.new
    env.loader = Crinja::Loader::FileSystemLoader.new("templates/")
    template = env.get_template("layout.html.j2")
    return template.render({
        "page" => "about"
    })
end

# routes
Kemal::RouteHandler::INSTANCE.add_route("GET", "/", &->releases(HTTP::Server::Context))
Kemal::RouteHandler::INSTANCE.add_route("GET", "/about", &->about(HTTP::Server::Context))

# static files
Kemal.config.add_handler(Kemal::StaticFileHandler.new("public", { :gzip => true, :dir_listing => false }))

Kemal.run