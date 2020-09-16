Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A617926CBBC
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Sep 2020 22:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgIPUdZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 16 Sep 2020 16:33:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40448 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgIPUdX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 16 Sep 2020 16:33:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id bd2so3820413plb.7;
        Wed, 16 Sep 2020 13:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=feeVN+aSKvuGTRtLaOM7DjouZnPrXC98D/Ru25A5UZE=;
        b=Byrg8PBPvwstvzjwjtjseONqLyaMKa2iLbNILy6OO1Zw9MS+m68yTJJD/F9KbPfxWw
         dkOVQQmSYOyHCbUf4z1UY8IQAn8gpVDDQBGqkDOq+Mv6xeVxZ+i+zt13pyBvsbb9mYIY
         RpfhQ8ICbHXdhR2YdgQKmkl0wKstQuaiqfpeZHx4vD19tEZJ6m+0W/j7rHUI1IqQ7/Gv
         gC2ni7iZbhgeypknAF2Up5QgAgIeaW5nd3STUnd3BeoX8mty7PqZOsXqmnZExA/Nv//4
         Yk3q2cgD6OgiU2E+DbmZZwJ3R1ZZge3xm8qG+7gfCS+Zd+gQR+Uvqf3pkGfR43CV0BmA
         1Rig==
X-Gm-Message-State: AOAM530W1vJe3in32XVBhMZirz+wZEDdxM9w9T7xJRny9/f30DtjIoP7
        0+mhGkAlClGlFrzTRfgbgkw=
X-Google-Smtp-Source: ABdhPJyOu3gx0fhseElQQ1BOoXzqqggGK6iHrMPrtmxX2qqd9dbxTtlzj/va6q0FGcb/tZC6r++5QQ==
X-Received: by 2002:a17:902:326:b029:d1:e5e7:be04 with SMTP id 35-20020a1709020326b02900d1e5e7be04mr8020680pld.55.1600288402291;
        Wed, 16 Sep 2020 13:33:22 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id o23sm15352751pgm.18.2020.09.16.13.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 13:33:21 -0700 (PDT)
Date:   Wed, 16 Sep 2020 13:33:20 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v1 02/12] fpga: create intel max10 bmc security engine
Message-ID: <20200916203320.GB1076460@epycbox.lan>
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-3-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904235305.6254-3-russell.h.weight@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Russ,

On Fri, Sep 04, 2020 at 04:52:55PM -0700, Russ Weight wrote:
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
> Reviewed-by: Wu Hao <hao.wu@intel.com>
> ---
>  drivers/fpga/Kconfig                |  11 ++
>  drivers/fpga/Makefile               |   3 +
>  drivers/fpga/intel-m10-bmc-secure.c | 170 ++++++++++++++++++++++++++++
>  include/linux/mfd/intel-m10-bmc.h   |  15 +++
>  4 files changed, 199 insertions(+)
>  create mode 100644 drivers/fpga/intel-m10-bmc-secure.c
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 97c0a6cc2ba7..0f0bed68e618 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -244,4 +244,15 @@ config IFPGA_SEC_MGR
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
> index ec9fbacdedd8..451a23ec3168 100644
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
> index 000000000000..1f86bfb694b4
> --- /dev/null
> +++ b/drivers/fpga/intel-m10-bmc-secure.c
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel Max10 Board Management Controller Security Engine Driver
> + *
> + * Copyright (C) 2019-2020 Intel Corporation. All rights reserved.
> + *
> + */
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
> +#define SHA256_REH_SIZE		32
> +#define SHA384_REH_SIZE		48
> +
> +static int get_reh_size(struct ifpga_sec_mgr *imgr,
> +			u32 exp_magic, u32 prog_addr)
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
> +	if ((magic & 0xffff) != exp_magic)
Consider using GENMASK() here.
> +		return 0;
> +
> +	sha_num_bytes = ((magic >> 16) & 0xffff) / 8;
And here.
> +
> +	if (sha_num_bytes != SHA256_REH_SIZE &&
> +	    sha_num_bytes != SHA384_REH_SIZE)   {
> +		dev_err(sec->dev, "%s bad sha num bytes %d\n", __func__,
> +			sha_num_bytes);
> +		return -EINVAL;
> +	}
> +
> +	return sha_num_bytes;
> +}
> +
> +#define BMC_REH_ADDR 0x17ffc004
> +#define BMC_PROG_ADDR 0x17ffc000
> +#define BMC_PROG_MAGIC 0x5746
> +
> +#define SR_REH_ADDR 0x17ffd004
> +#define SR_PROG_ADDR 0x17ffd000
> +#define SR_PROG_MAGIC 0x5253
> +
> +#define PR_REH_ADDR 0x17ffe004
> +#define PR_PROG_ADDR 0x17ffe000
> +#define PR_PROG_MAGIC 0x5250
> +
> +#define SYSFS_GET_REH_SIZE(_name, _exp_magic, _prog_addr) \
> +static int get_##_name##_reh_size(struct ifpga_sec_mgr *imgr) \
> +{ \
> +	return get_reh_size(imgr, _exp_magic, _prog_addr); \
> +}
> +
> +SYSFS_GET_REH_SIZE(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR)
> +SYSFS_GET_REH_SIZE(sr, SR_PROG_MAGIC, SR_PROG_ADDR)
> +SYSFS_GET_REH_SIZE(pr, PR_PROG_MAGIC, PR_PROG_ADDR)
> +
> +static int get_root_entry_hash(struct ifpga_sec_mgr *imgr,
> +			       u32 hash_addr, u8 *hash,
> +			       unsigned int size)
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
> +#define SYSFS_GET_REH(_name, _hash_addr) \
> +static int get_##_name##_root_entry_hash(struct ifpga_sec_mgr *imgr, \
> +					 u8 *hash, unsigned int size) \
> +{ \
> +	return get_root_entry_hash(imgr, _hash_addr, hash, size); \
> +}
> +
> +SYSFS_GET_REH(bmc, BMC_REH_ADDR)
> +SYSFS_GET_REH(sr, SR_REH_ADDR)
> +SYSFS_GET_REH(pr, PR_REH_ADDR)

