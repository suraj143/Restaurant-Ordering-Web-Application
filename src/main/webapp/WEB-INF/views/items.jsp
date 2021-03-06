<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"> -->
	
	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
	<script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.2.26/angular.min.js"></script>
	<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.0-beta.1/angular-sanitize.js"></script>
	
<link rel="stylesheet" type="text/css" href="../resources/style.css">

<!-- <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
	<script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
<script src="../resources/js/angular.min.js"></script> -->
<script type="text/javascript" src="../resources/js/items.js"></script>

<title>Fulfillment Management</title>
</head>
<body ng-app="itemApp" ng-controller="itemController" ng-init='items=${items}; categories=${categories}; initToken("${_csrf.parameterName}","${_csrf.token}");'
	style="padding-top: 80px;">
	
	
	<header>
	<div class="navbar navbar-default navbar-fixed-top"
			style="background: rgba(200, 54, 54, 0.7);">
			<div class="container" style="background: rgba(255, 255, 255, 0.9);">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target="#navbar-ex-collapse">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
					<a class="navbar-brand"><span>Food Delivery Service</span></a>
				</div>
				<div class="collapse navbar-collapse" id="navbar-ex-collapse">
					<ul class="nav navbar-nav navbar-right">
						<li class="active"><a href="<c:url value="/admin/" />">Home</a></li>
						<li><a href="<c:url value="/logout" />">Logout</a></li>
					</ul>
				</div>
			</div>
		</div>
		
	</header>
	
	<div class="container">
	<ul class="nav nav-tabs nav-justified dropup" style="margin-bottom: 10px"> 
   		<li><a href="" data-toggle="modal" data-target="#addItemModal" style="background-color:rgba(200, 54, 54, 0.7);color:white; font-weight: bold; margin:5px;">Add Item</a></li>
   		
   		<li><a href="<c:url value="/admin/orderReportPage"/>" style="background-color:rgba(200, 54, 54, 0.7);color:white; font-weight:bold; margin:5px;">Order Report</a></li>
   		
   		<li><a href="<c:url value="/admin/popularityReportPage"/>" style="background-color:rgba(200, 54, 54, 0.7);color:white; font-weight:bold; margin:5px;">Popularity Report</a></li>
   		
   		<li><a href="" ng-click="resetOrder()" style="background-color:rgba(200, 54, 54, 0.7);color:white; font-weight:bold;">Reset Order</a></li>
   		
   	</ul>  
	<!-- <input type="button" class="btn btn-success btn-sm pull-right" ng-click="resetOrder()" value="Reset Orders"> -->
	
	<!-- <input type="button" class="btn btn-success btn-sm pull-right" data-toggle="modal" data-target="#addItemModal" value="Add Item"> -->
		<table class="table">
			<tr>
				<th>Item Name</th>
				<th>Category</th>
				<th>Unit Price</th>
				<th>Preparation Time</th>
				<th>Calories</th>
				<th>Image</th>
				<th colspan="2"></th>
			</tr>
	        <tr ng-repeat="item in items">
	        	<td>{{item.itemName}}</td>
	        	<td>{{item.category}}</td>
	        	<td>$ {{item.unitPrice}}</td>
	        	<td>{{item.preparationTime}} minutes</td>
	        	<td>{{item.calories}}</td>
	        	<td>
	        		<img alt="{{item.itemName}}" ng-src="../images/{{item.id}}" style="width:128px;height:128px;">	        		
	        	</td>
	        	<td>
	        		<input ng-show="item.status"  type="button" class="btn btn-sm btn-block" value="Edit" ng-click="editClicked(item)" data-toggle="modal" data-target="#addItemModal" >
	        		<input ng-show="!item.status" disabled type="button" class="btn btn-sm btn-block" value="Deleted">
	        	</td>
	        	<td>
	        		<input ng-show="item.status" type="button" class="btn btn-sm btn-block" value="Delete" ng-click="deleteItem(item)" >
	        		<input ng-show="!item.status" type="button" class="btn btn-sm btn-block" value="Enable" ng-click="enableItem(item)" >
	        	</td>
	        </tr>	       
	       </table>
	       
	       
	       <!-- Modal start -->
			<div class="modal fade" id="addItemModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header" style="background-color:#3B5998; color: white;">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color:white" ng-click="newItem=null;edit=false;picture=null;"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="myModalLabel"> {{edit?'Edit':'Add'}} Item</h4>
			      </div>
			      <form ng-submit="addItem(newItem)" class="form-group" >
			      <div class="modal-body">
			      <table class="table">
			      	<tr>
			      		<th>Name</th>
			      		<th><input required type="text" class="form-control" name="newItem.itemName" ng-model="newItem.itemName"></th>
			      	</tr>
			      	<tr>
			      		<th>Category</th>
			      		<th><select class="form-control" name="newItem.category" ng-model="newItem.category" required>
			      			<option selected="selected" disabled value="">Choose Category</option>
			            	<option ng-repeat="category in categories">{{category}}</option>
			            	</select>
			            </th>
			      	</tr>
			      	<tr>
			      		<th>Unit Price (in $)</th>
			      		<th><input required step="0.1" type="number" class="form-control" name="newItem.unitPrice" ng-model="newItem.unitPrice"></th>
			      	</tr>
			      	<tr>
			      		<th>Preparation Time (in minutes)</th>
			      		<th><input required type="number" class="form-control" name="newItem.preparationTime" ng-model="newItem.preparationTime"></th>
			      	</tr>
			      	<tr>
			      		<th>Calories</th>
			      		<th><input required type="number" class="form-control" name="newItem.calories" ng-model="newItem.calories"></th>
			      	</tr>
			      	<tr>
			      		<th>Image</th>
			      		<th><input  required type="file" class="form-control" name="picture" ng-model="picture" file-model="picture" ng-change="fileUploaded()" ></th>
			      	</tr>
			      </table>			      	        
			      </div>
			      <div class="modal-footer">
			        <input type="button" class="btn btn-sm btn-default pull-right" data-dismiss="modal" value="Cancel" ng-click="newItem=null;edit=false;picture=null;">
			        <button type="submit" class="btn btn-sm btn-default pull-right" style="background-color:#3B5998; border: 1; color: white; margin-right:10px" value="Add" >{{edit?'Edit':'Add'}}</button>
			      </div>
			      </form>
			    </div>
			  </div>
			</div>
	       <!-- Modal end -->
	     	   
	       
	      </div>
    </body>
</html>
