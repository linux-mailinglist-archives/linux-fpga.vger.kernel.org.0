Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC5D3BDEF1
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Jul 2021 23:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhGFVhF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Jul 2021 17:37:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48424 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229935AbhGFVhF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Jul 2021 17:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625607266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hy6kcB3MWGmQBDSvkn9YWzp9imXowxOywbrwsmGu+rk=;
        b=VVXAmZTlfEOKWezrBMnzAet0EUsKVHPyFlKbLG622ssDVLjrm54/SMET55xSzmV6/1SKQm
        9bPCYbAOlM4BabBfgPd5uF37g+ww+it2/jsEUzxc14piIleN2kMr5581MexLzRw0JPpde0
        baKIyzwJn/ztMDFpG2uw+MJYaE2Hqp0=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-MV6Qo3g0MsCNKp4CGhb-Qw-1; Tue, 06 Jul 2021 17:34:24 -0400
X-MC-Unique: MV6Qo3g0MsCNKp4CGhb-Qw-1
Received: by mail-oo1-f72.google.com with SMTP id c25-20020a4ad7990000b029020e67cc1879so11245747oou.18
        for <linux-fpga@vger.kernel.org>; Tue, 06 Jul 2021 14:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Hy6kcB3MWGmQBDSvkn9YWzp9imXowxOywbrwsmGu+rk=;
        b=IuNBfTm8vRUqDtROCnvbGz05G27SmbRTX3htNkB1Nm7ghNkSVgia+xBoMbVnjALfxK
         BQaraEl3dris4JwHWoOMlDxWIqqm2EoIiMq+mwtXfGtkHtZEDnkipBHU55MTvoP1z7Gl
         79Zg202lPojSFtJRaBltaRG10KwwdzuDW/h6PBbDt/+DGR70HdrrKV1YLHP6tXJUix+P
         Blhf0dA/efx9uifLVZbElDCEr4CAHSlnt8200NktEhR6I/voGoseNOni2cmOFihkhzI+
         iDhVQsch5TSaR+rDCkHriPYgMs/s5t2cBlW+jTTgFDTlL6pXfPG4N+TsXd7c6LysXuvK
         qOcQ==
X-Gm-Message-State: AOAM5314KiHO/89EH6R2zPmxcct0xH4hRva31yAlIXDVztVDGcgVafqf
        2IqClEt+nnR+XsQ7Al0FgujR4ZWl8u1bLS/p5grdRXhItUZBami1dPS0uA2DcDCA88u8yYHfv+/
        5OSsqT2aptVHM1LclUtaQog==
X-Received: by 2002:a05:6830:4039:: with SMTP id i25mr7708069ots.187.1625607264266;
        Tue, 06 Jul 2021 14:34:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOPGU1f+ioZoUD9Gk09GX58M3FzDXJit2VBvWEDVdm0mrij5IOIC0yKFhYZIkQYwfMFoijGw==
X-Received: by 2002:a05:6830:4039:: with SMTP id i25mr7708058ots.187.1625607264072;
        Tue, 06 Jul 2021 14:34:24 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s2sm3082387ook.24.2021.07.06.14.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 14:34:23 -0700 (PDT)
Subject: Re: [PATCH v8 5/5] fpga: versal-fpga: Add versal fpga manager driver
To:     Nava kishore Manne <nava.manne@xilinx.com>, robh+dt@kernel.org,
        michal.simek@xilinx.com, mdf@kernel.org, arnd@arndb.de,
        rajan.vaja@xilinx.com, gregkh@linuxfoundation.org,
        amit.sunil.dhamne@xilinx.com, tejas.patel@xilinx.com,
        zou_wei@huawei.com, lakshmi.sai.krishna.potthuri@xilinx.com,
        ravi.patel@xilinx.com, iwamatsu@nigauri.org,
        wendy.liang@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, git@xilinx.com,
        chinnikishore369@gmail.com
Cc:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
References: <20210626155248.5004-1-nava.manne@xilinx.com>
 <20210626155248.5004-6-nava.manne@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4429c722-52f3-2e16-3a53-910345507d3e@redhat.com>
