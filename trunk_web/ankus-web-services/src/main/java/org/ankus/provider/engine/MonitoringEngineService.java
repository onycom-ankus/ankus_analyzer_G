package org.ankus.provider.engine;

import org.ankus.model.monitoring.HealthInfo;

public interface MonitoringEngineService {

	public HealthInfo getStatus(String hadoopurl);
}
