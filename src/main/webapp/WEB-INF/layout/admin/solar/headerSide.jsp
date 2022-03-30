<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<script>
	$(document).ready(function() {
	
		$("#logout_btn").on("click", function(){
			logout();
		});

		//initMenu();
	});

	function initMenu() {
		$(".gnbmenu > ul > li > a").attr("class", "");
		$(".gnbmenu > ul > li > a").eq(${fn:escapeXml(headerMenuIndex)}).attr("class", "active");
	}


	function logout() {
		if (confirm("로그아웃 하시겠습니까?")) {
			var comAjax = new ComAjax();
			comAjax.setUrl("<c:url value='/logoutJson' />");
			comAjax.setCallback("mainLoginCallback");
			comAjax.ajax();
		}
	}
	
	function mainLoginCallback(data) {
		if (data.result = "SUCCESS") {
			alert("로그아웃되었습니다.")
			location.href = "/user/rdt/login/adminLogin";
		}
	}

	function tabSelect(id, hrefUrl) {
		var index;
		if (id == "C0001" || id == "C0002") {
			index = 0;
		} else if (id == "C0003" || id == "C0004" || id == "C0005" || id == "C0006") {
			index = 1;
		} else if (id == "C0007" || id == "C0008" || id == "C0009") {
			index = 2;
		} else if (id == "C0010" || id == "C0011") {
			index = 3;
		} else if (id == "C0012" || id == "C0013" || id == "C0014" || id == "C0015" || id == "C0016") {
			index = 4;
		} else if (id == "C0017" || id == "C0018" || id == "C0019") {
			index = 5;
		}
		
		location.href = hrefUrl;// + "?index=" + index;
	}
	
</script>


<nav class="nav_bar">
	<div class="container clearfix">	
		<div class="logo-txt">
			<a href="/admin/rdt/home/management" class="clearfix">
			<span class="logo_img fl"><img src="/assets/img/logo_anchorData.png" alt="일자리내비게이터 로고"></span>
			<span class="top-txt-c2 m10 fl">일자리 내비게이터</span>
			<span class="top-txt-c1 fl">관리자 페이지</span>
			</a>
		</div>
		<!--<h1 class="logo"><img src="./imgs/logo.png" alt="한국에너지기술평가원 로고"></h1>		-->	             
<!--로그인 아이콘-->                
	    <div class="login-icon-box clearfix">
            <a href="javascript:void(0)" data-original-title="Logout" class="c-withe mr5 login-icon fl" onclick='logout();'>	
            	<i class="fa fa-power-off text-140"></i><div class="logout_txt">logout</div>
            </a>
                  <!--span class="top-login-txt c-gray fl">관리자님 로그인 했습니다.</span-->                    
		</div>
	</div>
