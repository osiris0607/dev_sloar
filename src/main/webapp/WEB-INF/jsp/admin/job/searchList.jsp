<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
  
<script type='text/javascript'>
	$(document).ready(function() {
		var body = $("#listBody");
		body.empty();
		
		// 검색
		$("#search_btn").click(function() {
			searchList(1);
		});
		
		// 생태계 분류 Click
	 	$("#selector_category").change(function(){
		    categoryId =  $(this).val();
		    categoryChange(categoryId);
		});

		selectorInit();
		ocurrpationInit();
		searchList(1);
	});


	function downloadExcelFile() {
		if (confirm('일자리 정보를 다운로드합니다. 일자리 수가 많으면 다소 시간이 걸릴 수도 있습니다. 다운로드하시겠습니까?')) {
			var queryString = "?category_id=" + $("#selector_category option:selected").val() + 
								 "&category_detail_id=" + $("#selector_category_detail option:selected").val() +
								 "&occupation=" + $("#selector_ocurrpation option:selected").val() +
								 "&major=" + $("#selector_major option:selected").val() +
								 "&education=" + $("#selector_education option:selected").val() +
								 "&difficulty=" + $("#selector_difficulty option:selected").val();
			location.href = "/admin/api/job/excelDownload" + queryString;
		}
	}

	function downloadExcelCB(data) {
	}

	function searchList(pageNo) {
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/admin/api/job/search/paging' />");
		comAjax.setCallback("searchListCB");
		comAjax.addParam("pageIndex", pageNo);
		comAjax.addParam("orderby", "JOB_ID DESC");

		comAjax.addParam("category_id", $("#selector_category option:selected").val());
		comAjax.addParam("category_detail_id", $("#selector_category_detail option:selected").val());
		comAjax.addParam("occupation", $("#selector_ocurrpation option:selected").val());
		comAjax.addParam("major", $("#selector_major option:selected").val());
		comAjax.addParam("education", $("#selector_education option:selected").val());
		comAjax.addParam("difficulty", $("#selector_difficulty option:selected").val());
		
		comAjax.ajax();
	}


	function searchListCB(data) {
		console.log(data);
		var total = data.totalCount;
		var body = $("#listBody");
		body.empty();
		if (total == 0) {
			var str = "<tr>" + "<td colspan='10'>조회된 결과가 없습니다.</td>" + "</tr>";
			$("#search_count").text("0");
			body.append(str);
		} else {
			var params = {
				divId : "pageNavi",
				pageIndex : "pageIndex",
				totalCount : total,
				eventName : "searchList"
			};

			gfnRenderPaging(params);

			$("#search_count").text(total);
			var index = 1;
			var str = "";
			$.each(data.result, function(key, value) {
				//console.log("value:"+ value);
				str += "<tr>";
				str += "	<td>" + index + "</td>";
				str += "	<td><span>" + value.category_id + "</span>" + value.category_name + "</td>";
				str += "	<td><span>" + value.category_detail_id + "</span>" + value.category_detail_name + "</td>";
				str += "	<td>" + value.occupation_name + "</td>";
				str += "	<td><a href='/admin/rdt/job/detail?job_id=" + value.job_id + "'>" + value.name + "</a></td>";
				str += "	<td>"+ value.education_name +"</td>";
				str += "	<td>"+ value.difficulty_name +"</td>";
				str += "	<td>"+ value.company_1_name +"</td>";
				str += "	<td>"+ value.company_2_name +"</td>";
				str += "	<td>"+ value.company_3_name +"</td>";
				str += "</tr>";

				index++;
			});
			body.append(str);
		}
	}
	

	function ocurrpationInit() {
		str = "";
		var ocurrpation = $("#selector_ocurrpation"); 
		ocurrpation.empty();
		str += '<option value="">직종 선택</option>';
		<c:forEach items="${commonCode}" var="code">
			<c:if test="${code.master_id == 'M000004'}">
				str += '<option value="${code.detail_id}"><c:out value="${code.name}"></c:out></option>';
			</c:if>
		</c:forEach>
		ocurrpation.append(str); 
	}

	function categoryChange(categoryId) {
		if (categoryId != ""){
			// 생테게 세부 분류 Select 생성	
	 		str = "";
			var categoryDetail = $("#selector_category_detail"); 
			categoryDetail.empty();
			str += '<option value="">생태계 분류 전체</option>';
			<c:forEach items="${commonCode}" var="code">
				<c:if test="${code.master_id == 'M000003'}">
					if (categoryId == "${fn:escapeXml(code.parent_id)}") {
						str += '<option value="${code.detail_id}"><c:out value="${code.name}"></c:out></option>';
					}
				</c:if>
			</c:forEach>
			categoryDetail.append(str); 
		} 
		else {
	 		var str = "";
			var category = $("#selector_category"); 
			category.empty();
			str += '<option value="">생태계 분류 선택</option>';
			<c:forEach items="${commonCode}" var="code">
				<c:if test="${code.master_id == 'M000002'}">
					str += '<option value="${code.detail_id}"><c:out value="${code.name}"></c:out></option>';
				</c:if>
			</c:forEach>	
			category.append(str);
			
	 		str = "";
			var categoryDetail = $("#selector_category_detail"); 
			categoryDetail.empty();
			str += '<option value="">생태계 세부분류 선택</option>';
			categoryDetail.append(str);
		}
	}

	function selectorInit() {
 		var str = "";
		var category = $("#selector_category"); 
		category.empty();
		str += '<option value="">생태계 분류 선택</option>';
		<c:forEach items="${commonCode}" var="code">
			<c:if test="${code.master_id == 'M000002'}">
				str += '<option value="${code.detail_id}">${code.name}</option>';
			</c:if>
		</c:forEach>	
		category.append(str);
		
 		str = "";
		var categoryDetail = $("#selector_category_detail"); 
		categoryDetail.empty();
		str += '<option value="">생태계 세부분류 선택</option>';
		categoryDetail.append(str); 
		
		str = "";
		var major = $("#selector_major"); 
		major.empty();
		str += '<option value="">전공 전체</option>';
		<c:forEach items="${commonCode}" var="code">
			<c:if test="${code.master_id == 'M000006'}">
				str += '<option value="${code.detail_id}">${code.name}</option>';
			</c:if>
		</c:forEach>
		major.append(str); 

		str = "";
		var education = $("#selector_education"); 
		education.empty();
		str += '<option value="">학력 전체</option>';
		<c:forEach items="${commonCode}" var="code">
			<c:if test="${code.master_id == 'M000005'}">
				str += '<option value="${code.detail_id}">${code.name}</option>';
			</c:if>
		</c:forEach>
		education.append(str);

		str = "";
		var dificulty = $("#selector_difficulty"); 
		dificulty.empty();
		str += '<option value="">난이도 전체</option>';
		<c:forEach items="${commonCode}" var="code">
			<c:if test="${code.master_id == 'M000012'}">
				str += '<option value="${code.detail_id}">${code.name}</option>';
			</c:if>
		</c:forEach>
		dificulty.append(str);
	}
