<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
  
<script type='text/javascript'>

	var jobList = new Array();
	var futureRoad1 = "";
	var futureRoad2 = "";
	var futureRoad3 = "";
	var futureRoadChoiceNo = "";
	
	$(document).ready(function() {
	});

	function registration() {
        var formData = new FormData();

		var chkVal = ["selector_category", "kor_name", "eng_name", "enforcement_agency", "summary", "performance_job"];
		for (var i = 0; i < chkVal.length; i++) 
		{
			if ($("#" + chkVal[i]).val() == "" ) {
				alert($("#" + chkVal[i]).attr("title") + "은(는) 필수입력입니다.");
				$("#" + chkVal[i]).focus();
				return false;
			}
		}

		formData.append("field", $("#selector_category").val());
		formData.append("kor_name", $("#kor_name").val());
		formData.append("eng_name", $("#eng_name").val());
		formData.append("ministry", $("#ministry").val());
		formData.append("enforcement_agency", $("#enforcement_agency").val());
		formData.append("summary", $("#summary").val());
		formData.append("change_process", $("#change_process").val());
		formData.append("performance_job", $("#performance_job").val());
		formData.append("prospect", $("#prospect").val());

		if (confirm('등록 하시겠습니까?')) {
			$.ajax({
			    type : "POST",
			    url : "/admin/api/notification/license/registration",
			    data : formData,
			    processData: false,
			    contentType: false,
			    mimeType: 'multipart/form-data',
			    success : function(data) {
			    	var jsonData = JSON.parse(data);
			        if (jsonData.result == 1) {
			            alert("등록 되었습니다.");
			            location.href = "/admin/rdt/notification/license/searchList";
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

</script>
  
<!--페이지 루트-->
<div class="page-nation container">
    <a href="./html/index.html"><i class="nav-icon fa fa-home mr5"></i>홈화면</a><span class="route_icon"></span>
    <a href="./html/industry-trend.html">알림/정보</a><span class="route_icon"></span>
    <a href="./html/industry-trend.html">교육기관&middot;훈련과정</a><span class="route_icon"></span>
    <a href="javascript:void(0);">자격증</a>
</div>

<!--본문시작-->
<div class="sub-container container">
	<div class="sub-content">
<!--페이지 타이틀-->				
		<div class="page-header">
			<h3 class="page-title text-primary-d2 text-120">
			교육기관&middot;훈련과정 - 자격증
			</h3>
		</div>
		<!--view-->				
		<div class="sub-content-box bgc-white"> 
           <!--분야-->            
           <table class="job_write">
                <caption>분야</caption>                       
                       <tr>							
                           <th class="w20 jop_write_table_title"><span class=" necessary_icon">*</span>분야</th>
                           <td class="w80">
                        		<select class="jop_write_table_txt ace-select w60" id="selector_category" title="분야 선택">	
                               	<option value="">분류 선택</option>
                        		<c:forEach items="${commonCode}" var="code">
									<c:if test="${code.master_id == 'M000007'}">
										<option value="${code.detail_id}"><c:out value="${code.name}"></c:out></option>
									</c:if>
								</c:forEach>
                                </select>
                           </td>												
                       </tr>
            </table>
              <!--자격증-->
            <table class="job_write">
                <caption>자격증</caption>
                <tr>
                    <th class="w20 jop_write_table_title"><span class=" necessary_icon">*</span>자격증명</th>
                    <td class="w90">
                        <input type="text" class="form-control brc-on-focusd-inline-block w90" id="kor_name" title="자격증명"/>
                    </td>
                </tr>
            </table>
            <!--영문명-->
            <table class="job_write">
                <caption>영문명</caption>
                <tr>
                    <th class="w20 jop_write_table_title"><span class=" necessary_icon">*</span>영문명</th>
                    <td class="w90">
                        <input type="text" class="form-control brc-on-focusd-inline-block w90" id="eng_name" title="영문명"/>
                    </td>
                </tr>
            </table>
            <!--관련부처-->
            <table class="job_write">
                <caption>관련부처</caption>
                <tr>
                    <th class="w20 jop_write_table_title">관련부처</th>
                     <td class="w90">
                        <input type="text" class="form-control brc-on-focusd-inline-block w90" id="ministry" title="관련부처"/>
                    </td>
                </tr>					
            </table>
            <!--시행기관--> 
            <table class="job_write">
                <caption>시행기관</caption>
                <tr>
                    <th class="w20 jop_write_table_title"><span class=" necessary_icon">*</span>시행기관</th>
                     <td class="w90">
                        <input type="text" class="form-control brc-on-focusd-inline-block w90" id="enforcement_agency" title="시행기관"/>
                    </td>
                </tr>					
            </table>
             <!--기본정보--> 
            <table class="job_write">
                <caption>기본정보</caption>
                <tr>
                    <th rowspan="4" class="w20 jop_write_table_title"><span class="necessary_icon">*</span>기본정보</th>
                    <td class="w13 txt_r">
                        <label class="jop_write_table_lable">
                            <span class="icon_box"><span class=" necessary_icon">*</span>개요</span>
                        </label>    
                    </td>
                    <td class="w87">
                         <textarea class="form-control w88" id="summary" title="개요"></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="w13 txt_r">
                        <label class="jop_write_table_lable">
                            <span class="icon_box">변천과정</span>
                        </label>    
                    </td>
                    <td class="w87">
                         <input type="text" class="form-control brc-on-focusd-inline-block w88" id="change_process" title="변천과정"/>
                    </td>
                </tr>
                <tr>
                    <td class="w13 txt_r">
                        <label class="jop_write_table_lable">
                            <span class="icon_box"><span class="necessary_icon">*</span>수행직무</span>
                        </label>    
                    </td>
                    <td class="w87">
                         <textarea class="form-control w88" id="performance_job" title="수행직무"></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="w13 txt_r">
                        <label class="jop_write_table_lable">
                            <span class="icon_box">진로 및 전망</span>
                        </label>    
                    </td>
                    <td class="w87">
                         <textarea class="form-control w88" id="prospect" title="진로 및 전망"></textarea>
                    </td>
                </tr>					
            </table>
            <p><span class=" necessary_icon">*</span> 표시된 항목은 필수 입력 항목입니다.</p>
            <div class="industry-trend-view_btns">
                <a href="javascript:registration();" class="blue_btn ok_back_btn btn">등록</a>
                <div class="fr">
                    <a href="/admin/rdt/notification/licenseList" class="gray_btn list_back_btn btn">목록</a>
                </div>
            </div>
        </div>
    </div>
</div>
