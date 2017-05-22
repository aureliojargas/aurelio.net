var currentTag="eu";
var linkFgColor="#07f";
var linkBgColor="#fff";
var tagTitles={};
var allLinks=[];
var linksLoaded=false;
function sortLinkArray(a,b){
a=a[1].toLowerCase();
b=b[1].toLowerCase();
try{
if(a<b){
return -1;
}else{
if(a>b){
return 1;
}
}
}
catch(e){
}
return 0;
}
if(!Array.prototype.push){
Array.prototype.push=function(_3){
this[this.length]=_3;
return this.length;
};
}
if(!Array.indexOf){
Array.prototype.indexOf=function(_4,_5){
for(var i=(_5||0);i<this.length;i++){
if(this[i]==_4){
return i;
}
}
return -1;
};
}
function getActiveTags(){
var _7=getAllMenuTags();
var _8=new Array();
for(var i=0;i<_7.length;i++){
var _a=_7[i];
if(_a.className=="on"){
_8.push(_a.innerHTML);
}
}
return _8;
}
function showorNot(_b,_c){
var _d=" "+_b.className+" ";
if(_c.length==0){
return false;
}
for(var i=0;i<_c.length;i++){
if(_d.indexOf(" "+_c[i]+" ")==-1){
return false;
}
}
return true;
}
function getAllMenuTags(){
return document.getElementById("menutags").getElementsByTagName("a");
}
function getAllMenuLinks(){
return document.getElementById("menulinks").getElementsByTagName("a");
}
function singleTag(_f){
var _10=getAllMenuTags();
for(var i=0;i<_10.length;i++){
_10[i].className="off";
}
_f.className="on";
var _12=[_f.innerHTML];
var _13=getAllMenuLinks();
for(var i=0;i<_13.length;i++){
_13[i].style.display=(showorNot(_13[i],_12))?"block":"none";
}
}
function clicked(){
clickedTag=this.innerHTML;
var _14=document.getElementById("menulinks");
if(currentTag==clickedTag){
if(_14.style.display=="none"){
_14.style.display="block";
this.className="on";
}else{
_14.style.display="none";
this.className="off";
}
}else{
_14.style.display="block";
if(!linksLoaded){
createLinkCloud();
linksLoaded=true;
}
singleTag(this);
}
currentTag=clickedTag;
return false;
}
function createLinkCloud(){
var _15=document.getElementById("menulinks");
allLinks.sort(sortLinkArray);
for(var i=0;i<allLinks.length;i++){
var el=document.createElement("a");
el.href=allLinks[i][2];
el.className=allLinks[i][3];
el.appendChild(document.createTextNode(allLinks[i][1]));
_15.appendChild(el);
_15.appendChild(document.createTextNode("\n"));
}
}
function init(){
var _18=new Array();
var _19=new Object();
for(var i=0;i<allLinks.length;i++){
var _1b=allLinks[i][3].split(" ");
for(var j=0;j<_1b.length;j++){
var _1d=_1b[j];
if(_19[_1d]){
_19[_1d]+=1;
}else{
_19[_1d]=1;
_18.push(_1d);
}
}
}
_18.sort();
var _1e=document.getElementById("menutags");
for(var i=0;i<_18.length;i++){
el=document.createElement("span");
el.className="menutagcount";
el.appendChild(document.createTextNode(_19[_18[i]]+"."));
_1e.appendChild(el);
var el=document.createElement("a");
el.href="#";
el.appendChild(document.createTextNode(_18[i]));
el.onclick=clicked;
el.title=tagTitles[_18[i]]||"";
currentTag="";
_1e.appendChild(el);
_1e.appendChild(document.createTextNode("\n"));
}
}
window.onload=init;

