<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
  
<script type='text/javascript'>

	var companyDetailObject;
	var relativeJob_1 = "";
	var relativeJob_2 = "";
	var relativeJob_3 = "";
	var relativeJobChoiceNo = "";
	
	
	$(document).ready(function() {

		// 행정 구역 정보 
		 getAdministrativeregionList();
		// 해정 구역 정보 Click
	 	$("#region").change(function(){
	 		var regiontId =  $("#region").val();
	 		regionChange(regiontId);
		});
		// 표준 산업 분류
		// initIndustryCategory();

		// 연관 일자리 확인
		$("#job_popup_ok").click(function() {
			if (relativeJobChoiceNo == "1" ) {
				relativeJob_1 = $(":input:radio[name=jobOptions1]:checked").val();
				$("#job_result_1").val($(":input:radio[name=jobOptions1]:checked").attr("text"));
			}
			else if (relativeJobChoiceNo == "2" ) {
				relativeJob_2 = $(":input:radio[name=jobOptions1]:checked").val();
				$("#job_result_2").val($(":input:radio[name=jobOptions1]:checked").attr("text"));
			}
			else {
				relativeJob_3 = $(":input:radio[name=jobOptions1]:checked").val();
				$("#job_result_3").val($(":input:radio[name=jobOptions1]:checked").attr("text"));
			}
		});

		$("#job_search_text").on("keydown", function(key) {
            //키의 코드가 13번일 경우 (13번은 엔터키)
            if (key.keyCode == 13) {
            	jobSearch();
            }
        });

		getJobList();
		getCompanyDetail();
	});


	function getCompanyDetail() {
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/admin/api/company/detail'/>");
		comAjax.setCallback("getDetailCB");
		comAjax.addParam("company_id", $("#company_id").val());
		comAjax.ajax();
	}

	
	function getDetailCB(data){
		companyDetailObject = data.result;

		// 업체규모 적용
		str = "";
		var size = $("#size"); 
		size.empty();
       	<c:forEach items="${commonCode}" var="code">
			<c:if test="${code.master_id == 'M000014'}">
				if ( companyDetailObject.size == "${fn:escapeXml(code.detail_id)}") {
					str += '<div class="form-check form-check-inline">';
					str += '		<input class="form-check-input" type="radio" name="sizeRadioOptions" value="${fn:escapeXml(code.detail_id)}" checked/>';
					str += '		<label class="form-check-label" ><c:out value="${code.name}"></c:out></label>';
					str += '</div>';
				}
				else {
					str += '<div class="form-check form-check-inline">';
					str += '		<input class="form-check-input" type="radio" name="sizeRadioOptions" value="${fn:escapeXml(code.detail_id)}"/>';
					str += '		<label class="form-check-label" ><c:out value="${code.name}"></c:out></label>';
					str += '</div>';
				}
			</c:if>
		</c:forEach>
		size.append(str);

		// 지역 정보 적용
		var str = "";
		var region = $("#region"); 
		region.empty();
		str += "<option value=''>전체</option>";
		$.each(regionList, function(key, value) {
			if (value.master_id == "D000001" && value.code == companyDetailObject.region ) {
				str += "<option value=\"" + value.code + "\" selected>" + value.addr + "</option>";
			}
			else if (value.master_id == "D000001" && value.code != companyDetailObject.region ) {
				str += "<option value=\"" + value.code + "\">" + value.addr + "</option>";
			}
		});
		region.append(str); 
		
		// 지역 정보 상세 적용
		var str = "";
		var regionDetail = $("#region_detail"); 
		regionDetail.empty();
		str += "<option value=''>전체</option>";
		$.each(regionList, function(key, value) {
			if (value.master_id == "D000002" && value.code == companyDetailObject.region_detail ) {
				str += "<option value=\"" + value.code + "\" selected>" + value.addr + "</option>";
			}
			else if (value.master_id == "D000002" && value.code != companyDetailObject.region_detail ) {
				str += "<option value=\"" + value.code + "\">" + value.addr + "</option>";
			}
		});
		regionDetail.append(str); 

		// 표준산업붐류
		str = "";
		var ksic = $("#ksic"); 
		ksic.empty();
		str += '<option value="">표준산업분류</option>';
       	<c:forEach items="${commonCode}" var="code">
			<c:if test="${code.master_id == 'M000015'}">
				if (companyDetailObject.ksic == "${fn:escapeXml(code.detail_id)}") {
					str += '<option value="${code.detail_id}" selected><c:out value="${code.name}"></c:out></option>';
				}
				else {
					str += '<option value="${code.detail_id}"><c:out value="${code.name}"></c:out></option>';
				}
			</c:if>
		</c:forEach>
		ksic.append(str); 

		$("#name").val(companyDetailObject.name);
		$("#address").val(companyDetailObject.address);
		$("#description").val(companyDetailObject.description);
		const phone = companyDetailObject.phone.split('-');
		$("#phone_1").val(phone[0]);
		$("#phone_2").val(phone[1]);
		$("#phone_3").val(phone[2]);
		$("#home_page").val(companyDetailObject.home_page);
		$("#staff_number").val(companyDetailObject.staff_number);
		$("#main_product").val(companyDetailObject.main_product);
		$("#job_result_1").val(companyDetailObject.associated_job_1_name);
		$("#job_result_2").val(companyDetailObject.associated_job_2_name);
		$("#job_result_3").val(companyDetailObject.associated_job_3_name);
		$("#attach_file_name").text(companyDetailObject.upload_file_name);
		$("#attach_file_description").val(companyDetailObject.attach_file_description);

		relativeJob_1 = companyDetailObject.associated_job_1;
		relativeJob_2 = companyDetailObject.associated_job_2;
		relativeJob_3 = companyDetailObject.associated_job_3;

	}

	function getJobList() {
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/admin/api/job/all' />");
		comAjax.setCallback("getJobListCB");
		comAjax.ajax();
	}

	function getJobListCB(data) {
		var body = $("#job_search_list");
		body.empty();
		if (data.result.length == 0) {
			var str = "<tr>" + "<td colspan='6'>조회된 결과가 없습니다.</td>" + "</tr>";
			body.append(str);
		} else {
			jobList = data.result;
			var str = "";
			$.each(data.result, function(key, value) {
				str += "<div class='form-check form-check-inline'>";
				str += "	<input class='form-check-input job_view_disabled' type='radio' name='jobOptions1' text='"+ value.name + "' value='" + value.job_id + "'>";
				str += "	<label class='form-check-label'>" + value.name + "</label>";
				str += "</div>";
			});
			body.append(str);
		}
	}

	function jobBtnClick(clickId) {
		relativeJobChoiceNo = clickId;
	}

	function jobSearch() {
		var str = "";
		var body = $("#job_search_list");
		var serachWord = $("#job_search_text").val();
		body.empty();
		if ( serachWord == null || serachWord == "") {
			$.each(jobList, function(key, value) {
				str += "<div class='form-check form-check-inline'>";
				str += "	<input class='form-check-input job_view_disabled' type='radio' name='jobOptions1' text='"+ value.name + "' value='" + value.job_id + "'>";
				str += "	<label class='form-check-label'>" + value.name + "</label>";
				str += "</div>";
			});
		}
		else {
			$.each(jobList, function(key, value) {
				if (value.name.indexOf(serachWord) != -1 ) {
					str += "<div class='form-check form-check-inline'>";
					str += "	<input class='form-check-input job_view_disabled' type='radio' name='jobOptions1' text='"+ value.name + "' value='" + value.job_id + "'>";
					str += "	<label class='form-check-label'>" + value.name + "</label>";
					str += "</div>";
				}
			});
		}
		body.append(str);
	}

	

	function initIndustryCategory(){
		str = "";
		var industryCategory = $("#ksic"); 
		industryCategory.empty();

		// License Category 별로 License Selector를 만든다.
		str += '<option value="">표준산업분류</option>';
       	<c:forEach items="${commonCode}" var="code">
			<c:if test="${code.master_id == 'M000015'}">
				str += '<option value="${code.detail_id}"><c:out value="${code.name}"></c:out></option>';
			</c:if>
		</c:forEach>
		industryCategory.append(str);

	}

	function getAdministrativeregionList() {
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/user/api/util/openapi/sgis/administrativeDistrict/all' />");
		comAjax.setCallback("getregionListCB");
		comAjax.ajax();
	}

	function getregionListCB(data) {
		regionList = data.result;
	}

	function regionChange(regionId){
		var str = "";
		var regionDetail = $("#region_detail"); 
		regionDetail.empty();

		if (regionId == "") {
			str += "<option value=''>전체</option>";
		}
		else {
			$.each(regionList, function(key, value) {
				if (value.master_id == "D000002" && value.parent_id == regionId ) {
					str += "<option value=\"" + value.code + "\">" + value.addr + "</option>";
				}
			});
		}
		regionDetail.append(str); 
	}
	

	function modification() {
        var formData = new FormData();

		var chkVal = ["region", "region_detail", "name", "address", "home_page"];
		for (var i = 0; i < chkVal.length; i++) 
		{
			if ($("#" + chkVal[i]).val() == "" ) {
				alert($("#" + chkVal[i]).attr("title") + "은(는) 필수입력입니다.");
				$("#" + chkVal[i]).focus();
				return false;
			}
		}

		if ( $('input:radio[name=sizeRadioOptions]').is(':checked') == false ){
			alert("업체 규모 선택은 필수입니다.");
			return false;				
		} 
		
		formData.append("company_id", $('#company_id').val());
		formData.append("size",$(":input:radio[name=sizeRadioOptions]:checked").val());
		formData.append("region", $("#region").val());
		formData.append("region_detail", $("#region_detail").val());
		formData.append("ksic", $("#ksic").val());
		formData.append("name", $("#name").val());
		formData.append("address", $("#address").val());
		formData.append("phone", $("#phone_1").val()+ "-" +$("#phone_2").val()+ "-" + $("#phone_3").val() );
		formData.append("home_page", $("#home_page").val());
		formData.append("staff_number", $("#staff_number").val());
		formData.append("main_product", $("#main_product").val());
		formData.append("associated_job_1", relativeJob_1);
		formData.append("associated_job_2", relativeJob_2);
		formData.append("associated_job_3", relativeJob_3);

		formData.append("upload_file_id", companyDetailObject.upload_file_id);
		formData.append("attach_file_description", $("#attach_file_description").val());


		if ( $("#attach_file")[0].files[0] != undefined && $("#attach_file")[0].files[0] != "") {
			formData.append("attach_file", $("#attach_file")[0].files[0]);
		}

		if (confirm('수정 하시겠습니까?')) {
			$.ajax({
			    type : "POST",
			    url : "/admin/api/company/modification",
			    data : formData,
			    processData: false,
			    contentType: false,
			    mimeType: 'multipart/form-data',
			    success : function(data) {
			    	var jsonData = JSON.parse(data);
			        if (jsonData.result == 1) {
			            alert("수정 되었습니다.");
			            location.href = "/admin/rdt/company/searchList";
			        } else {
			            alert(jsonData.result_msg);
			        }
			    },
			    error : function(err) {
			        alert(err.status);
			    }
			});
		}
	}

	function withdrawal() {
		if (confirm('삭제 하시겠습니까?')) {
			$.ajax({
			    type : "POST",
			    url : "/admin/api/company/withdrawal",
			    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			    data : {
		    				"company_id" : $('#company_id').val(),
		    				"upload_file_id" : companyDetailObject.upload_file_id
		    		    },
			    success : function(data) {
			    	console.log(data.result);
		            if (data.result == 1) {
		            	alert("삭제 되었습니다.");
		            	location.href = "/admin/rdt/company/searchList";
		            }
			    },
			    error : function(err) {
			        alert(err.status);
			    }
			});
		}
	}
	

	function administrativeDistrictUpdate() {
		if (confirm('데이터량에 따라 시간이 걸릴 수 있습니다. 업데이트 하시겠습니까?')) {
			$.ajax({
			    type : "POST",
			    url : "/user/api/util/openapi/sgis/administrativeDistrict/registration",
			    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			    success : function(data) {
			    	console.log(data.result);
		            if (data.result == 1) {
		            	alert("처리완료되었습니다.");
		            }
			    },
			    error : function(err) {
			        alert(err.status);
			    }
			});
		}
	}


	function execPostCode() {
		new daum.Postcode({
            oncomplete: function(data) {
               // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

               // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
               // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
               var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
               var extraRoadAddr = ''; // 도로명 조합형 주소 변수

               // 법정동명이 있을 경우 추가한다. (법정리는 제외)
               // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
               if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                   extraRoadAddr += data.bname;
               }
               // 건물명이 있고, 공동주택일 경우 추가한다.
               if(data.buildingName !== '' && data.apartment === 'Y'){
                  extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
               }
               // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
               if(extraRoadAddr !== ''){
                   extraRoadAddr = ' (' + extraRoadAddr + ')';
               }
               // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
               if(fullRoadAddr !== ''){
                   fullRoadAddr += extraRoadAddr;
               }

               // 우편번호와 주소 정보를 해당 필드에 넣는다.
               console.log(data.zonecode);
               console.log(fullRoadAddr);
               
               
               $("#zipcode").val(data.zonecode);
               $("#address").val(fullRoadAddr);
               
               /* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
               document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
               document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
           }
        }).open();
	}


	

</script>
  
<!--페이지 루트-->
<input type="hidden" id="company_id" name="company_id" value='<c:out value="${vo.company_id}"/>' />
<div class="page-nation container">
    <a  href="./html/index.html"><i class="nav-icon fa fa-home mr5"></i>홈화면</a><span class="route_icon"></span>
    <a href="/admin/rdt/company/searchList">기업 관리</a><span class="route_icon"></span>
    <a href="javascript:void(0);">기업 정보 수정</a>
</div>
<!--본문시작-->
<div class="sub-container container">
	<div class="sub-content">

<!--페이지 타이틀-->				
		<div class="page-header">
			<h3 class="page-title text-primary-d2 text-120">기업 정보 수정</h3>
			<a href="javascript:administrativeDistrictUpdate();" class="blue_btn button fr ml10" >행정 구역 업데이트</a>
		</div>
		
		<div class="sub-content-box bgc-white">
			<form name="frm" id="frm">
	    		  <!--기업 분류 정보-->
                  <table class="job_write">
                      <caption>기업 분류 정보</caption>
                      <colgroup>
                          <col style="width: 15%" />
                          <col style="width: 15%" />
                          <col style="width: 75%" />
                      </colgroup>				
                      <tr>							
                          <th rowspan="3" class="w20 jop_write_table_title">기업 분류 정보</th>
                          <td class="w18 txt_r">
                     		<span class="icon_box"><span class=" necessary_icon">&#42;</span>업체 규모</span>                          
                          </td>
                          <td class="w80" id="size" title="업체 규모"></td>												
                      </tr>
                      <tr>
                          <td class="w10 txt_r">
                              <label class="area_write_table_lable">
                                  <span class="icon_box"><span class="necessary_icon">&#42;</span>지역 선택</span>
                              </label>
                          </td>
                          <td class="w80">
                              	<select class="area_write_table_txt w30 ace-select" id="region" title="지역 선택"></select>
                         		<select class="area_write_table_txt w56-2 ace-select" id="region_detail" title="지역 선택">
                         			<option value=''>전체</option>
                         		</select>
                          </td>							
                      </tr>
                      <tr>
                          <td class="w10 txt_r">
                              <label for="jobcation-focus">
                                  <span class="icon_box">표준 산업 분류</span>
                              </label>
                          </td>
                          <td class="w80">
                              <select class="jop_write_table_txt w87 ace-select" id="ksic" titile="표준 산업 분류"></select>
                          </td>
                      </tr>						
                  </table>
			
                  <!--기본 정보-->					
                  <table class="job_write">
                      <caption>기본 정보</caption>				
                      <tr>							
                          <th rowspan="4" class="w20 jop_write_table_title">기업 정보</th>
                          <td class="w18 txt_r"><span class="icon_box"><span class=" necessary_icon">&#42;</span>기업명</span>
                          </td>
                          <td class="w80">
                              <input type="text" class="form-control brc-on-focusd-inline-block w87"  placeholder="기업이름을 입력하세요" id="name" title="기업명"/>
                          </td>									
                      </tr>
                      <tr>
                          <td class="w18 txt_r">					
                              <span class="icon_box"><span class=" necessary_icon">&#42;</span>주소</span>
                          </td>
                          <td class="w80">
                              <input type="text" class="form-control brc-on-focusd-inline-block w87" name="address" id="address" title="주소" />
                              <button type="button" class="gray_btn mt5" onclick="execPostCode();"><i class="fa fa-search"></i>검색</button>
                          </td>					
                      </tr>
                      <tr>
                          <td class="w18 txt_r">					
                              <span class="icon_box">전화 번호</span>
                          </td>
                          <td class="w80">
                                  <input type='tel' name='phone1' id='phone_1' maxlength="3" class="form-control  w10 fl" title="전화번호"/>
                                  <span style="display:block;" class="fl mc8">-</span>
                                  <input type='tel' name='phone2' id='phone_2' maxlength="4" class="form-control brc-on-focusd-inline-block w10 fl" title="전화번호"/>
                                  <span style="display:block;" class="fl mc8">-</span>
                                  <input type='tel' name='phone3' id='phone_3' maxlength="4" class="form-control brc-on-focusd-inline-block w10 fl" title="전화번호"/>
                          </td>				
                      </tr>	
                      <tr>
                          <td class="w18 txt_r">					
                              <span class="icon_box"><span class=" necessary_icon">&#42;</span>홈페이지</span>
                          </td>
                          <td class="w80">
                              <input type="text" class="form-control brc-on-focusd-inline-block w87" id='home_page' title='홈페이지'/>    
                          </td>					
                      </tr>					
                  </table>
                  <!--기업 정보-->
                  <table class="job_write">
                      <caption>기업 정보</caption>				
                      <tr>							
                          <th rowspan="5" class="w20 jop_write_table_title">기업 정보</th>
                          <td class="w18 txt_r"><span class="icon_box">고용 인원</span>
                          </td>
                          <td class="w80">
                              <input type="text" class="form-control brc-on-focusd-inline-block w35 fl ta_r" placeholder="고용인수를 입력하세요" id="staff_number"/>
                              <span class="text-95 color_9 sub_txt">명</span>
                          </td>									
                      </tr>
                      <tr>
                          <td class="w18 txt_r">
                              <label>
                                  <span class="icon_box">주력제품&#183;서비스</span>
                              </label>
                          </td>
                          <td class="w80 clearfix">                 
                              <input type="text" class="form-control brc-on-focusd-inline-block w87" placeholder="기업의 주력제품&#183;서비스를 입력하세요" id="main_product"/>
                          </td>		
                      </tr>
                      <tr>
                          <td class="w18 txt_r" rowspan="3">
                              <label class="jop_write_table_lable">
                                  <span class="icon_box">연관 일자리</span>
                              </label>
                          </td>
                          <td class="w80 clearfix">
                             <span class="text-95 color_9 sub_txt fl mr5">1. </span>                    
                             <textarea class="form-control brc-on-focusd-inline-block w84 ml5 text-h rc-on-focusd-inline-block" id="job_result_1" disabled></textarea>
                            
                             <button type="button" class="gray_btn mt5 company_job_btn_popup_open" style="margin-left: 21px" onclick='jobBtnClick("1")'>
                             	<i class="fa fa-search"></i>찾기
                           	 </button>
                          </td>                        	
                      </tr>	
                      <tr>
                          <td class="w80 clearfix">
                             <span class="text-95 color_9 sub_txt fl mr5">2. </span>
                             <textarea class="form-control brc-on-focusd-inline-block w84 ml5" id="job_result_2" disabled></textarea>
                            
                             <button type="button" class="gray_btn mt5 company_job_btn_popup_open" style="margin-left: 21px" onclick='jobBtnClick("2")'>
                             	<i class="fa fa-search"></i>찾기
                           	 </button>
                          </td>                             
                      </tr>
                      <tr>
                          <td class="w80 clearfix">
                             <span class="text-95 color_9 sub_txt fl mr5">3. </span>
                             <textarea class="form-control brc-on-focusd-inline-block w84 ml5" id="job_result_3" disabled></textarea>
                                       
                             <button type="button" class="gray_btn mt5 company_job_btn_popup_open" style="margin-left: 21px" onclick='jobBtnClick("3")'>
                             	<i class="fa fa-search"></i>찾기
                           	 </button>
                          </td>                             
                      </tr>
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
                  	<div class="upload_btn">
                        <input type="button" class="blue_btn btn job_retouch_btn" value="수정" onclick="modification();">
                        <div class="fr">
                        	<a href="/admin/rdt/company/searchList" class="gray_btn list_back_btn btn">목록</a>
                            <input type="button" class="gray_btn btn" value="삭제" onclick="withdrawal();">                           
                        </div>
                    </div>
          	</form>
        </div>
	</div>
</div>

<div class="company_job_popupbox">
	<input type="hidden" id="job_choice_no" name="job_choice_no" value="" />
    <div class="company_job_popup_bg"></div>
    <div class="company_job_popup_contents">
        <div class="company_job_popuphead_box">
            <h2 class="fl">연관 일자리 선택</h2>
            <a href="javascript:void(0)" id="company_job_btn_popup_close" class="fr"><i class="fas fa-times"></i></a>
        </div><!--specialism_popuphead_box-->
        <div class="company_job_popuptxt_box">
           <input type="text" class="form-control w84 fl mr5" placeholder="검색어을 입력하세요" id="job_search_text">
           <input type="button" class="blue_btn2 btn company_job_search_btn" onclick='jobSearch();' value="검색">
        </div><!--specialism_popuptxt_box-->
        <div class="company_job_popuptxt_box_box" id="job_search_list">
            
        </div>
        <div class="specialism_popup_btns">
            <button type="button" class="blue_btn company_job_popup_close" id="job_popup_ok">확인</button> 
        </div><!--specialism_popup_btns-->
    </div><!--specialism_popup_contents-->  
</div>
