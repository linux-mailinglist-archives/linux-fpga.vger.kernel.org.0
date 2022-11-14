Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D50628AA1
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Nov 2022 21:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbiKNUjq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Nov 2022 15:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiKNUjp (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Nov 2022 15:39:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EED12088
        for <linux-fpga@vger.kernel.org>; Mon, 14 Nov 2022 12:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668458325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0OQWHZw8LMfmyJBuEDJiFMxXV5B/S8yL66XbBPjsnCU=;
        b=aXqftR0CPoJAk9jVAja4EviIq/zEs9rlHubGJLvZk5LDdUuW4Ku3ykLmuaNPaA6crrUuK8
        AQXoDRtEqlttFwmmVoVe0CvySQxagHjfeHeOTMc7CoYG/0W7x9WUNahPUq1WjU+vMM1UJR
        WMskyIbIa16lYSNE3ih8kNmzO2Od4eU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-588-OVe2CymUOE24u9p5mkOzAw-1; Mon, 14 Nov 2022 15:38:44 -0500
X-MC-Unique: OVe2CymUOE24u9p5mkOzAw-1
Received: by mail-qk1-f197.google.com with SMTP id az31-20020a05620a171f00b006fa2cc1b0bfso12043944qkb.23
        for <linux-fpga@vger.kernel.org>; Mon, 14 Nov 2022 12:38:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0OQWHZw8LMfmyJBuEDJiFMxXV5B/S8yL66XbBPjsnCU=;
        b=T10NfHWkGKxRTQsurSvzFIDxp/QshVLnGVBzREOqC1UsD2wggQkKHyknX8tqtKGjtj
         tb0DBjTV8HTbhZ7B89akdDGo9qHXd4TjVG8PawbEPXlJZ5acBvHVOiK7H2js0sWcB3LR
         ohfdTiE++A94KPMkY2XngwUCK1E4n+N/nQT8s/0kkNvSNNOLILqJujzlWDb699dtRopO
         MR0AvsS7/QAd1NOKkUmk+joFowMgn7ziRRYl2/JBQTvjwNhogulV3Aykd2ObmX0hlZ8z
         bHdsO38kllFxW8L/S2H3SkSAsJFvH1hgNW/A7zpnz6em3ngOET7Byi2B/J2yNiYV/y+w
         OWDw==
X-Gm-Message-State: ANoB5pn3Ymj1rUk3RVG8L4C2E08ifue4QEO6+EhC5SCh/6OTbwILZovp
        cQy3ROH52UahKACXpKR0JSWZshSUFJ3b+RK7J70fgEOohF47NFrtv8vtTyQVbvCp4dS4oYgwPt6
        33XD38hR9lFXJFT450Efe
X-Received: by 2002:a05:620a:1337:b0:6fa:4a82:1146 with SMTP id p23-20020a05620a133700b006fa4a821146mr12747150qkj.303.1668458323914;
        Mon, 14 Nov 2022 12:38:43 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5KY2iWfQcNV7QAHDKw9pcZBDTWSuI9CQVxnDkOlA7aSXLSf69aor6x8ooiIphk5FAm4cb6KA==
X-Received: by 2002:a05:620a:1337:b0:6fa:4a82:1146 with SMTP id p23-20020a05620a133700b006fa4a821146mr12747128qkj.303.1668458323664;
        Mon, 14 Nov 2022 12:38:43 -0800 (PST)
Received: from [192.168.9.16] (net-2-34-31-29.cust.vodafonedsl.it. [2.34.31.29])
        by smtp.gmail.com with ESMTPSA id bs13-20020a05620a470d00b006b61b2cb1d2sm7182498qkb.46.2022.11.14.12.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 12:38:43 -0800 (PST)
Message-ID: <18756dcd-81c3-494d-d9c2-3494577e3f1e@redhat.com>
Date:   Mon, 14 Nov 2022 21:38:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 08/12] regmap: indirect: Add indirect regmap support
Content-Language: en-US
To:     ilpo.jarvinen@linux.intel.com
References: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com>
 <20221108144305.45424-9-ilpo.jarvinen@linux.intel.com>
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org, hao.wu@intel.com,
        lee@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew.gerlach@linux.intel.com,
        mdf@kernel.org, rafael@kernel.org, russell.h.weight@intel.com,
        tianfei.zhang@intel.com, trix@redhat.com, yilun.xu@intel.com
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <20221108144305.45424-9-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2022-11-08 15:43, Ilpo Järvinen wrote:
> Add support for indirect register access via a regmap interface.
> 
> Indirect register access is a generic way to access registers directly.
> One use case is accessing registers on Intel FPGA IPs with e.g. PMCI or
> HSSI.
> 
> Co-developed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/base/regmap/Kconfig           |   3 +
>  drivers/base/regmap/Makefile          |   1 +
>  drivers/base/regmap/regmap-indirect.c | 128 ++++++++++++++++++++++++++
>  include/linux/regmap.h                |  55 +++++++++++
>  4 files changed, 187 insertions(+)
>  create mode 100644 drivers/base/regmap/regmap-indirect.c
> 
> diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
> index 159bac6c5046..94e5ca5434cf 100644
> --- a/drivers/base/regmap/Kconfig
> +++ b/drivers/base/regmap/Kconfig
> @@ -65,3 +65,6 @@ config REGMAP_I3C
>  config REGMAP_SPI_AVMM
>  	tristate
>  	depends on SPI
> +
> +config REGMAP_INDIRECT
> +	tristate
> diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
> index 11facb32a027..6221a4740806 100644
> --- a/drivers/base/regmap/Makefile
> +++ b/drivers/base/regmap/Makefile
> @@ -20,3 +20,4 @@ obj-$(CONFIG_REGMAP_SCCB) += regmap-sccb.o
>  obj-$(CONFIG_REGMAP_I3C) += regmap-i3c.o
>  obj-$(CONFIG_REGMAP_SPI_AVMM) += regmap-spi-avmm.o
>  obj-$(CONFIG_REGMAP_MDIO) += regmap-mdio.o
> +obj-$(CONFIG_REGMAP_INDIRECT) += regmap-indirect.o
> diff --git a/drivers/base/regmap/regmap-indirect.c b/drivers/base/regmap/regmap-indirect.c
> new file mode 100644
> index 000000000000..3ceb0c044c7c
> --- /dev/null
> +++ b/drivers/base/regmap/regmap-indirect.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Indirect Register Access.
> + *
> + * Copyright (C) 2020-2022 Intel Corporation, Inc.
> + */
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/seq_file.h>
> +#include <linux/slab.h>
> +
> +struct indirect_ctx {
> +	void __iomem *base;
> +	struct device *dev;
> +	const struct regmap_indirect_cfg *indirect_cfg;
> +};
> +
> +static int indirect_bus_idle_cmd(struct indirect_ctx *ctx)
> +{
> +	unsigned int cmd;
> +	int ret;
> +
> +	writel(ctx->indirect_cfg->idle_cmd, ctx->base + ctx->indirect_cfg->cmd_offset);
> +
> +	ret = readl_poll_timeout(ctx->base + ctx->indirect_cfg->cmd_offset, cmd,
> +				 cmd == ctx->indirect_cfg->idle_cmd,
> +				 ctx->indirect_cfg->sleep_us, ctx->indirect_cfg->timeout_us);
> +	if (ret)
> +		dev_err(ctx->dev, "timed out waiting idle cmd (residual cmd=0x%x)\n", cmd);
> +
> +	return ret;
> +}
> +
> +static int indirect_bus_reg_read(void *context, unsigned int reg,
> +				     unsigned int *val)
> +{
> +	struct indirect_ctx *ctx = context;
> +	unsigned int cmd, ack, tmpval;
> +	int ret;
> +
> +	cmd = readl(ctx->base + ctx->indirect_cfg->cmd_offset);
> +	if (cmd != ctx->indirect_cfg->idle_cmd)
> +		dev_warn(ctx->dev, "residual cmd 0x%x on read entry\n", cmd);
> +
> +	writel(reg, ctx->base + ctx->indirect_cfg->addr_offset);
> +	writel(ctx->indirect_cfg->read_cmd, ctx->base + ctx->indirect_cfg->cmd_offset);
> +
> +	ret = readl_poll_timeout(ctx->base + ctx->indirect_cfg->ack_offset, ack,
> +				 (ack & ctx->indirect_cfg->ack_mask) == ctx->indirect_cfg->ack_mask,
> +				 ctx->indirect_cfg->sleep_us, ctx->indirect_cfg->timeout_us);
> +	if (ret) {
> +		dev_err(ctx->dev, "read timed out on reg 0x%x ack 0x%x\n", reg, ack);
> +		goto out;
> +	}
> +
> +	tmpval = readl(ctx->base + ctx->indirect_cfg->read_offset);
> +
> +	if (indirect_bus_idle_cmd(ctx)) {
> +		if (!ret)

Could you please explain why it is necessary to insert an idle_cmd after each
bus read or write? Do the bus read and write methods assume there will be an 
idle_cmd in the cmd register at initialization? Is this assumption safe if the
device detaches and reattaches? Isn't the "if (!ret)" check redundant since
ret is always == 0?

> +			ret = -ETIMEDOUT;
> +		goto out;
> +	}
> +
> +	*val = tmpval;
> +out:
> +	return ret;
> +}
> +
> +static int indirect_bus_reg_write(void *context, unsigned int reg,
> +				      unsigned int val)
> +{
> +	struct indirect_ctx *ctx = context;
> +	unsigned int cmd, ack;
> +	int ret;
> +
> +	cmd = readl(ctx->base + ctx->indirect_cfg->cmd_offset);
> +	if (cmd != ctx->indirect_cfg->idle_cmd)
> +		dev_warn(ctx->dev, "residual cmd 0x%x on write entry\n", cmd);
> +
> +	writel(val, ctx->base + ctx->indirect_cfg->write_offset);
> +	writel(reg, ctx->base + ctx->indirect_cfg->addr_offset);
> +	writel(ctx->indirect_cfg->write_cmd, ctx->base + ctx->indirect_cfg->cmd_offset);
> +
> +	ret = readl_poll_timeout(ctx->base + ctx->indirect_cfg->ack_offset, ack,
> +				 (ack & ctx->indirect_cfg->ack_mask) == ctx->indirect_cfg->ack_mask,
> +				 ctx->indirect_cfg->sleep_us, ctx->indirect_cfg->timeout_us);
> +	if (ret)
> +		dev_err(ctx->dev, "write timed out on reg 0x%x ack 0x%x\n", reg, ack);
> +
> +	if (indirect_bus_idle_cmd(ctx)) {
> +		if (!ret)
> +			ret = -ETIMEDOUT;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct regmap_bus indirect_bus = {
> +	.reg_write = indirect_bus_reg_write,
> +	.reg_read =  indirect_bus_reg_read,
> +};
> +
> +struct regmap *__devm_regmap_init_indirect(struct device *dev,
> +					   void __iomem *base,
> +					   struct regmap_config *cfg,
> +					   struct lock_class_key *lock_key,
> +					   const char *lock_name)
> +{
> +	struct indirect_ctx *ctx;
> +
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return NULL;
> +
> +	ctx->base = base;
> +	ctx->dev = dev;
> +	ctx->indirect_cfg = cfg->indirect_cfg;
> +
> +	return __devm_regmap_init(dev, &indirect_bus, ctx, cfg, lock_key, lock_name);
> +}
> +EXPORT_SYMBOL_GPL(__devm_regmap_init_indirect);
> +
> +MODULE_DESCRIPTION("Indirect Register Access");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index ca3434dca3a0..adaa7bca4f60 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -190,6 +190,41 @@ enum regmap_endian {
>  	REGMAP_ENDIAN_NATIVE,
>  };
>  
> +/**
> + * struct regmap_indirect_cfg - A configuration for indirect register access
> + *
> + * @cmd_offset: Command register offset
> + * @idle_cmd: Idle command
> + * @read_cmd: Read command
> + * @write_cmd: Write command
> + *
> + * @ack_offset: Command acknowledgment register offset
> + * @ack_mask: Command acknowledgment bit mask
> + *
> + * @addr_offset: Address register offset
> + * @read_offset: Read register offset
> + * @write_offset: Write register offset
> + *
> + * @sleep_us: Command wait sleep (usecs)
> + * @timeout_us: Command timeout (usecs)
> + */
> +struct regmap_indirect_cfg {
> +	unsigned int cmd_offset;
> +	u32 idle_cmd;
> +	u32 read_cmd;
> +	u32 write_cmd;
> +
> +	unsigned int ack_offset;
> +	u32 ack_mask;
> +
> +	unsigned int addr_offset;
> +	unsigned int read_offset;
> +	unsigned int write_offset;
> +
> +	unsigned long sleep_us;
> +	unsigned long timeout_us;
> +};
> +
>  /**
>   * struct regmap_range - A register range, used for access related checks
>   *                       (readable/writeable/volatile/precious checks)
> @@ -431,6 +466,8 @@ struct regmap_config {
>  	const struct regmap_range_cfg *ranges;
>  	unsigned int num_ranges;
>  
> +	const struct regmap_indirect_cfg *indirect_cfg;
> +
>  	bool use_hwlock;
>  	bool use_raw_spinlock;
>  	unsigned int hwlock_id;
> @@ -693,6 +730,12 @@ struct regmap *__devm_regmap_init_spi_avmm(struct spi_device *spi,
>  					   const struct regmap_config *config,
>  					   struct lock_class_key *lock_key,
>  					   const char *lock_name);
> +struct regmap *__devm_regmap_init_indirect(struct device *dev,
> +					   void __iomem *base,
> +					   struct regmap_config *cfg,
> +					   struct lock_class_key *lock_key,
> +					   const char *lock_name);
> +
>  /*
>   * Wrapper for regmap_init macros to include a unique lockdep key and name
>   * for each call. No-op if CONFIG_LOCKDEP is not set.
> @@ -1148,6 +1191,18 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
>  	__regmap_lockdep_wrapper(__devm_regmap_init_spi_avmm, #config,	\
>  				 spi, config)
>  
> +/**
> + * devm_regmap_init_indirect - create a regmap for indirect register access
> + * @dev: device creating the regmap
> + * @base: __iomem point to base of memory with mailbox
> + * @cfg: regmap_config describing interface
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +#define devm_regmap_init_indirect(dev, base, config)			\
> +	__regmap_lockdep_wrapper(__devm_regmap_init_indirect, #config,	\
> +				 dev, base, config)
> +
>  int regmap_mmio_attach_clk(struct regmap *map, struct clk *clk);
>  void regmap_mmio_detach_clk(struct regmap *map);
>  void regmap_exit(struct regmap *map);

Thanks,
Marco


