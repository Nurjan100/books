package com.bmtech.books.web;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.Locale;
import java.util.Random;

import javax.persistence.TypedQuery;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.MessageSource;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.authentication.encoding.MessageDigestPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.LocaleResolver;


import com.bmtech.books.domain.User;

@RequestMapping("/forgotpassword/**")
@Controller
public class ForgotPasswordController {

    @Autowired
    private transient MailSender mailSender;

    private transient SimpleMailMessage simpleMailMessage;

  @Autowired
  private MessageDigestPasswordEncoder messageDigestPasswordEncoder;

  @Autowired
  private MessageSource messageSource;
  
  @Autowired
  private ApplicationContext appContext;
  
  @Autowired
  private LocaleResolver localeResolver;
  
    @ModelAttribute("forgotpasswordForm")
    public ForgotPasswordForm formBackingObject() {
        return new ForgotPasswordForm();
    }

    @RequestMapping
    public String index() {
        return "forgotpassword/index";
    }

    @RequestMapping(value = "/forgotpassword/update", method = RequestMethod.POST)
    public String update(@ModelAttribute("forgotpasswordForm") ForgotPasswordForm form, BindingResult result, HttpServletRequest request) {
        if (result.hasErrors()) {
          return "forgotpassword/index";
        } else {
          TypedQuery<User> userQuery=User.findUsersByEmailAddress(form.getEmailAddress());
          if(null!=userQuery && userQuery.getMaxResults()>0){
            User user = userQuery.getSingleResult();
            Random random = new Random(System.currentTimeMillis());
            String newPassword = "pass"+random.nextLong();
            user.setPassword(messageDigestPasswordEncoder.encodePassword(newPassword, null));
            user.merge();
            SimpleMailMessage mail = new SimpleMailMessage();
            mail.setTo(form.getEmailAddress());
            
            Locale currentLocale = localeResolver.resolveLocale(request);
            String appName = appContext.getApplicationName().substring(1);
            String loginUrl = "ERROR";
        try {
          loginUrl = getLoginUrl(request);
        } catch (MalformedURLException e) {
          // TODO Auto-generated catch block
          e.printStackTrace();
        }
        String emailSubject = messageSource.getMessage(
                "typicalsecurity_forgotpassword_email_subject",
                new String[] {appName}, 
                currentLocale);
        mail.setSubject(emailSubject);
            String emailBody = messageSource.getMessage(
                "typicalsecurity_forgotpassword_email_body",
                new String[] {user.getFirstName(), appName, newPassword, loginUrl}, 
                currentLocale);
            mail.setText(emailBody);
            System.out.println("email body=" + emailBody);      
            
            mailSender.send(mail);
          }

            return "forgotpassword/thanks";
        }
    }

    private String getLoginUrl(HttpServletRequest request) throws MalformedURLException {
          URL base = new URL(request.getScheme(), 
                  request.getServerName(), 
                  request.getServerPort(), 
                  request.getContextPath());
          String url = base.toExternalForm() + "/login";
          return url;
        }

  public void sendMessage(String mailTo, String message) {
        simpleMailMessage.setTo(mailTo);
        simpleMailMessage.setText(message);
        mailSender.send(simpleMailMessage);
    }
}
