Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CB9383DC4
	for <lists+linux-fpga@lfdr.de>; Mon, 17 May 2021 21:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbhEQTvJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 17 May 2021 15:51:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:56066 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235119AbhEQTvJ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 17 May 2021 15:51:09 -0400
IronPort-SDR: SpKbIF2PCY9ANf5azBeN5VNmJXeGK1muCrF29hi/EYk6aaoYl9Ja4kUOWpbGBKE7EZy9CVIgg0
 qKn8ABOqdWnA==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="261784611"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="261784611"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 12:49:52 -0700
IronPort-SDR: UEXxa38AWwKH+SMzEkqxI7zTcchRHX3yUjNsciVd7afhq7il+mN4TwrtrFz/RYi+L84SQy/0er
 0FdvdC7QDisA==
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="543820505"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.212.243.163])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 12:49:51 -0700
Subject: Re: [PATCH 07/12] fpga: sec-mgr: expose hardware error info
To:     Greg KH <gregkh@linuxfoundation.org>,
        Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com,
        Tom Rix <trix@redhat.com>
References: <20210517023200.52707-1-mdf@kernel.org>
 <20210517023200.52707-8-mdf@kernel.org> <YKIWzleL3KxjOsQ/@kroah.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <028b540f-7677-fa33-a4f4-43ad31c27828@intel.com>
Date:   Mon, 17 May 2021 12:49:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YKIWzleL3KxjOsQ/@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 5/17/21 12:10 AM, Greg KH wrote:
> On Sun, May 16, 2021 at 07:31:55PM -0700, Moritz Fischer wrote:
>> From: Russ Weight <russell.h.weight@intel.com>
>>
>> Extend the FPGA Security Manager class driver to include
>> an optional update/hw_errinfo sysfs node that can be used
>> to retrieve 64 bits of device specific error information
>> following a secure update failure.
>>
>> The underlying driver must provide a get_hw_errinfo() callback
>> function to enable this feature. This data is treated as
>> opaque by the class driver. It is left to user-space software
>> or support personnel to interpret this data.
> No, you don't provide "opaque" data to userspace, that's a sure way to
> make it such that no one knows what this data is supposed to be, and so
> it can not be maintained at all.
My intent was that the data be opaque to the class driver layer, but not
to the parent driver or to the user-space code (which could process the
data based on the device type).

If this is not appropriate, it is an optional feature and can be removed.

>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> Reviewed-by: Tom Rix <trix@redhat.com>
>> Signed-off-by: Moritz Fischer <mdf@kernel.org>
>> ---
>>  .../ABI/testing/sysfs-class-fpga-sec-mgr      | 14 +++++++
>>  drivers/fpga/fpga-sec-mgr.c                   | 38 +++++++++++++++++++
>>  include/linux/fpga/fpga-sec-mgr.h             |  5 +++
>>  3 files changed, 57 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
>> index 749f2d4c78d3..f1881ce39c63 100644
>> --- a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
>> +++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
>> @@ -65,3 +65,17 @@ Description:	Read-only. Returns a string describing the failure
>>  		idle state. If this file is read while a secure
>>  		update is in progress, then the read will fail with
>>  		EBUSY.
>> +
>> +What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/hw_errinfo
>> +Date:		June 2021
>> +KernelVersion:	5.14
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	Read-only. Returns a 64 bit error value providing
>> +		hardware specific information that may be useful in
>> +		debugging errors that occur during FPGA image updates.
>> +		This file is only visible if the underlying device
>> +		supports it. The hw_errinfo value is only accessible
>> +		when the secure update engine is in the idle state.
>> +		If this file is read while a secure update is in
>> +		progress, then the read will fail with EBUSY.
>> +		Format: "0x%llx".
>> diff --git a/drivers/fpga/fpga-sec-mgr.c b/drivers/fpga/fpga-sec-mgr.c
>> index 48950843c2b4..cefe9182c3c3 100644
>> --- a/drivers/fpga/fpga-sec-mgr.c
>> +++ b/drivers/fpga/fpga-sec-mgr.c
>> @@ -36,10 +36,17 @@ static void fpga_sec_set_error(struct fpga_sec_mgr *smgr, enum fpga_sec_err err_
>>  	smgr->err_code = err_code;
>>  }
>>  
>> +static void fpga_sec_set_hw_errinfo(struct fpga_sec_mgr *smgr)
>> +{
>> +	if (smgr->sops->get_hw_errinfo)
>> +		smgr->hw_errinfo = smgr->sops->get_hw_errinfo(smgr);
>> +}
>> +
>>  static void fpga_sec_dev_error(struct fpga_sec_mgr *smgr,
>>  			       enum fpga_sec_err err_code)
>>  {
>>  	fpga_sec_set_error(smgr, err_code);
>> +	fpga_sec_set_hw_errinfo(smgr);
>>  	smgr->sops->cancel(smgr);
>>  }
>>  
>> @@ -221,6 +228,23 @@ error_show(struct device *dev, struct device_attribute *attr, char *buf)
>>  }
>>  static DEVICE_ATTR_RO(error);
>>  
>> +static ssize_t
>> +hw_errinfo_show(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
>> +	int ret;
>> +
>> +	mutex_lock(&smgr->lock);
>> +	if (smgr->progress != FPGA_SEC_PROG_IDLE)
>> +		ret = -EBUSY;
> Why does the state matter here?
The transfer and validation of image data can take up to 40 minutes for the N3000
acceleration card, so the transfer of data and the monitoring of the update are
happening in a worker thread. The hw_errinfo data is only valid when the update
engine is in the IDLE state. Returning EBUSY if the update is still in progress
simplifies the locking model.

- Russ

>
> greg k-h

