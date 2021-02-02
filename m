Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49C330CD41
	for <lists+linux-fpga@lfdr.de>; Tue,  2 Feb 2021 21:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbhBBUpp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 2 Feb 2021 15:45:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:36744 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233225AbhBBUpb (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 2 Feb 2021 15:45:31 -0500
IronPort-SDR: JAeP8lMf26O6JL3XbpG0AqYJsdGigZ+KzJZJqRYGypxRhHJgt+nms8RcEDkzLicWejOBCLIAp+
 IBxpn9/jGVgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="160693193"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="160693193"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 12:44:50 -0800
IronPort-SDR: zDoitENEs6Y/tdn2EunwMZssChy2S+zungt8lcYgBGANdY6utsij6fQ6aiGmkaOHGvdQLEErxf
 wuN7hI4v63hA==
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="396158499"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.209.22.86])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 12:44:50 -0800
Subject: Re: [PATCH v2 1/1] fpga: dfl: afu: harden port enable logic
To:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200917183219.3603-1-russell.h.weight@intel.com>
 <7f181203-c164-4e6e-c710-1096b0aa13b8@redhat.com>
 <20200917213850.GA30570@archbook>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <07189216-3662-4049-2bed-36fdbed9887e@intel.com>
Date:   Tue, 2 Feb 2021 12:44:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917213850.GA30570@archbook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 9/17/20 2:38 PM, Moritz Fischer wrote:
> On Thu, Sep 17, 2020 at 01:28:22PM -0700, Tom Rix wrote:
>> On 9/17/20 11:32 AM, Russ Weight wrote:
>>> Port enable is not complete until ACK = 0. Change
>>> __afu_port_enable() to guarantee that the enable process
>>> is complete by polling for ACK == 0.
>>>
>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> General note: Please keep a changelog if you send updated versions of a
> patch. This can be added here with an extra '---' + Text between Signed-off and
> diffstat:
>
> --- 
> Changes from v1:
> - FOo
> - Bar
Yes - I'll do that on future patch updates. In this case v2 just fixed a typo
in the commit message, so the patch was essentially the same as v1.
>>> ---
>>>  drivers/fpga/dfl-afu-error.c |  2 +-
>>>  drivers/fpga/dfl-afu-main.c  | 29 +++++++++++++++++++++--------
>>>  drivers/fpga/dfl-afu.h       |  2 +-
>>>  3 files changed, 23 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
>>> index c4691187cca9..0806532a3e9f 100644
>>> --- a/drivers/fpga/dfl-afu-error.c
>>> +++ b/drivers/fpga/dfl-afu-error.c
>>> @@ -103,7 +103,7 @@ static int afu_port_err_clear(struct device *dev, u64 err)
>>>  	__afu_port_err_mask(dev, false);
>>>  
>> There is an earlier bit that sets ret = -EINVAL.
>>
>> This error will be lost or not handled well.
>>
>> Right now it doesn't seem to be handled.
> Ultimately you'd want to report *at least* one of them, the current code
> seems to continue and enable the port either case. Is that what it
> should be doing? 
>
> Is the timeout more severe than the invalid value? Do you want to print
> a warning?
>
> Either way a comment explaining why this is ok would be appreciated :)
Yes - I'll add a comment explaining how the errors arebeing prioritized.
I'll give priority to the timeout, asit is likely a HW failure.

