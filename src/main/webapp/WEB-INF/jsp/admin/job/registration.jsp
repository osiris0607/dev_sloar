<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
  
<script type='text/javascript'>
	var companyList = new Array(); 
	var company1 = "";
	var company2 = "";
	var company3 = "";
	var companyChoiceNo = "";

	var jobList = new Array();
	var futureRoad1 = "";
	var futureRoad2 = "";
	var futureRoad3 = "";
	var futureRoadChoiceNo = "";
	
	$(document).ready(function() {

		// 향후 진로 검색
		$("#future_road_popup_ok").click(function() {
			if (futureRoadChoiceNo == "1" ) {
				futureRoad1 = $(":input:radio[name=futureroadOptions1]:checked").val();
				$("#future_result_1").val($(":input:radio[name=futureroadOptions1]:checked").attr("text"));
			}
			else if (futureRoadChoiceNo == "2" ) {
				futureRoad2 = $(":input:radio[name=futureroadOptions1]:checked").val();
				$("#future_result_2").val($(":input:radio[name=futureroadOptions1]:checked").attr("text"));
			}
			else {
				futureRoad3 = $(":input:radio[name=futureroadOptions1]:checked").val();
				$("#future_result_3").val($(":input:radio[name=futureroadOptions1]:checked").attr("text"));
			}
		});

		// 기업  검색
		$("#company_popup_ok").click(function() {
			if (companyChoiceNo == "1" ) {
				company1 = $(":input:radio[name=companyOptions1]:checked").val();
				$("#company_result_1").val($(":input:radio[name=companyOptions1]:checked").attr("text"));
			}
			else if (companyChoiceNo == "2" ) {
				company2 = $(":input:radio[name=companyOptions1]:checked").val();
				$("#company_result_2").val($(":input:radio[name=companyOptions1]:checked").attr("text"));
			}
			else {
				company3 = $(":input:radio[name=companyOptions1]:checked").val();
				$("#company_result_3").val($(":input:radio[name=companyOptions1]:checked").attr("text"));
			}
		});

		$("#company_search_text").on("keydown", function(key) {
            //키의 코드가 13번일 경우 (13번은 엔터키)
            if (key.keyCode == 13) {
            	companySearch();
            }
        });
		
		$("#future_search_text").on("keydown", function(key) {
            //키의 코드가 13번일 경우 (13번은 엔터키)
            if (key.keyCode == 13) {
            	jobSearch();
            }
        });
		
		// 생태계 분류 Click
	 	$("#selector_category").change(function(){
		    categoryId =  $(this).val();
		    categoryChange(categoryId);
		});

		// 생태계 상세 Click
	 	$("#category_detail").change(function(){
	 		var categoryDetailId =  $("#selector_category_detail").val();
		    categoryDetailChange(categoryDetailId);
		});

	 	selectorInit();
	 	radioEducationInit();
	 	radioDifficultyInit();
	 	checkboxMajorInit();
	 	getJobList();
	 	getLicenseList();
	 	getCompanyList();
	 	occupationInit();
	});


	function getCompanyList() {
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/admin/api/company/all' />");
		comAjax.setCallback("getCompanyListCB");
		comAjax.ajax();
	}

	function getCompanyListCB(data) {
		companyList = data.result;
	}

	function companyBtnClick(clickId) {
		companyChoiceNo = clickId;

		var compareId = "";
		if (companyChoiceNo == "1") {
			compareId = company1;
		} else if (companyChoiceNo == "2") {
			compareId = company2;
		}
		else {
			compareId = company3;
		}

		var body = $("#company_search_list");
		body.empty();
		if (companyList == null || companyList.length == 0) {
			var str = "조회된 결과가 없습니다";
			body.append(str);
		} else {
			var str = "";
			$.each(companyList, function(key, value) {
				if ( compareId == value.company_id ) {
					str += "<div class='form-check form-check-inline'>";
					str += "	<input class='form-check-input' type='radio' name='companyOptions1' text='"+ value.name + "' value='" + value.company_id + "' checked>";
					str += "	<label class='form-check-label'>" + value.name + "</label>";
					str += "</div>";
				}
				else {
					str += "<div class='form-check form-check-inline'>";
					str += "	<input class='form-check-input' type='radio' name='companyOptions1' text='"+ value.name + "' value='" + value.company_id + "'>";
					str += "	<label class='form-check-label'>" + value.name + "</label>";
					str += "</div>";
				}
			});
			body.append(str);
		}
	}

	function companySearch() {
		var compareId = "";
		if (companyChoiceNo == "1") {
			compareId = company1;
		} else if (companyChoiceNo == "2") {
			compareId = company2;
		}
		else {
			compareId = company3;
		}

		
		var str = "";
		var body = $("#company_search_list");
		var serachWord = $("#company_search_text").val();
		body.empty();
		if ( serachWord == null || serachWord == "") {
			$.each(companyList, function(key, value) {
				if ( compareId == value.company_id ) {
					str += "<div class='form-check form-check-inline'>";
					str += "	<input class='form-check-input' type='radio' name='companyOptions1' text='"+ value.name + "' value='" + value.company_id + "' checked>";
					str += "	<label class='form-check-label'>" + value.name + "</label>";
					str += "</div>";
				}
				else {
					str += "<div class='form-check form-check-inline'>";
					str += "	<input class='form-check-input' type='radio' name='companyOptions1' text='"+ value.name + "' value='" + value.company_id + "'>";
					str += "	<label class='form-check-label'>" + value.name + "</label>";
					str += "</div>";
				}
			});
		}
		else {
			$.each(companyList, function(key, value) {
				if (value.name.indexOf(serachWord) != -1 ) {
					if ( compareId == value.company_id ) {
						str += "<div class='form-check form-check-inline'>";
						str += "	<input class='form-check-input' type='radio' name='companyOptions1' text='"+ value.name + "' value='" + value.company_id + "' checked>";
						str += "	<label class='form-check-label'>" + value.name + "</label>";
						str += "</div>";
					}
					else {
						str += "<div class='form-check form-check-inline'>";
						str += "	<input class='form-check-input' type='radio' name='companyOptions1' text='"+ value.name + "' value='" + value.company_id + "'>";
						str += "	<label class='form-check-label'>" + value.name + "</label>";
						str += "</div>";
					}
				}
			});
		}
		body.append(str);
	}

	function getLicenseList() {
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/admin/api/notification/license/all' />");
		comAjax.setCallback("getLicenseListCB");
		comAjax.ajax();
	}

	function getLicenseListCB(data) {
		var str = "";
		// License Category Selector 만들기
		var licenseCategory = $("#selector_license_category"); 
		licenseCategory.empty();

		var index = 1;
		str += '<select class="ace-select w100" id="selector_license_category" name="testSelect" onChange="selectForm(this.options[this.selectedIndex].value)" title="">';
		str += '<option value="">--선택--</option>';
   		<c:forEach items="${commonCode}" var="code">
			<c:if test="${code.master_id == 'M000007'}">
				str += '<option value="' +index + '"><c:out value="${code.name}"></c:out></option>';
				index++;
			</c:if>
		</c:forEach>
		str += '</select>';
		licenseCategory.append(str); 


		// License Selector 만들기
		str = "";
		var selectorLicense = $("div[name=selector_license]"); 
		selectorLicense.empty();

		// License Category 별로 License Selector를 만든다.
       	<c:forEach items="${commonCode}" var="code">
			<c:if test="${code.master_id == 'M000007'}">
				var licenseId = "${fn:escapeXml(code.detail_id)}";

				str += '<ul>';
				// category 에 해당하는 License를 찾는다.
				$.each(data.result, function(key, value) {
					if (licenseId == value.field) {
						str += '<li>';
						str += '	<div class="form-check form-check-inline">';
						str += '		<input class="form-check-input" name="certificate" type="checkbox" id="" value="' + value.license_id + '" text="'+ value.kor_name +'">';
						str += '		<label class="form-check-label" for="">' + value.kor_name + '</label>';
						str += '	</div>';
						str += '</li>';
					}
				});
				str += '</ul>';
			</c:if>
		</c:forEach>
		selectorLicense.append(str);
	}

	function getJobList() {
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/admin/api/job/all' />");
		comAjax.setCallback("getJobListCB");
		comAjax.ajax();
	}

	function getJobListCB(data) {
		jobList = data.result;
	}

	function jobBtnClick(clickId) {
		futureRoadChoiceNo = clickId;

		var compareId = "";
		if (futureRoadChoiceNo == "1") {
			compareId = futureRoad1;
		} else if (futureRoadChoiceNo == "2") {
			compareId = futureRoad2;
		}
		else {
			compareId = futureRoad3;
		}

		var body = $("#future_search_list");
		body.empty();
		if (jobList == null || jobList.length == 0) {
			var str = "조회된 결과가 없습니다.";
			body.append(str);
		} else {
			
			var str = "";
			$.each(jobList, function(key, value) {
				if ( compareId == value.job_id ) {
					str += "<div class='form-check form-check-inline'>";
					str += "	<input class='form-check-input job_view_disabled' type='radio' name='futureroadOptions1' text='"+ value.name + "' value='" + value.job_id + "' checked>";
					str += "	<label class='form-check-label'>" + value.name + "</label>";
					str += "</div>";
				}
				else {
					str += "<div class='form-check form-check-inline'>";
					str += "	<input class='form-check-input job_view_disabled' type='radio' name='futureroadOptions1' text='"+ value.name + "' value='" + value.job_id + "'>";
					str += "	<label class='form-check-label'>" + value.name + "</label>";
					str += "</div>";
				}
			});
			body.append(str);
		}
	}

	function jobSearch() {
		var compareId = "";
		if (futureRoadChoiceNo == "1") {
			compareId = futureRoad1;
		} else if (futureRoadChoiceNo == "2") {
			compareId = futureRoad2;
		}
		else {
			compareId = futureRoad3;
		}

		
		var str = "";
		var body = $("#future_search_list");
		var serachWord = $("#future_search_text").val();
		body.empty();
		if ( serachWord == null || serachWord == "") {
			$.each(jobList, function(key, value) {
				if ( compareId == value.job_id ) {
					str += "<div class='form-check form-check-inline'>";
					str += "	<input class='form-check-input job_view_disabled' type='radio' name='futureroadOptions1' text='"+ value.name + "' value='" + value.job_id + "' checked>";
					str += "	<label class='form-check-label'>" + value.name + "</label>";
					str += "</div>";
				}
				else {
					str += "<div class='form-check form-check-inline'>";
					str += "	<input class='form-check-input job_view_disabled' type='radio' name='futureroadOptions1' text='"+ value.name + "' value='" + value.job_id + "'>";
					str += "	<label class='form-check-label'>" + value.name + "</label>";
					str += "</div>";
				}
			});
		}
		else {
			$.each(jobList, function(key, value) {
				if (value.name.indexOf(serachWord) != -1 ) {
					if ( compareId == value.job_id ) {
						str += "<div class='form-check form-check-inline'>";
						str += "	<input class='form-check-input job_view_disabled' type='radio' name='futureroadOptions1' text='"+ value.name + "' value='" + value.job_id + "' checked>";
						str += "	<label class='form-check-label'>" + value.name + "</label>";
						str += "</div>";
					}
					else {
						str += "<div class='form-check form-check-inline'>";
						str += "	<input class='form-check-input job_view_disabled' type='radio' name='futureroadOptions1' text='"+ value.name + "' value='" + value.job_id + "'>";
						str += "	<label class='form-check-label'>" + value.name + "</label>";
						str += "</div>";
					}
				}
			});
		}
		body.append(str);
	}

	function registration() {
		var form = $("#frm")[0];
        var formData = new FormData();
        var sUrl = "";
		var params = new Object();

		var chkVal = ["selector_category", "selector_category_detail", "selector_occupation", "name", "definition", "description"];
		for (var i = 0; i < chkVal.length; i++) 
		{
			if ($("#" + chkVal[i]).val() == "" || $("#" + chkVal[i]).val() == "none" ) {
				alert($("#" + chkVal[i]).attr("title") + "은(는) 필수입력입니다.");
				$("#" + chkVal[i]).focus();
				return false;
			}
		}

		if ( $('input:radio[name=inlineRadioOptions_education]').is(':checked') == false ){
			alert("요구 학력 선택은 필수입니다.");
			return false;				
		} 
		
		if ( $('input:radio[name=inlineRadioOptions_difficulty]').is(':checked') == false ){
			alert("직무 난이도 선택은 필수입니다.");
			return false;				
		} 

		formData.append("category_id", $("#selector_category").val());
		formData.append("category_detail_id", $("#selector_category_detail").val());
		formData.append("occupation", $("#selector_occupation").val());
		formData.append("name", $("#name").val());
		formData.append("definition", $("#definition").val());
		formData.append("description", $("#description").val());
		var educationVal = $(":input:radio[name=inlineRadioOptions_education]:checked").val();
		formData.append("education", educationVal);

		var majorList = new Array();
		$("input[name=specialism]:checked").each(function() {
			majorList.push($(this).val());
		});
		formData.append("major_list", majorList);

		var licenseList = new Array();
		$("input[name=certificate]:checked").each(function() {
			licenseList.push($(this).val());
		});
		formData.append("license_list", licenseList);

		if ( $("#attach_file")[0].files[0] != undefined && $("#attach_file")[0].files[0] != "") {
			formData.append("attach_file", $("#attach_file")[0].files[0]);
		}

		formData.append("career", $("#career").val());
		var radioVal = $(":input:radio[name=inlineRadioOptions_difficulty]:checked").val();
		formData.append("difficulty", radioVal);

		formData.append("knowledge", $("#knowledge").val());
		formData.append("skill", $("#skill").val());
		formData.append("attitude", $("#attitude").val());

		if ($("#salary_level").val() == null || $("#salary_level").val() == "") {
			formData.append("salary_level", 0);
		}
		else {
			formData.append("salary_level", $("#salary_level").val().replace(",", ""));
		}
		
		formData.append("related_job", $("#related_job").val());
		formData.append("related_occupation", $("#related_occupation").val());
		formData.append("keco", $("#keco").val());
		formData.append("company_1", company1);
		formData.append("company_2", company2);
		formData.append("company_3", company3);
		formData.append("future_career_1", futureRoad1);
		formData.append("future_career_2", futureRoad2);
		formData.append("future_career_3", futureRoad3);
		formData.append("attach_file_description", $("#attach_file_description").val());

		if (confirm('등록 하시겠습니까?')) {
			$.ajax({
			    type : "POST",
			    url : "/admin/api/job/registration",
			    data : formData,
			    processData: false,
			    contentType: false,
			    mimeType: 'multipart/form-data',
			    success : function(data) {
			    	var jsonData = JSON.parse(data);
			        if (jsonData.result == 1) {
			            alert("등록 되었습니다.");
			            location.href = "/admin/rdt/job/search";
			        } else {
			            alert("등록에 실패하였습니다. 다시 시도해 주시기 바랍니다.");
			        }
			    },
			    error : function(err) {
			        alert(err.status);
			    }
			});
		}
	}

	function checkboxMajorInit(){
		str = "";
		var major = $("#checkbox_major"); 

		major.empty();
   		<c:forEach items="${commonCode}" var="code">
			<c:if test="${code.master_id == 'M000006'}">
				str += '<li>';
				str += '	<div class="form-check form-check-inline">';
				str += '		<input class="form-check-input" name="specialism" type="checkbox" id="" value="${fn:escapeXml(code.detail_id)}" text="${fn:escapeXml(code.name)}" >';
				str += '		<label class="form-check-label" for="">${fn:escapeXml(code.name)}</label>';
				str += '	</div>';
				str += '</li>';
			</c:if>
		</c:forEach>
		major.append(str); 
	}

	function radioDifficultyInit() {
		str = "";
		var difficulty = $("#radio_difficulty"); 
		
		difficulty.empty();
   		<c:forEach items="${commonCode}" var="code">
			<c:if test="${code.master_id == 'M000012'}">
				str += '<div class="form-check form-check-inline">';
				str += '	<input class="form-check-input" type="radio" name="inlineRadioOptions_difficulty" id="" value="${fn:escapeXml(code.detail_id)}" >';
				str += '		<label class="form-check-label" for="">${fn:escapeXml(code.name)}</label>';
				str += '</div>';
			</c:if>
		</c:forEach>
		
		difficulty.append(str); 
	}

	function radioEducationInit(){
		str = "";
		var education = $("#radio_education"); 
		education.empty();
   		<c:forEach items="${commonCode}" var="code">
			<c:if test="${code.master_id == 'M000005'}">
				str += '<div class="form-check form-check-inline">';
				str += '	<input class="form-check-input" type="radio" name="inlineRadioOptions_education" id="" value="${fn:escapeXml(code.detail_id)}" >';
				str += '	<label class="form-check-label">${fn:escapeXml(code.name)}</label>';
				str += '</div>';
			</c:if>
		</c:forEach>
		
		education.append(str); 
	}


	function occupationInit() {
		// 직종 분류 Select 생성 
		str = "";
		var occupation = $("#category_occupation"); 
		occupation.empty();
		str += '<select class="jop_write_table_txt w60 ace-select" id="selector_occupation" title="직종 분류">';
		str += '<option value="">직종 선택</option>';
   		<c:forEach items="${commonCode}" var="code">
			<c:if test="${code.master_id == 'M000004'}">
				str += '<option value="${code.detail_id}"><c:out value="${code.name}"></c:out></option>';
			</c:if>
		</c:forEach>
		str += '</select>';
		occupation.append(str); 
	}

	function categoryChange(categoryId) {
		if (categoryId != "none"){
			// 생테게 세부 분류 Select 생성	
			var isSelected = true;
			var categoryDetailId = "";
			
			var str = "";
			var categoryDetail = $("#category_detail"); 
			categoryDetail.empty();
			str += '<select class="jop_write_table_txt w60 ace-select"  name="selector_category_detail" id="selector_category_detail" title="생태계 세부 분류">';
    		<c:forEach items="${commonCode}" var="code">
				<c:if test="${code.master_id == 'M000003'}">
					if (categoryId == "${fn:escapeXml(code.parent_id)}") {
						// 맴 처음 나오는 데이터가 Selected이며, Selected된 detail Id로 직종을 찾는다.
						if (isSelected) {
							isSelected = false;
							categoryDetailId = "${fn:escapeXml(code.detail_id)}";
						}
						str += '<option value="${code.detail_id}"><c:out value="${code.name}"></c:out></option>';
					}
				</c:if>
			</c:forEach>
			str += '</select>';
			categoryDetail.append(str); 
		} else {
			selectorInit();
		}
	}

	function selectorInit() {
 		var str = "";
		var categoryDetail = $("#category_detail"); 
		categoryDetail.empty();
		str += '<select class="jop_write_table_txt w60 ace-select"  name="selector_category_detail" id="selector_category_detail" title="생태계 세부 분류">';
		str += '<option value="">생태계 분류를 선택하세요.</option>';
		str += '</select>';
		categoryDetail.append(str); 
	}

	function majorClear() {
		$("#specialism_result").val("");
		$("input[name=specialism]").prop("checked",false);
	}

	function licenseClear() {
		$("#certificate_result").val("");
		$("input[name=certificate]").prop("checked",false);
	}

