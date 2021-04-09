package com.infrasofttech.microfinance.configurations;

import org.springframework.context.ApplicationContextInitializer;

public class ConfigurationInitializer{}/* implements EnvironmentPostProcessor {

	private final YamlPropertySourceLoader loader = new YamlPropertySourceLoader();

	@Override
	public void postProcessEnvironment(ConfigurableEnvironment environment, SpringApplication application) {
		Resource path = new ClassPathResource("com/example/myapp/config.yml");
		PropertySource<?> propertySource = load(path);
		environment.getPropertySources().addLast(propertySource);
	}

	private PropertySource<?> loadYaml(Resource path) {
		if (!path.exists()) {
			throw new IllegalArgumentException("Resource " + path + " does not exist");
		}
		try {
			return this.loader.load("custom-resource", path).get(0);
		}
		catch (IOException ex) {
			throw new IllegalStateException("Failed to load yaml configuration from " + path, ex);
		}
	}*/