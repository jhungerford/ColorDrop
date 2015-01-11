package dev.colordrop;

import dev.colordrop.api.HelloResource;
import io.dropwizard.Application;
import io.dropwizard.Configuration;
import io.dropwizard.assets.AssetsBundle;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;

public class ColorDropApplication extends Application<Configuration> {

	public void initialize(Bootstrap<Configuration> bootstrap) {
		bootstrap.addBundle(new AssetsBundle("/web", "/web", "", "web"));
		bootstrap.addBundle(new AssetsBundle("/html", "", "index.html", "html"));
	}

	public void run(Configuration configuration, Environment environment) throws Exception {
		environment.jersey().setUrlPattern("/api/*");

		environment.jersey().register(new HelloResource());
	}

	public static void main(String[] args) throws Exception {
		new ColorDropApplication().run(args);
	}
}