</nav>
<!--gnb--> 
<div class="gnbmenu">
	<ul id="menu" class="container">
		<li> 
			<a href="javascript:tabSelect('C0001', '/admin/rdt/home/management');"><i class="nav-icon fa fa-home"></i>홈화면</a>
			<ul class="2depth arrow_box">
				<li><a href="javascript:tabSelect('C0002', '/admin/rdt/home/management');">홈화면 관리</a></li>						
			</ul>
		</li>
		<li>
			<a href="javascript:tabSelect('C0003', '/admin/rdt/job/search');"><i class="nav-icon fas fa-search"></i>일자리</a>
			<ul class="2depth arrow_box">
				<li><a href="javascript:tabSelect('C0004', '/admin/rdt/job/search');">일자리 검색</a></li>
				<li><a href="javascript:tabSelect('C0005', '/admin/rdt/job/registration');">일자리 등록</a></li>
				<li><a href="javascript:tabSelect('C0006', '/admin/rdt/job/codeManagement');">일자리 코드 관리</a></li>
			</ul>
		</li>
		<li>
			<a href="javascript:tabSelect('C0007', '/admin/rdt/company/searchList');"><i class="nav-icon fa fa-edit"></i>기업 관리</a>
			<ul class="arrow_box">
				<li><a href="javascript:tabSelect('C0008', '/admin/rdt/company/searchList');">기업 검색</a></li>
				<li><a href="javascript:tabSelect('C0009', '/admin/rdt/company/registration');">기업 등록</a></li>
			</ul>
		</li>
		<li>
			<a href="javascript:tabSelect('C0010', '/admin/rdt/jobTop/management');"><i class="nav-icon fa fa-atom"></i>유망 일자리</a>
			<ul class="arrow_box">
				<li><a href="javascript:tabSelect('C0011', '/admin/rdt/jobTop/management');">유망 일자리 관리</a></li>
			</ul>
		</li>
         <!--li><a href="#"><i class="fas fa-city"></i>기업 지도</a><	/li-->
         <li>
         	<a href="javascript:tabSelect('C0012', '/admin/rdt/notification/trend/searchList');"><i class="fas fa-bullhorn"></i>알림/정보</a>
           	<ul class="arrow_box">
				<li><a href="javascript:tabSelect('C0013', '/admin/rdt/notification/trend/searchList');">태양광산업 동향</a></li>
				<li><a href="javascript:tabSelect('C0014', '/admin/rdt/notification/license/searchList');">자격증</a></li>
				<li><a href="javascript:tabSelect('C0015', '/admin/rdt/notification/training/searchList');">훈련과정</a></li>
				<li><a href="javascript:tabSelect('C0015', '/admin/rdt/notification/faq/searchList');">FAQ</a></li>
				<li><a href="javascript:tabSelect('C0016', '/admin/rdt/notification/suggest/management');">건의하기</a></li>
			</ul>
         </li>
         <li>
         	<a href="javascript:tabSelect('C0017', '/admin/rdt/notification/account/password');"><i class="fas fa-user-cog"></i>관리자</a>
			<ul class="arrow_box">
			 	<li><a href="javascript:tabSelect('C0018', '/admin/rdt/member/password');">비밀번호 변경</a></li>
				<li><a href="javascript:tabSelect('C0019', '/admin/rdt/member/management');">계정 관리</a></li>
	       </ul>
		</li>
	
		<!-- <li> 
			<a href="./html/index.html"><i class="nav-icon fa fa-home"></i>홈화면</a>
			<ul class="2depth arrow_box">
				<li><a href="html/index.html">홈화면 관리</a></li>						
			</ul>
		</li>
		<li>
			<a href="./html/job-list-search.html" class="active"><i class="nav-icon fas fa-search"></i>일자리</a>
			<ul class="2depth arrow_box">
				<li><a href="/admin/rdt/job/search">일자리 검색</a></li>
				<li><a href="/admin/rdt/job/registration">일자리 등록</a></li>
				<li><a href="/admin/rdt/job/codeManagement">일자리 코드 관리</a></li>
			</ul>
		</li>
		<li><a href="./html/company-list-search.html"><i class="nav-icon fa fa-edit"></i>기업 관리</a>
			<ul class="arrow_box">
				<li><a href="./html/company-list-search.html">기업 검색</a></li>
				<li><a href="./html/company-registration.html">기업 등록</a></li>
			</ul>
		</li>
		<li><a href="./html/job-top10.html"><i class="nav-icon fa fa-atom"></i>10대 유망 일자리</a>
			<ul class="arrow_box">
				<li><a href="./html/job-top10.html">10대 유망 일자리 관리</a></li>
			</ul>
		</li>
         li><a href="#"><i class="fas fa-city"></i>기업 지도</a></li
         <li><a href="./html/industry-trend.html"><i class="fas fa-bullhorn"></i>알림/정보</a>
           	<ul class="arrow_box">
				<li><a href="./html/industry-trend.html">태양광산업 동향</a></li>
				<li><a href="/admin/rdt/notification/licenseList">교육기관/훈련과정</a></li>
				<li><a href="./html/faq.html">FAQ</a></li>
				<li><a href="./html/suggest.html">건의하기</a></li>
			</ul>
         </li>
         <li><a href="./html/password.html"><i class="fas fa-user-cog"></i>관리자</a>
			<ul class="arrow_box">
			 	<li><a  href="./html/password.html">비밀번호 변경</a></li>
				<li><a href="./html/account.html">계정 관리</a></li>
	       </ul>
		</li> -->
	</ul>
</div>


<!-- [E] Header -->