</script>
  
<!--페이지 루트-->
<div class="page-nation container">
    <a  href="./html/index.html"><i class="nav-icon fa fa-home mr5"></i>홈화면</a><span class="route_icon"></span>
    <a href="./html/job-list-search.html">일자리</a><span class="route_icon"></span>
    <a href="#">일자리 등록</a>
</div>
<!--본문시작-->
<div class="sub-container container">
	<input type="hidden" id="common_code" name="common_code" value='<c:out value="${commonCode}"/>' />
	<div class="sub-content">
		<form name="frm" id="frm">
			<!--페이지 타이틀-->				
			<div class="page-header">
				<h3 class="page-title text-primary-d2 text-120">
				일자리 등록
				</h3>
			</div>
			
			<div class="sub-content-box bgc-white">
			    <!--기본 정보-->
                   <table class="job_write">
                       <caption>기본 정보</caption>
                       <colgroup>
                           <col style="width: 15%" />
                           <col style="width: 15%" />
                           <col style="width: 75%" />
                       </colgroup>				
                       <tr>							
                           <th rowspan="3" class="jop_write_table_title w20">기본 정보</th>
                           <td class="w18 txt_r">
                               <label for="category_select" class="jop_write_table_lable">
                                   <span class="icon_box"><span class=" necessary_icon">&#42;</span>생태계 분류</span>
                               </label>
                           </td>
                           <td class="w80">
                        		<select class="jop_write_table_txt ace-select w60" id="selector_category" title="생태계 분류">	
                               	<option value="">생태계 분류 전체</option>
                        		<c:forEach items="${commonCode}" var="code">
									<c:if test="${code.master_id == 'M000002'}">
										<option value="${code.detail_id}"><c:out value="${code.name}"></c:out></option>
									</c:if>
								</c:forEach>
                                </select>
                           </td>												
                       </tr>
                       <tr>
                           <td class="w10 txt_r">
                               <label class="jop_write_table_lable">
                                       <span class="icon_box"><span class=" necessary_icon">&#42;</span>생태계 세부 분류</span>
                               </label>
                           </td>
                           <td class="w80" id="category_detail">
                           </td>							
                       </tr>
                       <tr>
                           <td class="w10 txt_r">
                               <label for="selector_occupation" class="jop_write_table_lable">
                                       <span class="icon_box"><span class=" necessary_icon">&#42;</span>직종 분류</span>
                               </label>
                           </td>
                           <td class="w80" id="category_occupation">
                           </td>
                       </tr>						
                   </table>
				
                   <!--직무자격-->					
                   <table class="job_write" summary="일자리정보입니다.">
                       <caption>일자리 정보</caption>				
                       <tr>							
                           <th rowspan="3" class="w20" class="jop_write_table_title">일자리 정보</th>
                           <td class="w18 txt_r">    
                           	<span class="icon_box"><span class=" necessary_icon">&#42;</span>일자리명</span>
                           </td>
                           <td class="w80">
                               <input type="text" class="form-control brc-on-focusd-inline-block w60 fl"  placeholder="일자리명을 입력하세요" id="name" title="일자리명"/>
                               <span class="text-95 color_9 sub_txt"></span>
                           </td>									
                       </tr>
                       <tr>
                       
                           <td class="w18 txt_r">					
                               <span class="icon_box"><span class=" necessary_icon">&#42;</span>일자리 정의</span>
                           </td>
                           <td class="w80">
                               <input type="text" class="form-control brc-on-focusd-inline-block w87 fl" placeholder="일자리에 대한 정의를 입력하세요" id="definition" title="일자리 정의"/>
                               <span class="text-95 color_9 sub_txt"></span>
                           </td>					
                       </tr>
                       <tr>
                           <td class="w18 txt_r">					
                               <span class="icon_box"><span class=" necessary_icon">&#42;</span>직무 내용</span>

                           </td>
                           <td class="w80">
                               <input type="text" class="form-control brc-on-focusd-inline-block w87 fl" placeholder="직무내용을 입력하세요" id="description" title="직무 내용"/>
                               <span class="text-95 color_9 sub_txt"></span>
                           </td>				
                       </tr>						
                   </table>
                   <!--직무 자격-->
                   <table class="job_write" summary="직무 자격">
                       <caption>직무 자격</caption>				
                       <tr>							
                           <th rowspan="5" class="w20 jop_write_table_title">직무 자격</th>
                           <td class="w18 txt_r">						
							<span class="icon_box"><span class=" necessary_icon">*</span>요구학력</span>
                           </td>
                           <td class="w80" id="radio_education">
                           </td>										
                       </tr>
                       
                       <tr>
                            <td class="w18 txt_r">
                                <span class="icon_box"><span class=" necessary_icon">*</span><label for="specialism_result" class="jop_write_table_lable">
                                    <span class="icon_box">전공</span>
                                </label></span>
                            </td>
                            <td class="w80 clearfix">                 
                                <textarea class="form-control brc-on-focusd-inline-block w87" id="specialism_result" style="height:58px" disabled></textarea>                        
                                <div class="d-inline-flex2 align-items-center ml-sm-0 mb-1 mt5">
                                    <button type="button" class="gray_btn specialism_popup_btn fl" id="specialism_popup_btn"><i class="fa fa-search"></i>찾기</button> 
                                    <button type="button" class="erase gray_btn2 ml5 fl" onclick="majorClear();">초기화</button>  
                                </div>
                            </td>		
                    	</tr>
						<tr>
                            <td class="w18 txt_r">
                                <label for="certificate_result" class="jop_write_table_lable">
                                    <span class="icon_box">자격증</span>
                                </label>
                            </td>
                            <td class="w80 clearfix">
                              <textarea class="form-control brc-on-focusd-inline-block w87" id="certificate_result" style="height:58px" disabled></textarea>                    
                              <div class="d-inline-flex2 align-items-center ml-sm-0 mb-1 mt5 fl clearfix">
                                 <button type="button" class="gray_btn certificate_popup_btn fl" id="certificate_popup_btn"><i class="fa fa-search"></i>찾기</button> 
                                 <button type="button" class="erase gray_btn2 ml5" onclick="licenseClear();">초기화</button>  
                              </div>
                               
                            </td>                        	
                        </tr>                       
                       <tr>
                           <td class="w18 txt_r">
                               <label for="job_name" class="jop_write_table_lable">
                                   <span class="icon_box">필요 경력</span>

                               </label>
                           </td>
                           <td class="w80 clearfix">
                               <input type="text" class="form-control brc-on-focusd-inline-block w87 fl"  id="career" placeholder="필요경력을 입력하세요. (예)7년 이상">
                               <span class="text-95 color_9 sub_txt"></span>
                           </td>                        	
                       </tr>	
                       <tr>
                          <td class="w18 txt_r">						
                      			<span class="icon_box"><span class=" necessary_icon">*</span>직무 난이도</span>
                          </td>
                           <td class="w80" id="radio_difficulty">
                           </td>										
                       </tr>					
                   </table>
                   <!--직무 능력-->
                   <table class="job_write" summary="직무 능력">
                       <caption>직무 능력</caption>				
                       <tr>							
                           <th rowspan="3" class="w20" class="jop_write_table_title">직무 능력</th>
                           <td class="w18 txt_r">    
                           	<span class="icon_box">지식</span>
                           </td>
                           <td class="w80">
                               <input type="text" class="form-control brc-on-focusd-inline-block w87 fl" id="knowledge" placeholder="지식 정보를 입력하세요" />
                           </td>									
                       </tr>
                       <tr>
                           <td class="w18 txt_r">					
                               <span class="icon_box">기술</span>
                           </td>
                           <td class="w80">
                               <input type="text" class="form-control brc-on-focusd-inline-block w87 fl" id="skill" placeholder="기술 정보를 입력하세요" />
                           </td>					
                       </tr>
                       <tr>
                           <td class="w18 txt_r">					
                               <span class="icon_box">태도</span>
                           </td>
                           <td class="w80">
                               <input type="text" class="form-control brc-on-focusd-inline-block w87 fl" id="attitude" placeholder="일자리에 재한 태도를 입력하세요" />   
                           </td>				
                       </tr>						
                   </table>

                   <!--근무 여건-->
                   <table class="job_write" summary="근무 여건">
                       <caption>근무 여건</caption>				
                       <tr>							
                           <th class="w20 jop_write_table_title">근무 여건</th>
                           <td class="w18 txt_r"><span class="icon_box">급여 수준</span></td>
                           <td class="w80">
                              	<input type="text" id="salary_level" style="ime-mode:disabled"  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1').replace(/\B(?=(\d{3})+(?!\d))/g, ',');" class="onlynumber ta_r form-control brc-on-focusd-inline-block w30 fl" placeholder="연봉 수준을 입력하세요.">
                               <span class="text-95 color_9 sub_txt">(만원)</span>
                           </td>
                       </tr>  
                   </table>
                   
                   <!--기타-->
                   <table class="job_write" summary="기타">
                       <caption>기타</caption>				
                       <tr>							
                           <th rowspan="3" class="w20" class="jop_write_table_title">기타</th>
                           <td class="w18 txt_r"><span class="icon_box">관련 일자리</span>
                           </td>
                           <td class="w80">
                               <input type="text" id="related_job" class="form-control brc-on-focusd-inline-block w87 fl"  placeholder="관련일자리 정보를 입력하세요" />
                           </td>									
                       </tr> 
                       <tr>
                           <td class="w18 txt_r">					
                               <span class="icon_box">관련직업(타산업)</span>
                           </td>
                           <td class="w80">
                               <input type="text" id="related_occupation" class="form-control brc-on-focusd-inline-block w87 fl"  placeholder="관련직업(타직업) 정보를 입력하세요" />
                           </td>					
                       </tr>
                       <tr>
                           <td class="w18 txt_r">					
                               <span class="icon_box">한국고용직업분류</span>
                           </td>
                           <td class="w80">
                               <input type="text" id="keco" class="form-control brc-on-focusd-inline-block w87 fl"  placeholder="한국고용직업분류 정보를 입력하세요" /> 
                           </td>				
                       </tr>	
                   </table>
                   
                    <!--해당기업-->
                    <table class="job_write">
                        <caption>해당 기업</caption>			
                        <tr>							
                            <th rowspan="3" class="w20 jop_write_table_title">해당 기업</th>
                            <td class="w18 txt_r hm" style="padding-top:30px !important">
                           		<span class="icon_box"><span class="necessary_icon">*</span>기업 1</span>	
                            </td>
                            <td class="w80 clearfix">
                              	<textarea class="form-control brc-on-focusd-inline-block w87" id="company_result_1" style="height:58px" disabled></textarea> 
                              	<button type="button" class="gray_btn mt5 job_company_future_btn_popup_open1" onclick='companyBtnClick("1")'>
                              		<i class="fa fa-search"></i>찾기
                            	</button>    
                            </td>		
                        </tr>
                        <tr>
                            <td class="w18 txt_r  hm"><span class="icon_box">기업 2</span></td>
                            <td class="w80 clearfix">
                              	<textarea class="form-control brc-on-focusd-inline-block w87" id="company_result_2" style="height:58px" disabled></textarea> 
                              	<button type="button" class="gray_btn mt5 job_company_future_btn_popup_open1" onclick='companyBtnClick("2")'>
                              		<i class="fa fa-search"></i>찾기
                             	</button>    
                            </td>		                     	
                        </tr>	
                       <tr>
                            <td class="w18 txt_r hm"><span class="icon_box">기업 3</span></td>
                            <td class="w80 clearfix">
                              	<textarea class="form-control brc-on-focusd-inline-block w87" id="company_result_3" style="height:58px" disabled></textarea> 
                              	<button type="button" class="gray_btn mt5 job_company_future_btn_popup_open1" onclick='companyBtnClick("3")'>
                              		<i class="fa fa-search"></i>찾기
                             	</button>   
                            </td>		                     	
                        </tr>					
                    </table>
                   
                   <!--향후 진로-->
                    <table class="job_write">
                        <caption>향후 진로</caption>				
                        <tr>							
                            <th rowspan="3" class="w20 jop_write_table_title">향후 진로</th>
                            <td class="w18 txt_r hm"><span class="icon_box">향후 진로 1</span>
                            </td>
                            <td class="w80 clearfix">
                                <textarea class="form-control brc-on-focusd-inline-block w87" id="future_result_1" style="height:58px" disabled></textarea>
                                <button type="button" class="gray_btn mt5 future_btn_popup_open" onclick='jobBtnClick("1")' >
                                	<i class="fa fa-search"></i>찾기
                               	</button>
                            </td>		
                        </tr>
                        <tr>
                            <td class="w18 txt_r hm"><span class="icon_box">향후 진로 2</span>
                            </td>
                            <td class="w80 clearfix">
                                <textarea class="form-control brc-on-focusd-inline-block w87" id="future_result_2" style="height:58px" disabled></textarea>
                                <button type="button" class="gray_btn mt5 future_btn_popup_open" onclick='jobBtnClick("2")'>
                                	<i class="fa fa-search"></i>찾기
                               	</button>
                            </td>				                     	
                        </tr>	
                       <tr>
                            <td class="w18 txt_r hm"><span class="icon_box">향후 진로 3</span>
                            </td>
                            <td class="w80 clearfix">
                                <textarea class="form-control brc-on-focusd-inline-block w87" id="future_result_3" style="height:58px;" disabled></textarea>
                                <button type="button" class="gray_btn mt5 future_btn_popup_open" onclick='jobBtnClick("3")'>
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
                   <div class="upload_btn" id="registration_btn" onclick='registration();'>
                       <button  type="button" class="blue_btn">등록</button>
                   </div>               
			</div> <!--페이지 타이틀-->	
		</form>
	</div>
