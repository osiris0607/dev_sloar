<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

  
<script type='text/javascript'>

	$(document).ready(function() {

		getDetail();
		
	});

	function getDetail() {
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/admin/api/notification/training/search/detail'/>");
		comAjax.setCallback("getDetailCB");
		comAjax.addParam("training_id", $("#training_id").val());
		comAjax.ajax();
	}
	
	function getDetailCB(data){
		$("#title").val(data.result.title) ;
		$("#enforcement_agency").val(data.result.enforcement_agency);
		$("#address").val(data.result.address);
		$("#contact").val(data.result.contact);
		$("#home_page").val(data.result.home_page);
		$("#attach_file_name").text(data.result.upload_file_name);
		$("#attach_file_description").val(data.result.attach_file_description);
	}

	function modification() {
		var formData = new FormData();

		var chkVal = ["title", "enforcement_agency", "address", "contact", "home_page"];
		for (var i = 0; i < chkVal.length; i++) 
		{
			if ($("#" + chkVal[i]).val() == "" ) {
				alert($("#" + chkVal[i]).attr("title") + "은(는) 필수입력입니다.");
				$("#" + chkVal[i]).focus();
				return false;
			}
		}

		formData.append("training_id", $("#training_id	").val());
		formData.append("title", $("#title").val());
		formData.append("enforcement_agency", $("#enforcement_agency").val());
		formData.append("address", $("#address").val());
		formData.append("contact", $("#contact").val());
		formData.append("home_page", $("#home_page").val());

		formData.append("upload_file_id", $("#upload_file_id").val());
		formData.append("attach_file_description", $("#attach_file_description").val());

		if ( $("#attach_file")[0].files[0] != undefined && $("#attach_file")[0].files[0] != "") {
			formData.append("attach_file", $("#attach_file")[0].files[0]);
		}

		if (confirm('수정 하시겠습니까?')) {
			$.ajax({
			    type : "POST",
			    url : "/admin/api/notification/training/modification",
			    data : formData,
			    processData: false,
			    contentType: false,
			    mimeType: 'multipart/form-data',
			    success : function(data) {
			    	var jsonData = JSON.parse(data);
			        if (jsonData.result == 1) {
			            alert("수정 되었습니다.");
			            location.href = "/admin/rdt/notification/training/searchList";
			        } else {
			            alert("수정에 실패하였습니다. 다시 시도해 주시기 바랍니다.");
			        }
			    },
			    error : function(err) {
			        alert(err.status);
			    }
			});
		}
	}

	function withdrawal() {
		var formData = new FormData();
		formData.append("training_id", $("#training_id").val());
		
		if (confirm('삭제 하시겠습니까?')) {
			$.ajax({
			    type : "POST",
			    url : "/admin/api/notification/training/withdrawal",
			    data : formData,
			    processData: false,
			    contentType: false,
			    mimeType: 'multipart/form-data',
			    success : function(data) {
			    	var jsonData = JSON.parse(data);
			        if (jsonData.result == 1) {
			            alert("삭제 되었습니다.");
			            location.href = "/admin/rdt/notification/training/searchList";
			        } else {
			            alert("삭제 실패했습니다. 다시 시도해 주시기 바랍니다.");
			        }
			    },
			    error : function(err) {
			        alert(err.status);
			    }
			});
		}
	}

</script>

<!--페이지 루트-->
<input type="hidden" id="upload_file_id" name="upload_file_id" value='<c:out value="${vo.upload_file_id}"/>' />
<input type="hidden" id="training_id" name="training_id" value='<c:out value="${vo.training_id}"/>' />
<div class="page-nation container">
	<a href="/admin/rdt/home/management"><i class="nav-icon fa fa-home mr5"></i>홈화면</a><span class="route_icon"></span>
	<a href="/admin/rdt/notification/trend/searchList">알림/정보</a><span class="route_icon"></span>
	<a href="javascript:void(0);">훈련과정</a>
</div>

<!--본문시작-->
<div class="sub-container container">
	<div class="sub-content">
