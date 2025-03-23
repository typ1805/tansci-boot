package com.tansci.service;

import lombok.extern.slf4j.Slf4j;
import org.flowable.engine.IdentityService;
import org.flowable.engine.RepositoryService;
import org.flowable.engine.RuntimeService;
import org.flowable.engine.TaskService;
import org.flowable.engine.repository.Deployment;
import org.flowable.engine.runtime.ProcessInstance;
import org.flowable.task.api.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * @className：FlowableService.java
 * @description： Flowable
 * @author：tanyp
 * @date：2025/3/23
 */
@Slf4j
@Service
public class FlowableService {

    @Autowired
    private RepositoryService repositoryService;
    @Autowired
    private RuntimeService runtimeService;
    @Autowired
    private TaskService taskService;
    @Autowired
    private IdentityService identityService;

    /**
     * @MonthName： deployProcess
     * @Description： 部署流程模型
     * @Author： tanyp
     * @Date： 2025/3/23
     * @Param： [name, xml]
     * @return： java.lang.String
     **/
    public String deployProcess(String name, String xml) {
        try {
            Deployment deployment = repositoryService.createDeployment()
                    .addClasspathResource(xml)
                    .name(name)
                    .deploy();
            log.info("流程【{}】部署成功", deployment.getId());
            return deployment.getId();
        } catch (Exception e) {
            log.error("部署流程异常：{}", e);
            return null;
        }
    }

    /**
     * @MonthName： startProcessInstance
     * @Description： 启动流程
     * @Author： tanyp
     * @Date： 2025/3/23
     * @Param： [processId]
     * @return： java.lang.String
     **/
    public String startProcessInstance(String processId) {
        try {
            ProcessInstance processInstance = runtimeService.startProcessInstanceById(processId);
            log.info("流程实例【{}】启动成功", processInstance.getId());
            return processInstance.getId();
        } catch (Exception e) {
            log.error("启动流程异常：{}", e);
            return null;
        }
    }

    /**
     * @MonthName： getTaskByAssignee
     * @Description： 查询分配给指定用户的任务
     * @Author： tanyp
     * @Date： 2025/3/23
     * @Param： [assignee]
     * @return： Task
     **/
    public Task getTaskByAssignee(String assignee) {
        try {
            return taskService.createTaskQuery().taskAssignee(assignee).singleResult();
        } catch (Exception e) {
            log.error("查询分配给指定用户的任务：{}", e);
            return null;
        }
    }

    /**
     * @MonthName： approveTask
     * @Description： 任务审批通过
     * @Author： tanyp
     * @Date： 2025/3/23
     * @Param： [processId]
     * @return： java.lang.String
     **/
    public String approveTask(String taskId) {
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("approval", "approved");
            taskService.complete(taskId, map);
            log.info("任务审批通过,任务ID: {}", taskId);
            return "ok";
        } catch (Exception e) {
            log.error("审批通过异常：{}", e);
            return null;
        }
    }

    /**
     * @MonthName： rejectTask
     * @Description： 任务被拒绝
     * @Author： tanyp
     * @Date： 2025/3/23
     * @Param： [processId]
     * @return： java.lang.String
     **/
    public String rejectTask(String taskId) {
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("approval", "rejected");
            taskService.complete(taskId, map);
            log.info("任务被拒绝，任务ID: {}", taskId);
            return "ok";
        } catch (Exception e) {
            log.error("任务被拒绝异常：{}", e);
            return null;
        }
    }

}
