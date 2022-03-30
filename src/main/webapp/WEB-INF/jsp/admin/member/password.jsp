<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<sec:authentication property="principal.username" var="member_id" />
<script type='text/javascript'>
	function changePwd() {
		var form = $("#frm")[0];
        var formData = new FormData(form);
		
		var chkVal = ["current_pwd", "new_pwd", "confrim_new_pwd"];
		
		for (var i = 0; i < chkVal.length; i++) {
			if ($("#" + chkVal[i]).val() == "") {
				alert($("#" + chkVal[i]).attr("title") + "은(는) 필수입력입니다.");
				$("#" + chkVal[i]).focus();
				return false;
			}
		}

		if ( $("#new_pwd").val() != $("#confrim_new_pwd").val() ) {
			alert("신규 비밀번호와 확인 비멀번호가 틀립니다.");
			return false;
		}

		var base64CurrentPwd = btoa($("#current_pwd").val());
		var base64newPwd = btoa($("#new_pwd").val());
		var memberId = "${fn:escapeXml(member_id)}";
		
		if (confirm('변경 하시겠습니까?')) {
			$.ajax({
			    type : "POST",
			    url : "/admin/api/member/changePwd",
			    data :{
			    	"current_pwd" : base64CurrentPwd,
			    	"new_pwd" : base64newPwd,
			    	"member_id" : memberId,
			    },
			    success : function(data) {
			    	alert("변경 되었습니다");
			    },
			    error : function(err) {
		        	alert(err);
			    }
			});
		}
	}


</script>
  
<!--페이지 루트-->
<div class="page-nation container">
	<a href="/admin/rdt/home/management"><i class="nav-icon fa fa-home mr5"></i>홈화면</a><span class="route_icon"></span>
	<a href="javascript:void(0)">관리자</a><span class="route_icon"></span>
	<a href="javascript:void(0)">비밀번호 변경</a>
</div>       
		

<!--본문시작-->
<div class="sub-container container">
	<div class="sub-content">
<!--페이지 타이틀-->				
		<div class="page-header">
			<h3 class="page-title text-primary-d2 text-120">비밀번호 변경</h3>
		</div>
<!--리스트 검색 상단-->				
		<div class="sub-content-box bgc-white">
                  <div class="box_bg">
                      <h4 class="clearfix title_icon"><img src="assets/img/password_lock_icon.png" class="mr5 password_icon fl" alt="자물쇠 아이콘" /><span class="fl txt">비밀번호 재설정 </span></h4>
                      <p class="gray_p">비밀번호 변경을 위해 현재 비밀번호와 신규 비밀번호 입력을 해주시기 바랍니다.</p>
                      <div class="border_top_box">
                          <table class="job_write">
                              <caption>아이디</caption>				
                              <tr>							
                                  <th class="w20 jop_write_table_title">아이디</th>
                                  <td class="w80 clearfix">
                                      <input class="form-control w97" type="text" value="${fn:escapeXml(member_id)}" disabled />
                                  </td>		
                              </tr>				
                          </table> 

                          <table class="job_write">
                              <caption>현재 비밀번호</caption>				
                              <tr>							
                                  <th class="w20 jop_write_table_title">현재 비밀번호</th>
                                  <td class="w80 clearfix">
                                      <input type="password" class="form-control brc-on-focusd-inline-block w97" placeholder="현재 비밀번호를 입력하세요." id="current_pwd" title="현재 비밀번호"/>
                                  </td>		
                              </tr>				
                          </table> 

                          <table class="job_write">
                              <caption>신규 비밀번호</caption>				
                              <tr>							
                                  <th class="w20 jop_write_table_title">신규 비밀번호</th>
                                  <td class="w80 clearfix">
                                      <input type="password" maxlength="20" class="form-control brc-on-focusd-inline-block w97" placeholder="신규 비밀번호를 입력하세요." id="new_pwd" title="신규 비밀번호"/>
                                  </td>		
                              </tr>				
                          </table> 

                          <table class="job_write">
                              <caption>신규 비밀번호 확인</caption>				
                              <tr>							
                                  <th class="w20 jop_write_table_title">신규 비밀번호 확인</th>
                                  <td class="w80 clearfix">
                                      <input type="password" maxlength="20" class="form-control brc-on-focusd-inline-block w97" placeholder="신규 비밀번호를 입력하세요." id="confrim_new_pwd" title="신규 비밀번호 확인"/>
                                  </td>		
                              </tr>				
                          </table>   
                          <div class="password_box">
                              <button class="blue_btn btn" onclick="changePwd();">변경하기</button> 
                          </div>
                      </div>
                  </div>      
		</div>
	</div>
</div>
