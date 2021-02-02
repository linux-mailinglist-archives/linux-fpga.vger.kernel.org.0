Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9507E30CD08
	for <lists+linux-fpga@lfdr.de>; Tue,  2 Feb 2021 21:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhBBU01 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 2 Feb 2021 15:26:27 -0500
Received: from mga02.intel.com ([134.134.136.20]:33050 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232957AbhBBUVK (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 2 Feb 2021 15:21:10 -0500
IronPort-SDR: DrHlrOrc0nIC7C59rBAE0WAfdlrcXBCYiko0glVkLBDzfw7ReTPzEdU4zmxxhwruRTLPrzMo6s
 u2aXarrwcGSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="168031745"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="168031745"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 12:16:22 -0800
IronPort-SDR: jBxBppq8HVCFQTAYgJDsnV45zWNoYttBI7Ub3Dl/9q3GG1k30Uy3U2emPMgOpDN2EZ7rRVsnim
 ayE67msGIb+Q==
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="396153033"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.209.22.86])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 12:16:22 -0800
Subject: Re: [PATCH v2 1/1] fpga: dfl: afu: harden port enable logic
To:     "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>
References: <20200917183219.3603-1-russell.h.weight@intel.com>
 <DM6PR11MB38194BD85854B598F1CD97C5853F0@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <8ab0e288-97f0-d167-50f0-624e05d77944@intel.com>
Date:   Tue, 2 Feb 2021 12:16:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB38194BD85854B598F1CD97C5853F0@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Sorry for the delay on this patch. It seemed like a lower priority patch than
others, since we haven't seen any issues with current products. Please my
responses inline.

