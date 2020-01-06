package cn.geek51.controller;

import cn.geek51.domain.FileUpload;
import cn.geek51.domain.PageHelper;
import cn.geek51.service.IFileUploadService;
import cn.geek51.util.ResponseUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import javax.xml.ws.Response;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
public class FileController {
    @Autowired
    IFileUploadService service;

    @Value("${file.path}")
    private String filePath;

    // 删除文件
    @DeleteMapping("/files/{id}")
    public Object deleteUploadedFile(@PathVariable("id") Integer fileId) {
        service.delete(fileId);
        return ResponseUtil.general_response("success delete file1");
    }

    // 查询上传的文件
    @GetMapping("/files")
    public Object getUploadedFiles(PageHelper pageHelper) {
        Map<Object, Object> map = pageHelper.getMap();
        List<FileUpload> fileUploadList = service.listAll(map);
        if (map == null) map = new HashMap<>();
        else map.clear();
        map.put("size", service.count());
        return ResponseUtil.general_response(fileUploadList, map);
    }

    @GetMapping("/files/{id}")
    public Object getUploadedFile(@PathVariable("id") Integer id) {
        FileUpload file = service.listOneById(id);
        return ResponseUtil.general_response(file);
    }

    // 更改文件
    @PutMapping("/files")
    public Object updateUploadedFile(@RequestBody FileUpload fileUpload) {
        fileUpload.setPath(filePath + fileUpload.getPath());
        service.update(fileUpload);
        return ResponseUtil.general_response("success update file!");
    }

    // 增加文件
    @PostMapping("/files")
    public Object postUploadFile(FileUpload fileUpload) {
        System.out.println(fileUpload);
        fileUpload.setPath(filePath + fileUpload.getPath());
        service.save(fileUpload);
        return ResponseUtil.general_response("success save file to db!");
    }
    // 文件上传
    @PostMapping("/files/upload")
    public Object uploadFile(MultipartFile file) throws Exception {
       // System.out.println(filePath);
        //System.out.println(file.getOriginalFilename());
        String extName = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
        String fileName = UUID.randomUUID().toString() + extName;
        FileCopyUtils.copy(file.getInputStream(), new FileOutputStream(new File(filePath + fileName)));
        return ResponseUtil.general_response("success update file!", fileName);
    }

    // 文件下载
    @GetMapping("/files/download/{id}")
    public ResponseEntity<InputStreamResource> downloadFile(@PathVariable("id") String fileId) throws Exception {
        String downloadPath = service.listOneById(Integer.parseInt(fileId)).getPath();
        FileSystemResource file = new FileSystemResource(downloadPath);
        HttpHeaders headers = new HttpHeaders();
        headers.add("Cache-Control", "no-cache, no-store, must-revalidate");
        headers.add("Content-Disposition", String.format("attachment; filename=\"%s\"", file.getFilename()));
        headers.add("Pragma", "no-cache");
        headers.add("Expires", "0");

        return ResponseEntity
                .ok()
                .headers(headers)
                .contentLength(file.contentLength())
                .contentType(MediaType.parseMediaType("application/octet-stream"))
                .body(new InputStreamResource(file.getInputStream()));
    }
}
