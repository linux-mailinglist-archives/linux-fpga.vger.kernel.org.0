Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0FA3056B1
	for <lists+linux-fpga@lfdr.de>; Wed, 27 Jan 2021 10:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhA0JTg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 27 Jan 2021 04:19:36 -0500
Received: from mail-eopbgr690072.outbound.protection.outlook.com ([40.107.69.72]:55837
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235094AbhA0JRk (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 27 Jan 2021 04:17:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsnRlq4thvsvPSTa+wVyb41lV5DKRYo1ClQPm2DGWATXaXTPxJ4Jto6LAM1DF3bsLgykflfEQoF8LnKbcZRtSr+F8jbMqf8OnWHYQB2t9pugxby+5IhiM9E54JHeghJ5kOk4RWN5yPg6ylIKFKkEhF1iVoPq0vzT4VP4H14uUFy4C6zn13xPF+yuKnWIgYUEdVahOBZJlrfBpAm8jvXb746lp14N+t+RsLjQlugbsZkyQtp80afBYny49+Nur/eUo+s8fpKLtN0x9dC84c36qmeQfst/wuXODNQRvxyeFagP2lD3OIuHFgtqH0xoV9cbD7nNj3U6FCHQW+cnr1TiAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHEd+hDAtX0xz40EGhxOnXO4xkOL0uwewTrfEO3t0uM=;
 b=kNM+MA/Q6OTmgftE+X2kYihFxPyhc3H7/ye8zoPnJXBW25ACZpoSgqXjWNIafzFNJyrPDcYluBxItBVj+rqBV0cbbCx0gSR5osFaT/iBBaH6Neahhj/j4OQzx2TnlDaSlzR/9L8liLVXIFVSNg2ejXHzxpJYj7QVdtDsyTPixcmF4vCJGwA3kWV55quC8znI0a2SyfLRsuGr5n0vKGsGXzL2mmUhDEpQG2SCwyYAP5sZkg+3cvvKqCuIOc5KcaiAJrGjyW92pcKEDXYaOBKJyO8Uc7+jKXlQzfjFXoB+2IBW/TCk7uKQTXyEA7cc4QlY75DDfHCbn+Qk4UzJzlSU9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHEd+hDAtX0xz40EGhxOnXO4xkOL0uwewTrfEO3t0uM=;
 b=D8OFbJBp8+GvgX/u/Uk/RB/x8U9edhGTyBETp+66nQoTN9ncrpUeqJc6uX8vFRJ/40cpzcjt8fH2p5iGCxlSVuNJ73riSggX9be6p7t4/D0HIOH15fqfXEJ1xJJgPrNvpN0TlaSgh4aqRRvDTCqt+OFBqQ8uO1uVETroeRUVXRU=
Received: from SN1PR12CA0046.namprd12.prod.outlook.com (2603:10b6:802:20::17)
 by CY4PR02MB2181.namprd02.prod.outlook.com (2603:10b6:903:e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 27 Jan
 2021 09:16:50 +0000
Received: from SN1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2603:10b6:802:20:cafe::10) by SN1PR12CA0046.outlook.office365.com
 (2603:10b6:802:20::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Wed, 27 Jan 2021 09:16:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT023.mail.protection.outlook.com (10.152.72.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Wed, 27 Jan 2021 09:16:50 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 27 Jan 2021 01:16:37 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 27 Jan 2021 01:16:37 -0800
Envelope-to: git@xilinx.com,
 chinnikishore369@gmail.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 robh+dt@kernel.org,
 trix@redhat.com,
 mdf@kernel.org
Received: from [172.30.17.109] (port=53524)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1l4gwG-00072c-3Q; Wed, 27 Jan 2021 01:16:36 -0800
Subject: Re: [PATCH 3/3] fpga: versal-fpga: Add versal fpga manager driver
To:     Nava kishore Manne <navam@xilinx.com>,
        Moritz Fischer <mdf@kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>,
        "Appana Durga Kedareswara Rao" <appanad@xilinx.com>
References: <20210118024318.9530-1-nava.manne@xilinx.com>
 <20210118024318.9530-3-nava.manne@xilinx.com> <YAYo1ksLfMMNxPuL@epycbox.lan>
 <MWHPR02MB26239A3F539DE8E053D512D5C2A09@MWHPR02MB2623.namprd02.prod.outlook.com>
 <YAyyU9dybSdmOAQL@epycbox.lan>
 <MWHPR02MB26231DAF3A8E2A65EF25A4C3C2BB9@MWHPR02MB2623.namprd02.prod.outlook.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <5ae6d181-3258-a877-23c5-6ba81c40b10a@xilinx.com>
Date:   Wed, 27 Jan 2021 10:16:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <MWHPR02MB26231DAF3A8E2A65EF25A4C3C2BB9@MWHPR02MB2623.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b2f940a-7ca2-48cb-6903-08d8c2a447a1
X-MS-TrafficTypeDiagnostic: CY4PR02MB2181:
X-Microsoft-Antispam-PRVS: <CY4PR02MB21810125EC044FAE7F1C1D4FC6BB9@CY4PR02MB2181.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wJ/jpC3xKhMWPsx4GKtNKlnb48wX9dhX6EIAGsxWsX28s8q+iWO03vOn0mW0/WdhE2qJt/wKhorHEBufR+W/gRFDafvLZDZ1itdJHzGtPnaGTGe8wWbkXxrNjGQ6Jjpd9y2AKeqHhT3JNEJqM+X/bpTkgsFohUUm70NN5Yn7hxXUxV8r1uHlVe8MW7FkQlE8D1tDpCJEsMwNLbCtJ4rlFIUKMZY8wB5DIkZKGr692HBTqJng13kgBm3gTkImEDwvdQw2vobUGmIKdTWTeMkt2l8KAARzRwD9Mw+WE5EJ4bQDVtYhP7UxS4JexPZm3t1ME5jZVPfOpk+VQrPa4WU9+uXsPccTEg+QG5mSlALQNIvudrSXuPHw3j5+mS1hgEdzSa7e0UF1RQqX0eGszDOoOdM4+GKtNYzIImcUIpV82s1/tjr5ITAlXSXQluIfG0NHl5IEjvpLxC8Ae3rn4LUVz6HiwTMrhNOmH0nUq1VFMJZMW8S+pUVKtHg9G7a1pzgH0Kqy5off61abcvEx/SmH68bgqYBSmCHztM/tjniG1KpcML5RByNP7DBrZDGFvyglcWQlsyNEclpbjFTJLwbiX5+NhihOQg2w31lrGS4Qv6zpbZa0KnMoOBpA5KaBabN2IfMvRFwwGdR84sKsqqSJng==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(46966006)(2906002)(5660300002)(54906003)(53546011)(356005)(36756003)(426003)(6666004)(31686004)(8676002)(9786002)(478600001)(336012)(83380400001)(47076005)(7636003)(82310400003)(4326008)(26005)(44832011)(36906005)(110136005)(31696002)(70206006)(107886003)(82740400003)(316002)(186003)(8936002)(70586007)(2616005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 09:16:50.4302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2f940a-7ca2-48cb-6903-08d8c2a447a1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT023.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2181
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi

On 1/27/21 9:57 AM, Nava kishore Manne wrote:
> Hi Moritz,
> 
> 	Please find my response inline.
> 
>> -----Original Message-----
>> From: Moritz Fischer <mdf@kernel.org>
>> Sent: Sunday, January 24, 2021 5:04 AM
>> To: Nava kishore Manne <navam@xilinx.com>
>> Cc: Moritz Fischer <mdf@kernel.org>; trix@redhat.com;
>> robh+dt@kernel.org; Michal Simek <michals@xilinx.com>; linux-
>> fpga@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git
>> <git@xilinx.com>; chinnikishore369@gmail.com; Appana Durga Kedareswara
>> Rao <appanad@xilinx.com>
>> Subject: Re: [PATCH 3/3] fpga: versal-fpga: Add versal fpga manager driver
>>
>> Hi Nava,
>>
>> On Fri, Jan 22, 2021 at 10:34:15AM +0000, Nava kishore Manne wrote:
>>> Hi Moritz,
>>>
>>> 	Thanks for the review.
>>> Please find my response inline.
>>>
>>>> -----Original Message-----
>>>> From: Moritz Fischer <mdf@kernel.org>
>>>> Sent: Tuesday, January 19, 2021 6:03 AM
>>>> To: Nava kishore Manne <navam@xilinx.com>
>>>> Cc: mdf@kernel.org; trix@redhat.com; robh+dt@kernel.org; Michal
>>>> Simek <michals@xilinx.com>; linux-fpga@vger.kernel.org;
>>>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>>>> linux- kernel@vger.kernel.org; git <git@xilinx.com>;
>>>> chinnikishore369@gmail.com; Appana Durga Kedareswara Rao
>>>> <appanad@xilinx.com>
>>>> Subject: Re: [PATCH 3/3] fpga: versal-fpga: Add versal fpga manager
>>>> driver
>>>>
>>>> Hi Nava,
>>>>
>>>> On Mon, Jan 18, 2021 at 08:13:18AM +0530, Nava kishore Manne wrote:
>>>>> This patch adds driver for versal fpga manager.
>>>> Nit: Add support for Xilinx Versal FPGA manager
>>>
>>> Will fix in v2.
>>>
>>>>>
>>>>> PDI source type can be DDR, OCM, QSPI flash etc..
>>>> No idea what PDI is :)
>>>
>>> Programmable device image (PDI).
>>> This file is generated by Xilinx Vivado tool and it contains configuration data
>> objects.
>>>
>>>>> But driver allocates memory always from DDR, Since driver supports
>>>>> only DDR source type.
>>>>>
>>>>> Signed-off-by: Appana Durga Kedareswara rao
>>>>> <appana.durga.rao@xilinx.com>
>>>>> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
>>>>> ---
>>>>>  drivers/fpga/Kconfig       |   8 ++
>>>>>  drivers/fpga/Makefile      |   1 +
>>>>>  drivers/fpga/versal-fpga.c | 149
>>>>> +++++++++++++++++++++++++++++++++++++
>>>>>  3 files changed, 158 insertions(+)  create mode 100644
>>>>> drivers/fpga/versal-fpga.c
>>>>>
>>>>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig index
>>>>> 5645226ca3ce..9f779c3a6739 100644
>>>>> --- a/drivers/fpga/Kconfig
>>>>> +++ b/drivers/fpga/Kconfig
>>>>> @@ -216,4 +216,12 @@ config FPGA_MGR_ZYNQMP_FPGA
>>>>>  	  to configure the programmable logic(PL) through PS
>>>>>  	  on ZynqMP SoC.
>>>>>
>>>>> +config FPGA_MGR_VERSAL_FPGA
>>>>> +        tristate "Xilinx Versal FPGA"
>>>>> +        depends on ARCH_ZYNQMP || COMPILE_TEST
>>>>> +        help
>>>>> +          Select this option to enable FPGA manager driver support for
>>>>> +          Xilinx Versal SOC. This driver uses the versal soc firmware
>>>>> +          interface to load programmable logic(PL) images
>>>>> +          on versal soc.
>>>>>  endif # FPGA
>>>>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile index
>>>>> d8e21dfc6778..40c9adb6a644 100644
>>>>> --- a/drivers/fpga/Makefile
>>>>> +++ b/drivers/fpga/Makefile
>>>>> @@ -18,6 +18,7 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)		+=
>>>> ts73xx-fpga.o
>>>>>  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
>>>>>  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
>>>>>  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
>>>>> +obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)      += versal-fpga.o
>>>>>  obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
>>>>>  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
>>>>>
>>>>> diff --git a/drivers/fpga/versal-fpga.c
>>>>> b/drivers/fpga/versal-fpga.c new file mode 100644 index
>>>>> 000000000000..2a42aa78b182
>>>>> --- /dev/null
>>>>> +++ b/drivers/fpga/versal-fpga.c
>>>>> @@ -0,0 +1,149 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>>> +/*
>>>>> + * Copyright (C) 2021 Xilinx, Inc.
>>>>> + */
>>>>> +
>>>>> +#include <linux/dma-mapping.h>
>>>>> +#include <linux/fpga/fpga-mgr.h>
>>>>> +#include <linux/io.h>
>>>>> +#include <linux/kernel.h>
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/of_address.h>
>>>>> +#include <linux/string.h>
>>>>> +#include <linux/firmware/xlnx-zynqmp.h>
>>>>> +
>>>>> +/* Constant Definitions */
>>>>> +#define PDI_SOURCE_TYPE	0xF
>>>>> +
>>>>> +/**
>>>>> + * struct versal_fpga_priv - Private data structure
>>>>> + * @dev:	Device data structure
>>>>> + * @flags:	flags which is used to identify the PL Image type
>>>>> + */
>>>>> +struct versal_fpga_priv {
>>>>> +	struct device *dev;
>>>>> +	u32 flags;
>>>> This seems unused ... please introduce them when/if you start using
>> them.
>>>
>>> Will fix in v2.
>>>
>>>>> +};
>>>>> +
>>>>> +static int versal_fpga_ops_write_init(struct fpga_manager *mgr,
>>>>> +				      struct fpga_image_info *info,
>>>>> +				      const char *buf, size_t size) {
>>>>> +	struct versal_fpga_priv *priv;
>>>>> +
>>>>> +	priv = mgr->priv;
>>>>> +	priv->flags = info->flags;
>>>> ? What uses this ? It seems this function could just be 'return 0' right now.
>>>
>>> Will fix in v2.
>>>
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static int versal_fpga_ops_write(struct fpga_manager *mgr,
>>>>> +				 const char *buf, size_t size) {
>>>>> +	struct versal_fpga_priv *priv;
>>>>> +	dma_addr_t dma_addr = 0;
>>>>> +	char *kbuf;
>>>>> +	int ret;
>>>>> +
>>>>> +	priv = mgr->priv;
>>>>> +
>>>>> +	kbuf = dma_alloc_coherent(priv->dev, size, &dma_addr,
>>>> GFP_KERNEL);
>>>>> +	if (!kbuf)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	memcpy(kbuf, buf, size);
>>>>> +
>>>>> +	wmb(); /* ensure all writes are done before initiate FW call */
>>>>> +
>>>>> +	ret = zynqmp_pm_load_pdi(PDI_SOURCE_TYPE, dma_addr);
>>>>> +
>>>>> +	dma_free_coherent(priv->dev, size, kbuf, dma_addr);
>>>>> +
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>> +static int versal_fpga_ops_write_complete(struct fpga_manager *mgr,
>>>>> +					  struct fpga_image_info *info) {
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static enum fpga_mgr_states versal_fpga_ops_state(struct
>>>>> +fpga_manager
>>>>> +*mgr) {
>>>>> +	return FPGA_MGR_STATE_OPERATING;
>>>> Is that always the case? Shouldn't that be
>> FPGA_MGR_STATE_UNKNOWN?
>>>
>>> For Versal SoC base PDI is always configured prior to Linux boot up. So I
>> make the fpga state as OPERATING.
>>> Please let know if it is not a proper implementation will think about the
>> alternate solution.
>>
>> So you're saying I can't boot a Versal SoC without a PDI / Bitstream loaded?
>> Interesting :)
>>>
> 
> For Versal SoC Vivado generated base PDI is always needed to bring-up the board. 

Look at PDI as ps7_init/psu_init file but in different format. And
bitstream is optional part of it (like a one partition).

Thanks,
Michal

