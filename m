Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C50039BA46
	for <lists+linux-fpga@lfdr.de>; Fri,  4 Jun 2021 15:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhFDNzA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 4 Jun 2021 09:55:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40077 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230328AbhFDNy7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 4 Jun 2021 09:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622814793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IckDAZssfgYJ1H8/AEiqV54BB8ADMJ8AwPtrrhs2CSM=;
        b=Oo/KqgIO+K3c8M3FVoG7e0lHqqY4qu0lQFNcx7aSstYXPyMcl90Jfrx2pCirFyDcOlZBMM
        lo1cQYPJoytKtbzjEGDFrGE0KM0OxicLLOjfgUU+hHn8I/cYoQy2WcpL9pmRRDJXdZshAR
        TSXFoybZiZIQecl/m9CUStoSiUjek/M=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-bpexa5bSOmGA7crFhJycoA-1; Fri, 04 Jun 2021 09:53:12 -0400
X-MC-Unique: bpexa5bSOmGA7crFhJycoA-1
Received: by mail-oo1-f70.google.com with SMTP id f5-20020a4ab0050000b029023e3bd79e80so5528129oon.10
        for <linux-fpga@vger.kernel.org>; Fri, 04 Jun 2021 06:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IckDAZssfgYJ1H8/AEiqV54BB8ADMJ8AwPtrrhs2CSM=;
        b=qUgK4GJQifGpcnpDn2IqP7v4yLtq6+kEEcP1b0P36zUXOvbLLkbMPfwCPZf9ufOLA0
         mdTYBQGtdS3535rp6JY5VfmYy3JAjCYBnrUkW/ClFNEDCZOBGZ3+g3goLp849/74NVhJ
         d0zS6fqEEgBB1+ZkOabtThVxv1kLRtmek7hi+LJFK9Oinx4n3JlpAqaa1TBvG8HmwsMw
         Wis57zG6mSmQlGXNCHRMIgkjMGBQMNDt1O7E2rn3AM28V8ui4mX9cL3KYRFAVa2e4UcO
         EVHkMwkfuXwzJB8e03StqyPJ/S+FNib6cPhfZ61ahQXJ2NQhNyY5NuRz0/FzHVF6+cZO
         5ALQ==
X-Gm-Message-State: AOAM530jVJ16cEJTWfdsT8Xb3CAEcRxYbXbeg9ygmnbAQRfwRnNDUqzb
        tQbgv8FIw0z8sOJeIx3XyiybRsz4wb6ExbxzmObAAK8K3Obuq0y8I1f6GxnbfC9zWe3FJQtCRX5
        F4hkNPKHOHD+7tbdIhJaD6A==
X-Received: by 2002:a05:6808:f0a:: with SMTP id m10mr3139138oiw.126.1622814790481;
        Fri, 04 Jun 2021 06:53:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywgBCM7YWiZh2wwBr1dHOt/kyTBo3x4i95PGHFeGFhnA762HqpyiztB2ST4zIW8mmcs10GHQ==
X-Received: by 2002:a05:6808:f0a:: with SMTP id m10mr3139120oiw.126.1622814790243;
        Fri, 04 Jun 2021 06:53:10 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b6sm474329oic.12.2021.06.04.06.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 06:53:09 -0700 (PDT)
Subject: Re: [PATCH v7 4/4] fpga: versal-fpga: Add versal fpga manager driver
To:     Greg KH <gregkh@linuxfoundation.org>,
        Nava kishore Manne <nava.manne@xilinx.com>
Cc:     robh+dt@kernel.org, michal.simek@xilinx.com, mdf@kernel.org,
        arnd@arndb.de, rajan.vaja@xilinx.com, amit.sunil.dhamne@xilinx.com,
        tejas.patel@xilinx.com, zou_wei@huawei.com,
        lakshmi.sai.krishna.potthuri@xilinx.com, ravi.patel@xilinx.com,
        iwamatsu@nigauri.org, wendy.liang@xilinx.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        git@xilinx.com, chinnikishore369@gmail.com,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
References: <20210604113332.1394-1-nava.manne@xilinx.com>
 <20210604113332.1394-5-nava.manne@xilinx.com> <YLoTK02aUs2vNt+4@kroah.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <06301910-10a1-0e62-45a0-d28ab5a787ed@redhat.com>
