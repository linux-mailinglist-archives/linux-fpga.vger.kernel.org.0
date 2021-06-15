Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A133A85EF
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Jun 2021 18:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhFOQDm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Jun 2021 12:03:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:38417 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231975AbhFOQDg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 15 Jun 2021 12:03:36 -0400
IronPort-SDR: 14K62RWE4530L3/7DxuaLL3yhQTYJhrhBeaOVY+xMUMw4xW0mmOagxEZo+CXU6iRhcrxROwP9x
 PlOYkDXiFLUA==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="206055214"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="206055214"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 09:01:20 -0700
IronPort-SDR: VgKPCRNajtVRzfHCV0Nob0lFT2CCHRYAJSaNnmNf+jsParAgaLf2hxNSs1J+g/dHBW/y5mh8DO
 2FAHbovAFzgg==
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="404268324"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.251.21.166])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 09:01:18 -0700
Subject: Re: [PATCH 6/8] fpga: mgr: Use standard dev_release for class driver
To:     Greg KH <gregkh@linuxfoundation.org>,
        Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>
References: <20210614170909.232415-1-mdf@kernel.org>
 <20210614170909.232415-7-mdf@kernel.org> <YMhV8XGJ6fxXi9Eh@kroah.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <263efef2-8e75-2c6c-f6ac-9cfb73b9dc86@intel.com>
Date:   Tue, 15 Jun 2021 09:00:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMhV8XGJ6fxXi9Eh@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 6/15/21 12:25 AM, Greg KH wrote:
> On Mon, Jun 14, 2021 at 10:09:07AM -0700, Moritz Fischer wrote:
>> From: Russ Weight <russell.h.weight@intel.com>
>>
>> The FPGA manager class driver data structure is being treated as a
>> managed resource instead of using the class.dev_release call-back
>> function to release the class data structure. This change populates
>> the class.dev_release function, changes the fpga_mgr_free() function
>> to call put_device() and changes the fpga_mgr_unregister() function
>> to call device_del() instead of device_unregister().
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
>> Signed-off-by: Moritz Fischer <mdf@kernel.org>
>> ---
>>  drivers/fpga/fpga-mgr.c | 35 +++++++++++++++--------------------
>>  1 file changed, 15 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
>> index 42ddc0844781..9f6c3760b6ff 100644
>> --- a/drivers/fpga/fpga-mgr.c
>> +++ b/drivers/fpga/fpga-mgr.c
>> @@ -585,8 +585,10 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
>>  		return NULL;
>>  
>>  	id = ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
>> -	if (id < 0)
>> -		goto error_kfree;
>> +	if (id < 0) {
>> +		kfree(mgr);
>> +		return NULL;
>> +	}
>>  
>>  	mutex_init(&mgr->ref_mutex);
>>  
>> @@ -602,17 +604,12 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
>>  	mgr->dev.id = id;
>>  
>>  	ret = dev_set_name(&mgr->dev, "fpga%d", id);
>> -	if (ret)
>> -		goto error_device;
>> +	if (ret) {
>> +		put_device(&mgr->dev);
>> +		return NULL;
>> +	}
>>  
>>  	return mgr;
>> -
>> -error_device:
>> -	ida_simple_remove(&fpga_mgr_ida, id);
>> -error_kfree:
>> -	kfree(mgr);
>> -
>> -	return NULL;
>>  }
>>  EXPORT_SYMBOL_GPL(fpga_mgr_create);
>>  
>> @@ -622,8 +619,7 @@ EXPORT_SYMBOL_GPL(fpga_mgr_create);
>>   */
>>  void fpga_mgr_free(struct fpga_manager *mgr)
>>  {
>> -	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
>> -	kfree(mgr);
>> +	put_device(&mgr->dev);
>>  }
>>  EXPORT_SYMBOL_GPL(fpga_mgr_free);
>>  
>> @@ -692,16 +688,11 @@ int fpga_mgr_register(struct fpga_manager *mgr)
>>  
>>  	ret = device_add(&mgr->dev);
>>  	if (ret)
>> -		goto error_device;
>> +		return ret;
> If this fails, are you sure you want to just return the error number?
>
> You can not call device_del() afterward if this fails, you have to call
> put_device().  See the documentation for device_add() for details.
>
> This is messy as you are doing a "two step" initialization of your
> fpga_manager device for some odd reason.  Why do you need to do that?
>
> When you call this you seem to be forced to do:
> 	fpga_mgr_create()
> 	fpga_mgr_register()
> in each individual driver.
>
> Why force drivers to do this and not just do a simple:
> 	fpga_mgr_register()
> that internally does the create/add process?
>
> Why the two steps?  That's normally reserved for when you need to do
> something complex in the "core" for the subsystem, and shouldn't be
> pushed out to each individual driver like it currently is for the fpga
> core as you will run into the problem you have here.
>
> Namely when you want to clean up from a failure, you don't know if you
> really did register that device properly or not.

I started on this patchset by moving to a single fpga_mgr_register call. There were some subtle issues that made it more complex, and it was suggested that there was value in simplifying the fix and maintaining the current API.

Based on your comments, I'll go back resume my original fix, address the remaining issues, and go back through the review process.

Thanks,
- Russ

>
> And no, don't add another flag, just make this simple and hard to get
> wrong.  As it is it feels like each fpga driver has to do extra work to
> be sure to get this all correct each time.
>
> So I can not take this as-is, sorry.
>
> And sorry I never noticed these problems when the code when in
> originally.
>
> thanks,
>
> greg k-h

