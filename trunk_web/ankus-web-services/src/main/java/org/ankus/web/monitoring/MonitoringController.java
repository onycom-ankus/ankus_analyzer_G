/**
 * This file is part of ankus.
 *
 * ankus is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * ankus is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with ankus.  If not, see <http://www.gnu.org/licenses/>.
 */
package org.ankus.web.monitoring;

import org.ankus.model.monitoring.DiskInfo;
import org.ankus.model.monitoring.HealthInfo;
import org.ankus.model.rest.Engine;
import org.ankus.model.rest.HadoopCluster;
import org.ankus.model.rest.HiveServer;
import org.ankus.model.rest.Response;
import org.ankus.provider.engine.MonitoringEngineService;
import org.ankus.provider.fs.FileSystemService;
import org.ankus.util.ExceptionUtils;
import org.ankus.util.StringUtils;
import org.ankus.web.admin.HadoopClusterAdminService;
import org.ankus.web.admin.HiveAdminService;
import org.ankus.web.core.LocaleSupport;
import org.ankus.web.core.RemoteService;
import org.ankus.web.engine.EngineService;
import org.ankus.web.hive.HiveService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.lang.management.ManagementFactory;
import java.lang.management.OperatingSystemMXBean;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/monitoring")
public class MonitoringController extends LocaleSupport {
	
    private Logger logger = LoggerFactory.getLogger(MonitoringController.class);

    /** Workflow Engine 정보를 얻기 위한 Engine Service. */
    @Autowired
    private EngineService engineService;
    
    /** Hadoop Cluster 정보를 얻기 위한 Hadoop Cluster Admin Service. */
    @Autowired
    private HadoopClusterAdminService hadoopClusterAdminService;
    
    @Autowired
    private MonitoringService monitoringService;
    
    @RequestMapping(value = "get_hadoopstatus")
    @ResponseBody
    public HashMap<String, Object> get_hadoopstatus(HttpServletRequest req, HttpServletResponse resp
                              , @RequestParam(defaultValue = "", required=true) String engineId
                               ) {
    	HashMap<String, Object> mv = new HashMap<>();
    	
    	if (StringUtils.isEmpty(engineId)) {
    		mv.put("code",500);
    		mv.put("message","fail");
            return mv;
        }
          
    	Engine engine = engineService.getEngine(Long.parseLong(engineId));
    	HadoopCluster hadoopCluster = hadoopClusterAdminService.getHadoopCluster(engine.getHadoopClusterId());
    	
    	HealthInfo stat = monitoringService.getStatus(hadoopCluster.getHdfsUrl(), engine);
    	System.out.println("stat : " + stat);
		if (stat != null) {
			mv.put("code", 0);
			mv.put("data", stat);
			mv.put("message", "success");
		} else {
			mv.put("code", 500);
			mv.put("message", "fail");
		}
		return mv;
    }      
}