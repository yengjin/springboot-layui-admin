package cn.geek51.util.handler;

import freemarker.core.Environment;
import freemarker.template.TemplateException;
import freemarker.template.TemplateExceptionHandler;

import java.io.Writer;

public class FreemarkerExceptionHandler implements TemplateExceptionHandler {
    @Override
    public void handleTemplateException(TemplateException e, Environment environment, Writer writer) throws TemplateException {
        try {
            writer.write("Freemarker出错啦!");
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
