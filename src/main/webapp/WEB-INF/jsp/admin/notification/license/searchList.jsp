<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

  
<script type='text/javascript'>

	var jobList = new Array();
	var futureRoad1 = "";
	var futureRoad2 = "";
	var futureRoad3 = "";
	var futureRoadChoiceNo = "";
	
	$(document).ready(function() {
		$("#search_txt").on("keydown", function(key) {
            //키의 코드가 13번일 경우 (13번은 엔터키)
            if (key.keyCode == 13) {
            	searchList(1);
            }
        });

		// 생태계 분류 Click
	 	$("#selector_category").change(function(){
	 		searchList(1);
		});
		
		searchList(1);
	});

	function searchList(pageNo) {
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/admin/api/notification/license/search/paging' />");
		comAjax.setCallback("searchListCB");
		comAjax.addParam("pageIndex", pageNo);
		comAjax.addParam("orderby", "FIELD ASC");

		comAjax.addParam("field", $("#selector_category option:selected").val());
		comAjax.addParam("name", $("#search_txt").val());
		comAjax.ajax();
	}


	function searchListCB(data) {
		console.log(data);
		var total = data.totalCount;
		var body = $("#list_body");
		body.empty();
		if (total == 0) {
			var str = "<tr>" + "<td'>조회된 결과가 없습니다.</td>" + "</tr>";
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
				str += "	<td>"+ value.field_name + "</td>";
				str += "	<td><a href='/admin/rdt/notification/license/detail?license_id=" + value.license_id + "'>" + value.kor_name + "</a></td>";
				str += "	<td>"+ value.enforcement_agency +"</td>";
				str += "</tr>";

				index++;
			});
			body.append(str);
		}
	}
	


</script>
  
<!--페이지 루트-->
<div class="page-nation container">
	<a href="./html/index.html"><i class="nav-icon fa fa-home mr5"></i>홈화면</a><span class="route_icon"></span>
	<a href="./html/industry-trend.html">알림/정보</a><span class="route_icon"></span>
	<a href="/admin/rdt/notification/license/searchList">교육기관&middot;훈련과정</a><span class="route_icon"></span>
	<a href="javascript:void(0);">자격증</a>
</div>

<!--본문시작-->
<div class="sub-container container">
	<div class="sub-content">
<!--페이지 타이틀-->				
		<div class="page-header">
			<h3 class="page-title text-primary-d2 text-120">교육기관&middot;훈련과정 - 자격증</h3>
		</div>
<!--리스트 검색 상단-->				
		<div class="sub-content-box bgc-white">
           <!--리스트 상단 검색결과-->                
           <div class="list_search_end_box clearfix">
               <h4 class="fl">전체</h4>
               <span class="list_search_results fl ml10" id="search_count">0</span><em class="fl mr10">건 </em>
<!--                <h4 class="fl">현재 페이지</h4>
               <span class="list_search_results fl ml5">1/100</span> -->
               <div class="fr education-center_table_top_seach">
					<select class="ace-select fl" id="selector_category" title="분야 선택">	
                      	<option value="">분류 선택</option>
                     	<c:forEach items="${commonCode}" var="code">
							<c:if test="${code.master_id == 'M000007'}">
								<option value="${code.detail_id}"><c:out value="${code.name}"></c:out></option>
							</c:if>
						</c:forEach>
                   </select>						
                   <input type="text" class="form-control brc-on-focusd-inline-block fl ml5" id="search_txt" value="" placeholder="검색어를 입력하세요" />    
                   <button class="blue_btn2 fl btn ml5" onclick="searchList(1)">검색</button>						
                   <a href="/admin/rdt/notification/license/registration" class="btn blue_btn fr">등록</a>
               </div>

           <!--리스트 상단 검색결과 테이블-->    
              <table class="table table-striped-primary table-borderless">
		           <colgroup>
		               <col style="width: 10%" />
		               <col style="width: 20%" />
		               <col style="width: 50%" />
		               <col style="width: 20%" />
		           </colgroup>
	              <thead>
	                  <tr class="bgc-primary-d2 text-white text-sm-center">
	                     <th>번호</th>
	                     <th>분야</th>
	                     <th>자격증명</th>
	                     <th>시행기관</th>
	                  </tr>
	             </thead>
	             <tbody class="bgc-primary-d2 text-sm-center" id="list_body">
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