</div>
         
<!--팝업-->
    <!--전공 팝업-->
    <div class="specialism_popup_pannel">
        <div class="specialism_popup_bg"></div>
        <div class="specialism_popup_contents">
            <div class="specialism_popuphead_box">
                <h2 class="fl">전공 선택</h2>
                <a href="javascript:void(0)" id="specialism_btn_popup_close" class="fr"><i class="fas fa-times"></i></a>
            </div><!--specialism_popuphead_box-->
            <div class="specialism_popuptxt_box">
               
                   	<ul class="clearfix" id="checkbox_major">
					</ul>
                
            </div><!--specialism_popuptxt_box-->
            <div class="specialism_popup_btns">
                <button class="blue_btn specialism_popup_close" id="specialism_popup_ok" onclick='specialism_getCheckboxValue()'>확인</button> 
            </div><!--specialism_popup_btns-->
        </div><!--specialism_popup_contents-->  
    </div>
    
    <!--자격증 팝업-->
    <div class="certificate_popup_pannel">
        <div class="certificate_popup_bg"></div>
        <div class="certificate_popup_contents">
            <div class="certificate_popuphead_box">
                <h2 class="fl">자격증 선택</h2>
                <a href="javascript:void(0)" id="certificate_btn_popup_close" class="fr"><i class="fas fa-times"></i></a>
            </div><!--specialism_popuphead_box-->
            <div class="certificate_popuptxt_box" id="selector_license_category" title="자격증 분류">
            </div>  
            <div class="certificate_popuptxt_box2" id="allForms" name="selector_license" title="자격증 종류">
            </div><!--specialism_popuptxt_box-->
            
            <div class="certificate_popup_btns">
                <button class="blue_btn certificate_popup_close" id="certificate_popup_close" onclick='getCheckboxValue()'>확인</button> 
                
            </div><!--specialism_popup_btns-->
        </div><!--specialism_popup_contents-->  
    </div>         
 

