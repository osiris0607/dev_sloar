<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" scope="application" />
<%
	pageContext.setAttribute("cr", "\r");
	pageContext.setAttribute("lf", "\n");
	pageContext.setAttribute("crlf", "\r\n");
%>

<!DOCTYPE html>
<html lang="ko">

	<tiles:insertAttribute name="header" />
	
	<body>
			<tiles:insertAttribute name="headerSide" /> 
			<tiles:insertAttribute name="body" />
			<tiles:insertAttribute name="footer" />
			
			
	  <script>
	    $(window).scroll(function () {
	      var position = $(window).scrollTop();
	      if (position > 80) {
	        // $('.swiper-container').fadeOut();
	        $('header').addClass('on');
	      } else {
	        // $('.swiper-container').fadeIn();
	        $('header').removeClass('on');
	      }
	    });
	  </script>
	</body>
	
	<script src="<c:url value='/assets/solar/mobile/js/common.js'/>"></script>
	<script src="<c:url value='/assets/solar/mobile/js/jquery-accessible-tabs.js'/>"></script>
	
	<script src="<c:url value='/assets/js/common_anchordata.js'/>"></script>
	<script src="<c:url value='/assets/js/paging.js'/>"></script>
	
	
	
</html>

<%-- <!DOCTYPE html>
<html lang="ko">
	
	<script src="/assets/js/common.js"></script>
	<script src="/assets/js/jquery-accessible-tabs.js"></script>
	
	<script src="/assets/js/lib/jquery.nice-select.min.js"></script>
	<script src="/assets/js/paging.js"></script>
	
	<script>
		$(window).scroll(function () {
	    	var position = $(window).scrollTop();
		    if (position > 80) {
		      // $('.swiper-container').fadeOut();
		      $('header').addClass('on');
		    } else {
		      // $('.swiper-container').fadeIn();
		      $('header').removeClass('on');
		    }
	  });
	</script>

	<tiles:insertAttribute name="header" />
	<body>
		<!-- skip list -->
		<div id="skip_navi" role="navigation">
			<a href="#GNB"><span>???????????? ????????????</span></a>
		</div>
		<!-- //skip list -->
	  
		<div id="wrap">
			<tiles:insertAttribute name="headerSide" /> 

			<tiles:insertAttribute name="footer" />
		</div>
	</body>
	
	<script src="/assets/js/common_anchordata.js"></script>

</html> --%>
