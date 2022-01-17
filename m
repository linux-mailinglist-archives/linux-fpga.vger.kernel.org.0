Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433A3490FCB
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Jan 2022 18:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiAQRnq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 17 Jan 2022 12:43:46 -0500
Received: from mail-mw2nam12on2070.outbound.protection.outlook.com ([40.107.244.70]:61588
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241269AbiAQRnp (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 17 Jan 2022 12:43:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRmyFLAjURIDdpezhfj1Wuu4dQtYNZnwQprHJS1LjbuT9HigvQgZb1oPSw+SmjDCTvCRg/HlB1YmpWLOdIkYzO8zHyKVS69EhdctBvSTW6uZZsMABbU+RqcwLpqY/775XD/M29RP7o/I6ZVcES8cGM+D3zikk8YOKgkB3HQwvQhjg4DH4wAi2fgKATDoas5/g2/3e3g47a43XHKat+snRVXFP+kwvtsjMTfG401pHozpVuu3an73EiRDW+V5qdRoHW+EJxE1PeZVkjAXm8xUrQ1fwLGYEse7p+KWqggJ0of0j6CaoAh8XgFnZCjy1p4txCb2bG/t/rCFowxsjgJ3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GD6B655wP7i7H7GAMRac4Y0wl5N+anzOhY92hAHKAA=;
 b=fmsQrXo3JSwu3+ACA/31R9FtrtLC6vg9D6XLfgbQmLzXSvOhI+XKB9VhlmNYaDdQwU+qM5A+i8Vwo40NWX9v3tPVMC4sVzOq4+ZSb0E594DOvXYxkzp9E3oxAzGhjWTJ3UOMp6izj6V9VWi8p8C9mJlSgysBVeFWDquCTxx9eRC3oAphhwCOktjBT/T3V81WqrF3IG76k8H+MhKu/1Qv7cykdRphUZNfY41NpEbKbnXxLXW1k9iMZDijTi/zm9wD7JnBL5nWKHwo04Agp64bpMjuVUtwsyxOOZXNSemJ4gMTQmID+hpSyPOrGFwc22mG1W4ocI08kLC9tEflYznfVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GD6B655wP7i7H7GAMRac4Y0wl5N+anzOhY92hAHKAA=;
 b=G+jF4kDuNmANCoQJhjcVTh126DHf/iVr1HoI96u7X/HcTrl+7XO0OnsQC80UPxkblaENZAw71g2D4r7S3ssOiM9wWFvE52Hbne6Pfkakxvjz9QGF0vkqs4uzUV53kQXv+ieyI+wr+RDFZpzdMG5WeFlDK35HN2/dmN1BrmT8JQY=
Received: from BN9PR03CA0089.namprd03.prod.outlook.com (2603:10b6:408:fc::34)
 by BN8PR02MB5796.namprd02.prod.outlook.com (2603:10b6:408:b8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Mon, 17 Jan
 2022 17:43:41 +0000
Received: from BN1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::2a) by BN9PR03CA0089.outlook.office365.com
 (2603:10b6:408:fc::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Mon, 17 Jan 2022 17:43:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT034.mail.protection.outlook.com (10.13.2.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Mon, 17 Jan 2022 17:43:40 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 17 Jan 2022 09:43:40 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 17 Jan 2022 09:43:40 -0800
Envelope-to: dwmw2@infradead.org,
 robh@kernel.org,
 mdf@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 yilun.xu@intel.com
Received: from [10.17.2.60] (port=43594)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1n9W2e-00046U-ET; Mon, 17 Jan 2022 09:43:40 -0800
Subject: Re: [PATCH V4 XRT Alveo Infrastructure 5/5] fpga: xrt: management
 physical function driver
To:     Xu Yilun <yilun.xu@intel.com>, Lizhi Hou <lizhi.hou@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
References: <20220105225013.1567871-1-lizhi.hou@xilinx.com>
 <20220105225013.1567871-6-lizhi.hou@xilinx.com>
 <20220111070000.GC979169@yilunxu-OptiPlex-7050>
 <446d9abb-b1ee-b0e7-9c48-aa7e960ec1e9@xilinx.com>
 <20220114014339.GA1027147@yilunxu-OptiPlex-7050>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <cd6210bb-2189-eace-0522-da4b338110c9@xilinx.com>
Date:   Mon, 17 Jan 2022 09:43:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20220114014339.GA1027147@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aaa19602-e214-4d9a-cf9f-08d9d9e0e663
X-MS-TrafficTypeDiagnostic: BN8PR02MB5796:EE_
X-Microsoft-Antispam-PRVS: <BN8PR02MB57963EBA269CE742528D418FA1579@BN8PR02MB5796.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hw4z/aIO+NDPjIy5GxD6GQV/aC/WLnGwlDkCTNPsTfS8XHre1vUg4nAUGwOeNLyxyzUnzu3z63givcdGeakIRvCRTo6SEpkNduoqUlwcMbyILpCL673jQXQE1CTz6kxglni43WNyuVGglL1JcyyMNwoHedGMSIOuHfHXy9zhjVv5LyGW9TDMLm1ODYTMvBvce36YPMrTna87oegWCUUggb9OUm12zjo5EJwSqv2BUsLvrcex3/o/TSCXBHdr1a+wpBaoLPZFzbzLTJCGPNyaSgnLm8iUItiiAWUmuJHq6yvGlxRXRjqyLoVcUZ9gmFedfHwKdegUlxffvBcbgPiVvc7ZLCFgtVd8fuERtmeHwcx66TvkDtueRHbDNIFj59uMHN20yJYdsa1cHLBOZUGG553pUmpKBFFZm6vK6hoCc0GJ3aTkNV4/up+avAIgdsqRphZqbEkH9F6qqGRuhzknwN8K5N59g2PqNXCW4cjyD+VyXSCc0jFckp0lkoIszHCfjR86pjpluXNszN+Cm8YdIpeW5xTlzwmRNCr3y/oKsMyfwdNnoDCvgnqiNiz3LYD8BbbtJFmIKELJlMHJmC+HyJom/oy/3xpUnHK19CxUIGz2DZt/uyY5tZCDI1Br+n2NfyhW46g1qRzq9aoB+/kCb03kAy5etccqyTQJqoyNqS2brA09A+CBLVOEcp0qKrmd2JPWmmLh3zFgQClu98A3KvCgx76+OBolJ/ch4tGOr1CIEIjmDlgoL6XGjwsLR/Nv8k/nHCk5cpFhNnBHOkKG9Y6oL3GQjB1jWvzhEJhscgFFHlUAgU8u+UMOPABlGonFxeQo8KVKGFhjUWIvzBVP3w==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(110136005)(8676002)(36860700001)(2906002)(316002)(36756003)(966005)(508600001)(356005)(336012)(53546011)(31696002)(186003)(83380400001)(9786002)(47076005)(5660300002)(7636003)(4326008)(426003)(70206006)(54906003)(26005)(82310400004)(30864003)(31686004)(107886003)(2616005)(70586007)(44832011)(8936002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 17:43:40.9119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa19602-e214-4d9a-cf9f-08d9d9e0e663
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT034.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB5796
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/13/22 5:43 PM, Xu Yilun wrote:
> On Thu, Jan 13, 2022 at 03:41:47PM -0800, Lizhi Hou wrote:
>> On 1/10/22 11:00 PM, Xu Yilun wrote:
>>> =
>>>
>>> On Wed, Jan 05, 2022 at 02:50:13PM -0800, Lizhi Hou wrote:
>>>> The PCIE device driver which attaches to management function on Alveo
>>>> devices. It instantiates one or more partition. Each partition consists
>>>> a set of hardward endpoints. A flat device tree is associated with each
>>>> partition. The first version of this driver uses test version flat device
>>>> tree and call xrt lib API to unflatten it.
>>>>
>>>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>>>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>>>> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
>>>> ---
>>>>    drivers/fpga/Makefile             |   1 +
>>>>    drivers/fpga/xrt/Kconfig          |   1 +
>>>>    drivers/fpga/xrt/mgmt/Kconfig     |  14 +++
>>>>    drivers/fpga/xrt/mgmt/Makefile    |  16 +++
>>>>    drivers/fpga/xrt/mgmt/dt-test.dts |  12 +++
>>>>    drivers/fpga/xrt/mgmt/dt-test.h   |  15 +++
>>>>    drivers/fpga/xrt/mgmt/xmgmt-drv.c | 158 ++++++++++++++++++++++++++++++
>>>>    7 files changed, 217 insertions(+)
>>>>    create mode 100644 drivers/fpga/xrt/mgmt/Kconfig
>>>>    create mode 100644 drivers/fpga/xrt/mgmt/Makefile
>>>>    create mode 100644 drivers/fpga/xrt/mgmt/dt-test.dts
>>>>    create mode 100644 drivers/fpga/xrt/mgmt/dt-test.h
>>>>    create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-drv.c
>>>>
>>>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>>>> index 5bd41cf4c7ec..544e2144878f 100644
>>>> --- a/drivers/fpga/Makefile
>>>> +++ b/drivers/fpga/Makefile
>>>> @@ -52,3 +52,4 @@ obj-$(CONFIG_FPGA_DFL_PCI)          += dfl-pci.o
>>>>
>>>>    # XRT drivers for Alveo
>>>>    obj-$(CONFIG_FPGA_XRT_LIB)           += xrt/lib/
>>>> +obj-$(CONFIG_FPGA_XRT_XMGMT)         += xrt/mgmt/
>>>> diff --git a/drivers/fpga/xrt/Kconfig b/drivers/fpga/xrt/Kconfig
>>>> index 04c3bb5aaf4f..50422f77c6df 100644
>>>> --- a/drivers/fpga/xrt/Kconfig
>>>> +++ b/drivers/fpga/xrt/Kconfig
>>>> @@ -4,3 +4,4 @@
>>>>    #
>>>>
>>>>    source "drivers/fpga/xrt/lib/Kconfig"
>>>> +source "drivers/fpga/xrt/mgmt/Kconfig"
>>>> diff --git a/drivers/fpga/xrt/mgmt/Kconfig b/drivers/fpga/xrt/mgmt/Kconfig
>>>> new file mode 100644
>>>> index 000000000000..a978747482be
>>>> --- /dev/null
>>>> +++ b/drivers/fpga/xrt/mgmt/Kconfig
>>>> @@ -0,0 +1,14 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only
>>>> +#
>>>> +# Xilinx XRT FPGA device configuration
>>>> +#
>>>> +
>>>> +config FPGA_XRT_XMGMT
>>>> +     tristate "Xilinx Alveo Management Driver"
>>>> +     depends on FPGA_XRT_LIB
>>>> +     select FPGA_BRIDGE
>>>> +     select FPGA_REGION
>>>> +     help
>>>> +       Select this option to enable XRT PCIe driver for Xilinx Alveo FPGA.
>>>> +       This driver provides interfaces for userspace application to access
>>>> +       Alveo FPGA device.
>>>> diff --git a/drivers/fpga/xrt/mgmt/Makefile b/drivers/fpga/xrt/mgmt/Makefile
>>>> new file mode 100644
>>>> index 000000000000..c5134bf71cca
>>>> --- /dev/null
>>>> +++ b/drivers/fpga/xrt/mgmt/Makefile
>>>> @@ -0,0 +1,16 @@
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +#
>>>> +# Copyright (C) 2020-2022 Xilinx, Inc. All rights reserved.
>>>> +#
>>>> +# Authors: Sonal.Santan@xilinx.com
>>>> +#
>>>> +
>>>> +FULL_XRT_PATH=$(srctree)/$(src)/..
>>>> +
>>>> +obj-$(CONFIG_FPGA_XRT_LIB) += xrt-mgmt.o
>>>> +
>>>> +xrt-mgmt-objs :=             \
>>>> +     xmgmt-drv.o             \
>>>> +     dt-test.dtb.o
>>>> +
>>>> +ccflags-y := -I$(FULL_XRT_PATH)/include
>>>> diff --git a/drivers/fpga/xrt/mgmt/dt-test.dts b/drivers/fpga/xrt/mgmt/dt-test.dts
>>>> new file mode 100644
>>>> index 000000000000..68dbcb7fd79d
>>>> --- /dev/null
>>>> +++ b/drivers/fpga/xrt/mgmt/dt-test.dts
>>>> @@ -0,0 +1,12 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/dts-v1/;
>>>> +
>>>> +/ {
>>>> +     compatible = "xlnx,alveo-partition", "simple-bus";
>>>> +     #address-cells = <2>;
>>>> +     #size-cells = <2>;
>>>> +     pr_isolate_ulp@0,41000 {
>>>> +             compatible = "xlnx,alveo-pr-isolation";
>>>> +             reg = <0x0 0x41000 0x0 0x1000>;
>>>> +     };
>>>> +};
>>> I remember Rob's comments:
>>>
>>> "we'd need to create a base tree (if there isn't one) with nodes
>>> for the USB or PCI device(s) and then an overlay for the device can be
>>> applied to those nodes."
>>>
>>> https://lore.kernel.org/linux-fpga/CAL_JsqJfyRymB=VxLuQqLpep+Q1Eie48dobv9sC5OizDz0d2DQ@mail.gmail.com/
>>>
>>> So could we firstly create a pci device node under the of_root when
>>> the driver probing, then add the partition DTs under the pci device node
>>> by overlay machenism.
>>>
>>> I'm considering if finally we could leverage the existing of-fpga-region
>>> that reprograms and enumerates FPGA sub devices by overlay.
>>>
>>> Open for discussion.
>> I would list the main ideas of our implementation
>>
>> 1. “alveo-partition (simple-bus)” node is created under of_root in xmgmt
>> probe function. “simple-bus” is used as it fits well and we can modify it to
>> “fpga-region” when we refactor fpga-mgr/region/bridge part.
> OK. "fpga-region" for an independent reprogramable region. And
> "simple-bus" for static board components.
>
>> 2. we are the first pcie device using flatten device tree to describe sub
>> devices. Adding device tree nodes for all pcie device sounds intrusive. We
>> can expend to all pcie device when we have another user of this feature.
> I don't mean we create DT nodes for all pcie devices in system, it is the
> device driver's choice to create the node for DT style enumeration of its
> sub devices. This is mainly for pcie based fpga cards. Now there exsits
Glad to know this.
> plenty of these cards in the world, and the enumeration of their sub
> devices could be a common concern. I think it's good we have a clear
> design at the beginning.

For single Alveo card on system, we are thinking this structure

of_root -----alveo-part@0 (simple-bus or fpga-region)

              |---alveo-part@1 (fpga-region or fpga-region)

               .....

Are you suggesting to add a pcie device layer. e.g.

of_root----alveo-fpga@<addr>----alveo-part@0

                                                  |--alveo-part@1


Thanks,

Lizhi

>
>> 3. of_overlay_fdt_apply() does not support overlaying to a dynamic generated
> Yes that's the problem we have.
>
>> parent node. Thus, we use of_dynamic functions of_changeset_attach_node()
>> instead. (similar to drivers/pci/hotplug/pnv_php.c,) . If needed ,we can
>> consider to add parameter “parent node” to of_overlay_fdt_apply() to support
>> dynamical overlay case.
> I agree we do some investigation for this.
>
> Thanks,
> Yilun
>
>>
>> Thanks,
>>
>> Lizhi
>>
>>> Thanks,
>>> Yilun
>>>
>>>> diff --git a/drivers/fpga/xrt/mgmt/dt-test.h b/drivers/fpga/xrt/mgmt/dt-test.h
>>>> new file mode 100644
>>>> index 000000000000..6ec4203afbd2
>>>> --- /dev/null
>>>> +++ b/drivers/fpga/xrt/mgmt/dt-test.h
>>>> @@ -0,0 +1,15 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + * Copyright (C) 2020-2022 Xilinx, Inc.
>>>> + *
>>>> + * Authors:
>>>> + *   Lizhi Hou <lizhih@xilinx.com>
>>>> + */
>>>> +
>>>> +#ifndef _DT_TEST_H_
>>>> +#define _DT_TEST_H_
>>>> +
>>>> +extern u8 __dtb_dt_test_begin[];
>>>> +extern u8 __dtb_dt_test_end[];
>>>> +
>>>> +#endif       /* _DT_TEST_H_ */
>>>> diff --git a/drivers/fpga/xrt/mgmt/xmgmt-drv.c b/drivers/fpga/xrt/mgmt/xmgmt-drv.c
>>>> new file mode 100644
>>>> index 000000000000..87abe5b86e0b
>>>> --- /dev/null
>>>> +++ b/drivers/fpga/xrt/mgmt/xmgmt-drv.c
>>>> @@ -0,0 +1,158 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Xilinx Alveo Management Function Driver
>>>> + *
>>>> + * Copyright (C) 2020-2022 Xilinx, Inc.
>>>> + *
>>>> + * Authors:
>>>> + *   Cheng Zhen <maxz@xilinx.com>
>>>> + *   Lizhi Hou <lizhih@xilinx.com>
>>>> + */
>>>> +
>>>> +#include <linux/module.h>
>>>> +#include <linux/pci.h>
>>>> +#include <linux/aer.h>
>>>> +#include <linux/vmalloc.h>
>>>> +#include <linux/delay.h>
>>>> +#include "xpartition.h"
>>>> +#include "dt-test.h"
>>>> +
>>>> +#define XMGMT_MODULE_NAME    "xrt-mgmt"
>>>> +
>>>> +#define XMGMT_PDEV(xm)               ((xm)->pdev)
>>>> +#define XMGMT_DEV(xm)                (&(XMGMT_PDEV(xm)->dev))
>>>> +#define xmgmt_err(xm, fmt, args...)  \
>>>> +     dev_err(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
>>>> +#define xmgmt_warn(xm, fmt, args...) \
>>>> +     dev_warn(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
>>>> +#define xmgmt_info(xm, fmt, args...) \
>>>> +     dev_info(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
>>>> +#define xmgmt_dbg(xm, fmt, args...)  \
>>>> +     dev_dbg(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
>>>> +#define XMGMT_DEV_ID(_pcidev)                        \
>>>> +     ({ typeof(_pcidev) (pcidev) = (_pcidev);        \
>>>> +     ((pci_domain_nr((pcidev)->bus) << 16) | \
>>>> +     PCI_DEVID((pcidev)->bus->number, (pcidev)->devfn)); })
>>>> +
>>>> +#define XRT_MAX_READRQ               512
>>>> +
>>>> +/* PCI Device IDs */
>>>> +#define PCI_DEVICE_ID_U50            0x5020
>>>> +static const struct pci_device_id xmgmt_pci_ids[] = {
>>>> +     { PCI_DEVICE(PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_U50), }, /* Alveo U50 */
>>>> +     { 0, }
>>>> +};
>>>> +
>>>> +struct xmgmt {
>>>> +     struct pci_dev *pdev;
>>>> +     void *base_partition;
>>>> +
>>>> +     bool ready;
>>>> +};
>>>> +
>>>> +static int xmgmt_config_pci(struct xmgmt *xm)
>>>> +{
>>>> +     struct pci_dev *pdev = XMGMT_PDEV(xm);
>>>> +     int rc;
>>>> +
>>>> +     rc = pcim_enable_device(pdev);
>>>> +     if (rc < 0) {
>>>> +             xmgmt_err(xm, "failed to enable device: %d", rc);
>>>> +             return rc;
>>>> +     }
>>>> +
>>>> +     rc = pci_enable_pcie_error_reporting(pdev);
>>>> +     if (rc)
>>>> +             xmgmt_warn(xm, "failed to enable AER: %d", rc);
>>>> +
>>>> +     pci_set_master(pdev);
>>>> +
>>>> +     rc = pcie_get_readrq(pdev);
>>>> +     if (rc > XRT_MAX_READRQ)
>>>> +             pcie_set_readrq(pdev, XRT_MAX_READRQ);
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int xmgmt_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>> +{
>>>> +     struct xrt_partition_range ranges[PCI_NUM_RESOURCES];
>>>> +     struct xrt_partition_info xp_info = { 0 };
>>>> +     struct device *dev = &pdev->dev;
>>>> +     int ret, i, idx = 0;
>>>> +     struct xmgmt *xm;
>>>> +
>>>> +     xm = devm_kzalloc(dev, sizeof(*xm), GFP_KERNEL);
>>>> +     if (!xm)
>>>> +             return -ENOMEM;
>>>> +     xm->pdev = pdev;
>>>> +     pci_set_drvdata(pdev, xm);
>>>> +
>>>> +     ret = xmgmt_config_pci(xm);
>>>> +     if (ret)
>>>> +             goto failed;
>>>> +
>>>> +     for (i = 0; i < PCI_NUM_RESOURCES; i++) {
>>>> +             if (pci_resource_len(pdev, i) > 0) {
>>>> +                     ranges[idx].bar_idx = i;
>>>> +                     ranges[idx].base = pci_resource_start(pdev, i);
>>>> +                     ranges[idx].size = pci_resource_len(pdev, i);
>>>> +                     idx++;
>>>> +             }
>>>> +     }
>>>> +     xp_info.num_range = idx;
>>>> +     xp_info.ranges = ranges;
>>>> +     xp_info.fdt = __dtb_dt_test_begin;
>>>> +     xp_info.fdt_len = (u32)(__dtb_dt_test_end - __dtb_dt_test_begin);
>>>> +     ret = xrt_partition_create(&pdev->dev, &xp_info, &xm->base_partition);
>>>> +     if (ret)
>>>> +             goto failed;
>>>> +
>>>> +     xmgmt_info(xm, "%s started successfully", XMGMT_MODULE_NAME);
>>>> +     return 0;
>>>> +
>>>> +failed:
>>>> +     if (xm->base_partition)
>>>> +             xrt_partition_destroy(xm->base_partition);
>>>> +     pci_set_drvdata(pdev, NULL);
>>>> +     return ret;
>>>> +}
>>>> +
>>>> +static void xmgmt_remove(struct pci_dev *pdev)
>>>> +{
>>>> +     struct xmgmt *xm = pci_get_drvdata(pdev);
>>>> +
>>>> +     xrt_partition_destroy(xm->base_partition);
>>>> +     pci_disable_pcie_error_reporting(xm->pdev);
>>>> +     xmgmt_info(xm, "%s cleaned up successfully", XMGMT_MODULE_NAME);
>>>> +}
>>>> +
>>>> +static struct pci_driver xmgmt_driver = {
>>>> +     .name = XMGMT_MODULE_NAME,
>>>> +     .id_table = xmgmt_pci_ids,
>>>> +     .probe = xmgmt_probe,
>>>> +     .remove = xmgmt_remove,
>>>> +};
>>>> +
>>>> +static int __init xmgmt_init(void)
>>>> +{
>>>> +     int res = 0;
>>>> +
>>>> +     res = pci_register_driver(&xmgmt_driver);
>>>> +     if (res)
>>>> +             return res;
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static __exit void xmgmt_exit(void)
>>>> +{
>>>> +     pci_unregister_driver(&xmgmt_driver);
>>>> +}
>>>> +
>>>> +module_init(xmgmt_init);
>>>> +module_exit(xmgmt_exit);
>>>> +
>>>> +MODULE_DEVICE_TABLE(pci, xmgmt_pci_ids);
>>>> +MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
>>>> +MODULE_DESCRIPTION("Xilinx Alveo management function driver");
>>>> +MODULE_LICENSE("GPL v2");
>>>> --
>>>> 2.27.0
