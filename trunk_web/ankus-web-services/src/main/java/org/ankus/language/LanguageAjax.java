package org.ankus.language;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

@Controller
public class LanguageAjax {

	@Autowired
	SessionLocaleResolver localeResolver;
	
	@RequestMapping(value = "/lang/getLanguage")
	@ResponseBody
	public String getLanguage(HttpServletRequest request, HttpSession session) {
		
		Locale locale = Locale.getDefault();
		String currentLanguage = locale.getLanguage();
		
		Object obj = session.getAttribute(localeResolver.LOCALE_SESSION_ATTRIBUTE_NAME);
		
		if(obj != null) {
			currentLanguage = session.getAttribute(localeResolver.LOCALE_SESSION_ATTRIBUTE_NAME).toString();
		}
		
		return currentLanguage;
	}
}
