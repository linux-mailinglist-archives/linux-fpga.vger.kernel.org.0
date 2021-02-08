Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84466313A8E
	for <lists+linux-fpga@lfdr.de>; Mon,  8 Feb 2021 18:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhBHRM5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 8 Feb 2021 12:12:57 -0500
Received: from mga03.intel.com ([134.134.136.65]:40243 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231751AbhBHRLA (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 8 Feb 2021 12:11:00 -0500
IronPort-SDR: SO/NykpxqBC2cB9DNdeDhvQ8IsjsQNFKqspa4T6zd7aR9C/Z4sNx9mvbGenMR9lI4s7uo3KgTM
 lqrB3Fq5FXGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="181812383"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="181812383"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 09:10:13 -0800
IronPort-SDR: lCIbErkhTTnRzrxOb/bfSV6k3l/arQ7tGPt3/CI1aP+592kMq0VVRsdr7hR/q6ZX4jx9Z5GUAR
 ZcwTI/VnL4vg==
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="398464226"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.209.12.237])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 09:10:13 -0800
Subject: Re: [PATCH v5 1/1] fpga: dfl: afu: harden port enable logic
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <20210205182521.275887-1-russell.h.weight@intel.com>
 <YB8AD46GfmVpC7xh@epycbox.lan>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <546df09e-1702-0b95-bb7d-421933293c30@intel.com>