On 9/17/20 7:08 PM, Wu, Hao wrote:
>> -----Original Message-----
>> From: Russ Weight <russell.h.weight@intel.com>
>> Sent: Friday, September 18, 2020 2:32 AM
>> To: mdf@kernel.org; linux-fpga@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Cc: trix@redhat.com; lgoncalv@redhat.com; Xu, Yilun <yilun.xu@intel.com>;
>> Wu, Hao <hao.wu@intel.com>; Gerlach, Matthew
>> <matthew.gerlach@intel.com>; Weight, Russell H
>> <russell.h.weight@intel.com>
>> Subject: [PATCH v2 1/1] fpga: dfl: afu: harden port enable logic
>>
>> Port enable is not complete until ACK = 0. Change
>> __afu_port_enable() to guarantee that the enable process
>> is complete by polling for ACK == 0.
> The description of this port reset ack bit is
>
> " After initiating a Port soft reset, SW should monitor this bit. HW
> will set this bit when all outstanding requests initiated by this port
> have been drained, and the minimum soft reset pulse width has
> elapsed. "
>
> But no description about what to do when clearing a Port soft reset
> to enable the port.
>
> So we need to understand clearly on why we need this change
> (e.g. what may happen without this change), and will it apply for all
> existing DFL devices and future ones, or just for one specific card.
> Could you please help? : )
I touched bases with the hardware engineers. The recommendation to wait
for ACK to be cleared is new with OFS and is documented in the latest
OFS specification as follows (see step #4):

> 3.7.1 AFU Soft Resets
> Software may cause a soft reset to be issued to the AFU as follows:
> 1. Assert the PortSoftReset field of the PORT_CONTROL register
> 2. Wait for the Port to acknowledge the soft reset by monitoring the
> PortSoftResetAck field of the PORT_CONTROL register, i.e. PortSoftResetAck=1
> 3. Deasserting the PortSoftReset field
> 4. Wait for the Port to acknowledge the soft reset de-assertion by monitoring the
> PortSoftResetAck field of the PORT_CONTROL register, i.e. PortSoftResetAck=0
>
> This sequence ensures that outstanding transactions are suitably flushed and
> that the FIM minimum reset pulse width is respected. Failing to follow this 
> sequence leaves the AFU in an undefined state.

The OFS specification has not been posted publicly, yet.

Also, this is how it was explained to me:

> In most scenario, port will be able to get out of reset soon enough
> when SW releases the port reset, especially on all the PAC products
> which have been verified before release.
>
> Polling for HW to clear the ACK is meant to handle the following scenarios:
>
>   * Different platform can take variable period of time to get out of reset
>   * Bug in the HW that hold the port in reset

So this change is not required for the currently released PAC cards,
but it is needed for OFS based products. I don't think there is any reason
to hold off on the patch, as it is still valid for current products.

>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>>  drivers/fpga/dfl-afu-error.c |  2 +-
>>  drivers/fpga/dfl-afu-main.c  | 29 +++++++++++++++++++++--------
>>  drivers/fpga/dfl-afu.h       |  2 +-
>>  3 files changed, 23 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
>> index c4691187cca9..0806532a3e9f 100644
>> --- a/drivers/fpga/dfl-afu-error.c
>> +++ b/drivers/fpga/dfl-afu-error.c
>> @@ -103,7 +103,7 @@ static int afu_port_err_clear(struct device *dev, u64
>> err)
>>  __afu_port_err_mask(dev, false);
>>
>>  /* Enable the Port by clear the reset */
>> -__afu_port_enable(pdev);
>> +ret = __afu_port_enable(pdev);
>>
>>  done:
>>  mutex_unlock(&pdata->lock);
>> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
>> index 753cda4b2568..f73b06cdf13c 100644
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
>>  struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev-
>>> dev);
>>  void __iomem *base;
>> @@ -41,7 +44,7 @@ void __afu_port_enable(struct platform_device *pdev)
>>  WARN_ON(!pdata->disable_count);
>>
>>  if (--pdata->disable_count != 0)
>> -return;
>> +return 0;
>>
>>  base = dfl_get_feature_ioaddr_by_id(&pdev->dev,
>> PORT_FEATURE_ID_HEADER);
>>
>> @@ -49,10 +52,20 @@ void __afu_port_enable(struct platform_device
>> *pdev)
>>  v = readq(base + PORT_HDR_CTRL);
>>  v &= ~PORT_CTRL_SFTRST;
>>  writeq(v, base + PORT_HDR_CTRL);
>> -}
>>
>> -#define RST_POLL_INVL 10 /* us */
>> -#define RST_POLL_TIMEOUT 1000 /* us */
>> +/*
>> + * HW clears the ack bit to indicate that the port is fully out
>> + * of reset.
>> + */
>> +if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
>> +       !(v & PORT_CTRL_SFTRST_ACK),
>> +       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
>> +dev_err(&pdev->dev, "timeout, failure to enable device\n");
>> +return -ETIMEDOUT;
>> +}
>> +
>> +return 0;
>> +}
>>
>>  /**
>>   * __afu_port_disable - disable a port by hold reset
>> @@ -111,7 +124,7 @@ static int __port_reset(struct platform_device *pdev)
>>
>>  ret = __afu_port_disable(pdev);
>>  if (!ret)
>> -__afu_port_enable(pdev);
>> +ret = __afu_port_enable(pdev);
>>
>>  return ret;
> What about:
>
> ret = __afu_port_disable(pdev);
> if (ret)
> return ret;
>
> return __afu_port_enable(pdev);
Sure - I'll make this change.

Thanks,
- Russ
>
> Thanks
> Hao
>
>>  }
>> @@ -872,11 +885,11 @@ static int afu_dev_destroy(struct platform_device
>> *pdev)
>>  static int port_enable_set(struct platform_device *pdev, bool enable)
>>  {
>>  struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev-
>>> dev);
>> -int ret = 0;
>> +int ret;
>>
>>  mutex_lock(&pdata->lock);
>>  if (enable)
>> -__afu_port_enable(pdev);
>> +ret = __afu_port_enable(pdev);
>>  else
>>  ret = __afu_port_disable(pdev);
>>  mutex_unlock(&pdata->lock);
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
>> 2.17.1

