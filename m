Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7D748E113
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Jan 2022 00:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbiAMXlx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 13 Jan 2022 18:41:53 -0500
Received: from mail-bn7nam10on2049.outbound.protection.outlook.com ([40.107.92.49]:15680
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233774AbiAMXlv (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 13 Jan 2022 18:41:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDHmE+yJTlSOw8PEFvgxTBX+rY6+oMw2WxSzBrkvTWodu+X/jK4TicJeg6vrwUDwG1x3bNsi6HyAUIvO6EeNvR6gu4DVd3s5+GI1g9cJIbgMdQnHzG5N1rMknmGrqJeP5OlMDHRxNXG5RHrje5mqqbvgIxw1GB03s+8KhYXJ8k9D+U0HHUfMvn5dJfdxYJONpVRzMz0GsJpwo7yMEVuAYNo4PIwKPJ63COuy5SJPQtsyD+YsGthnGRYmDQf2aL9dDMdxzx6LlftyG7YcFu4nhsbUPY9b3F+RevK2WySB3S/9qq+aM2uxsEvIq2tFV/iRd917+Le9OnAXgfK51AusPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoutQZNYU6BKh+6Zn5W5QavDG+NcxROLScqyJgyQetY=;
 b=KZcKWvJWILBwQaDgzYZiGORg0BfXlaFZbhmJCMP5LQJfcOIufTQSHGkJsUIBOhuQG5/CrksnYQ/xbDAn7Q+OCTGeC4p6JDRc8pj9hpjbw4uQe3RUlI1fGd++FhRRpZL2fLPFtgUzDeZBqTxcZrp7j6vWGVebzqaqZEYF28rhqCxXLt1ZCt905kN0FqZNI5Ayakd2h/LJeA6zsfXDqcbyKSTjmx0YEzAh5BUsFL9YcCQoqtUL+lRLcul4n9ddRFx7KUNnKbchpPrHz8SWBBkyiWF/QEY8uSMySTBU9kqAseXTj5aBqUIwo/AP2lI030956PHbKTNUNcPuWek6VaQBrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoutQZNYU6BKh+6Zn5W5QavDG+NcxROLScqyJgyQetY=;
 b=dRHYiMzhquX+TeaN03x2POaYKb4UDSI0v/KoFAxGVqfgPq1fxWvtwRCqA0Eqn8mAnEEjC3cVoDGGt5dXaIzq1vsPmnFDB79kh9W4KdOJ/astAKVZlTBx+7AU47XmzA+gVwMelooP1eZHKKE23FpORsw2iwpbZAqGwdttALyEknw=
Received: from DM6PR11CA0002.namprd11.prod.outlook.com (2603:10b6:5:190::15)
 by BN6PR02MB2803.namprd02.prod.outlook.com (2603:10b6:404:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Thu, 13 Jan
 2022 23:41:49 +0000
Received: from DM3NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::3c) by DM6PR11CA0002.outlook.office365.com
 (2603:10b6:5:190::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Thu, 13 Jan 2022 23:41:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT047.mail.protection.outlook.com (10.13.4.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 23:41:48 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 13 Jan 2022 15:41:48 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 13 Jan 2022 15:41:48 -0800
Envelope-to: dwmw2@infradead.org,
 robh@kernel.org,
 mdf@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 yilun.xu@intel.com
Received: from [10.17.2.60] (port=39068)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1n89j2-0008Si-0n; Thu, 13 Jan 2022 15:41:48 -0800
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
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <446d9abb-b1ee-b0e7-9c48-aa7e960ec1e9@xilinx.com>
Date:   Thu, 13 Jan 2022 15:41:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20220111070000.GC979169@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 942bc07e-0208-4df3-4f9e-08d9d6ee446a
X-MS-TrafficTypeDiagnostic: BN6PR02MB2803:EE_
X-Microsoft-Antispam-PRVS: <BN6PR02MB2803A9E8EA19E7E564F29BFFA1539@BN6PR02MB2803.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rZxwEHJ8+nFEzIN76aLHtIp173LvzNSLEkzK2e8B0OZxOejUofCR99vyk1HtGUhSzyCx1hb1ljkKwngn22grstvcYXtZFlOoLC7riPtRAU9gKYQz1jKMMHr3/vzbLz3isZrL33Dmthb4TqA/1DDNqX4ysaNfR9yINnem17QtHu+9ZobEPWwu8vKQLtJWhbmGG5KTqbh0yH+rPDmbR/gle3BShQj867zB4Lf5Krn7f9je4wUDYN6UWRstM0tC/7sFacA3ZIxdtYkj4qGtN+8NGbsPvIOvwIKzFmZ88I7TOOQd6iY7xnqv7vLFKBCSKlB4yenYlIfBlm97v/44r54a4GXwCV71+4N3qgTlgEbOU1OfXPezVP/1pQRo2nJUaJCl+asHvAg6lCE19nNYr+yqoQ2u7mHrr7riABdIFtGpS1OVnjCVMtbqBA3RHVQNKSDIMGIAUGYVO9obhXVvIkixysw0agXHsHNIJpEVyj4adW3tsiI3Py9tVqqRWCNDIQshBCQAxTFQyb03GS64Y8vciwCuf2To/JmNC1Ha4jXKAdIZkl7jvCmBM/Y30iWjQgVaRBwl068M/0ld93cOZffH3+1kukB6bxuyDAG2UFviEHZA+fmjS2GHVdZ8qbLeP05NzCqCVN0iUeJUpfKk/0VeH/ACi5UtRuw6vqq78kWOzVEc4jdmZ/FCHZSN97l+nkV7+BDqA1g3UCPz8ELMHUFkf2704h1jlEguBEt7C4PM2/H+GmV5Izu+mDcw6FKr0/tQsGp99dtSh3gq+/XEx4IazHm2HZvXzWX44hSQZgXWl89DZUUT28hEbUv3lIkzobCfB2EA8CfH2+RRdqIFWnrHRQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36756003)(336012)(426003)(110136005)(8676002)(316002)(44832011)(54906003)(2616005)(83380400001)(9786002)(7636003)(82310400004)(8936002)(966005)(508600001)(47076005)(31696002)(70586007)(31686004)(2906002)(53546011)(356005)(26005)(5660300002)(107886003)(36860700001)(30864003)(70206006)(4326008)(186003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 23:41:48.7076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 942bc07e-0208-4df3-4f9e-08d9d6ee446a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT047.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2803
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/10/22 11:00 PM, Xu Yilun wrote:
> =
>
> On Wed, Jan 05, 2022 at 02:50:13PM -0800, Lizhi Hou wrote:
>> The PCIE device driver which attaches to management function on Alveo
>> devices. It instantiates one or more partition. Each partition consists
>> a set of hardward endpoints. A flat device tree is associated with each
>> partition. The first version of this driver uses test version flat device
>> tree and call xrt lib API to unflatten it.
>>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
>> ---
>>   drivers/fpga/Makefile             |   1 +
>>   drivers/fpga/xrt/Kconfig          |   1 +
>>   drivers/fpga/xrt/mgmt/Kconfig     |  14 +++
>>   drivers/fpga/xrt/mgmt/Makefile    |  16 +++
>>   drivers/fpga/xrt/mgmt/dt-test.dts |  12 +++
>>   drivers/fpga/xrt/mgmt/dt-test.h   |  15 +++
>>   drivers/fpga/xrt/mgmt/xmgmt-drv.c | 158 ++++++++++++++++++++++++++++++
>>   7 files changed, 217 insertions(+)
>>   create mode 100644 drivers/fpga/xrt/mgmt/Kconfig
>>   create mode 100644 drivers/fpga/xrt/mgmt/Makefile
>>   create mode 100644 drivers/fpga/xrt/mgmt/dt-test.dts
>>   create mode 100644 drivers/fpga/xrt/mgmt/dt-test.h
>>   create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-drv.c
>>
>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>> index 5bd41cf4c7ec..544e2144878f 100644
>> --- a/drivers/fpga/Makefile
>> +++ b/drivers/fpga/Makefile
>> @@ -52,3 +52,4 @@ obj-$(CONFIG_FPGA_DFL_PCI)          += dfl-pci.o
>>
>>   # XRT drivers for Alveo
>>   obj-$(CONFIG_FPGA_XRT_LIB)           += xrt/lib/
>> +obj-$(CONFIG_FPGA_XRT_XMGMT)         += xrt/mgmt/
>> diff --git a/drivers/fpga/xrt/Kconfig b/drivers/fpga/xrt/Kconfig
>> index 04c3bb5aaf4f..50422f77c6df 100644
>> --- a/drivers/fpga/xrt/Kconfig
>> +++ b/drivers/fpga/xrt/Kconfig
>> @@ -4,3 +4,4 @@
>>   #
>>
>>   source "drivers/fpga/xrt/lib/Kconfig"
>> +source "drivers/fpga/xrt/mgmt/Kconfig"
>> diff --git a/drivers/fpga/xrt/mgmt/Kconfig b/drivers/fpga/xrt/mgmt/Kconfig
>> new file mode 100644
>> index 000000000000..a978747482be
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/mgmt/Kconfig
>> @@ -0,0 +1,14 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# Xilinx XRT FPGA device configuration
>> +#
>> +
>> +config FPGA_XRT_XMGMT
>> +     tristate "Xilinx Alveo Management Driver"
>> +     depends on FPGA_XRT_LIB
>> +     select FPGA_BRIDGE
>> +     select FPGA_REGION
>> +     help
>> +       Select this option to enable XRT PCIe driver for Xilinx Alveo FPGA.
>> +       This driver provides interfaces for userspace application to access
>> +       Alveo FPGA device.
>> diff --git a/drivers/fpga/xrt/mgmt/Makefile b/drivers/fpga/xrt/mgmt/Makefile
>> new file mode 100644
>> index 000000000000..c5134bf71cca
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/mgmt/Makefile
>> @@ -0,0 +1,16 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Copyright (C) 2020-2022 Xilinx, Inc. All rights reserved.
>> +#
>> +# Authors: Sonal.Santan@xilinx.com
>> +#
>> +
>> +FULL_XRT_PATH=$(srctree)/$(src)/..
>> +
>> +obj-$(CONFIG_FPGA_XRT_LIB) += xrt-mgmt.o
>> +
>> +xrt-mgmt-objs :=             \
>> +     xmgmt-drv.o             \
>> +     dt-test.dtb.o
>> +
>> +ccflags-y := -I$(FULL_XRT_PATH)/include
>> diff --git a/drivers/fpga/xrt/mgmt/dt-test.dts b/drivers/fpga/xrt/mgmt/dt-test.dts
>> new file mode 100644
>> index 000000000000..68dbcb7fd79d
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/mgmt/dt-test.dts
>> @@ -0,0 +1,12 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/dts-v1/;
>> +
>> +/ {
>> +     compatible = "xlnx,alveo-partition", "simple-bus";
>> +     #address-cells = <2>;
>> +     #size-cells = <2>;
>> +     pr_isolate_ulp@0,41000 {
>> +             compatible = "xlnx,alveo-pr-isolation";
>> +             reg = <0x0 0x41000 0x0 0x1000>;
>> +     };
>> +};
> I remember Rob's comments:
>
> "we'd need to create a base tree (if there isn't one) with nodes
> for the USB or PCI device(s) and then an overlay for the device can be
> applied to those nodes."
>
> https://lore.kernel.org/linux-fpga/CAL_JsqJfyRymB=VxLuQqLpep+Q1Eie48dobv9sC5OizDz0d2DQ@mail.gmail.com/
>
> So could we firstly create a pci device node under the of_root when
> the driver probing, then add the partition DTs under the pci device node
> by overlay machenism.
>
> I'm considering if finally we could leverage the existing of-fpga-region
> that reprograms and enumerates FPGA sub devices by overlay.
>
> Open for discussion.

I would list the main ideas of our implementation

1. “alveo-partition (simple-bus)” node is created under of_root in xmgmt 
probe function. “simple-bus” is used as it fits well and we can modify 
it to “fpga-region” when we refactor fpga-mgr/region/bridge part.
2. we are the first pcie device using flatten device tree to describe 
sub devices. Adding device tree nodes for all pcie device sounds 
intrusive. We can expend to all pcie device when we have another user of 
this feature.

3. of_overlay_fdt_apply() does not support overlaying to a dynamic 
generated parent node. Thus, we use of_dynamic functions 
of_changeset_attach_node() instead. (similar to 
drivers/pci/hotplug/pnv_php.c,) . If needed ,we can consider to add 
parameter “parent node” to of_overlay_fdt_apply() to support dynamical 
overlay case.


Thanks,

Lizhi

>
> Thanks,
> Yilun
>
>> diff --git a/drivers/fpga/xrt/mgmt/dt-test.h b/drivers/fpga/xrt/mgmt/dt-test.h
>> new file mode 100644
>> index 000000000000..6ec4203afbd2
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/mgmt/dt-test.h
>> @@ -0,0 +1,15 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2020-2022 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *   Lizhi Hou <lizhih@xilinx.com>
>> + */
>> +
>> +#ifndef _DT_TEST_H_
>> +#define _DT_TEST_H_
>> +
>> +extern u8 __dtb_dt_test_begin[];
>> +extern u8 __dtb_dt_test_end[];
>> +
>> +#endif       /* _DT_TEST_H_ */
>> diff --git a/drivers/fpga/xrt/mgmt/xmgmt-drv.c b/drivers/fpga/xrt/mgmt/xmgmt-drv.c
>> new file mode 100644
>> index 000000000000..87abe5b86e0b
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/mgmt/xmgmt-drv.c
>> @@ -0,0 +1,158 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Xilinx Alveo Management Function Driver
>> + *
>> + * Copyright (C) 2020-2022 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *   Cheng Zhen <maxz@xilinx.com>
>> + *   Lizhi Hou <lizhih@xilinx.com>
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <linux/aer.h>
>> +#include <linux/vmalloc.h>
>> +#include <linux/delay.h>
>> +#include "xpartition.h"
>> +#include "dt-test.h"
>> +
>> +#define XMGMT_MODULE_NAME    "xrt-mgmt"
>> +
>> +#define XMGMT_PDEV(xm)               ((xm)->pdev)
>> +#define XMGMT_DEV(xm)                (&(XMGMT_PDEV(xm)->dev))
>> +#define xmgmt_err(xm, fmt, args...)  \
>> +     dev_err(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
>> +#define xmgmt_warn(xm, fmt, args...) \
>> +     dev_warn(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
>> +#define xmgmt_info(xm, fmt, args...) \
>> +     dev_info(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
>> +#define xmgmt_dbg(xm, fmt, args...)  \
>> +     dev_dbg(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
>> +#define XMGMT_DEV_ID(_pcidev)                        \
>> +     ({ typeof(_pcidev) (pcidev) = (_pcidev);        \
>> +     ((pci_domain_nr((pcidev)->bus) << 16) | \
>> +     PCI_DEVID((pcidev)->bus->number, (pcidev)->devfn)); })
>> +
>> +#define XRT_MAX_READRQ               512
>> +
>> +/* PCI Device IDs */
>> +#define PCI_DEVICE_ID_U50            0x5020
>> +static const struct pci_device_id xmgmt_pci_ids[] = {
>> +     { PCI_DEVICE(PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_U50), }, /* Alveo U50 */
>> +     { 0, }
>> +};
>> +
>> +struct xmgmt {
>> +     struct pci_dev *pdev;
>> +     void *base_partition;
>> +
>> +     bool ready;
>> +};
>> +
>> +static int xmgmt_config_pci(struct xmgmt *xm)
>> +{
>> +     struct pci_dev *pdev = XMGMT_PDEV(xm);
>> +     int rc;
>> +
>> +     rc = pcim_enable_device(pdev);
>> +     if (rc < 0) {
>> +             xmgmt_err(xm, "failed to enable device: %d", rc);
>> +             return rc;
>> +     }
>> +
>> +     rc = pci_enable_pcie_error_reporting(pdev);
>> +     if (rc)
>> +             xmgmt_warn(xm, "failed to enable AER: %d", rc);
>> +
>> +     pci_set_master(pdev);
>> +
>> +     rc = pcie_get_readrq(pdev);
>> +     if (rc > XRT_MAX_READRQ)
>> +             pcie_set_readrq(pdev, XRT_MAX_READRQ);
>> +     return 0;
>> +}
>> +
>> +static int xmgmt_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>> +{
>> +     struct xrt_partition_range ranges[PCI_NUM_RESOURCES];
>> +     struct xrt_partition_info xp_info = { 0 };
>> +     struct device *dev = &pdev->dev;
>> +     int ret, i, idx = 0;
>> +     struct xmgmt *xm;
>> +
>> +     xm = devm_kzalloc(dev, sizeof(*xm), GFP_KERNEL);
>> +     if (!xm)
>> +             return -ENOMEM;
>> +     xm->pdev = pdev;
>> +     pci_set_drvdata(pdev, xm);
>> +
>> +     ret = xmgmt_config_pci(xm);
>> +     if (ret)
>> +             goto failed;
>> +
>> +     for (i = 0; i < PCI_NUM_RESOURCES; i++) {
>> +             if (pci_resource_len(pdev, i) > 0) {
>> +                     ranges[idx].bar_idx = i;
>> +                     ranges[idx].base = pci_resource_start(pdev, i);
>> +                     ranges[idx].size = pci_resource_len(pdev, i);
>> +                     idx++;
>> +             }
>> +     }
>> +     xp_info.num_range = idx;
>> +     xp_info.ranges = ranges;
>> +     xp_info.fdt = __dtb_dt_test_begin;
>> +     xp_info.fdt_len = (u32)(__dtb_dt_test_end - __dtb_dt_test_begin);
>> +     ret = xrt_partition_create(&pdev->dev, &xp_info, &xm->base_partition);
>> +     if (ret)
>> +             goto failed;
>> +
>> +     xmgmt_info(xm, "%s started successfully", XMGMT_MODULE_NAME);
>> +     return 0;
>> +
>> +failed:
>> +     if (xm->base_partition)
>> +             xrt_partition_destroy(xm->base_partition);
>> +     pci_set_drvdata(pdev, NULL);
>> +     return ret;
>> +}
>> +
>> +static void xmgmt_remove(struct pci_dev *pdev)
>> +{
>> +     struct xmgmt *xm = pci_get_drvdata(pdev);
>> +
>> +     xrt_partition_destroy(xm->base_partition);
>> +     pci_disable_pcie_error_reporting(xm->pdev);
>> +     xmgmt_info(xm, "%s cleaned up successfully", XMGMT_MODULE_NAME);
>> +}
>> +
>> +static struct pci_driver xmgmt_driver = {
>> +     .name = XMGMT_MODULE_NAME,
>> +     .id_table = xmgmt_pci_ids,
>> +     .probe = xmgmt_probe,
>> +     .remove = xmgmt_remove,
>> +};
>> +
>> +static int __init xmgmt_init(void)
>> +{
>> +     int res = 0;
>> +
>> +     res = pci_register_driver(&xmgmt_driver);
>> +     if (res)
>> +             return res;
>> +
>> +     return 0;
>> +}
>> +
>> +static __exit void xmgmt_exit(void)
>> +{
>> +     pci_unregister_driver(&xmgmt_driver);
>> +}
>> +
>> +module_init(xmgmt_init);
>> +module_exit(xmgmt_exit);
>> +
>> +MODULE_DEVICE_TABLE(pci, xmgmt_pci_ids);
>> +MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
>> +MODULE_DESCRIPTION("Xilinx Alveo management function driver");
>> +MODULE_LICENSE("GPL v2");
>> --
>> 2.27.0