Date:   Mon, 8 Feb 2021 09:10:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YB8AD46GfmVpC7xh@epycbox.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2/6/21 12:46 PM, Moritz Fischer wrote:
> Russ,
>
> On Fri, Feb 05, 2021 at 10:25:21AM -0800, Russ Weight wrote:
>> Port enable is not complete until ACK = 0. Change
>> __afu_port_enable() to guarantee that the enable process
>> is complete by polling for ACK == 0.
>>
>> Reviewed-by: Tom Rix <trix@redhat.com>
>> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> v5:
>>   - Added Reviewed-by tag to commit message
>> v4:
>>   - Added a dev_warn() call for the -EINVAL case of afu_port_err_clear()
>>   - Modified dev_err() message in __afu_port_disable() to say "disable"
>>     instead of "reset"
>> v3:
>>   - afu_port_err_clear() changed to prioritize port_enable failure over
>>     other a detected mismatch in port errors.
>>   - reorganized code in port_reset() to be more readable.
>> v2:
>>   - Fixed typo in commit message
>> ---
>>  drivers/fpga/dfl-afu-error.c | 10 ++++++----
>>  drivers/fpga/dfl-afu-main.c  | 33 +++++++++++++++++++++++----------
>>  drivers/fpga/dfl-afu.h       |  2 +-
>>  3 files changed, 30 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
>> index c4691187cca9..601e599fc33d 100644
>> --- a/drivers/fpga/dfl-afu-error.c
>> +++ b/drivers/fpga/dfl-afu-error.c
>> @@ -52,7 +52,7 @@ static int afu_port_err_clear(struct device *dev, u64 err)
>>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
>>  	struct platform_device *pdev = to_platform_device(dev);
>>  	void __iomem *base_err, *base_hdr;
>> -	int ret = -EBUSY;
>> +	int enable_ret = 0, ret = -EBUSY;
>>  	u64 v;
>>  
>>  	base_err = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
>> @@ -96,18 +96,20 @@ static int afu_port_err_clear(struct device *dev, u64 err)
>>  		v = readq(base_err + PORT_FIRST_ERROR);
>>  		writeq(v, base_err + PORT_FIRST_ERROR);
>>  	} else {
>> +		dev_warn(dev, "__func__: received 0x%llx, expected 0x%llx\n",
>> +			 v, err);
>>  		ret = -EINVAL;
>>  	}
>>  
>>  	/* Clear mask */
>>  	__afu_port_err_mask(dev, false);
>>  
>> -	/* Enable the Port by clear the reset */
>> -	__afu_port_enable(pdev);
>> +	/* Enable the Port by clearing the reset */
>> +	enable_ret = __afu_port_enable(pdev);
>>  
>>  done:
>>  	mutex_unlock(&pdata->lock);
>> -	return ret;
>> +	return enable_ret ? enable_ret : ret;
> Help me understand (sorry if I'm slow here ...), you set ret to -EINVAL,
> but then we only care if enabling the port worked?
Port errors are represented in a bitmask. To clear the errors, the same bitmask is
expected to be written to the "errors" sysfs node. It is considered an error
(EINVAL) if the values do not match. This would most likely be a user error.

The second error case is that we fail to enable the port. This is a
critical/fatal HW error, indicating that the PR region can not be accessed.

The EINVAL still has meaning (I have added an informative warning message for this
case), but it is not as serious as the inability to re-enable the port. So we are
prioritizing the more critical error code.

- Russ
>
> I'm not sure I follow the logic (doesn't mean it's wrong :) ).
>>  }
>>  
>>  static ssize_t errors_show(struct device *dev, struct device_attribute *attr,
>> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
>> index 753cda4b2568..77dadaae5b8f 100644
>> --- a/drivers/fpga/dfl-afu-main.c
>> +++ b/drivers/fpga/dfl-afu-main.c
>> @@ -21,6 +21,9 @@
>>  
>>  #include "dfl-afu.h"
>>  
>> +#define RST_POLL_INVL 10 /* us */
>> +#define RST_POLL_TIMEOUT 1000 /* us */
>> +
>>  /**
>>   * __afu_port_enable - enable a port by clear reset
>>   * @pdev: port platform device.
>> @@ -32,7 +35,7 @@
>>   *
>>   * The caller needs to hold lock for protection.
>>   */
>> -void __afu_port_enable(struct platform_device *pdev)
>> +int __afu_port_enable(struct platform_device *pdev)
>>  {
>>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
>>  	void __iomem *base;
>> @@ -41,7 +44,7 @@ void __afu_port_enable(struct platform_device *pdev)
>>  	WARN_ON(!pdata->disable_count);
>>  
>>  	if (--pdata->disable_count != 0)
>> -		return;
>> +		return 0;
>>  
>>  	base = dfl_get_feature_ioaddr_by_id(&pdev->dev, PORT_FEATURE_ID_HEADER);
>>  
>> @@ -49,10 +52,20 @@ void __afu_port_enable(struct platform_device *pdev)
>>  	v = readq(base + PORT_HDR_CTRL);
>>  	v &= ~PORT_CTRL_SFTRST;
>>  	writeq(v, base + PORT_HDR_CTRL);
>> -}
>>  
>> -#define RST_POLL_INVL 10 /* us */
>> -#define RST_POLL_TIMEOUT 1000 /* us */
>> +	/*
>> +	 * HW clears the ack bit to indicate that the port is fully out
>> +	 * of reset.
>> +	 */
>> +	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
>> +			       !(v & PORT_CTRL_SFTRST_ACK),
>> +			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
>> +		dev_err(&pdev->dev, "timeout, failure to enable device\n");
>> +		return -ETIMEDOUT;
>> +	}
>> +
>> +	return 0;
>> +}
>>  
>>  /**
>>   * __afu_port_disable - disable a port by hold reset
>> @@ -86,7 +99,7 @@ int __afu_port_disable(struct platform_device *pdev)
>>  	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
>>  			       v & PORT_CTRL_SFTRST_ACK,
>>  			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
>> -		dev_err(&pdev->dev, "timeout, fail to reset device\n");
>> +		dev_err(&pdev->dev, "timeout, failure to disable device\n");
>>  		return -ETIMEDOUT;
>>  	}
>>  
>> @@ -111,9 +124,9 @@ static int __port_reset(struct platform_device *pdev)
>>  
>>  	ret = __afu_port_disable(pdev);
>>  	if (!ret)
>> -		__afu_port_enable(pdev);
>> +		return ret;
>>  
>> -	return ret;
>> +	return __afu_port_enable(pdev);
>>  }
>>  
>>  static int port_reset(struct platform_device *pdev)
>> @@ -872,11 +885,11 @@ static int afu_dev_destroy(struct platform_device *pdev)
>>  static int port_enable_set(struct platform_device *pdev, bool enable)
>>  {
>>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
>> -	int ret = 0;
>> +	int ret;
>>  
>>  	mutex_lock(&pdata->lock);
>>  	if (enable)
>> -		__afu_port_enable(pdev);
>> +		ret = __afu_port_enable(pdev);
>>  	else
>>  		ret = __afu_port_disable(pdev);
>>  	mutex_unlock(&pdata->lock);
>> diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
>> index 576e94960086..e5020e2b1f3d 100644
>> --- a/drivers/fpga/dfl-afu.h
>> +++ b/drivers/fpga/dfl-afu.h
>> @@ -80,7 +80,7 @@ struct dfl_afu {
>>  };
>>  
>>  /* hold pdata->lock when call __afu_port_enable/disable */
>> -void __afu_port_enable(struct platform_device *pdev);
>> +int __afu_port_enable(struct platform_device *pdev);
>>  int __afu_port_disable(struct platform_device *pdev);
>>  
>>  void afu_mmio_region_init(struct dfl_feature_platform_data *pdata);
>> -- 
>> 2.25.1
>>
> Thanks,
> Moritz