Date:   Tue, 6 Jul 2021 14:34:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210626155248.5004-6-nava.manne@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 6/26/21 8:52 AM, Nava kishore Manne wrote:
> Add support for Xilinx Versal FPGA manager.
>
> PDI source type can be DDR, OCM, QSPI flash etc..
> But driver allocates memory always from DDR, Since driver supports only
> DDR source type.
>
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
> Changes for v2:
>                -Updated the Fpga Mgr registrations call's
>                 to 5.11
>                -Fixed some minor coding issues as suggested by
>                 Moritz.
>
> Changes for v3:
>                -Rewritten the Versal fpga Kconfig contents.
>
> Changes for v4:
>                -Rebased the changes on linux-next.
>                 No functional changes.
>
> Changes for v5:
>                -None.
>
> Changes for v6:
>                -None.
>
> Changes for v7:
>                -Updated driver to remove unwated priv struct dependency.
>
> Changes for v8:
>                -None.
>
>   drivers/fpga/Kconfig       |  9 ++++
>   drivers/fpga/Makefile      |  1 +
>   drivers/fpga/versal-fpga.c | 96 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 106 insertions(+)
>   create mode 100644 drivers/fpga/versal-fpga.c
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 8cd454ee20c0..16793bfc2bb4 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -234,4 +234,13 @@ config FPGA_MGR_ZYNQMP_FPGA
>   	  to configure the programmable logic(PL) through PS
>   	  on ZynqMP SoC.
>   
> +config FPGA_MGR_VERSAL_FPGA
> +	tristate "Xilinx Versal FPGA"
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
Shouldn't this depend on ZYNQMP_FIRMWARE ?
> +	help
> +	  Select this option to enable FPGA manager driver support for
> +	  Xilinx Versal SoC. This driver uses the firmware interface to
> +	  configure the programmable logic(PL).
> +
> +	  To compile this as a module, choose M here.
>   endif # FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 18dc9885883a..0bff783d1b61 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
>   obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
>   obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
>   obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
> +obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)      += versal-fpga.o
The other CONFIG_FPGA_MGR* configs are alphabetical, versal should follow.
>   obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
>   obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
>   
> diff --git a/drivers/fpga/versal-fpga.c b/drivers/fpga/versal-fpga.c
> new file mode 100644
> index 000000000000..1bd312a31b23
> --- /dev/null
> +++ b/drivers/fpga/versal-fpga.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019-2021 Xilinx, Inc.
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/string.h>
> +#include <linux/firmware/xlnx-zynqmp.h>
> +
> +static int versal_fpga_ops_write_init(struct fpga_manager *mgr,
> +				      struct fpga_image_info *info,
> +				      const char *buf, size_t size)
> +{
> +	return 0;
> +}
> +
These empty ops should go away with my wrappers patchset
> +static int versal_fpga_ops_write(struct fpga_manager *mgr,
> +				 const char *buf, size_t size)
> +{
> +	dma_addr_t dma_addr = 0;
> +	char *kbuf;
> +	int ret;
> +
> +	kbuf = dma_alloc_coherent(mgr->dev.parent, size, &dma_addr, GFP_KERNEL);
> +	if (!kbuf)
> +		return -ENOMEM;
> +
> +	memcpy(kbuf, buf, size);
> +	ret = zynqmp_pm_load_pdi(PDI_SRC_DDR, dma_addr);
why isn't the size passed ?
> +	dma_free_coherent(mgr->dev.parent, size, kbuf, dma_addr);
> +
> +	return ret;
> +}
> +
> +static int versal_fpga_ops_write_complete(struct fpga_manager *mgr,
> +					  struct fpga_image_info *info)
> +{
> +	return 0;
> +}
> +
> +static enum fpga_mgr_states versal_fpga_ops_state(struct fpga_manager *mgr)
> +{
> +	return FPGA_MGR_STATE_UNKNOWN;
> +}
> +
> +static const struct fpga_manager_ops versal_fpga_ops = {
> +	.state = versal_fpga_ops_state,
> +	.write_init = versal_fpga_ops_write_init,
> +	.write = versal_fpga_ops_write,
> +	.write_complete = versal_fpga_ops_write_complete,
> +};
> +
> +static int versal_fpga_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct fpga_manager *mgr;
> +	int ret;
> +
> +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +	if (ret < 0) {
> +		dev_err(dev, "no usable DMA configuration\n");
> +		return ret;
> +	}
> +
> +	mgr = devm_fpga_mgr_create(dev, "Xilinx Versal FPGA Manager",
> +				   &versal_fpga_ops, NULL);
> +	if (!mgr)
> +		return -ENOMEM;
> +
> +	return devm_fpga_mgr_register(dev, mgr);
> +}
> +
> +static const struct of_device_id versal_fpga_of_match[] = {
> +	{ .compatible = "xlnx,versal-fpga", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, versal_fpga_of_match);
needs #if defined(CONFIG_OF) wrapper
> +
> +static struct platform_driver versal_fpga_driver = {
> +	.probe = versal_fpga_probe,
> +	.driver = {
> +		.name = "versal_fpga_manager",
> +		.of_match_table = of_match_ptr(versal_fpga_of_match),
> +	},
> +};
> +module_platform_driver(versal_fpga_driver);
> +
> +MODULE_AUTHOR("Nava kishore Manne <nava.manne@xilinx.com>");
> +MODULE_AUTHOR("Appana Durga Kedareswara rao <appanad.durga.rao@xilinx.com>");

Rao - needs to be capitalized ?

Tom

> +MODULE_DESCRIPTION("Xilinx Versal FPGA Manager");
> +MODULE_LICENSE("GPL");

