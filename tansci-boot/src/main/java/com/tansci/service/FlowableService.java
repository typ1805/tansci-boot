package com.tansci.service;

import lombok.extern.slf4j.Slf4j;
import org.flowable.engine.IdentityService;
import org.flowable.engine.RepositoryService;
import org.flowable.engine.RuntimeService;
import org.flowable.engine.TaskService;
import org.flowable.engine.repository.Deployment;
import org.flowable.engine.repository.Model;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.engine.runtime.ProcessInstance;
import org.flowable.engine.task.Comment;
import org.flowable.task.api.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
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

    // ===============================模型管理和流程定义 (RepositoryService)============================================

    /**
     * @MonthName： modelList
     * @Description： 模型列表
     * @Author： tanyp
     * @Date： 2025/3/23
     * @Param： [name, xml]
     * @return： java.util.List
     **/
    public List<Model> modelList(String name, String xml) {
        try {
            List<Model> list = repositoryService.createModelQuery().list();
            return list;
        } catch (Exception e) {
            log.error("模型列表异常：{}", e);
            return null;
        }
    }

    /**
     * @MonthName： processDefinitionList
     * @Description： 流程定义列表
     * @Author： tanyp
     * @Date： 2025/3/23
     * @Param： [name, xml]
     * @return： java.util.List
     **/
    public List<ProcessDefinition> processDefinitionList(String name, String xml) {
        try {
            List<ProcessDefinition> list = repositoryService.createProcessDefinitionQuery().list();
            return list;
        } catch (Exception e) {
            log.error(" 流程定义列表异常：{}", e);
            return null;
        }
    }

    /**
     * @MonthName： deployProcess
     * @Description： 部署流程
     * @Author： tanyp
     * @Date： 2025/3/23
     * @Param： [name, xml]
     * @return： java.lang.String
     **/
    public String deployProcess(String name, String xml) {
        try {
            Deployment deployment = repositoryService.createDeployment()
                    .addString(name, xml)
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
     * @MonthName： activateProcess
     * @Description： 激活流程
     * @Author： tanyp
     * @Date： 2025/3/26
     * @Param： [id]
     * @return： java.lang.String
     **/
    public String activateProcess(String id) {
        try {
            repositoryService.activateProcessDefinitionById(id);
            log.info("流程【{}】激活成功", id);
            return "ok";
        } catch (Exception e) {
            log.error("激活流程异常：{}", e);
            return null;
        }
    }

    /**
     * @MonthName： suspendProcess
     * @Description： 挂起流程
     * @Author： tanyp
     * @Date： 2025/3/26
     * @Param： [id]
     * @return： java.lang.String
     **/
    public String suspendProcess(String id) {
        try {
            repositoryService.suspendProcessDefinitionById(id);
            log.info("流程【{}】挂起成功", id);
            return "ok";
        } catch (Exception e) {
            log.error("挂起流程异常：{}", e);
            return null;
        }
    }

    /**
     * @MonthName： deleteDeployment
     * @Description： 删除流程
     * @Author： tanyp
     * @Date： 2025/3/26
     * @Param： [id]
     * @return： java.lang.String
     **/
    public String deleteDeployment(String id) {
        try {
            repositoryService.deleteDeployment(id);
            log.info("流程【{}】删除成功", id);
            return "ok";
        } catch (Exception e) {
            log.error("删除流程异常：{}", e);
            return null;
        }
    }

    // ===============================处理正在运行的流程 (RuntimeService)===========================================

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
     * @MonthName： deleteProcessInstance
     * @Description： 删除正在运行的流程
     * @Author： tanyp
     * @Date： 2025/3/23
     * @Param： [processId]
     * @return： java.lang.String
     **/
    public String deleteProcessInstance(String val1, String val2) {
        try {
            runtimeService.deleteProcessInstance(val1, val2);
            return "ok";
        } catch (Exception e) {
            log.error("删除正在运行的流程异常：{}", e);
            return null;
        }
    }

    /**
     * @MonthName： getActiveActivityIds
     * @Description： 获取以进行的流程图节点 （当前进行到的那个节点的流程图使用）
     * @Author： tanyp
     * @Date： 2025/3/23
     * @Param： [processInstanceId]
     * @return： java.lang.String
     **/
    public List<String> getActiveActivityIds(String processInstanceId) {
        try {
            return runtimeService.getActiveActivityIds(processInstanceId);
        } catch (Exception e) {
            log.error("获取以进行的流程图节点异常：{}", e);
            return null;
        }
    }

    // ==================================审批处理(TaskService)=====================================

    /**
     * @MonthName： taskList
     * @Description： 待办任务列
     * @Author： tanyp
     * @Date： 2025/3/26
     * @Param： []
     * @return： java.util.List<org.flowable.task.api.Task>
     **/
    public List<Task> taskList() {
        try {
            return taskService.createTaskQuery().list();
        } catch (Exception e) {
            log.error("待办任务列表异常：{}", e);
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
            log.error("查询分配给指定用户的任务异常：{}", e);
            return null;
        }
    }

    /**
     * @MonthName： getProcessInstanceComments
     * @Description： 查看任务详情（也就是都经过哪些人的审批，意见是什么）
     * @Author： tanyp
     * @Date： 2025/3/23
     * @Param： [processInstanceId]
     * @return： Task
     **/
    public List<Comment> getProcessInstanceComments(String processInstanceId) {
        try {
            return taskService.getProcessInstanceComments(processInstanceId);
        } catch (Exception e) {
            log.error("查看任务详情异常：{}", e);
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
