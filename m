Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93C0339A20
	for <lists+linux-fpga@lfdr.de>; Sat, 13 Mar 2021 00:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbhCLXoG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 12 Mar 2021 18:44:06 -0500
Received: from mail-bn8nam11on2077.outbound.protection.outlook.com ([40.107.236.77]:12352
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235863AbhCLXn5 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 12 Mar 2021 18:43:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7Zz+DQ+6ELVJ2SQqHOHuOPqoFTuKMNMBXjskBKZ7eaToTfzN15kJXUgxcEuQYD39Z+f4WCs40iwIpah7kJGexS8h9mHJSmOwkSUJ+ZKl1KJjHghdAEdA87CZ+WeInnxxuvtsEui2ill8Sw4OenRsTXvaWqbJkuoYY76ZVbGIWmt27Hy78KF3USClVXBGNFnuiTDT1/2MQrYBveJxKNpwYr0l6c5yEPrtnwSjDL1PtBsSioiN01HnZlIZNv2MlYd48P/bhzsjoVsbDtC/z5IQkadaYmEDXRJ+bwoO8fNpsnvd260Rt0qPmR5nlifonKFAYh4n+/Q6DKejZwkWT09FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G497oqaaIeXa5NsTqmZQU/6GONH+b1ZwhWk5QxGIUnQ=;
 b=YSQGr/L/LuikDbhCCFJejiARruZffKyXPzPy6PSxKGBV0Ma5WbF6kTGuWlbC5zjRxv+3w51+H2pfCo/bP4St5Fkd2e5XHbPITCc1wvlfad12ZhSrmycl+k5vgKDrMm7hwvNyh/qUDxlTK6iQsOe4riSWoFR7TS/LDA8tVpod8nNA/ckSuL13cpZ8z2HMtR0odKUFHux5zFdiVHM9b3gR5xRbIv9l9CWvEHx6sWgihA+BUfKBdNvocZKvtp30HLishZFOoSQHoRfiwwrsaPoDXoLb/pSdcCaEU41PMH1thK/abn1H45hsW4uwqsT0QjZxOA5u07AhIVZD1yZjTkrX5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G497oqaaIeXa5NsTqmZQU/6GONH+b1ZwhWk5QxGIUnQ=;
 b=UlJ20yoMBSZLh2GtJgGiSGHo8xwveicLg5SmNxW0ARXbVHalio7dI0S/sAzQbsbvvoOfDsdxKQRgOfsbqln40Uh2hfPKX5IlnUI1yGoJIXkM11YrZy3pi4NXwRxGVIFI+1wsuT0iQtIsAU9oDEZ2X7IjGJNMMj5iBqn2PrTxpxM=
Received: from CY4PR1201CA0004.namprd12.prod.outlook.com
 (2603:10b6:910:16::14) by DM6PR02MB5419.namprd02.prod.outlook.com
 (2603:10b6:5:79::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 23:43:55 +0000
Received: from CY1NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2603:10b6:910:16:cafe::7c) by CY4PR1201CA0004.outlook.office365.com
 (2603:10b6:910:16::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 12 Mar 2021 23:43:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT015.mail.protection.outlook.com (10.152.75.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.25 via Frontend Transport; Fri, 12 Mar 2021 23:43:55 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 12 Mar 2021 15:43:55 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Fri, 12 Mar 2021 15:43:55 -0800
Envelope-to: robh@kernel.org,
 mdf@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.2.60] (port=45574)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lKrRj-0002Xw-1R; Fri, 12 Mar 2021 15:43:55 -0800
Subject: Re: [PATCH V3 XRT Alveo 15/18] fpga: xrt: clock frequence counter
 platform driver
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <sonal.santan@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <mdf@kernel.org>, <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-16-lizhih@xilinx.com>
 <85c34149-ccb4-31c9-4a7d-477b30effad2@redhat.com>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <4dcd1a9f-1d96-6c1e-8e70-13cbc312c7b5@xilinx.com>
Date:   Fri, 12 Mar 2021 15:43:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <85c34149-ccb4-31c9-4a7d-477b30effad2@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e39ff261-c358-4f77-0feb-08d8e5b0b313
X-MS-TrafficTypeDiagnostic: DM6PR02MB5419:
X-Microsoft-Antispam-PRVS: <DM6PR02MB54198D899DC05B790950F05FA16F9@DM6PR02MB5419.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q3URuf4bsYRFm+OfzG3WHBExYe6vUeskYC9RBSaKdErmavjaNLZB/D0bKNOlOmQa8n/JRrnF8WAXjkktLVXzykxa0DC4jGclZ+0v4Zne0InB+LbJqAD1dgOAE1jym8bWziIZ/p4V+sr5BHvpQ8/Wk5ZX8uS7QkSFCOo0K4HUt9xUVEsOnbWK1M++0M258Hku2Iplv4PjNNkmAeKpWaxJbXorTQHIBcoFfrVxWuDhZVBko8ZdpvlzH7gr5nrxo6tjSIpaFrNQptQC/dTsKyx/xjMxkQR7Ad4fV+jczLS3d2ZEOd2Eze38rqahZvGcDNpIBEzWApzSn7Ar+0fDdPrU3G9xR68ma7tFGELHaiKpzRayM+iqlyE3pC9C4z/NUGduMHZwBJXKDp8OpUapKuC8TXEETcT2ogKKO+8BGO8T3Kb9OOZehGqxsEqqLxS6zKEkUP10OrkoMO3GLZEPV7M2+LxQ8p/Mhi8szMv/kVYuRwM0ORyfwbSmOXVCmkGsOlrv/a8g/L1jHKuo6m+1b/srq6TPIx+yUOIXYtjWNRBfrXvne/Hq0E8zxCHPCGVi0KM7AOaYvJv/ZD3bONk71x8/XT37CnMh8aAOIY2VDCbe+/YoBbJ2/yMlIlobkRKylHzqIEsIQ6wd11gZxVUlZKxoUQIsmGwOf8GNSUyclRbs/aLSC0LhYZbFo9Pb7gWj7B7BXnoa33OfvWUizQVp0Wtq3jrC2TkSm5+Y4+aI2UZv/C8=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966006)(36840700001)(336012)(36756003)(83380400001)(356005)(4326008)(7636003)(107886003)(26005)(426003)(186003)(36906005)(36860700001)(5660300002)(82310400003)(2616005)(316002)(110136005)(70206006)(44832011)(70586007)(31696002)(31686004)(47076005)(8676002)(8936002)(2906002)(53546011)(54906003)(478600001)(9786002)(82740400003)(50156003)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 23:43:55.3681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e39ff261-c358-4f77-0feb-08d8e5b0b313
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT015.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5419
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,


On 03/06/2021 07:25 AM, Tom Rix wrote:
> On 2/17/21 10:40 PM, Lizhi Hou wrote:
>> Add clock frequence counter driver. Clock frequence counter is
>> a hardware function discovered by walking xclbin metadata. A platform
>> device node will be created for it. Other part of driver can read the
>> actual clock frequence through clock frequence counter driver.
>>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
>> ---
>>   drivers/fpga/xrt/include/xleaf/clkfreq.h |  23 +++
>>   drivers/fpga/xrt/lib/xleaf/clkfreq.c     | 221 +++++++++++++++++++++++
>>   2 files changed, 244 insertions(+)
>>   create mode 100644 drivers/fpga/xrt/include/xleaf/clkfreq.h
>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/clkfreq.c
>>
>> diff --git a/drivers/fpga/xrt/include/xleaf/clkfreq.h b/drivers/fpga/xrt/include/xleaf/clkfreq.h
>> new file mode 100644
>> index 000000000000..29fc45e8a31b
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/include/xleaf/clkfreq.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Header file for XRT Clock Counter Leaf Driver
>> + *
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *   Lizhi Hou <Lizhi.Hou@xilinx.com>
>> + */
>> +
>> +#ifndef _XRT_CLKFREQ_H_
>> +#define _XRT_CLKFREQ_H_
>> +
>> +#include "xleaf.h"
>> +
>> +/*
>> + * CLKFREQ driver IOCTL calls.
>> + */
>> +enum xrt_clkfreq_ioctl_cmd {
>> +     XRT_CLKFREQ_READ = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
>> +};
>> +
>> +#endif       /* _XRT_CLKFREQ_H_ */
>> diff --git a/drivers/fpga/xrt/lib/xleaf/clkfreq.c b/drivers/fpga/xrt/lib/xleaf/clkfreq.c
>> new file mode 100644
>> index 000000000000..2482dd2cff47
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/lib/xleaf/clkfreq.c
>> @@ -0,0 +1,221 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Xilinx Alveo FPGA Clock Frequency Counter Driver
>> + *
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *      Lizhi Hou<Lizhi.Hou@xilinx.com>
>> + */
>> +
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/io.h>
>> +#include "metadata.h"
>> +#include "xleaf.h"
>> +#include "xleaf/clkfreq.h"
>> +
>> +#define CLKFREQ_ERR(clkfreq, fmt, arg...)   \
>> +     xrt_err((clkfreq)->pdev, fmt "\n", ##arg)
>> +#define CLKFREQ_WARN(clkfreq, fmt, arg...)  \
>> +     xrt_warn((clkfreq)->pdev, fmt "\n", ##arg)
>> +#define CLKFREQ_INFO(clkfreq, fmt, arg...)  \
>> +     xrt_info((clkfreq)->pdev, fmt "\n", ##arg)
>> +#define CLKFREQ_DBG(clkfreq, fmt, arg...)   \
>> +     xrt_dbg((clkfreq)->pdev, fmt "\n", ##arg)
>> +
>> +#define XRT_CLKFREQ          "xrt_clkfreq"
>> +
>> +#define OCL_CLKWIZ_STATUS_MASK               0xffff
>> +
>> +#define OCL_CLKWIZ_STATUS_MEASURE_START      0x1
>> +#define OCL_CLKWIZ_STATUS_MEASURE_DONE       0x2
>> +#define OCL_CLK_FREQ_COUNTER_OFFSET  0x8
>> +#define OCL_CLK_FREQ_V5_COUNTER_OFFSET       0x10
>> +#define OCL_CLK_FREQ_V5_CLK0_ENABLED 0x10000
> Similar to earlier, OCL -> XRT_CLKFREQ
>
> Use regmap
Will change this.
>
>> +
>> +struct clkfreq {
>> +     struct platform_device  *pdev;
>> +     void __iomem            *clkfreq_base;
>> +     const char              *clkfreq_ep_name;
>> +     struct mutex            clkfreq_lock; /* clock counter dev lock */
>> +};
>> +
>> +static inline u32 reg_rd(struct clkfreq *clkfreq, u32 offset)
>> +{
>> +     return ioread32(clkfreq->clkfreq_base + offset);
>> +}
>> +
>> +static inline void reg_wr(struct clkfreq *clkfreq, u32 val, u32 offset)
>> +{
>> +     iowrite32(val, clkfreq->clkfreq_base + offset);
>> +}
>> +
>> +static u32 clkfreq_read(struct clkfreq *clkfreq)
>> +{
> failure returns 0, it would be better if -EINVAL or similar was returned.
>
> and u32 *freq added as a function parameter
Will change this.
>
>> +     u32 freq = 0, status;
>> +     int times = 10;
> 10 is a config parameter, should be a #define
Sure.
>> +
>> +     mutex_lock(&clkfreq->clkfreq_lock);
>> +     reg_wr(clkfreq, OCL_CLKWIZ_STATUS_MEASURE_START, 0);
>> +     while (times != 0) {
>> +             status = reg_rd(clkfreq, 0);
>> +             if ((status & OCL_CLKWIZ_STATUS_MASK) ==
>> +                 OCL_CLKWIZ_STATUS_MEASURE_DONE)
>> +                     break;
>> +             mdelay(1);
>> +             times--;
>> +     };
>> +     if (times > 0) {
> I do not like tristate setting, convert to if-else
Will change this.
>> +             freq = (status & OCL_CLK_FREQ_V5_CLK0_ENABLED) ?
>> +                     reg_rd(clkfreq, OCL_CLK_FREQ_V5_COUNTER_OFFSET) :
>> +                     reg_rd(clkfreq, OCL_CLK_FREQ_COUNTER_OFFSET);
>> +     }
>> +     mutex_unlock(&clkfreq->clkfreq_lock);
>> +
>> +     return freq;
>> +}
>> +
>> +static ssize_t freq_show(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +     struct clkfreq *clkfreq = platform_get_drvdata(to_platform_device(dev));
>> +     u32 freq;
>> +     ssize_t count;
>> +
>> +     freq = clkfreq_read(clkfreq);
> unchecked error
Will add check.
>> +     count = snprintf(buf, 64, "%d\n", freq);
> %u
Sure.
>> +
>> +     return count;
>> +}
>> +static DEVICE_ATTR_RO(freq);
>> +
>> +static struct attribute *clkfreq_attrs[] = {
>> +     &dev_attr_freq.attr,
>> +     NULL,
>> +};
>> +
>> +static struct attribute_group clkfreq_attr_group = {
>> +     .attrs = clkfreq_attrs,
>> +};
>> +
>> +static int
>> +xrt_clkfreq_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
>> +{
>> +     struct clkfreq          *clkfreq;
>> +     int                     ret = 0;
>> +
>> +     clkfreq = platform_get_drvdata(pdev);
>> +
>> +     switch (cmd) {
>> +     case XRT_XLEAF_EVENT:
>> +             /* Does not handle any event. */
>> +             break;
>> +     case XRT_CLKFREQ_READ: {
> brace not needed
Will remove.
>> +             *(u32 *)arg = clkfreq_read(clkfreq);
> Unchecked error
Will add check.
>> +             break;
>> +     }
>> +     default:
>> +             xrt_err(pdev, "unsupported cmd %d", cmd);
>> +             return -EINVAL;
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +static int clkfreq_remove(struct platform_device *pdev)
>> +{
>> +     struct clkfreq *clkfreq;
>> +
>> +     clkfreq = platform_get_drvdata(pdev);
>> +     if (!clkfreq) {
>> +             xrt_err(pdev, "driver data is NULL");
>> +             return -EINVAL;
>> +     }
>> +
>> +     platform_set_drvdata(pdev, NULL);
>> +     devm_kfree(&pdev->dev, clkfreq);
>> +
>> +     CLKFREQ_INFO(clkfreq, "successfully removed clkfreq subdev");
>> +     return 0;
>> +}
>> +
>> +static int clkfreq_probe(struct platform_device *pdev)
>> +{
>> +     struct clkfreq *clkfreq = NULL;
>> +     struct resource *res;
>> +     int ret;
>> +
>> +     clkfreq = devm_kzalloc(&pdev->dev, sizeof(*clkfreq), GFP_KERNEL);
>> +     if (!clkfreq)
>> +             return -ENOMEM;
>> +
>> +     platform_set_drvdata(pdev, clkfreq);
>> +     clkfreq->pdev = pdev;
>> +     mutex_init(&clkfreq->clkfreq_lock);
>> +
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     clkfreq->clkfreq_base = ioremap(res->start, res->end - res->start + 1);
>> +     if (!clkfreq->clkfreq_base) {
>> +             CLKFREQ_ERR(clkfreq, "map base %pR failed", res);
>> +             ret = -EFAULT;
>> +             goto failed;
>> +     }
>> +     clkfreq->clkfreq_ep_name = res->name;
>> +
>> +     ret = sysfs_create_group(&pdev->dev.kobj, &clkfreq_attr_group);
>> +     if (ret) {
>> +             CLKFREQ_ERR(clkfreq, "create clkfreq attrs failed: %d", ret);
>> +             goto failed;
>> +     }
>> +
>> +     CLKFREQ_INFO(clkfreq, "successfully initialized clkfreq subdev");
>> +
>> +     return 0;
>> +
>> +failed:
>> +     clkfreq_remove(pdev);
>> +     return ret;
>> +}
>> +
>> +static struct xrt_subdev_endpoints xrt_clkfreq_endpoints[] = {
>> +     {
>> +             .xse_names = (struct xrt_subdev_ep_names[]) {
>> +                     { .regmap_name = "freq_cnt" },
> name should be closer to filename, maybe 'clock_frequency' or 'clkfreq'
'freq_cnt' is from firmware metadata. I will add #define in metadata.h.

Thanks,
Lizhi
>
> Tom
>
>> +                     { NULL },
>> +             },
>> +             .xse_min_ep = 1,
>> +     },
>> +     { 0 },
>> +};
>> +
>> +static struct xrt_subdev_drvdata xrt_clkfreq_data = {
>> +     .xsd_dev_ops = {
>> +             .xsd_ioctl = xrt_clkfreq_leaf_ioctl,
>> +     },
>> +};
>> +
>> +static const struct platform_device_id xrt_clkfreq_table[] = {
>> +     { XRT_CLKFREQ, (kernel_ulong_t)&xrt_clkfreq_data },
>> +     { },
>> +};
>> +
>> +static struct platform_driver xrt_clkfreq_driver = {
>> +     .driver = {
>> +             .name = XRT_CLKFREQ,
>> +     },
>> +     .probe = clkfreq_probe,
>> +     .remove = clkfreq_remove,
>> +     .id_table = xrt_clkfreq_table,
>> +};
>> +
>> +void clkfreq_leaf_init_fini(bool init)
>> +{
>> +     if (init) {
>> +             xleaf_register_driver(XRT_SUBDEV_CLKFREQ,
>> +                                   &xrt_clkfreq_driver, xrt_clkfreq_endpoints);
>> +     } else {
>> +             xleaf_unregister_driver(XRT_SUBDEV_CLKFREQ);
>> +     }
>> +}