<!--페이지 타이틀-->				
	<div class="page-header">
		<h3 class="page-title text-primary-d2 text-120	">훈련과정</h3>
	</div>
<!--리스트 검색 상단-->				
	<div class="sub-content-box bgc-white">
                 <table class="job_write">
			<caption>훈련과정명</caption>
			<tbody>
			   <tr>							
					<th class="w20 jop_write_table_title"><span class="icon_box"><span class="necessary_icon">*</span>훈련과정명</span></th>
					<td class="w80">
						<input type="text" class="form-control brc-on-focusd-inline-block w90" id="title"/>                              
					</td>									
			   </tr>
			</tbody>
	   </table>
	   <table class="job_write">
			<caption>기관명</caption>
			<tbody>
			   <tr>							
					<th class="w20 jop_write_table_title"><span class="icon_box"><span class="necessary_icon">*</span>기관명</span></th>
					<td class="w80">
						<input type="text" class="form-control brc-on-focusd-inline-block w90" id="enforcement_agency" title="기관명"/>                              
					</td>									
			   </tr>
			</tbody>
	   </table>
	   <table class="job_write">
			<caption>기관정보 - 주소</caption>
			<tbody>
			   <tr>	
					<th rowspan="3" class="w20 jop_write_table_title">기관정보</th>
					
					<td class="w10 txt_r hm" style="padding-top:30px !important"><span class="icon_box"><span class="necessary_icon">*</span>주소</span></td>
					<td class="w80">
                        <input type="text" class="form-control brc-on-focusd-inline-block w87" name="address" id="address" title="주소" />
                        <button type="button" class="gray_btn mt5" onclick="execPostCode();"><i class="fa fa-search"></i>검색</button>
                    </td>										
			   </tr>
			
			   <tr>							
					<td class="w10 txt_r hm" style="padding-top:30px !important"><span class="necessary_icon">*</span>연락처</td>
					<td class="w80">
						<input type="text" class="form-control brc-on-focusd-inline-block w89" id="contact" title="연락처"/>                              
					</td>									
			   </tr>

	   
			   <tr>							
					<td class="w10 txt_r hm" style="padding-top:30px !important"><span class="necessary_icon">*</span>홈페이지</td>
						<td class="w80">
							<input type="text" class="form-control brc-on-focusd-inline-block w89" id="home_page" title="홈페이지"/>                              
						</td>									
				   </tr>
				</tbody>
		   </table>
		   
		   
		   <table class="job_write">
              <caption>첨부 파일</caption>				
                      	<tr>							
                         	<th rowspan="2" class="w20 jop_write_table_title">이미지</th>
                    	 	<td class="w18 txt_r">				
                           		 <span class="icon_box">기업 이미지</span>  
						 	</td>                           
							<td class="w80 txt_r">                
                              <div class="job_file_upload w87"> 
                                  <div class="custom-file w100">
                                      <input type="file" class="custom-file-input custom-file-input-write-company" id="attach_file" name="attach_file">
                                      <label class="custom-file-label custom-control-label-write-company" for="attach_file" id="attach_file_name">선택된 파일 없음</label>
                                  </div>
                                  
                              </div>                               
                       	 	</td>		
                      	</tr>
                      	<tr>
                            <td class="w18 txt_r">이미지 설명</td>	
                            <td><input type="text" class="form-control brc-on-focusd-inline-block w87 fl" id="attach_file_description" placeholder="이미지 등록시 이미지 설명글을 넣어주세요."></td>	
                        </tr>                      					
            </table>
		   
		   
            <div class="industry-trend-view_btns">
                <a href="javascript:void(0)" class="blue_btn ok_back_btn btn" onclick="modification();">수정</a>
                <div class="fr">
                    <a href="/admin/api/notification/training/searchList" class="gray_btn list_back_btn btn">목록</a>
                    <a href="javascript:void(0)" class="gray_btn list_back_btn btn" onclick="withdrawal();">삭제</a>
                </div>
            </div>
        </div>
    </div>
</div>
