Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7360B30FA81
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Feb 2021 19:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238571AbhBDSAY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 4 Feb 2021 13:00:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:31225 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237183AbhBDR7x (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 4 Feb 2021 12:59:53 -0500
IronPort-SDR: dkgsXljIqWdUJo02c5rinDXVQdcPqAU5PCLQn0izlwftYu1wNieutbm8bS78BBoHpIThuGIJ28
 5dA5JTNKXkMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="168413044"
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="scan'208";a="168413044"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 09:59:04 -0800
IronPort-SDR: kwyrg7fXC7WjHBM6f8jZvx93rd7k0r/hcEyjb2FwgVIyC1OMIaXYap5ii9k/gFnOmSH85mvsvy
 QcYL1O8TaN2w==
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="scan'208";a="397133845"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.209.87.127])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 09:59:04 -0800
Subject: Re: [PATCH v3 1/1] fpga: dfl: afu: harden port enable logic
To:     "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>
References: <20210202230631.198950-1-russell.h.weight@intel.com>
 <DM6PR11MB3819173E2C84099BA5D6EB4785B49@DM6PR11MB3819.namprd11.prod.outlook.com>
 <7ab15adf-81b5-f1ba-ef02-c31701592e4c@intel.com>
 <DM6PR11MB38190997A52B3E3C8C618AF885B39@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <e3e441ed-4063-b471-f6b6-1930626e5b1a@intel.com>
Date:   Thu, 4 Feb 2021 09:59:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB38190997A52B3E3C8C618AF885B39@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2/3/21 5:38 PM, Wu, Hao wrote:
>> On 2/3/21 1:01 AM, Wu, Hao wrote:
>>>> Subject: [PATCH v3 1/1] fpga: dfl: afu: harden port enable logic
>>>>
>>>> Port enable is not complete until ACK = 0. Change
>>>> __afu_port_enable() to guarantee that the enable process
>>>> is complete by polling for ACK == 0.
>>>>
>>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>>> ---
>>>> v3:
>>>>   - afu_port_err_clear() changed to prioritize port_enable failure over
>>>>     other a detected mismatch in port errors.
>>>>   - reorganized code in port_reset() to be more readable.
>>>> v2:
>>>>   - Fixed typo in commit message
>>>> ---
>>>>  drivers/fpga/dfl-afu-error.c |  8 ++++----
>>>>  drivers/fpga/dfl-afu-main.c  | 31 ++++++++++++++++++++++---------
>>>>  drivers/fpga/dfl-afu.h       |  2 +-
>>>>  3 files changed, 27 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
>>>> index c4691187cca9..2ced610059cc 100644
>>>> --- a/drivers/fpga/dfl-afu-error.c
>>>> +++ b/drivers/fpga/dfl-afu-error.c
>>>> @@ -52,7 +52,7 @@ static int afu_port_err_clear(struct device *dev, u64 err)
>>>>  struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
>>>>  struct platform_device *pdev = to_platform_device(dev);
>>>>  void __iomem *base_err, *base_hdr;
>>>> -int ret = -EBUSY;
>>>> +int enable_ret = 0, ret = -EBUSY;
>>>>  u64 v;
>>>>
>>>>  base_err = dfl_get_feature_ioaddr_by_id(dev,
>>>> PORT_FEATURE_ID_ERROR);
>>>> @@ -102,12 +102,12 @@ static int afu_port_err_clear(struct device *dev,
>> u64
>>>> err)
>>>>  /* Clear mask */
>>>>  __afu_port_err_mask(dev, false);
>>>>
>>>> -/* Enable the Port by clear the reset */
>>>> -__afu_port_enable(pdev);
>>>> +/* Enable the Port by clearing the reset */
>>>> +enable_ret = __afu_port_enable(pdev);
>>>>
>>>>  done:
>>>>  mutex_unlock(&pdata->lock);
>>>> -return ret;
>>>> +return enable_ret ? enable_ret : ret;
>>> Maybe we should add some error message to notify user, there are more
>> errors happened,
>>> as some ret value is not returned.
>> It is the -EINVAL error case that would get lost if there was a double error.
>> This error indicates that the value written to sysfs by the user does not
>> correspond to the current port errors. This is not a hardware error, and could
>> even be a user error. Do you think a warning in the error log is needed here?
> I think so, as there are actually two errors there, I feel it's better to let user know
> their input is not accepted too than just keeping silence, right? as this error
> should be triggered by user input?
In the single error case, the EINVAL would be returned to the user-space caller. That is
the common case. In the double error case, the EINVAL would be lost. Either way, it is
helpful to know what the expected/actual values are. I have added a warning message to
the kernel log for the next version of the patch which also shows the expected/actual
values.

