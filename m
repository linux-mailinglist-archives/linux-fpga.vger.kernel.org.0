Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA0B2850D6
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Oct 2020 19:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgJFRby (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Oct 2020 13:31:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26049 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726197AbgJFRbt (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Oct 2020 13:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602005507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PVq3Z1OHzymxlyyqdCpx03ezBFxwU6vssMo9UMimTDo=;
        b=KgpEaTp8+fJe8UwgRlffeXvtm66bB2pRT0CckuwyAMmbaSD4rkB6C2t4olvbeOSgSpsuTu
        6KSopzSK8rn0KJGHaUC+wgC6VktRo2//GnRzYhbIP7XDI+LBa4EJGFv6GIhRe9jbJ8wtRM
        3KT0R8lAAhxVS181Fn29FjEt9UFcsXM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-c3HRb_x7P7G4Wq-cNbaMbA-1; Tue, 06 Oct 2020 13:31:42 -0400
X-MC-Unique: c3HRb_x7P7G4Wq-cNbaMbA-1
Received: by mail-qk1-f197.google.com with SMTP id m23so9705624qkh.10
        for <linux-fpga@vger.kernel.org>; Tue, 06 Oct 2020 10:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PVq3Z1OHzymxlyyqdCpx03ezBFxwU6vssMo9UMimTDo=;
        b=uSo0PI8QcJQ75JZlr6U4Vu1qktMoNnPt9PjOjriqcBm8gbuyjslHtrRgBz9GC7b4AJ
         li3uIBdBEhUz/+vkxtPPks70q6ycxABnT+rurUvXZ5mBmIzInRSqLnszuhwhLFfVSkDt
         NoyTCZaR8XyKjjJebDcIvTBqU9QAA/sYiDij2DH9NGq0VE+1EpQhRSlWGSwq5eEQ7ALD
         /k1mEbxCVN4O0CZRJiWejh8qAT5BXDzrCumfXj18T3PJzIVSKK4mfqjjxuiKHi2vh86E
         YoUGuBTQ05L7AnFbpl2IXhKmqNI1HbEaOeF/eGB4WomZF7Qm3CF1CN1zvWN00mfFNfbt
         8KPA==
X-Gm-Message-State: AOAM531V1dgfGYTZQRzNY9oQsg2CCPXXtFJoObjIaFwIi9k/E8hf7TUy
        yObbFm6SCocv46UzOMTNHmHc57OjYSE6HFZlL3pwfbQHz8sjMf/1VrvK5+UoCaXSBR7BK1SwBMC
        YWJvlpKjxmUWmY4eittxYeA==
X-Received: by 2002:a05:620a:13b9:: with SMTP id m25mr6406840qki.467.1602005502231;
        Tue, 06 Oct 2020 10:31:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrZWeO3HHdYvIslnJ6x0bwARP0ZMrjpbha4BcbnKX1NZSgJR+V6WoeIZApPpPI0RYiPS5ITg==
X-Received: by 2002:a05:620a:13b9:: with SMTP id m25mr6406793qki.467.1602005501879;
        Tue, 06 Oct 2020 10:31:41 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r12sm2822675qke.87.2020.10.06.10.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 10:31:41 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] fpga: m10bmc-sec: create max10 bmc security engine
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20201003012412.16831-1-russell.h.weight@intel.com>
 <20201003012412.16831-3-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <31f6a8a2-86f1-a9b5-d32e-9172bb89ddd4@redhat.com>
Date:   Tue, 6 Oct 2020 10:31:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201003012412.16831-3-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/2/20 6:24 PM, Russ Weight wrote:
> Create a platform driver that can be invoked as a sub
> driver for the Intel MAX10 BMC in order to support
> secure updates. This sub-driver will invoke an
> instance of the Intel FPGA Security Manager class driver
> in order to expose sysfs interfaces for managing and
> monitoring secure updates to FPGA and BMC images.
>
> This patch creates the MAX10 BMC Security Engine driver and
> provides support for displaying the current root entry hashes
> for the FPGA static region, the FPGA PR region, and the MAX10
> BMC.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v2:
>   - Added drivers/fpga/intel-m10-bmc-secure.c file to MAINTAINERS.
>   - Switched to GENMASK(31, 16) for a couple of mask definitions.
>   - Moved MAX10 BMC address and function definitions to a separate
>     patch.
>   - Replaced small function-creation macros with explicit function
>     declarations.
>   - Removed ifpga_sec_mgr_init() and ifpga_sec_mgr_uinit() functions.
>   - Adapted to changes in the Intel FPGA Security Manager by splitting
>     the single call to ifpga_sec_mgr_register() into two function
>     calls: devm_ifpga_sec_mgr_create() and ifpga_sec_mgr_register().
> ---
>  MAINTAINERS                         |   1 +
>  drivers/fpga/Kconfig                |  11 ++
>  drivers/fpga/Makefile               |   3 +
>  drivers/fpga/intel-m10-bmc-secure.c | 165 ++++++++++++++++++++++++++++
>  4 files changed, 180 insertions(+)
>  create mode 100644 drivers/fpga/intel-m10-bmc-secure.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0bb5ef309dec..c359d0214980 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6898,6 +6898,7 @@ S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>  F:	Documentation/fpga/ifpga-sec-mgr.rst
>  F:	drivers/fpga/ifpga-sec-mgr.c
> +F:	drivers/fpga/intel-m10-bmc-secure.c
>  F:	include/linux/fpga/ifpga-sec-mgr.h
>  
>  FPU EMULATOR
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index c534cc80f398..2380d36b08c7 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -235,4 +235,15 @@ config IFPGA_SEC_MGR
>  	  region and for the BMC. Select this option to enable
>  	  updates for secure FPGA devices.
>  
> +config IFPGA_M10_BMC_SECURE
> +        tristate "Intel MAX10 BMC security engine"
> +	depends on MFD_INTEL_M10_BMC && IFPGA_SEC_MGR
> +        help
> +          Secure update support for the Intel MAX10 board management
> +	  controller.
> +
> +	  This is a subdriver of the Intel MAX10 board management controller
> +	  (BMC) and provides support for secure updates for the BMC image,
> +	  the FPGA image, the Root Entry Hashes, etc.
> +
>  endif # FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 6f706590e209..8e702689cdda 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -24,6 +24,9 @@ obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
>  # Intel FPGA Security Manager Framework
>  obj-$(CONFIG_IFPGA_SEC_MGR)		+= ifpga-sec-mgr.o
>  
> +# Intel Security Manager Drivers
> +obj-$(CONFIG_IFPGA_M10_BMC_SECURE)	+= intel-m10-bmc-secure.o
> +
>  # FPGA Bridge Drivers
>  obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
>  obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
> new file mode 100644
> index 000000000000..df8ebda9a9cb
> --- /dev/null
> +++ b/drivers/fpga/intel-m10-bmc-secure.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel Max10 Board Management Controller Security Engine Driver
> + *
> + * Copyright (C) 2019-2020 Intel Corporation. All rights reserved.
> + *
> + */
> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/fpga/ifpga-sec-mgr.h>
> +#include <linux/mfd/intel-m10-bmc.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/vmalloc.h>
> +
> +struct m10bmc_sec {
> +	struct device *dev;
> +	struct intel_m10bmc *m10bmc;
> +	struct ifpga_sec_mgr *imgr;
> +};
> +
> +#define REH_SHA256_SIZE		32
> +#define REH_SHA384_SIZE		48
> +#define REH_MAGIC		GENMASK(15, 0)
> +#define REH_SHA_NUM_BYTES	GENMASK(31, 16)
> +
> +static int m10bmc_reh_size(struct ifpga_sec_mgr *imgr,
> +			   u32 exp_magic, u32 prog_addr)
> +{
> +	struct m10bmc_sec *sec = imgr->priv;
> +	int sha_num_bytes, ret;
> +	u32 magic;
> +
> +	ret = m10bmc_raw_read(sec->m10bmc, prog_addr, &magic);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(sec->dev, "%s magic 0x%08x\n", __func__, magic);
> +
> +	/*
> +	 * If no magic number, then no REH is programmed, so
> +	 * the REH size is zero.
> +	 */
> +	if (FIELD_GET(REH_MAGIC, magic) != exp_magic)
> +		return 0;
> +
> +	sha_num_bytes = FIELD_GET(REH_SHA_NUM_BYTES, magic) / 8;
> +	if (sha_num_bytes != REH_SHA256_SIZE &&
> +	    sha_num_bytes != REH_SHA384_SIZE)   {
> +		dev_err(sec->dev, "%s bad sha num bytes %d\n", __func__,
> +			sha_num_bytes);
> +		return -EINVAL;
> +	}
> +
> +	return sha_num_bytes;
> +}
> +
> +static int m10bmc_bmc_reh_size(struct ifpga_sec_mgr *imgr)

For naming consistency, the _reh_ vs _root_entry_hash_

pick one.

If you pick _reh_ put a comment at the top since reh isn't a familiar acronym (at least to me)

> +{
> +	return m10bmc_reh_size(imgr, BMC_PROG_MAGIC, BMC_PROG_ADDR);
> +}
> +
> +static int m10bmc_sr_reh_size(struct ifpga_sec_mgr *imgr)
> +{
> +	return m10bmc_reh_size(imgr, SR_PROG_MAGIC, SR_PROG_ADDR);
> +}
> +
> +static int m10bmc_pr_reh_size(struct ifpga_sec_mgr *imgr)
> +{
> +	return m10bmc_reh_size(imgr, PR_PROG_MAGIC, PR_PROG_ADDR);
> +}
> +
> +static int m10bmc_root_entry_hash(struct ifpga_sec_mgr *imgr,
> +				  u32 hash_addr, u8 *hash,
> +				  unsigned int size)
> +{
> +	struct m10bmc_sec *sec = imgr->priv;
> +	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
> +	int ret;
> +
> +	ret = m10bmc_raw_bulk_read(sec->m10bmc, hash_addr,
> +				   hash, size / stride);
> +	if (ret)
> +		dev_err(sec->dev, "bulk_read of 0x%x failed %d",
> +			hash_addr, ret);
> +
> +	return ret;
> +}
> +
> +static int m10bmc_bmc_root_entry_hash(struct ifpga_sec_mgr *imgr,
> +				      u8 *hash, unsigned int size)
> +{
> +	return m10bmc_root_entry_hash(imgr, BMC_REH_ADDR, hash, size);
> +}
> +
> +static int m10bmc_sr_root_entry_hash(struct ifpga_sec_mgr *imgr,
> +				     u8 *hash, unsigned int size)
> +{
> +	return m10bmc_root_entry_hash(imgr, SR_REH_ADDR, hash, size);
> +}
> +
> +static int m10bmc_pr_root_entry_hash(struct ifpga_sec_mgr *imgr,
> +				     u8 *hash, unsigned int size)
> +{
> +	return m10bmc_root_entry_hash(imgr, PR_REH_ADDR, hash, size);
> +}
> +
> +static const struct ifpga_sec_mgr_ops m10bmc_iops = {
> +	.bmc_root_entry_hash = m10bmc_bmc_root_entry_hash,
> +	.sr_root_entry_hash = m10bmc_sr_root_entry_hash,
> +	.pr_root_entry_hash = m10bmc_pr_root_entry_hash,
> +	.bmc_reh_size = m10bmc_bmc_reh_size,
> +	.sr_reh_size = m10bmc_sr_reh_size,
> +	.pr_reh_size = m10bmc_pr_reh_size,
> +};
> +
> +static int m10bmc_secure_probe(struct platform_device *pdev)
> +{
> +	struct ifpga_sec_mgr *imgr;
> +	struct m10bmc_sec *sec;
> +	int ret;
> +
> +	sec = devm_kzalloc(&pdev->dev, sizeof(*sec), GFP_KERNEL);
> +	if (!sec)
> +		return -ENOMEM;
> +
> +	sec->dev = &pdev->dev;
> +	sec->m10bmc = dev_get_drvdata(pdev->dev.parent);
> +	dev_set_drvdata(&pdev->dev, sec);
> +
> +	imgr = devm_ifpga_sec_mgr_create(sec->dev, "Max10 BMC Security Manager",
> +					 &m10bmc_iops, sec);
> +	if (!imgr) {
> +		dev_err(sec->dev,
> +			"Security manager failed to start: %d\n", ret);
> +		return -ENOMEM;
> +	}
> +
> +	sec->imgr = imgr;
> +
> +	return ifpga_sec_mgr_register(imgr);
> +}
> +
> +static int m10bmc_secure_remove(struct platform_device *pdev)
> +{
> +	struct m10bmc_sec *sec = dev_get_drvdata(&pdev->dev);
> +
> +	ifpga_sec_mgr_unregister(sec->imgr);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver intel_m10bmc_secure_driver = {
> +	.probe = m10bmc_secure_probe,
> +	.remove = m10bmc_secure_remove,
> +	.driver = {
> +		.name = "n3000bmc-secure",
> +	},
> +};
> +module_platform_driver(intel_m10bmc_secure_driver);
> +
> +MODULE_ALIAS("platform:n3000bmc-secure");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_DESCRIPTION("Intel MAX10 BMC secure engine");

Maybe "... secure update"

Tom

> +MODULE_LICENSE("GPL v2");