</script>
  
  
<div class="page-nation container">
	<a  href="./html/index.html"><i class="nav-icon fa fa-home mr5"></i>홈화면</a>
	<span class="route_icon"></span><a href="./html/job-list-search.html">일자리</a>
	<span class="route_icon"></span><a href="./html/job-list-search.html">일자리 검색</a>
</div>
<!--본문시작-->
<div class="sub-container container">
	<div class="sub-content">
<!--페이지 타이틀-->				
		<div class="page-header">
			<h3 class="page-title text-primary-d2 text-120">
			일자리 검색
			</h3>
		</div>
<!--리스트 검색 상단-->				
		<div class="sub-content-box bgc-white">
                  <div class="bgc-secondary-l4 clearfix">
                      <ul>
                          <li>
                              <div class="form-group row">                       
                                  <div class="col-sm-1 col-form-label text-sm-right pr-0">
                             	  	<label class="mb-0">생태계</label>
                                  </div>
                                  <div class="col-sm-9">
                                      <select class="area_write_table_txt w31 ace-select" id="selector_category">
                                      </select>
                                      <select class="area_write_table_txt w31 ace-select" id="selector_category_detail">
                                      </select>
                                      <select class="ace-select w31 ace-select" id="selector_ocurrpation">
                                      </select>
                                  </div>
                              </div>                                
                          </li>
                          <li>
                             <div class="form-group row">
                                 <div class="col-sm-1 col-form-label text-sm-right pr-0">
                                 <label class="mb-0">직무</label>
                                 </div> 
                                 <div class="col-sm-9">
                                    <select class="ace-select w31" id="selector_major">
                                    </select>
                                    <select class="ace-select w31" id="selector_education">
                                    </select>
                                    <select class="ace-select w31" id="selector_difficulty">
                                    </select>
                                </div>         
                             </div>                                
                          </li>
                      </ul>
                      <div class="clearfix list_top_btn_box" style="float: right">
                          <button class="grean_btn fl" id="excel_download" onclick='downloadExcelFile();'>엑셀 다운로드</button>
                          <button class="blue_btn2 fl ml5" id="search_btn">검색</button>
                      </div>
                  </div> 
                  <!--리스트 상단 검색결과-->                
                  <div class="list_search_end_box clearfix">
                      <h4 class="fl">검색결과</h4>
                      <span class="list_search_results fl ml10" id="search_count">0</span><em class="fl">개</em>
                      <!-- <a href="./html/job-registration.html" class="blue_btn button fr ml10" >일자리 등록</a> -->
                      
                      
                      <!--리스트 상단 검색결과 테이블-->    
                     <table class="table table-striped-primary table-borderless text-dark-m1 mb-0" id="responsive-table">
                         <thead>
                             <tr class="bgc-primary-d2 text-white text-sm-center">
                                <th>순번</th>
                                <th>생태계 분류</th>
                                <th>생태계 세부분류</th>
                                <th>직종분류</th>
                                <th>일자리명</th>
                                <th>요구학력</th>
                                <th>직무 난이도</th>
                                <th>해당기업1</th>
                                <th>해당기업2</th>
                                <th>해당기업3</th>
                             </tr>
                        </thead>
                        <tbody class="bgc-primary-d2 text-sm-center" id="listBody">
                        </tbody>
                     </table> 

					<div class="Page_navigation">
						<div id="pageNavi"></div>
						<input type="hidden" id="pageIndex" name="pageIndex"/>
					</div>
					
						
										
                  </div>
              </div>
              
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
            
            <!--체크 미리보기
            <input type="text" id="certificate_result2" class="certificate_result2" style="border: 1px solid #000; width:100%; height:50px">-->
                
    
            <div class="certificate_popup_btns">
                <button class="blue_btn certificate_popup_close" id="certificate_popup_close" onclick='getCheckboxValue()'>확인</button> 
                
            </div><!--specialism_popup_btns-->
        </div><!--specialism_popup_contents-->  
    </div>         
 



