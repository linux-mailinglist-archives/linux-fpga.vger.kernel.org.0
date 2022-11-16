Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B3262C5B3
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Nov 2022 18:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbiKPRAa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 16 Nov 2022 12:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbiKPRAX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 16 Nov 2022 12:00:23 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42F32714A;
        Wed, 16 Nov 2022 09:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668618006; x=1700154006;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CudIIedN6FCwytt23gmpCKUPk3EgmSM7rkttUHir3IM=;
  b=OGgZxwcQcPiEcXO4VwPnoH0/NW6j0Ap22l1PGDE2RAWwjBu+E9eOYduL
   ub4wAc6LRyv/RXscuRAqEP1Qa/wnZld7hmoagfLdYPHVkshSN4LnVCSjm
   0mf3gY2zbxkn52qbfBsl415HxBA6sNJcOkIeFQWHUCrK3vvalNQAAvHOK
   w7xnphEMFpWoTKUKld+YX6ismnsKZYWW+vsGlDj0jXOMAIRNnSqgTosLQ
   iKR5411aqQZ+2Ovw0Ta8wZeruXHWVlqbc/H7WAuD49nqYp4QJ4AbqJXUL
   C6qmUXMxn2K0HU9BrahHE37ciUx+y/qR1/G571P3m0Ds+KwOLvjwAPKVP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="300127259"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="300127259"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 09:00:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="590258772"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="590258772"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 09:00:05 -0800
Date:   Wed, 16 Nov 2022 09:00:27 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Marco Pagani <marpagan@redhat.com>
cc:     ilpo.jarvinen@linux.intel.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, hao.wu@intel.com, lee@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, rafael@kernel.org, russell.h.weight@intel.com,
        tianfei.zhang@intel.com, trix@redhat.com, yilun.xu@intel.com
Subject: Re: [PATCH 08/12] regmap: indirect: Add indirect regmap support
In-Reply-To: <18756dcd-81c3-494d-d9c2-3494577e3f1e@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2211160855460.4079830@rhweight-WRK1>
References: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com> <20221108144305.45424-9-ilpo.jarvinen@linux.intel.com> <18756dcd-81c3-494d-d9c2-3494577e3f1e@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1645248391-1668618032=:4079830"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1645248391-1668618032=:4079830
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT



On Mon, 14 Nov 2022, Marco Pagani wrote:

