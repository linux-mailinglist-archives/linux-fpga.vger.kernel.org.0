Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180FA3348DD
	for <lists+linux-fpga@lfdr.de>; Wed, 10 Mar 2021 21:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhCJUY4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 10 Mar 2021 15:24:56 -0500
Received: from mail-mw2nam12on2043.outbound.protection.outlook.com ([40.107.244.43]:61001
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231246AbhCJUYz (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 10 Mar 2021 15:24:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvTMxtk7ikltI5DS7lPsnTDenAKvOfz9k0NEbOgRsYM7ejW1q03U6HYV+iAR/LPWsqU/nwJwzYB/7PRKvV/9y6kiKGkMX9Va7A8r5GdtkmbCRXQs8kaCb2D2fsLB6WhKBcuwa4Y8vGnszN/dLoPfwknL1obiKxKDJTUUFITyqYE4+U2R7G5+iyFxKw7CQvGSrEm+VfVLIMtC83YLFD/blMsttoD6SXIFxZpYHqpX52fyG8KHSIBsYY37VQoflDYhRsmdjUdk0A10jzRYqcY5glDZzwiwnzDLN4u+bFXzlC5WN4NVKFIsNtCL0EF10hbR++UY78CwP4VOVEMEBt2Czg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZ8AgI8PAJp8NqIU0x8gfkjO6R0kpULhuLaeHtpBqIk=;
 b=BFEXe50kESK+eDmf/3Cp4+QZqRsr3xHgITimTYSdtZSwy1FuYFam0JrMaVvoodKMKSEuyRE/ogHQy4nP7XhbUgCLdm1rAJPusB/FzhFM31A9NHeEetHLZfTyrz5AHLp4R4YCOdVoM2ObWSPJCZJzHQgtUtp3+nURbz4yhmQGan4UavhSSXQdyRU/wz3ZW+9EDZNt3xEXlBkKclL3N8bpcccOOnwnJPkpNyGUUpZA1Ib81oDiVun0gYBrg83AM/BFnzL9gQc22vgDa8fJPjDpVsujcXP1hVYhuhAG7zTHuKe+wp3Zw9ittTeCzyh6+qY1xFuPcZQf3FMd65Cyb99r7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZ8AgI8PAJp8NqIU0x8gfkjO6R0kpULhuLaeHtpBqIk=;
 b=VbZpQLBsv+tbpYSGRhoMSdYnsBgsJ2bpoo6eBaH7pjnCjizimL6ZcdVJ08rqr33tfDu17WrJEXO46hQxY1Slx7cc4jH3Iv9Us+dRgzEtXU1SjIZOMVefgtD60RAlTWtw4UGaYWlz+kEuINeAElB7RBPFaHaoXc4rXeEcnjDkRA8=
Received: from DM5PR1101CA0012.namprd11.prod.outlook.com (2603:10b6:4:4c::22)
 by CH2PR02MB6789.namprd02.prod.outlook.com (2603:10b6:610:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Wed, 10 Mar
 2021 20:24:53 +0000
Received: from DM3NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::4f) by DM5PR1101CA0012.outlook.office365.com
 (2603:10b6:4:4c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Wed, 10 Mar 2021 20:24:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT055.mail.protection.outlook.com (10.13.5.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.25 via Frontend Transport; Wed, 10 Mar 2021 20:24:52 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Mar 2021 12:24:52 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Wed, 10 Mar 2021 12:24:52 -0800
Envelope-to: robh@kernel.org,
 mdf@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.2.60] (port=40648)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lK5O0-0004PV-2e; Wed, 10 Mar 2021 12:24:52 -0800
Subject: Re: [PATCH V3 XRT Alveo 11/18] fpga: xrt: UCS platform driver
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <sonal.santan@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <mdf@kernel.org>, <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-12-lizhih@xilinx.com>
 <3e4edfaa-e90d-1889-cd05-41107e730c18@redhat.com>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <5013bcb9-2216-0c39-c557-51958fa5d0d4@xilinx.com>
Date:   Wed, 10 Mar 2021 12:24:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <3e4edfaa-e90d-1889-cd05-41107e730c18@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1f8941f-17b1-440c-3e95-08d8e402900c
X-MS-TrafficTypeDiagnostic: CH2PR02MB6789:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6789B5FBBB85EE534C727FF4A1919@CH2PR02MB6789.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qgUin5wG9QR5Rip3KGV8FOg/VsavbGNcjK+4+IFMi0mCVyoSe8Ysq/TRFfNDTastH8ggXZkANp5EYMp2GNBnzok//tLaVOZ5NQgKWYjx/haOvzrsZRoAoRe59ht/aXArk3QF5RUQ166+WJ6Utq2+iG8eoOVDRccukVLUPwEbbVcSgrQsV5CDA9Mu4rrZ6LJOiBb9wFMZxsb5HQMF8xYmJVTtTShqf7ZIWA6CkyAsYHzb9yIPNKDG4AShqymmCxG/X+yAey3FgCPqV5RUdJDFSqzCmyrefKtMjoc2UhNT9xMnC73LLAKUjSGiHgeBWcvVFmz9FqgfoDb8z1puR6ou3NbH+69w6VlrhaGCAaw1CSPohrgt1AZB0v+3X9338zhyfDh1emx3EL3/o+iSN4v6bFwav7VjaQU6quFQJejCVuTbr+pEo2BPsxcA1TB2AwolyxM82Ixv28li7MoWioDsFNRPViyWDQWBiuvg3/57OfWGmGsV/ZBsh7tIVWqmBuLIq+4ZfJx/VPE3EtGQBSrH3ggOsUDjRTqYccspIPAy5WFQNmve2iYuvwB0PmQ45BOSzYJWvfUJ1V28R/j/jFi3b8RSGzFe2o0CTQA/kFq+HV+7rzC0f31O1uMVZiGSy8jcX7tqQZz2l85mO9Ti+31PeZRrTsXNBO4cY0eDH+0A7RpfglgQGBaHjot9aInIFVMVDoQD2fNxLPMF6whGLA9HYz6MAEEhWW4D5QfcKJp6E1s=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(36840700001)(46966006)(8676002)(44832011)(82310400003)(478600001)(54906003)(9786002)(8936002)(47076005)(31686004)(36860700001)(5660300002)(26005)(70206006)(70586007)(186003)(36906005)(2906002)(4326008)(7636003)(2616005)(82740400003)(53546011)(31696002)(426003)(83380400001)(356005)(36756003)(316002)(107886003)(336012)(110136005)(50156003)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 20:24:52.9814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f8941f-17b1-440c-3e95-08d8e402900c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT055.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6789
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,


On 03/02/2021 08:09 AM, Tom Rix wrote:
> On 2/17/21 10:40 PM, Lizhi Hou wrote:
>> Add UCS driver. UCS is a hardware function discovered by walking xclbin
> What does UCS stand for ? add to commit log
UCS stands for User Clock Subsystem. I will add it to log.
>> metadata. A platform device node will be created for it.
>> UCS enables/disables the dynamic region clocks.
>>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
>> ---
>>   drivers/fpga/xrt/include/xleaf/ucs.h |  24 +++
>>   drivers/fpga/xrt/lib/xleaf/ucs.c     | 235 +++++++++++++++++++++++++++
>>   2 files changed, 259 insertions(+)
>>   create mode 100644 drivers/fpga/xrt/include/xleaf/ucs.h
>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/ucs.c
>>
>> diff --git a/drivers/fpga/xrt/include/xleaf/ucs.h b/drivers/fpga/xrt/include/xleaf/ucs.h
>> new file mode 100644
>> index 000000000000..a5ef0e100e12
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/include/xleaf/ucs.h
> This header is only used by ucs.c, so is it needed ?
>
> could the enum be defined in ucs.c ?
It will be used in the future. I will remove it.
>
>> @@ -0,0 +1,24 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Header file for XRT UCS Leaf Driver
>> + *
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *   Lizhi Hou <Lizhi.Hou@xilinx.com>
>> + */
>> +
>> +#ifndef _XRT_UCS_H_
>> +#define _XRT_UCS_H_
>> +
>> +#include "xleaf.h"
>> +
>> +/*
>> + * UCS driver IOCTL calls.
>> + */
>> +enum xrt_ucs_ioctl_cmd {
>> +     XRT_UCS_CHECK = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
>> +     XRT_UCS_ENABLE,
> no disable ?
It does not need to disable because reset the fpga bridge will disable 
it. I will remove ucs.h because it is not used in this patchset.
>> +};
>> +
>> +#endif       /* _XRT_UCS_H_ */
>> diff --git a/drivers/fpga/xrt/lib/xleaf/ucs.c b/drivers/fpga/xrt/lib/xleaf/ucs.c
>> new file mode 100644
>> index 000000000000..ae762c8fddbb
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/lib/xleaf/ucs.c
>> @@ -0,0 +1,235 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Xilinx Alveo FPGA UCS Driver
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
>> +#include "xleaf/ucs.h"
>> +#include "xleaf/clock.h"
>> +
>> +#define UCS_ERR(ucs, fmt, arg...)   \
>> +     xrt_err((ucs)->pdev, fmt "\n", ##arg)
>> +#define UCS_WARN(ucs, fmt, arg...)  \
>> +     xrt_warn((ucs)->pdev, fmt "\n", ##arg)
>> +#define UCS_INFO(ucs, fmt, arg...)  \
>> +     xrt_info((ucs)->pdev, fmt "\n", ##arg)
>> +#define UCS_DBG(ucs, fmt, arg...)   \
>> +     xrt_dbg((ucs)->pdev, fmt "\n", ##arg)
>> +
>> +#define XRT_UCS              "xrt_ucs"
>> +
>> +#define CHANNEL1_OFFSET                      0
>> +#define CHANNEL2_OFFSET                      8
>> +
>> +#define CLK_MAX_VALUE                        6400
>> +
>> +struct ucs_control_status_ch1 {
>> +     unsigned int shutdown_clocks_latched:1;
>> +     unsigned int reserved1:15;
>> +     unsigned int clock_throttling_average:14;
>> +     unsigned int reserved2:2;
>> +};
> Likely needs to be packed and/or the unsigned int changed to u32
Will remove this structure because it is not used in this patch set.
>> +
>> +struct xrt_ucs {
>> +     struct platform_device  *pdev;
>> +     void __iomem            *ucs_base;
>> +     struct mutex            ucs_lock; /* ucs dev lock */
>> +};
>> +
>> +static inline u32 reg_rd(struct xrt_ucs *ucs, u32 offset)
>> +{
>> +     return ioread32(ucs->ucs_base + offset);
>> +}
>> +
>> +static inline void reg_wr(struct xrt_ucs *ucs, u32 val, u32 offset)
>> +{
>> +     iowrite32(val, ucs->ucs_base + offset);
>> +}
>> +
>> +static void xrt_ucs_event_cb(struct platform_device *pdev, void *arg)
>> +{
>> +     struct platform_device  *leaf;
>> +     struct xrt_event *evt = (struct xrt_event *)arg;
>> +     enum xrt_events e = evt->xe_evt;
>> +     enum xrt_subdev_id id = evt->xe_subdev.xevt_subdev_id;
>> +     int instance = evt->xe_subdev.xevt_subdev_instance;
>> +
>> +     switch (e) {
>> +     case XRT_EVENT_POST_CREATION:
>> +             break;
>> +     default:
>> +             xrt_dbg(pdev, "ignored event %d", e);
>> +             return;
>> +     }
> this switch is a noop, remove
Will change to if (e != XRT_EVENT_POST_CREATION) return -EINVAL
>> +
>> +     if (id != XRT_SUBDEV_CLOCK)
>> +             return;
>> +
>> +     leaf = xleaf_get_leaf_by_id(pdev, XRT_SUBDEV_CLOCK, instance);
>> +     if (!leaf) {
>> +             xrt_err(pdev, "does not get clock subdev");
>> +             return;
>> +     }
>> +
>> +     xleaf_ioctl(leaf, XRT_CLOCK_VERIFY, NULL);
>> +     xleaf_put_leaf(pdev, leaf);
>> +}
>> +
>> +static void ucs_check(struct xrt_ucs *ucs, bool *latched)
>> +{
> checking but not returning status, change to returning int.
>
> this function is called but xrt_ucs_leaf_ioctl which does return status.
Will remove ucs_check() because it is not used in this patch set.
>
>> +     struct ucs_control_status_ch1 *ucs_status_ch1;
>> +     u32 status;
>> +
>> +     mutex_lock(&ucs->ucs_lock);
>> +     status = reg_rd(ucs, CHANNEL1_OFFSET);
>> +     ucs_status_ch1 = (struct ucs_control_status_ch1 *)&status;
>> +     if (ucs_status_ch1->shutdown_clocks_latched) {
>> +             UCS_ERR(ucs,
>> +                     "Critical temperature or power event, kernel clocks have been stopped.");
>> +             UCS_ERR(ucs,
>> +                     "run 'xbutil valiate -q' to continue. See AR 73398 for more details.");
> This error message does not seem like it would be useful, please review.
>> +             /* explicitly indicate reset should be latched */
>> +             *latched = true;
>> +     } else if (ucs_status_ch1->clock_throttling_average >
>> +         CLK_MAX_VALUE) {
>> +             UCS_ERR(ucs, "kernel clocks %d exceeds expected maximum value %d.",
>> +                     ucs_status_ch1->clock_throttling_average,
>> +                     CLK_MAX_VALUE);
>> +     } else if (ucs_status_ch1->clock_throttling_average) {
>> +             UCS_ERR(ucs, "kernel clocks throttled at %d%%.",
>> +                     (ucs_status_ch1->clock_throttling_average /
>> +                      (CLK_MAX_VALUE / 100)));
>> +     }
>> +     mutex_unlock(&ucs->ucs_lock);
>> +}
>> +
>> +static void ucs_enable(struct xrt_ucs *ucs)
>> +{
>> +     reg_wr(ucs, 1, CHANNEL2_OFFSET);
> lock ?
Yes. will add it.
>> +}
>> +
>> +static int
>> +xrt_ucs_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
>> +{
>> +     struct xrt_ucs          *ucs;
>> +     int                     ret = 0;
>> +
>> +     ucs = platform_get_drvdata(pdev);
>> +
>> +     switch (cmd) {
>> +     case XRT_XLEAF_EVENT:
>> +             xrt_ucs_event_cb(pdev, arg);
>> +             break;
>> +     case XRT_UCS_CHECK: {
> brace not needed here
will remove.
>> +             ucs_check(ucs, (bool *)arg);
>> +             break;
>> +     }
>> +     case XRT_UCS_ENABLE:
>> +             ucs_enable(ucs);
>> +             break;
>> +     default:
>> +             xrt_err(pdev, "unsupported cmd %d", cmd);
>> +             return -EINVAL;
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +static int ucs_remove(struct platform_device *pdev)
>> +{
>> +     struct xrt_ucs *ucs;
>> +
>> +     ucs = platform_get_drvdata(pdev);
>> +     if (!ucs) {
> is this possible ?
Will remove.

Thanks,
Lizhi
>
> Tom
>
>> +             xrt_err(pdev, "driver data is NULL");
>> +             return -EINVAL;
>> +     }
>> +
>> +     if (ucs->ucs_base)
>> +             iounmap(ucs->ucs_base);
>> +
>> +     platform_set_drvdata(pdev, NULL);
>> +     devm_kfree(&pdev->dev, ucs);
>> +
>> +     return 0;
>> +}
>> +
>> +static int ucs_probe(struct platform_device *pdev)
>> +{
>> +     struct xrt_ucs *ucs = NULL;
>> +     struct resource *res;
>> +     int ret;
>> +
>> +     ucs = devm_kzalloc(&pdev->dev, sizeof(*ucs), GFP_KERNEL);
>> +     if (!ucs)
>> +             return -ENOMEM;
>> +
>> +     platform_set_drvdata(pdev, ucs);
>> +     ucs->pdev = pdev;
>> +     mutex_init(&ucs->ucs_lock);
>> +
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     ucs->ucs_base = ioremap(res->start, res->end - res->start + 1);
>> +     if (!ucs->ucs_base) {
>> +             UCS_ERR(ucs, "map base %pR failed", res);
>> +             ret = -EFAULT;
>> +             goto failed;
>> +     }
>> +     ucs_enable(ucs);
>> +
>> +     return 0;
>> +
>> +failed:
>> +     ucs_remove(pdev);
>> +     return ret;
>> +}
>> +
>> +static struct xrt_subdev_endpoints xrt_ucs_endpoints[] = {
>> +     {
>> +             .xse_names = (struct xrt_subdev_ep_names[]) {
>> +                     { .ep_name = XRT_MD_NODE_UCS_CONTROL_STATUS },
>> +                     { NULL },
>> +             },
>> +             .xse_min_ep = 1,
>> +     },
>> +     { 0 },
>> +};
>> +
>> +static struct xrt_subdev_drvdata xrt_ucs_data = {
>> +     .xsd_dev_ops = {
>> +             .xsd_ioctl = xrt_ucs_leaf_ioctl,
>> +     },
>> +};
>> +
>> +static const struct platform_device_id xrt_ucs_table[] = {
>> +     { XRT_UCS, (kernel_ulong_t)&xrt_ucs_data },
>> +     { },
>> +};
>> +
>> +static struct platform_driver xrt_ucs_driver = {
>> +     .driver = {
>> +             .name = XRT_UCS,
>> +     },
>> +     .probe = ucs_probe,
>> +     .remove = ucs_remove,
>> +     .id_table = xrt_ucs_table,
>> +};
>> +
>> +void ucs_leaf_init_fini(bool init)
>> +{
>> +     if (init)
>> +             xleaf_register_driver(XRT_SUBDEV_UCS, &xrt_ucs_driver, xrt_ucs_endpoints);
>> +     else
>> +             xleaf_unregister_driver(XRT_SUBDEV_UCS);
>> +}