- Russ
>
> Hao
>
>>>>  }
>>>>
>>>>  static ssize_t errors_show(struct device *dev, struct device_attribute *attr,
>>>> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
>>>> index 753cda4b2568..729eb306062e 100644
>>>> --- a/drivers/fpga/dfl-afu-main.c
>>>> +++ b/drivers/fpga/dfl-afu-main.c
>>>> @@ -21,6 +21,9 @@
>>>>
>>>>  #include "dfl-afu.h"
>>>>
>>>> +#define RST_POLL_INVL 10 /* us */
>>>> +#define RST_POLL_TIMEOUT 1000 /* us */
>>>> +
>>>>  /**
>>>>   * __afu_port_enable - enable a port by clear reset
>>>>   * @pdev: port platform device.
>>>> @@ -32,7 +35,7 @@
>>>>   *
>>>>   * The caller needs to hold lock for protection.
>>>>   */
>>>> -void __afu_port_enable(struct platform_device *pdev)
>>>> +int __afu_port_enable(struct platform_device *pdev)
>>>>  {
>>>>  struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev-
>>>>> dev);
>>>>  void __iomem *base;
>>>> @@ -41,7 +44,7 @@ void __afu_port_enable(struct platform_device *pdev)
>>>>  WARN_ON(!pdata->disable_count);
>>>>
>>>>  if (--pdata->disable_count != 0)
>>>> -return;
>>>> +return 0;
>>>>
>>>>  base = dfl_get_feature_ioaddr_by_id(&pdev->dev,
>>>> PORT_FEATURE_ID_HEADER);
>>>>
>>>> @@ -49,10 +52,20 @@ void __afu_port_enable(struct platform_device
>> *pdev)
>>>>  v = readq(base + PORT_HDR_CTRL);
>>>>  v &= ~PORT_CTRL_SFTRST;
>>>>  writeq(v, base + PORT_HDR_CTRL);
>>>> -}
>>>>
>>>> -#define RST_POLL_INVL 10 /* us */
>>>> -#define RST_POLL_TIMEOUT 1000 /* us */
>>>> +/*
>>>> + * HW clears the ack bit to indicate that the port is fully out
>>>> + * of reset.
>>>> + */
>>>> +if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
>>>> +       !(v & PORT_CTRL_SFTRST_ACK),
>>>> +       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
>>>> +dev_err(&pdev->dev, "timeout, failure to enable device\n");
>>> Maybe we can change dev_err message in port disable to "disable device" as
>> well. : )
>> Thank you. I'll submit a new version of the patch with this fix.
>>
>> - Russ
>>> Hao
>>>
>>>> +return -ETIMEDOUT;
>>>> +}
>>>> +
>>>> +return 0;
>>>> +}
>>>>
>>>>  /**
>>>>   * __afu_port_disable - disable a port by hold reset
>>>> @@ -111,9 +124,9 @@ static int __port_reset(struct platform_device *pdev)
>>>>
>>>>  ret = __afu_port_disable(pdev);
>>>>  if (!ret)
>>>> -__afu_port_enable(pdev);
>>>> +return ret;
>>>>
>>>> -return ret;
>>>> +return __afu_port_enable(pdev);
>>>>  }
>>>>
>>>>  static int port_reset(struct platform_device *pdev)
>>>> @@ -872,11 +885,11 @@ static int afu_dev_destroy(struct platform_device
>>>> *pdev)
>>>>  static int port_enable_set(struct platform_device *pdev, bool enable)
>>>>  {
>>>>  struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev-
>>>>> dev);
>>>> -int ret = 0;
>>>> +int ret;
>>>>
>>>>  mutex_lock(&pdata->lock);
>>>>  if (enable)
>>>> -__afu_port_enable(pdev);
>>>> +ret = __afu_port_enable(pdev);
>>>>  else
>>>>  ret = __afu_port_disable(pdev);
>>>>  mutex_unlock(&pdata->lock);
>>>> diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
>>>> index 576e94960086..e5020e2b1f3d 100644
>>>> --- a/drivers/fpga/dfl-afu.h
>>>> +++ b/drivers/fpga/dfl-afu.h
>>>> @@ -80,7 +80,7 @@ struct dfl_afu {
>>>>  };
>>>>
>>>>  /* hold pdata->lock when call __afu_port_enable/disable */
>>>> -void __afu_port_enable(struct platform_device *pdev);
>>>> +int __afu_port_enable(struct platform_device *pdev);
>>>>  int __afu_port_disable(struct platform_device *pdev);
>>>>
>>>>  void afu_mmio_region_init(struct dfl_feature_platform_data *pdata);
>>>> --
>>>> 2.25.1