>
> On 2022-11-08 15:43, Ilpo Järvinen wrote:
>> Add support for indirect register access via a regmap interface.
>>
>> Indirect register access is a generic way to access registers directly.
>> One use case is accessing registers on Intel FPGA IPs with e.g. PMCI or
>> HSSI.
>>
>> Co-developed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> ---
>>  drivers/base/regmap/Kconfig           |   3 +
>>  drivers/base/regmap/Makefile          |   1 +
>>  drivers/base/regmap/regmap-indirect.c | 128 ++++++++++++++++++++++++++
>>  include/linux/regmap.h                |  55 +++++++++++
>>  4 files changed, 187 insertions(+)
>>  create mode 100644 drivers/base/regmap/regmap-indirect.c
>>
>> diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
>> index 159bac6c5046..94e5ca5434cf 100644
>> --- a/drivers/base/regmap/Kconfig
>> +++ b/drivers/base/regmap/Kconfig
>> @@ -65,3 +65,6 @@ config REGMAP_I3C
>>  config REGMAP_SPI_AVMM
>>  	tristate
>>  	depends on SPI
>> +
>> +config REGMAP_INDIRECT
>> +	tristate
>> diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
>> index 11facb32a027..6221a4740806 100644
>> --- a/drivers/base/regmap/Makefile
>> +++ b/drivers/base/regmap/Makefile
>> @@ -20,3 +20,4 @@ obj-$(CONFIG_REGMAP_SCCB) += regmap-sccb.o
>>  obj-$(CONFIG_REGMAP_I3C) += regmap-i3c.o
>>  obj-$(CONFIG_REGMAP_SPI_AVMM) += regmap-spi-avmm.o
>>  obj-$(CONFIG_REGMAP_MDIO) += regmap-mdio.o
>> +obj-$(CONFIG_REGMAP_INDIRECT) += regmap-indirect.o
>> diff --git a/drivers/base/regmap/regmap-indirect.c b/drivers/base/regmap/regmap-indirect.c
>> new file mode 100644
>> index 000000000000..3ceb0c044c7c
>> --- /dev/null
>> +++ b/drivers/base/regmap/regmap-indirect.c
>> @@ -0,0 +1,128 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Indirect Register Access.
>> + *
>> + * Copyright (C) 2020-2022 Intel Corporation, Inc.
>> + */
>> +#include <linux/debugfs.h>
>> +#include <linux/device.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/regmap.h>
>> +#include <linux/seq_file.h>
>> +#include <linux/slab.h>
>> +
>> +struct indirect_ctx {
>> +	void __iomem *base;
>> +	struct device *dev;
>> +	const struct regmap_indirect_cfg *indirect_cfg;
>> +};
>> +
>> +static int indirect_bus_idle_cmd(struct indirect_ctx *ctx)
>> +{
>> +	unsigned int cmd;
>> +	int ret;
>> +
>> +	writel(ctx->indirect_cfg->idle_cmd, ctx->base + ctx->indirect_cfg->cmd_offset);
>> +
>> +	ret = readl_poll_timeout(ctx->base + ctx->indirect_cfg->cmd_offset, cmd,
>> +				 cmd == ctx->indirect_cfg->idle_cmd,
>> +				 ctx->indirect_cfg->sleep_us, ctx->indirect_cfg->timeout_us);
>> +	if (ret)
>> +		dev_err(ctx->dev, "timed out waiting idle cmd (residual cmd=0x%x)\n", cmd);
>> +
>> +	return ret;
>> +}
>> +
>> +static int indirect_bus_reg_read(void *context, unsigned int reg,
>> +				     unsigned int *val)
>> +{
>> +	struct indirect_ctx *ctx = context;
>> +	unsigned int cmd, ack, tmpval;
>> +	int ret;
>> +
>> +	cmd = readl(ctx->base + ctx->indirect_cfg->cmd_offset);
>> +	if (cmd != ctx->indirect_cfg->idle_cmd)
>> +		dev_warn(ctx->dev, "residual cmd 0x%x on read entry\n", cmd);
>> +
>> +	writel(reg, ctx->base + ctx->indirect_cfg->addr_offset);
>> +	writel(ctx->indirect_cfg->read_cmd, ctx->base + ctx->indirect_cfg->cmd_offset);
>> +
>> +	ret = readl_poll_timeout(ctx->base + ctx->indirect_cfg->ack_offset, ack,
>> +				 (ack & ctx->indirect_cfg->ack_mask) == ctx->indirect_cfg->ack_mask,
>> +				 ctx->indirect_cfg->sleep_us, ctx->indirect_cfg->timeout_us);
>> +	if (ret) {
>> +		dev_err(ctx->dev, "read timed out on reg 0x%x ack 0x%x\n", reg, ack);
>> +		goto out;

This goto needs to be removed.  The code needs to fall throuch and call 
indirect_bus_idle_cmd().

>> +	}
>> +
>> +	tmpval = readl(ctx->base + ctx->indirect_cfg->read_offset);
>> +
>> +	if (indirect_bus_idle_cmd(ctx)) {
>> +		if (!ret)
>
> Could you please explain why it is necessary to insert an idle_cmd after each
> bus read or write? Do the bus read and write methods assume there will be an
> idle_cmd in the cmd register at initialization? Is this assumption safe if the
> device detaches and reattaches? Isn't the "if (!ret)" check redundant since
> ret is always == 0?

The idle_cmd ensures the RD or WR bits and the ACK bits are cleared before 
the next transaction. The if (!ret) doesn't override the error returned by 
readl_poll_timeout.

>
>> +			ret = -ETIMEDOUT;
>> +		goto out;
>> +	}
>> +
>> +	*val = tmpval;
>> +out:
>> +	return ret;
>> +}
>> +
>> +static int indirect_bus_reg_write(void *context, unsigned int reg,
>> +				      unsigned int val)
>> +{
>> +	struct indirect_ctx *ctx = context;
>> +	unsigned int cmd, ack;
>> +	int ret;
>> +
>> +	cmd = readl(ctx->base + ctx->indirect_cfg->cmd_offset);
>> +	if (cmd != ctx->indirect_cfg->idle_cmd)
>> +		dev_warn(ctx->dev, "residual cmd 0x%x on write entry\n", cmd);
>> +
>> +	writel(val, ctx->base + ctx->indirect_cfg->write_offset);
>> +	writel(reg, ctx->base + ctx->indirect_cfg->addr_offset);
>> +	writel(ctx->indirect_cfg->write_cmd, ctx->base + ctx->indirect_cfg->cmd_offset);
>> +
>> +	ret = readl_poll_timeout(ctx->base + ctx->indirect_cfg->ack_offset, ack,
>> +				 (ack & ctx->indirect_cfg->ack_mask) == ctx->indirect_cfg->ack_mask,
>> +				 ctx->indirect_cfg->sleep_us, ctx->indirect_cfg->timeout_us);
>> +	if (ret)
>> +		dev_err(ctx->dev, "write timed out on reg 0x%x ack 0x%x\n", reg, ack);
>> +
>> +	if (indirect_bus_idle_cmd(ctx)) {
>> +		if (!ret)
>> +			ret = -ETIMEDOUT;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct regmap_bus indirect_bus = {
>> +	.reg_write = indirect_bus_reg_write,
>> +	.reg_read =  indirect_bus_reg_read,
>> +};
>> +
>> +struct regmap *__devm_regmap_init_indirect(struct device *dev,
>> +					   void __iomem *base,
>> +					   struct regmap_config *cfg,
>> +					   struct lock_class_key *lock_key,
>> +					   const char *lock_name)
>> +{
>> +	struct indirect_ctx *ctx;
>> +
>> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
>> +	if (!ctx)
>> +		return NULL;
>> +
>> +	ctx->base = base;
>> +	ctx->dev = dev;
>> +	ctx->indirect_cfg = cfg->indirect_cfg;
>> +
>> +	return __devm_regmap_init(dev, &indirect_bus, ctx, cfg, lock_key, lock_name);
>> +}
>> +EXPORT_SYMBOL_GPL(__devm_regmap_init_indirect);
>> +
>> +MODULE_DESCRIPTION("Indirect Register Access");
>> +MODULE_AUTHOR("Intel Corporation");
>> +MODULE_LICENSE("GPL");
>> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
>> index ca3434dca3a0..adaa7bca4f60 100644
>> --- a/include/linux/regmap.h
>> +++ b/include/linux/regmap.h
>> @@ -190,6 +190,41 @@ enum regmap_endian {
>>  	REGMAP_ENDIAN_NATIVE,
>>  };
>>
>> +/**
>> + * struct regmap_indirect_cfg - A configuration for indirect register access
>> + *
>> + * @cmd_offset: Command register offset
>> + * @idle_cmd: Idle command
>> + * @read_cmd: Read command
>> + * @write_cmd: Write command
>> + *
>> + * @ack_offset: Command acknowledgment register offset
>> + * @ack_mask: Command acknowledgment bit mask
>> + *
>> + * @addr_offset: Address register offset
>> + * @read_offset: Read register offset
>> + * @write_offset: Write register offset
>> + *
>> + * @sleep_us: Command wait sleep (usecs)
>> + * @timeout_us: Command timeout (usecs)
>> + */
>> +struct regmap_indirect_cfg {
>> +	unsigned int cmd_offset;
>> +	u32 idle_cmd;
>> +	u32 read_cmd;
>> +	u32 write_cmd;
>> +
>> +	unsigned int ack_offset;
>> +	u32 ack_mask;
>> +
>> +	unsigned int addr_offset;
>> +	unsigned int read_offset;
>> +	unsigned int write_offset;
>> +
>> +	unsigned long sleep_us;
>> +	unsigned long timeout_us;
>> +};
>> +
>>  /**
>>   * struct regmap_range - A register range, used for access related checks
>>   *                       (readable/writeable/volatile/precious checks)
>> @@ -431,6 +466,8 @@ struct regmap_config {
>>  	const struct regmap_range_cfg *ranges;
>>  	unsigned int num_ranges;
>>
>> +	const struct regmap_indirect_cfg *indirect_cfg;
>> +
>>  	bool use_hwlock;
>>  	bool use_raw_spinlock;
>>  	unsigned int hwlock_id;
>> @@ -693,6 +730,12 @@ struct regmap *__devm_regmap_init_spi_avmm(struct spi_device *spi,
>>  					   const struct regmap_config *config,
>>  					   struct lock_class_key *lock_key,
>>  					   const char *lock_name);
>> +struct regmap *__devm_regmap_init_indirect(struct device *dev,
>> +					   void __iomem *base,
>> +					   struct regmap_config *cfg,
>> +					   struct lock_class_key *lock_key,
>> +					   const char *lock_name);
>> +
>>  /*
>>   * Wrapper for regmap_init macros to include a unique lockdep key and name
>>   * for each call. No-op if CONFIG_LOCKDEP is not set.
>> @@ -1148,6 +1191,18 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
>>  	__regmap_lockdep_wrapper(__devm_regmap_init_spi_avmm, #config,	\
>>  				 spi, config)
>>
>> +/**
>> + * devm_regmap_init_indirect - create a regmap for indirect register access
>> + * @dev: device creating the regmap
>> + * @base: __iomem point to base of memory with mailbox
>> + * @cfg: regmap_config describing interface
>> + *
>> + * Return: 0 on success, negative error code otherwise.
>> + */
>> +#define devm_regmap_init_indirect(dev, base, config)			\
>> +	__regmap_lockdep_wrapper(__devm_regmap_init_indirect, #config,	\
>> +				 dev, base, config)
>> +
>>  int regmap_mmio_attach_clk(struct regmap *map, struct clk *clk);
>>  void regmap_mmio_detach_clk(struct regmap *map);
>>  void regmap_exit(struct regmap *map);
>
> Thanks,
> Marco
>
>
>
--8323328-1645248391-1668618032=:4079830--