<!--향후진로1 검색-->
    <div class="future_road_popupbox">
    	<input type="hidden" id="future_road_choice_no" name="future_road_choice_no" value="" />
        <div class="future_road_popup_bg"></div>
        <div class="future_road_popup_contents">
            <div class="future_road_popuphead_box">
                <h2 class="fl">향후 진로 선택</h2>
                <a href="javascript:void(0)" id="future_road_btn_popup_close" class="future_road_popup_close fr"><i class="fas fa-times"></i></a>
            </div><!--specialism_popuphead_box-->
            <div class="future_road_popuptxt_box">
               <input type="text" class="form-control w84 fl mr5" placeholder="검색어을 입력하세요" id="future_search_text">
               <input type="button" class="gray_btn btn future_road_search_btn" onclick='jobSearch();' value="검색">
            </div><!--specialism_popuptxt_box-->
            <div class="future_road_popuptxt_box_box" id="future_search_list">
            </div>
            <div class="specialism_popup_btns">
                <button type="button" class="blue_btn future_road_popup_close" id="future_road_popup_ok">확인</button> 
            </div><!--specialism_popup_btns-->
        </div><!--specialism_popup_contents-->  
    </div>
    
    
    
    
   <!--해당기업 기업1-->
   <div class="jobcompany_popupbox1">
		<input type="hidden" id="company_choice_no" name="company_choice_no" value="" />
       	<div class="jobcompany_road_popup_bg1"></div>
       	<div class="jobcompany_job_popup_contents1">
        	<div class="jobcompany_job_popuphead_box1">
            	<h2 class="fl">기업 선택</h2>
               	<a href="javascript:void(0)" id="jobcompany_btn_popup_close1" class="fr"><i class="fas fa-times"></i></a>
          	</div>
           	<div class="jobcompany_popuptxt_box1">
              <input type="text" class="form-control w84 fl mr5" placeholder="검색어을 입력하세요" id="company_search_text">
              <input type="button" class="gray_btn btn jobcompany_search_btn1" onclick='companySearch();' value="검색">
           </div>
           <div class="jobcompany_popuptxt_box_box1" id="company_search_list"></div>
           <div class="jobcompany_popup_btns">
               <button type="button" class="blue_btn jobcompany_popup_close1" id="company_popup_ok">확인</button> 
           </div><!--jobcompany_popup_btns-->
       </div><!--jobcompany_popup-->  
   </div>
    
    
