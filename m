Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116902696F5
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Sep 2020 22:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgINUs5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Sep 2020 16:48:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726038AbgINUsx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Sep 2020 16:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600116530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UikjlfdvYBFSYfHdY6bg2SvoHxxYO26Yfta7w3DPvL4=;
        b=S8ncFTuJ30C4ZtTdOuxlFjfOFTxl5MpAZ4HeEwKrWzqrrHqfRvxMIrC9eVpOIkxYzQKFWS
        ibzJvP16re0nmOi/lNx99RvCDKtnowzZ1Xyw2o+9+xg7T+2LPpzEtgMiwEBkfl2or+p9iM
        2gr0i5hRc/g/q0ZIBCUcaNnlNzB7Okw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-y0-DEANLM0yDtvryTTtLGg-1; Mon, 14 Sep 2020 16:48:47 -0400
X-MC-Unique: y0-DEANLM0yDtvryTTtLGg-1
Received: by mail-qt1-f198.google.com with SMTP id b54so894637qtk.17
        for <linux-fpga@vger.kernel.org>; Mon, 14 Sep 2020 13:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UikjlfdvYBFSYfHdY6bg2SvoHxxYO26Yfta7w3DPvL4=;
        b=TMuPz7uUEdBEVgZl5sr25A+m+QYe23UXRMOn/PEIgALSqzm0G68NmfzB5COwokwEy/
         IoQu6QLBGwHKoqLn2vjieu7RQk+nl6RBaatGX8BWDO8HtO4Oa7vjSdG9gG8CCCW459sZ
         +adnoiltTglckd4hvAGK2YEI30hAemoHHTjMQ7SMsSrKhMPJbEoAgAns8Ll/OPvL52dV
         a32MKPV9x/Om1YnqcDKUImOyNc7UvnvMfWDXWl8o8wcloSAQ5ypn1YiKxM2Dzkav9drL
         K1+Aw+GWvijCtlaxHb8LQJ6FgCdKAqVTOoXgBCG/xIk8BTdqoEelME8OahH4Pi4u8Oe5
         GNzg==
X-Gm-Message-State: AOAM5339xH+BJbGJ9ZmSavrU/Dz0fzoOjA5GMCi2vF1xBO/7TVcwO6CW
        TSZPVjFSmKsDAEZeAAwbQdnY9Wj5VEzf4JHnu6/JEohuoCBJkSWY67ZKXsY5VrnXIPctXijtWHc
        +HEXBQ6CD2EXQ/mWNZRE+Vw==
X-Received: by 2002:a0c:a9d6:: with SMTP id c22mr15585047qvb.102.1600116526780;
        Mon, 14 Sep 2020 13:48:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpERF0pwU2dSH5e5L8hwfCaMS/IayEn4g+PAfLiBfnvlhaJupbIjHn8C7FX5q0cAYlvb+itg==
X-Received: by 2002:a0c:a9d6:: with SMTP id c22mr15584998qvb.102.1600116526217;
        Mon, 14 Sep 2020 13:48:46 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l29sm15749916qtb.77.2020.09.14.13.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 13:48:45 -0700 (PDT)
Subject: Re: [PATCH v1 02/12] fpga: create intel max10 bmc security engine
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-3-russell.h.weight@intel.com>
 <77143987-4388-9d2a-0ef0-6a1e60ee18f9@redhat.com>
 <a22d3234-2fbf-454a-773c-da6c853b11a0@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <7dde12fd-66f0-4fe2-eeb2-ff810dcfc24f@redhat.com>
