package com.bmtech.books.web;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.Date;
import java.util.Locale;
import java.util.Random;

import javax.persistence.TypedQuery;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.MessageSource;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.authentication.encoding.MessageDigestPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.LocaleResolver;

import com.bmtech.books.domain.User;

@RequestMapping("/signup/**")
@Controller
public class SignUpController {

    @Autowired
    private SignUpValidator validator;

    @Autowired
    private transient MailSender mailSender;

    private transient SimpleMailMessage simpleMailMessage;

    @Autowired
    private MessageSource messageSource;
    
    @Autowired
    private LocaleResolver localeResolver;
    
    @Autowired
    private MessageDigestPasswordEncoder messageDigestPasswordEncoder;

    @Autowired
    private ApplicationContext appContext;
  
    @ModelAttribute("User")
    public UserRegistrationForm formBackingObject() {
        return new UserRegistrationForm();
    }

    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String createForm(Model model) {
      UserRegistrationForm form = new UserRegistrationForm();
        model.addAttribute("User", form);
        model.addAttribute("captcha_form",form.getReCaptchaHtml());
        return "signup/index";
    }
    
    @RequestMapping(params = "activate", method = RequestMethod.GET)
    public String activateUser(@RequestParam(value = "activate", required = true) String activationKey,@RequestParam(value = "emailAddress", required = true) String emailAddress,Model model) {
        TypedQuery<User> query = User.findUsersByActivationKeyAndEmailAddress(activationKey, emailAddress);
        User user=query.getSingleResult();
        if(null!=user){
          user.setActivationDate(new Date());
          user.setEnabled(true);
          user.merge();
          return "signup/activated";
        }
        else{
          return "signup/error";
        }

    }

    @RequestMapping(method = RequestMethod.POST)
    public String create(@Valid UserRegistrationForm userRegistration, BindingResult result, Model model, HttpServletRequest request) {
        validator.validate(userRegistration, result);
        if (result.hasErrors()) {
          
            return createForm(model);
        } else { 
          
            Random random = new Random(System.currentTimeMillis());
            String activationKey = "activationKey:" + random.nextInt();

            User user = new User();
            user.setActivationDate(null);
            user.setEmailAddress(userRegistration.getEmailAddress());
            user.setFirstName(userRegistration.getFirstName());
            user.setLastName(userRegistration.getLastName());
            user.setPassword(messageDigestPasswordEncoder.encodePassword(userRegistration.getPassword(), null));
            user.setActivationKey(activationKey);
            user.setEnabled(false);
            user.setLocked(false);
            user.persist();
            
            SimpleMailMessage mail = new SimpleMailMessage();
        mail.setTo(user.getEmailAddress());       
        
        String validateUrl = "ERROR";
      try {
        validateUrl = getValidateUrl(request, user, activationKey);
      } catch (MalformedURLException e) {
        e.printStackTrace();
      }
        Locale currentLocale = localeResolver.resolveLocale(request);
        String appName = appContext.getApplicationName().substring(1);
        String emailSubject = messageSource.getMessage(
            "typicalsecurity_validate_signup_email_subject",
            new String[] {appName}, 
            currentLocale);
      mail.setSubject(emailSubject);
        String emailBody = messageSource.getMessage(
            "typicalsecurity_validate_signup_email_body",
            new String[] {user.getFirstName(), appName, validateUrl}, 
            currentLocale);
        mail.setText(emailBody);
        System.out.println("email body=" + emailBody);
            mailSender.send(mail);
            return "signup/thanks";
        }
    }

    private String getValidateUrl(HttpServletRequest request, User user, String activationKey) throws MalformedURLException {
      URL base = new URL(request.getScheme(), 
              request.getServerName(), 
              request.getServerPort(), 
              request.getContextPath());
      String url = base.toExternalForm() + "/signup?emailAddress="+user.getEmailAddress()+"&activate="+activationKey;
      return url;
    }

  @RequestMapping
    public String index() {
        return "signup/index";
    }

    public void sendMessage(String mailTo, String message) {
        simpleMailMessage.setTo(mailTo);
        simpleMailMessage.setText(message);
        mailSender.send(simpleMailMessage);
    }
}
