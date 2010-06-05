{include file='header.tpl'}

<link rel="stylesheet" type="text/css" href="{$sTemplateWebPathPlugin}css/style.css" media="all" />


<div class="topic">
	<h2>{$aLang.page_admin}</h2>
	
	
	{if $aParams.0=='new'}
		<h3>{$aLang.page_create}</h3>
		{include file="$sTemplatePathPlugin/actions/ActionPage/add.tpl"}
	{elseif $aParams.0=='edit'}
		<h3>{$aLang.page_edit} «{$oPageEdit->getTitle()}»</h3>
		{include file="$sTemplatePathPlugin/actions/ActionPage/add.tpl"}
	{else}
		<a href="{router page='page'}admin/new/" class="page-new">{$aLang.page_new}</a><br /><br />
	{/if}


	<table cellspacing="0" class="table">
		<thead>
			<tr>
				<td>{$aLang.page_admin_title}</td>
				<td align="center" width="250px">{$aLang.page_admin_url}</td>    	
				<td align="center" width="50px">{$aLang.page_admin_active}</td>    	   	
				<td align="center" width="80px">{$aLang.page_admin_action}</td>    	   	
			</tr>
		</thead>
		
		<tbody>
			{foreach from=$aPages item=oPage name=el2} 	
				<tr>
					<td>
						<img src="{$sTemplateWebPathPlugin}images/{if $oPage->getLevel()==0}folder{else}document{/if}.gif" alt="" title="" border="0" style="margin-left: {$oPage->getLevel()*20}px;"/>
						<a href="{router page='page'}{$oPage->getUrlFull()}/">{$oPage->getTitle()}</a>
					</td>
					<td>
						/{$oPage->getUrlFull()}/
					</td>   
					<td align="center">
						{if $oPage->getActive()}
							{$aLang.page_admin_active_yes}
						{else}
							{$aLang.page_admin_active_no}
						{/if}
					</td>
					<td align="center">  
						<a href="{router page='page'}admin/edit/{$oPage->getId()}/"><img src="{cfg name='path.static.skin'}/images/edit.png" alt="{$aLang.page_admin_action_edit}" title="{$aLang.page_admin_action_edit}" /></a>      	
						<a href="{router page='page'}admin/delete/{$oPage->getId()}/?security_ls_key={$LIVESTREET_SECURITY_KEY}" onclick="return confirm('«{$oPage->getTitle()}»: {$aLang.page_admin_action_delete_confirm}');"><img src="{cfg name='path.static.skin'}/images/delete.png" alt="{$aLang.page_admin_action_delete}" title="{$aLang.page_admin_action_delete}" /></a>        	    
					</td>   
				</tr>
			{/foreach}
		</tbody>
	</table>
</div>


{include file='footer.tpl'}