Date:   Mon, 14 Sep 2020 13:48:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <a22d3234-2fbf-454a-773c-da6c853b11a0@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/14/20 12:07 PM, Russ Weight wrote:
>
> On 9/5/20 1:22 PM, Tom Rix wrote:
>> On 9/4/20 4:52 PM, Russ Weight wrote:
>>> Create a platform driver that can be invoked as a sub
>>> driver for the Intel MAX10 BMC in order to support
>>> secure updates. This sub-driver will invoke an
>>> instance of the Intel FPGA Security Manager class driver
>>> in order to expose sysfs interfaces for managing and
>>> monitoring secure updates to FPGA and BMC images.
>>>
>>> This patch creates the MAX10 BMC Security Engine driver and
>>> provides support for displaying the current root entry hashes
>>> for the FPGA static region, the FPGA PR region, and the MAX10
>>> BMC.
>>>
>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>> Reviewed-by: Wu Hao <hao.wu@intel.com>
>>> ---
>>>  drivers/fpga/Kconfig                |  11 ++
>>>  drivers/fpga/Makefile               |   3 +
>>>  drivers/fpga/intel-m10-bmc-secure.c | 170 ++++++++++++++++++++++++++++
>>>  include/linux/mfd/intel-m10-bmc.h   |  15 +++
>>>  4 files changed, 199 insertions(+)
>>>  create mode 100644 drivers/fpga/intel-m10-bmc-secure.c
>>>
>>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>>> index 97c0a6cc2ba7..0f0bed68e618 100644
>>> --- a/drivers/fpga/Kconfig
>>> +++ b/drivers/fpga/Kconfig
>>> @@ -244,4 +244,15 @@ config IFPGA_SEC_MGR
>>>  	  region and for the BMC. Select this option to enable
>>>  	  updates for secure FPGA devices.
>>>  
>>> +config IFPGA_M10_BMC_SECURE
>>> +        tristate "Intel MAX10 BMC security engine"
>>> +	depends on MFD_INTEL_M10_BMC && IFPGA_SEC_MGR
>>> +        help
>>> +          Secure update support for the Intel MAX10 board management
>>> +	  controller.
>>> +
>>> +	  This is a subdriver of the Intel MAX10 board management controller
>>> +	  (BMC) and provides support for secure updates for the BMC image,
>>> +	  the FPGA image, the Root Entry Hashes, etc.
>>> +
>>>  endif # FPGA
>>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>>> index ec9fbacdedd8..451a23ec3168 100644
>>> --- a/drivers/fpga/Makefile
>>> +++ b/drivers/fpga/Makefile
>>> @@ -24,6 +24,9 @@ obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
>>>  # Intel FPGA Security Manager Framework
>>>  obj-$(CONFIG_IFPGA_SEC_MGR)		+= ifpga-sec-mgr.o
>>>  
>>> +# Intel Security Manager Drivers
>>> +obj-$(CONFIG_IFPGA_M10_BMC_SECURE)	+= intel-m10-bmc-secure.o
>>> +
>>>  # FPGA Bridge Drivers
>>>  obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
>>>  obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
>>> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
>>> new file mode 100644
>>> index 000000000000..1f86bfb694b4
>>> --- /dev/null
>>> +++ b/drivers/fpga/intel-m10-bmc-secure.c
>>> @@ -0,0 +1,170 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Intel Max10 Board Management Controller Security Engine Driver
>>> + *
>>> + * Copyright (C) 2019-2020 Intel Corporation. All rights reserved.
>>> + *
>>> + */
>>> +#include <linux/device.h>
>>> +#include <linux/fpga/ifpga-sec-mgr.h>
>>> +#include <linux/mfd/intel-m10-bmc.h>
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/vmalloc.h>
>>> +
>>> +struct m10bmc_sec {
>>> +	struct device *dev;
>>> +	struct intel_m10bmc *m10bmc;
>>> +	struct ifpga_sec_mgr *imgr;
>>> +};
>>> +
>>> +#define SHA256_REH_SIZE		32
>>> +#define SHA384_REH_SIZE		48
>>> +
>>> +static int get_reh_size(struct ifpga_sec_mgr *imgr,
>>> +			u32 exp_magic, u32 prog_addr)
>>> +{
>>> +	struct m10bmc_sec *sec = imgr->priv;
>>> +	int sha_num_bytes, ret;
>>> +	u32 magic;
>>> +
>>> +	ret = m10bmc_raw_read(sec->m10bmc, prog_addr, &magic);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	dev_dbg(sec->dev, "%s magic 0x%08x\n", __func__, magic);
>>> +
>>> +	if ((magic & 0xffff) != exp_magic)
>> return -EINVAL ?
> The absence of the magic number indicates that a Root Entry Hash has
> not been programmed. So a null string (string size of zero) is appropriate
> here.
>
> I'll add a comment.
>
>>> +		return 0;
>>> +
>>> +	sha_num_bytes = ((magic >> 16) & 0xffff) / 8;
>>> +
>>> +	if (sha_num_bytes != SHA256_REH_SIZE &&
>>> +	    sha_num_bytes != SHA384_REH_SIZE)   {
>>> +		dev_err(sec->dev, "%s bad sha num bytes %d\n", __func__,
>>> +			sha_num_bytes);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	return sha_num_bytes;
>>> +}
>>> +
>>> +#define BMC_REH_ADDR 0x17ffc004
>>> +#define BMC_PROG_ADDR 0x17ffc000
>>> +#define BMC_PROG_MAGIC 0x5746
>>> +
>>> +#define SR_REH_ADDR 0x17ffd004
>>> +#define SR_PROG_ADDR 0x17ffd000
>>> +#define SR_PROG_MAGIC 0x5253
>>> +
>>> +#define PR_REH_ADDR 0x17ffe004
>>> +#define PR_PROG_ADDR 0x17ffe000
>>> +#define PR_PROG_MAGIC 0x5250
>> Why shouldn't these #defines be collected in the intel-m10-bmc.h ?
> Placing them in intel-m10-bmc-h would give them a broader scope and make them
> available to all m10-bmc sub-drivers. I placed them here to limit the scope to
> the only file that should care about these definitions.
>
> Is this OK - or should they be moved to the header file?

My thinking keeping all the register defines in one place is

better than spreading it all out.  This would help with possible

future changes that effected the entire register set.

>
>>> +
>>> +#define SYSFS_GET_REH_SIZE(_name, _exp_magic, _prog_addr) \
>>> +static int get_##_name##_reh_size(struct ifpga_sec_mgr *imgr) \
>>> +{ \
>>> +	return get_reh_size(imgr, _exp_magic, _prog_addr); \
>>> +}
>> Is this macro overkill for a 1 liner ?
> It gives a slight reduction in code. I could go either way. What do you think? Should I take out the macros? Or leave it as is?
>
>>> +
>>> +SYSFS_GET_REH_SIZE(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR)
>>> +SYSFS_GET_REH_SIZE(sr, SR_PROG_MAGIC, SR_PROG_ADDR)
>>> +SYSFS_GET_REH_SIZE(pr, PR_PROG_MAGIC, PR_PROG_ADDR)
>> These and similar below do not directly interact
>>
>> with the sysfs so the sysfs_ prefix should not be needed.
> OK - I'll remove the SYSFS_ prefix.
>
>>> +
>>> +static int get_root_entry_hash(struct ifpga_sec_mgr *imgr,
>>> +			       u32 hash_addr, u8 *hash,
>>> +			       unsigned int size)
>>> +{
>>> +	struct m10bmc_sec *sec = imgr->priv;
>>> +	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
>>> +	int ret;
>>> +
>>> +	ret = m10bmc_raw_bulk_read(sec->m10bmc, hash_addr,
>>> +				   hash, size / stride);
>>> +	if (ret)
>>> +		dev_err(sec->dev, "bulk_read of 0x%x failed %d",
>>> +			hash_addr, ret);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +#define SYSFS_GET_REH(_name, _hash_addr) \
>>> +static int get_##_name##_root_entry_hash(struct ifpga_sec_mgr *imgr, \
>>> +					 u8 *hash, unsigned int size) \
>>> +{ \
>>> +	return get_root_entry_hash(imgr, _hash_addr, hash, size); \
>>> +}
>>> +
>>> +SYSFS_GET_REH(bmc, BMC_REH_ADDR)
>>> +SYSFS_GET_REH(sr, SR_REH_ADDR)
>>> +SYSFS_GET_REH(pr, PR_REH_ADDR)
>>> +
>>> +static const struct ifpga_sec_mgr_ops m10bmc_iops = {
>>> +	.bmc_root_entry_hash = get_bmc_root_entry_hash,
>>> +	.sr_root_entry_hash = get_sr_root_entry_hash,
>>> +	.pr_root_entry_hash = get_pr_root_entry_hash,
>>> +	.bmc_reh_size = get_bmc_reh_size,
>>> +	.sr_reh_size = get_sr_reh_size,
>>> +	.pr_reh_size = get_pr_reh_size,
>> The prefix of the ops should be similar to the file name.
>>
>> so consider changing get_pr_reh_size to max10_pr_reh_size
> I'll switch to a prefix of m10bmc_ to be consistent with the probe and
> remove functions.
>
>>> +};
>>> +
>>> +static void ifpga_sec_mgr_uinit(struct m10bmc_sec *sec)
>>> +{
>>> +	ifpga_sec_mgr_unregister(sec->imgr);
>>> +}
>>> +
>>> +static int ifpga_sec_mgr_init(struct m10bmc_sec *sec)
>>> +{
>>> +	struct ifpga_sec_mgr *imgr;
>>> +
>>> +	imgr = ifpga_sec_mgr_register(sec->dev, "Max10 BMC Security Manager",
>>> +				      &m10bmc_iops, sec);
>>> +	if (IS_ERR(imgr))
>>> +		return PTR_ERR(imgr);
>>> +
>>> +	sec->imgr = imgr;
>>> +	return 0;
>>> +}
>>> +
>>> +static int m10bmc_secure_probe(struct platform_device *pdev)
>>> +{
>>> +	struct m10bmc_sec *sec;
>>> +	int ret;
>>> +
>>> +	sec = devm_kzalloc(&pdev->dev, sizeof(*sec), GFP_KERNEL);
>>> +	if (!sec)
>>> +		return -ENOMEM;
>>> +
>>> +	sec->dev = &pdev->dev;
>>> +	sec->m10bmc = dev_get_drvdata(pdev->dev.parent);
>>> +	dev_set_drvdata(&pdev->dev, sec);
>>> +
>>> +	ret = ifpga_sec_mgr_init(sec);
>>> +	if (ret)
>>> +		dev_err(&pdev->dev,
>>> +			"Security manager failed to start: %d\n", ret);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int m10bmc_secure_remove(struct platform_device *pdev)
>>> +{
>>> +	struct m10bmc_sec *sec = dev_get_drvdata(&pdev->dev);
>>> +
>>> +	ifpga_sec_mgr_uinit(sec);
>>> +	return 0;
>>> +}
>>> +
>>> +static struct platform_driver intel_m10bmc_secure_driver = {
>>> +	.probe = m10bmc_secure_probe,
>>> +	.remove = m10bmc_secure_remove,
>>> +	.driver = {
>>> +		.name = "n3000bmc-secure",
>> From the filename, should this be "max10bmc-secure" ?
> This driver file will also service other devices. A future patch will add support
> for the d5005 card and the same driver code will be used, with some conditional
> logic, to support the d5005 card under the name "d5005bmc-secure". See the following
> link for a preview of these changes.
>
> https://github.com/OPAE/linux-dfl/blob/8e94e1f41c1571a322aac0c8d6ab8ee282e45016/drivers/mfd/intel-m10-bmc-secure.c#L803
>
> I chose to put n3000 in the name now so that the driver name (visible to user
> space applications) will not have to change names the d5005 functionality is added.
>
> The source filename is intel-m10-bmc-secure.c. Would it be better to call this driver
> n3000-m10bmc-secure? 
>
> Should I introduce the struct platform_device_id array (see the above link) now with
> a single entry for the n3000? So that the initial version of this file will contain
> the main driver name (intel-m10bmc-secure) as well as the n3000bmc-secure name?

Thanks for you explanation that this will also be used by d5005.

I think you have fine as-is.

Thanks

Tom

>
>>> +	},
>>> +};
>>> +module_platform_driver(intel_m10bmc_secure_driver);
>>> +
>>> +MODULE_ALIAS("platform:n3000bmc-secure");
>>> +MODULE_AUTHOR("Intel Corporation");
>>> +MODULE_DESCRIPTION("Intel MAX10 BMC secure engine");
>>> +MODULE_LICENSE("GPL v2");
>>> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
>>> index d4cb01b73357..7fe465c320c2 100644
>>> --- a/include/linux/mfd/intel-m10-bmc.h
>>> +++ b/include/linux/mfd/intel-m10-bmc.h
>>> @@ -63,6 +63,7 @@ struct intel_m10bmc {
>>>   * register access helper functions.
>>>   *
>>>   * m10bmc_raw_read - read m10bmc register per addr
>>> + * m10bmc_raw_bulk_read - bulk_read max10 registers per addr
>> second '_' should be removed so it reads like
>>
>> bulk read max10 registers..
> Thanks for the comments! I'll fix this.
>
>> Tom
>>
>>>   * m10bmc_sys_read - read m10bmc system register per offset
>>>   */
>>>  static inline int
>>> @@ -79,6 +80,20 @@ m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
>>>  	return ret;
>>>  }
>>>  
>>> +static inline int
>>> +m10bmc_raw_bulk_read(struct intel_m10bmc *m10bmc, unsigned int addr,
>>> +		     void *val, size_t cnt)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = regmap_bulk_read(m10bmc->regmap, addr, val, cnt);
>>> +	if (ret)
>>> +		dev_err(m10bmc->dev, "fail to read raw reg %x cnt %zx: %d\n",
>>> +			addr, cnt, ret);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>  #define m10bmc_sys_read(m10bmc, offset, val) \
>>>  	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)
>>>  