>>>  	/* Enable the Port by clear the reset */
>>> -	__afu_port_enable(pdev);
>>> +	ret = __afu_port_enable(pdev);
>>>  
>>>  done:
>>>  	mutex_unlock(&pdata->lock);
>>> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
>>> index 753cda4b2568..f73b06cdf13c 100644
>>> --- a/drivers/fpga/dfl-afu-main.c
>>> +++ b/drivers/fpga/dfl-afu-main.c
>>> @@ -21,6 +21,9 @@
>>>  
>>>  #include "dfl-afu.h"
>>>  
>>> +#define RST_POLL_INVL 10 /* us */
>>> +#define RST_POLL_TIMEOUT 1000 /* us */
>>> +
>>>  /**
>>>   * __afu_port_enable - enable a port by clear reset
>>>   * @pdev: port platform device.
>>> @@ -32,7 +35,7 @@
>>>   *
>>>   * The caller needs to hold lock for protection.
>>>   */
>>> -void __afu_port_enable(struct platform_device *pdev)
>>> +int __afu_port_enable(struct platform_device *pdev)
>>>  {
>>>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
>>>  	void __iomem *base;
>>> @@ -41,7 +44,7 @@ void __afu_port_enable(struct platform_device *pdev)
>>>  	WARN_ON(!pdata->disable_count);
>>>  
>>>  	if (--pdata->disable_count != 0)
>>> -		return;
>>> +		return 0;
>> Is this really a success ? Maybe -EBUSY ?
> Seems like if it's severe enough for a warning you'd probably want to
> return an error.
As mentioned by Hao and Yilun, the disable_count is a reference count.The
WARN_ON() is checking for a different condition - an invalid reference count.
We should never call port_enable if the port is not disabled. Do you think a
comment is needed here?

Thanks,
- Russ

>>>  
>>>  	base = dfl_get_feature_ioaddr_by_id(&pdev->dev, PORT_FEATURE_ID_HEADER);
>>>  
>>> @@ -49,10 +52,20 @@ void __afu_port_enable(struct platform_device *pdev)
>>>  	v = readq(base + PORT_HDR_CTRL);
>>>  	v &= ~PORT_CTRL_SFTRST;
>>>  	writeq(v, base + PORT_HDR_CTRL);
>>> -}
>>>  
>>> -#define RST_POLL_INVL 10 /* us */
>>> -#define RST_POLL_TIMEOUT 1000 /* us */
>>> +	/*
>>> +	 * HW clears the ack bit to indicate that the port is fully out
>>> +	 * of reset.
>>> +	 */
>>> +	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
>>> +			       !(v & PORT_CTRL_SFTRST_ACK),
>>> +			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
>>> +		dev_err(&pdev->dev, "timeout, failure to enable device\n");
>>> +		return -ETIMEDOUT;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>>  
>>>  /**
>>>   * __afu_port_disable - disable a port by hold reset
>>> @@ -111,7 +124,7 @@ static int __port_reset(struct platform_device *pdev)
>>>  
>>>  	ret = __afu_port_disable(pdev);
>>>  	if (!ret)
>>> -		__afu_port_enable(pdev);
>>> +		ret = __afu_port_enable(pdev);
>>>  
>>>  	return ret;
>>>  }
>>> @@ -872,11 +885,11 @@ static int afu_dev_destroy(struct platform_device *pdev)
>>>  static int port_enable_set(struct platform_device *pdev, bool enable)
>>>  {
>>>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
>>> -	int ret = 0;
>>> +	int ret;
>>>  
>>>  	mutex_lock(&pdata->lock);
>>>  	if (enable)
>>> -		__afu_port_enable(pdev);
>>> +		ret = __afu_port_enable(pdev);
>>>  	else
>>>  		ret = __afu_port_disable(pdev);
>>>  	mutex_unlock(&pdata->lock);
>>> diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
>>> index 576e94960086..e5020e2b1f3d 100644
>>> --- a/drivers/fpga/dfl-afu.h
>>> +++ b/drivers/fpga/dfl-afu.h
>>> @@ -80,7 +80,7 @@ struct dfl_afu {
>>>  };
>>>  
>>>  /* hold pdata->lock when call __afu_port_enable/disable */
>>> -void __afu_port_enable(struct platform_device *pdev);
>>> +int __afu_port_enable(struct platform_device *pdev);
>>>  int __afu_port_disable(struct platform_device *pdev);
>> The other functions in this file have afu_*  since the __afu_port_enable/disable
>>
>> are used other places would it make sense to remove the '__' prefix ?
> The idea on those is to indicate that the caller need to be cautious
> (often a lock / mutex) is required. I think keeping them as is is fine.
>
>> If you think so, maybe a cleanup patch later.
>>
>> Tom
>>
>>>  
>>>  void afu_mmio_region_init(struct dfl_feature_platform_data *pdata);
> Thanks,
> Moritz