Date:   Fri, 4 Jun 2021 06:53:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YLoTK02aUs2vNt+4@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 6/4/21 4:48 AM, Greg KH wrote:
> On Fri, Jun 04, 2021 at 05:03:32PM +0530, Nava kishore Manne wrote:
>> Add support for Xilinx Versal FPGA manager.
>>
>> PDI source type can be DDR, OCM, QSPI flash etc..
>> But driver allocates memory always from DDR, Since driver supports only
>> DDR source type.
>>
>> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
>> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
>> Reviewed-by: Moritz Fischer <mdf@kernel.org>
>> ---
>> Changes for v2:
>>                -Updated the Fpga Mgr registrations call's
>>                 to 5.11
>>                -Fixed some minor coding issues as suggested by
>>                 Moritz.
>>
>> Changes for v3:
>>                -Rewritten the Versal fpga Kconfig contents.
>>
>> Changes for v4:
>>                -Rebased the changes on linux-next.
>>                 No functional changes.
>>
>> Changes for v5:
>>                -None.
>>
>> Changes for v6:
>>                -None.
>>
>> Changes for v7:
>>                -Updated driver to remove unwated priv struct dependency.
>>
>>   drivers/fpga/Kconfig       |  9 ++++
>>   drivers/fpga/Makefile      |  1 +
>>   drivers/fpga/versal-fpga.c | 96 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 106 insertions(+)
>>   create mode 100644 drivers/fpga/versal-fpga.c
>>
>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>> index 33e15058d0dc..92c20b92357a 100644
>> --- a/drivers/fpga/Kconfig
>> +++ b/drivers/fpga/Kconfig
>> @@ -234,4 +234,13 @@ config FPGA_MGR_ZYNQMP_FPGA
>>   	  to configure the programmable logic(PL) through PS
>>   	  on ZynqMP SoC.
>>   
>> +config FPGA_MGR_VERSAL_FPGA
>> +	tristate "Xilinx Versal FPGA"
>> +	depends on ARCH_ZYNQMP || COMPILE_TEST
>> +	help
>> +	  Select this option to enable FPGA manager driver support for
>> +	  Xilinx Versal SoC. This driver uses the firmware interface to
>> +	  configure the programmable logic(PL).
>> +
>> +	  To compile this as a module, choose M here.
>>   endif # FPGA
>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>> index 18dc9885883a..0bff783d1b61 100644
>> --- a/drivers/fpga/Makefile
>> +++ b/drivers/fpga/Makefile
>> @@ -18,6 +18,7 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
>>   obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
>>   obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
>>   obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
>> +obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)      += versal-fpga.o
>>   obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
>>   obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
>>   
>> diff --git a/drivers/fpga/versal-fpga.c b/drivers/fpga/versal-fpga.c
>> new file mode 100644
>> index 000000000000..1bd312a31b23
>> --- /dev/null
>> +++ b/drivers/fpga/versal-fpga.c
>> @@ -0,0 +1,96 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2019-2021 Xilinx, Inc.
>> + */
>> +
>> +#include <linux/dma-mapping.h>
>> +#include <linux/fpga/fpga-mgr.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/string.h>
>> +#include <linux/firmware/xlnx-zynqmp.h>
>> +
>> +static int versal_fpga_ops_write_init(struct fpga_manager *mgr,
>> +				      struct fpga_image_info *info,
>> +				      const char *buf, size_t size)
>> +{
>> +	return 0;
> Why have this if it does nothing?
>
>> +}
>> +
>> +static int versal_fpga_ops_write(struct fpga_manager *mgr,
>> +				 const char *buf, size_t size)
>> +{
>> +	dma_addr_t dma_addr = 0;
>> +	char *kbuf;
>> +	int ret;
>> +
>> +	kbuf = dma_alloc_coherent(mgr->dev.parent, size, &dma_addr, GFP_KERNEL);
>> +	if (!kbuf)
>> +		return -ENOMEM;
>> +
>> +	memcpy(kbuf, buf, size);
>> +	ret = zynqmp_pm_load_pdi(PDI_SRC_DDR, dma_addr);
>> +	dma_free_coherent(mgr->dev.parent, size, kbuf, dma_addr);
>> +
>> +	return ret;
>> +}
>> +
>> +static int versal_fpga_ops_write_complete(struct fpga_manager *mgr,
>> +					  struct fpga_image_info *info)
>> +{
>> +	return 0;
> Same here, why have this at all?
>
>> +}
>> +
>> +static enum fpga_mgr_states versal_fpga_ops_state(struct fpga_manager *mgr)
>> +{
>> +	return FPGA_MGR_STATE_UNKNOWN;
> Shouln't that be the default state of the fpga manager if there is no
> state function callback?
>
> This driver should just need a write and probe function, and that's it,
> why make it more complex?

These empty functions are needed by each board because of an aggressive 
check of ops early in the bringup of the fpga mgr.

I did some deck chair shuffling here recently

https://lore.kernel.org/linux-fpga/20210524162820.2221474-1-trix@redhat.com/

that shows location of check.

A finer grained handling of the ops would be better.

I'll add that to the next spin.

Tom

> thanks,
>
> greg k-h
>