Tbh, I'd drop the macro and just have the functions as one liners,
and yes, please add the prefix.
> +
> +static const struct ifpga_sec_mgr_ops m10bmc_iops = {
> +	.bmc_root_entry_hash = get_bmc_root_entry_hash,
> +	.sr_root_entry_hash = get_sr_root_entry_hash,
> +	.pr_root_entry_hash = get_pr_root_entry_hash,
> +	.bmc_reh_size = get_bmc_reh_size,
> +	.sr_reh_size = get_sr_reh_size,
> +	.pr_reh_size = get_pr_reh_size,
> +};
> +
> +static void ifpga_sec_mgr_uinit(struct m10bmc_sec *sec)
> +{
> +	ifpga_sec_mgr_unregister(sec->imgr);
> +}
Consider dropping this function (see below).
> +
> +static int ifpga_sec_mgr_init(struct m10bmc_sec *sec)
> +{
> +	struct ifpga_sec_mgr *imgr;
> +
> +	imgr = ifpga_sec_mgr_register(sec->dev, "Max10 BMC Security Manager",
> +				      &m10bmc_iops, sec);
> +	if (IS_ERR(imgr))
> +		return PTR_ERR(imgr);
> +
> +	sec->imgr = imgr;
> +	return 0;
> +}
> +
> +static int m10bmc_secure_probe(struct platform_device *pdev)
> +{
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

If you implement the devm_ versions then this could be:

	imgr = devm_ifpga_sec_mgr_create(&pdev->dev, "Max10 BMC Security
					Manager", &m10bmc_ips, sec);
	if (IS_ERR(imgr))
		return PTR_ERR(imgr);
	sec->imgr = imgr;

	return ifpga_sec_mgr_register(imgr);

> +
> +	ret = ifpga_sec_mgr_init(sec);
> +	if (ret)
> +		dev_err(&pdev->dev,
> +			"Security manager failed to start: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int m10bmc_secure_remove(struct platform_device *pdev)
> +{
> +	struct m10bmc_sec *sec = dev_get_drvdata(&pdev->dev);
> +
> +	ifpga_sec_mgr_uinit(sec);

If you drop the above:
	ifpga_sec_mgr_remove(sec->imgr);
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
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index d4cb01b73357..7fe465c320c2 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -63,6 +63,7 @@ struct intel_m10bmc {
>   * register access helper functions.
>   *
>   * m10bmc_raw_read - read m10bmc register per addr
> + * m10bmc_raw_bulk_read - bulk_read max10 registers per addr
>   * m10bmc_sys_read - read m10bmc system register per offset
>   */
>  static inline int
> @@ -79,6 +80,20 @@ m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
>  	return ret;
>  }
>  
> +static inline int
> +m10bmc_raw_bulk_read(struct intel_m10bmc *m10bmc, unsigned int addr,
> +		     void *val, size_t cnt)
> +{
> +	int ret;
> +
> +	ret = regmap_bulk_read(m10bmc->regmap, addr, val, cnt);
> +	if (ret)
> +		dev_err(m10bmc->dev, "fail to read raw reg %x cnt %zx: %d\n",
> +			addr, cnt, ret);
> +
> +	return ret;
> +}
> +
>  #define m10bmc_sys_read(m10bmc, offset, val) \
>  	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)
>  
> -- 
> 2.17.1
> 

Thanks,
Moritz
