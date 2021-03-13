Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561AE339C7A
	for <lists+linux-fpga@lfdr.de>; Sat, 13 Mar 2021 07:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbhCMGx7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 13 Mar 2021 01:53:59 -0500
Received: from mail-bn8nam12on2070.outbound.protection.outlook.com ([40.107.237.70]:29217
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232627AbhCMGxw (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 13 Mar 2021 01:53:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpZuLWSOSEp8/NJ7IXmv/QTroZE3DhQb3pD125H9dskd9224rSD6Rzq6h5m3gNbgfBKiGdNlSU87Qj3xcZgAQdhGMfWN5a1tQS9W3VjEwFQ6AHCGraFkQPWo0Vif8dj7R2vs21GdkCys7MxJ9/ka8CIOgQ70ZvZqaHxawoCy1l+y8P/CloGVEb5VO5T1Pl0+ZUqyQxZc/huELUtpp5NDDD+sU9Q9c9LZrj1oAFbpHxQdBtlallNx+Dd+oyD/QsfkqzHKq/3LkfoJlWAlZoWz/hM/9QqyXGDLWbpeCdyFx5GSMeJmtO23tCsmqq6jSawBnCx5ZHaJJhIe9y3YWmg0GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Wk9yY2+Axn/bLEL6PNpblUs1zD2GtWe0fOvGj6cufU=;
 b=PiqDyjKCGLANs1UmbZ+Mh7m9Gx5qHaUly6vTxAcZgaU83ytbA4FElqY/+gcnVcGy9GJTgiRTF4w+gEAahLsJDrGrefQmr5s8nakWGKTOsX3buI8Xr8TmtwYTLnGovlsj47hpLtPgxlyc53ojrGWfu4J2ysoPZJevH018Cmcq4ByZN4Wj7Vr+V20Z8F2PdZ6XG78b7SdguCOrT+bMKwus7TVJtiPvMYJyTiRP/TkwzxJL8iZdFR+DQlQLYw/v8OpoNmOrEBf1qMqZ4d9mCX75lN9P4NdsdXTGaMuUtuA7WQJvLa/hZQHacUY64F8BcAbccFw8XsglOsGtdqgGQAtZsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Wk9yY2+Axn/bLEL6PNpblUs1zD2GtWe0fOvGj6cufU=;
 b=VBH61KaaNhTwqwheeGxARS9t7zp9Y5KHiqc1azAnESEIgg7dEwzCS4h30utcMAtKpyCBSbo7yd7mf+32/bUUl1lpskDrAPzQdmeHF1nF3+AvqoO/nIE+VPa1ST6YSef1tA3RzNxuNslPaivwyWNH8OEuQ5ysbLWVQ7wmO5SqNPc=
Received: from BL0PR02CA0072.namprd02.prod.outlook.com (2603:10b6:207:3d::49)
 by BL0PR02MB5554.namprd02.prod.outlook.com (2603:10b6:208:8d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Sat, 13 Mar
 2021 06:53:42 +0000
Received: from BL2NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:3d:cafe::a0) by BL0PR02CA0072.outlook.office365.com
 (2603:10b6:207:3d::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend
 Transport; Sat, 13 Mar 2021 06:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT035.mail.protection.outlook.com (10.152.77.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.25 via Frontend Transport; Sat, 13 Mar 2021 06:53:42 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 12 Mar 2021 22:53:41 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Fri, 12 Mar 2021 22:53:41 -0800
Envelope-to: robh@kernel.org,
 mdf@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.2.60] (port=46250)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lKy9d-0003xQ-ME; Fri, 12 Mar 2021 22:53:41 -0800
Subject: Re: [PATCH V3 XRT Alveo 17/18] fpga: xrt: partition isolation
 platform driver
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <sonal.santan@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <mdf@kernel.org>, <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-18-lizhih@xilinx.com>
 <74def489-0a25-f90a-a00c-9d79dcbaf25a@redhat.com>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <41c8a448-ca43-e296-3253-97e24483b0a2@xilinx.com>
Date:   Fri, 12 Mar 2021 22:53:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <74def489-0a25-f90a-a00c-9d79dcbaf25a@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b64262ea-0f54-42a6-7767-08d8e5ecbd29
X-MS-TrafficTypeDiagnostic: BL0PR02MB5554:
X-Microsoft-Antispam-PRVS: <BL0PR02MB555462772F2B39C00BBAB9FBA16E9@BL0PR02MB5554.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9iomgWVo6Y6q1BSin9PuRe2hY/EqrYYUTCc4XepEABxs04Qf7MtC9yu09EpiK6RqpekvWxfeNVBUnhJ9VudSqgYI9IENwrpgF//WsO9hq3iIoTN9+ghe7xFSWVQVajzwmscaGaVGv709QmOzLYjdUL6+2j2cOz0q0qhr9mHibG2KGW+IaF4MxCbdam9470r7ABMtaCe29d3v8wV+hodgoM4+1S8Yikijz4rilOOmPUKJ8/MNgNGWZhuZpOjJPMnyMBrU1YrKAcg1+wb04V2HAnPkCQ30K6t0JikEvjcfD0xzC9KEwILzWf5u91TO/0PG1cENz7i/cDHbYYkrweskiqpmcerIJwSIS/1V/w/cU3pqhmxqIzRiMqKcqK4dx1E4SK8Xjcw3AFQ1TUDoV4Q5MhqFfqTyO6skNJoZqMb1kb9uae+uORgd2oDA8fTHRkFcLUSKUf4ugtkJf8LgzzPn/Z6PjIc+2mV5i7GjU5VWYNurKAkc0MlNE5lDEzrOF5DJeh03hhI6A0+tZjLykbDj7eqHj0POpq5N3PMn9+O9/mL36Nq+uuTHXxoBQ9LhX4SgyvjakE1wJ5dLDXnCnOWQ485gJdx2DHFc7PnNE0rLm4jDZd7xfrWtwd+9X5aGr8ncWws60BuR0BLLj3KfvmOhcEXhP4Z1Zh62qiTjzbHjUFama5/Kmuf87hU3XyQGSjAmQyJV536RIAkNRoOAym4lRbI5WXwou6EUOCxvCwFZrTI=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(46966006)(36840700001)(336012)(356005)(31696002)(110136005)(44832011)(8936002)(316002)(2616005)(8676002)(426003)(36906005)(54906003)(31686004)(26005)(47076005)(53546011)(36860700001)(7636003)(70206006)(70586007)(107886003)(4326008)(9786002)(2906002)(186003)(82310400003)(5660300002)(478600001)(83380400001)(30864003)(36756003)(82740400003)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2021 06:53:42.0087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b64262ea-0f54-42a6-7767-08d8e5ecbd29
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT035.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5554
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,

On 03/06/2021 07:54 AM, Tom Rix wrote:
> On 2/17/21 10:40 PM, Lizhi Hou wrote:
>> Add partition isolation platform driver. partition isolation is
>> a hardware function discovered by walking firmware metadata.
>> A platform device node will be created for it. Partition isolation
>> function isolate the different fpga regions
>>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
>> ---
>>   drivers/fpga/xrt/include/xleaf/axigate.h |  25 ++
>>   drivers/fpga/xrt/lib/xleaf/axigate.c     | 298 +++++++++++++++++++++++
>>   2 files changed, 323 insertions(+)
>>   create mode 100644 drivers/fpga/xrt/include/xleaf/axigate.h
>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/axigate.c
>>
>> diff --git a/drivers/fpga/xrt/include/xleaf/axigate.h b/drivers/fpga/xrt/include/xleaf/axigate.h
>> new file mode 100644
>> index 000000000000..2cef71e13b30
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/include/xleaf/axigate.h
>> @@ -0,0 +1,25 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Header file for XRT Axigate Leaf Driver
>> + *
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *   Lizhi Hou <Lizhi.Hou@xilinx.com>
>> + */
>> +
>> +#ifndef _XRT_AXIGATE_H_
>> +#define _XRT_AXIGATE_H_
>> +
>> +#include "xleaf.h"
>> +#include "metadata.h"
>> +
>> +/*
>> + * AXIGATE driver IOCTL calls.
>> + */
>> +enum xrt_axigate_ioctl_cmd {
>> +     XRT_AXIGATE_FREEZE = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
>> +     XRT_AXIGATE_FREE,
> These are substrings, could change suffix to make it harder for developer to mix up.
Will change 'freeze' to 'close', 'free' to 'open'.
>> +};
>> +
>> +#endif       /* _XRT_AXIGATE_H_ */
>> diff --git a/drivers/fpga/xrt/lib/xleaf/axigate.c b/drivers/fpga/xrt/lib/xleaf/axigate.c
>> new file mode 100644
>> index 000000000000..382969f9925f
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/lib/xleaf/axigate.c
>> @@ -0,0 +1,298 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Xilinx Alveo FPGA AXI Gate Driver
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
>> +#include "xleaf/axigate.h"
>> +
>> +#define XRT_AXIGATE "xrt_axigate"
>> +
>> +struct axigate_regs {
>> +     u32             iag_wr;
>> +     u32             iag_rvsd;
>> +     u32             iag_rd;
>> +} __packed;
> similar to other patches, prefix of element is not needed.
Will remove this and use #define and regmap.
>> +
>> +struct xrt_axigate {
>> +     struct platform_device  *pdev;
>> +     void                    *base;
>> +     struct mutex            gate_lock; /* gate dev lock */
>> +
>> +     void                    *evt_hdl;
>> +     const char              *ep_name;
>> +
>> +     bool                    gate_freezed;
>> +};
>> +
>> +/* the ep names are in the order of hardware layers */
>> +static const char * const xrt_axigate_epnames[] = {
>> +     XRT_MD_NODE_GATE_PLP,
>> +     XRT_MD_NODE_GATE_ULP,
> what are plp, ulp ? it is helpful to comment or expand acronyms
plp stands for  provider logic partition and ulp stands for user logic 
partition. Will add comment.
>> +     NULL
>> +};
>> +
>> +#define reg_rd(g, r)                                         \
>> +     ioread32((void *)(g)->base + offsetof(struct axigate_regs, r))
>> +#define reg_wr(g, v, r)                                              \
>> +     iowrite32(v, (void *)(g)->base + offsetof(struct axigate_regs, r))
>> +
>> +static inline void freeze_gate(struct xrt_axigate *gate)
>> +{
>> +     reg_wr(gate, 0, iag_wr);
> The values written here and below are magic, the need to have #defines
Will add #defines
>> +     ndelay(500);
>> +     reg_rd(gate, iag_rd);
>> +}
>> +
>> +static inline void free_gate(struct xrt_axigate *gate)
>> +{
>> +     reg_wr(gate, 0x2, iag_wr);
>> +     ndelay(500);
>> +     (void)reg_rd(gate, iag_rd);
>> +     reg_wr(gate, 0x3, iag_wr);
>> +     ndelay(500);
>> +     reg_rd(gate, iag_rd);
>> +}
>> +
>> +static int xrt_axigate_epname_idx(struct platform_device *pdev)
>> +{
>> +     int                     i;
>> +     int                     ret;
> int i, ret;
sure.
>> +     struct resource         *res;
>> +
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     if (!res) {
>> +             xrt_err(pdev, "Empty Resource!");
>> +             return -EINVAL;
>> +     }
>> +
>> +     for (i = 0; xrt_axigate_epnames[i]; i++) {
> null guarded array is useful with the size isn't know,
>
> in this case it is, so covert loop to using ARRAY_SIZE
Will use ARRAY_SIZE.
>
>> +             ret = strncmp(xrt_axigate_epnames[i], res->name,
>> +                           strlen(xrt_axigate_epnames[i]) + 1);
> needs a strlen check in case res->name is just a substring
'strlen() + 1' is used, thus the comparing covers substring as well.
>> +             if (!ret)
>> +                     break;
>> +     }
>> +
>> +     ret = (xrt_axigate_epnames[i]) ? i : -EINVAL;
>> +     return ret;
>> +}
>> +
>> +static void xrt_axigate_freeze(struct platform_device *pdev)
>> +{
>> +     struct xrt_axigate      *gate;
>> +     u32                     freeze = 0;
>> +
>> +     gate = platform_get_drvdata(pdev);
>> +
>> +     mutex_lock(&gate->gate_lock);
>> +     freeze = reg_rd(gate, iag_rd);
>> +     if (freeze) {           /* gate is opened */
>> +             xleaf_broadcast_event(pdev, XRT_EVENT_PRE_GATE_CLOSE, false);
>> +             freeze_gate(gate);
>> +     }
>> +
>> +     gate->gate_freezed = true;
> Looks like freeze could be 0, so is setting gate_freeze = true correct all the time ?
added checking for freeze_gate(). if it succeed, gate will be frozen 
(closed).
>> +     mutex_unlock(&gate->gate_lock);
>> +
>> +     xrt_info(pdev, "freeze gate %s", gate->ep_name);
>> +}
>> +
>> +static void xrt_axigate_free(struct platform_device *pdev)
>> +{
>> +     struct xrt_axigate      *gate;
>> +     u32                     freeze;
>> +
>> +     gate = platform_get_drvdata(pdev);
>> +
>> +     mutex_lock(&gate->gate_lock);
>> +     freeze = reg_rd(gate, iag_rd);
>> +     if (!freeze) {          /* gate is closed */
>> +             free_gate(gate);
>> +             xleaf_broadcast_event(pdev, XRT_EVENT_POST_GATE_OPEN, true);
>> +             /* xrt_axigate_free() could be called in event cb, thus
>> +              * we can not wait for the completes
>> +              */
>> +     }
>> +
>> +     gate->gate_freezed = false;
> freezed is not a word, the element name should be 'gate_frozen'
Will change to gate_closed.
>> +     mutex_unlock(&gate->gate_lock);
>> +
>> +     xrt_info(pdev, "free gate %s", gate->ep_name);
>> +}
>> +
>> +static void xrt_axigate_event_cb(struct platform_device *pdev, void *arg)
>> +{
>> +     struct platform_device *leaf;
>> +     struct xrt_event *evt = (struct xrt_event *)arg;
>> +     enum xrt_events e = evt->xe_evt;
>> +     enum xrt_subdev_id id = evt->xe_subdev.xevt_subdev_id;
>> +     int instance = evt->xe_subdev.xevt_subdev_instance;
>> +     struct xrt_axigate *gate = platform_get_drvdata(pdev);
>> +     struct resource *res;
>> +
>> +     switch (e) {
>> +     case XRT_EVENT_POST_CREATION:
>> +             break;
>> +     default:
>> +             return;
>> +     }
> convert switch() to if ()
Sure.
>> +
>> +     if (id != XRT_SUBDEV_AXIGATE)
>> +             return;
>> +
>> +     leaf = xleaf_get_leaf_by_id(pdev, id, instance);
>> +     if (!leaf)
>> +             return;
>> +
>> +     res = platform_get_resource(leaf, IORESOURCE_MEM, 0);
>> +     if (!res || !strncmp(res->name, gate->ep_name, strlen(res->name) + 1)) {
>> +             (void)xleaf_put_leaf(pdev, leaf);
>> +             return;
>> +     }
>> +
>> +     /*
>> +      * higher level axigate instance created,
>> +      * make sure the gate is openned. This covers 1RP flow which
> is openned -> is opened
sure.
>
> what is 1RP ?
1RP flow is one of hardware shell build flow. It is xilinx internal term 
I will remove this sentence.

Thanks,
Lizhi
>
> Tom
>
>> +      * has plp gate as well.
>> +      */
>> +     if (xrt_axigate_epname_idx(leaf) > xrt_axigate_epname_idx(pdev))
>> +             xrt_axigate_free(pdev);
>> +     else
>> +             xleaf_ioctl(leaf, XRT_AXIGATE_FREE, NULL);
>> +
>> +     (void)xleaf_put_leaf(pdev, leaf);
>> +}
>> +
>> +static int
>> +xrt_axigate_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
>> +{
>> +     switch (cmd) {
>> +     case XRT_XLEAF_EVENT:
>> +             xrt_axigate_event_cb(pdev, arg);
>> +             break;
>> +     case XRT_AXIGATE_FREEZE:
>> +             xrt_axigate_freeze(pdev);
>> +             break;
>> +     case XRT_AXIGATE_FREE:
>> +             xrt_axigate_free(pdev);
>> +             break;
>> +     default:
>> +             xrt_err(pdev, "unsupported cmd %d", cmd);
>> +             return -EINVAL;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int xrt_axigate_remove(struct platform_device *pdev)
>> +{
>> +     struct xrt_axigate      *gate;
>> +
>> +     gate = platform_get_drvdata(pdev);
>> +
>> +     if (gate->base)
>> +             iounmap(gate->base);
>> +
>> +     platform_set_drvdata(pdev, NULL);
>> +     devm_kfree(&pdev->dev, gate);
>> +
>> +     return 0;
>> +}
>> +
>> +static int xrt_axigate_probe(struct platform_device *pdev)
>> +{
>> +     struct xrt_axigate      *gate;
>> +     struct resource         *res;
>> +     int                     ret;
>> +
>> +     gate = devm_kzalloc(&pdev->dev, sizeof(*gate), GFP_KERNEL);
>> +     if (!gate)
>> +             return -ENOMEM;
>> +
>> +     gate->pdev = pdev;
>> +     platform_set_drvdata(pdev, gate);
>> +
>> +     xrt_info(pdev, "probing...");
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     if (!res) {
>> +             xrt_err(pdev, "Empty resource 0");
>> +             ret = -EINVAL;
>> +             goto failed;
>> +     }
>> +
>> +     gate->base = ioremap(res->start, res->end - res->start + 1);
>> +     if (!gate->base) {
>> +             xrt_err(pdev, "map base iomem failed");
>> +             ret = -EFAULT;
>> +             goto failed;
>> +     }
>> +
>> +     gate->ep_name = res->name;
>> +
>> +     mutex_init(&gate->gate_lock);
>> +
>> +     return 0;
>> +
>> +failed:
>> +     xrt_axigate_remove(pdev);
>> +     return ret;
>> +}
>> +
>> +static struct xrt_subdev_endpoints xrt_axigate_endpoints[] = {
>> +     {
>> +             .xse_names = (struct xrt_subdev_ep_names[]) {
>> +                     { .ep_name = "ep_pr_isolate_ulp_00" },
>> +                     { NULL },
>> +             },
>> +             .xse_min_ep = 1,
>> +     },
>> +     {
>> +             .xse_names = (struct xrt_subdev_ep_names[]) {
>> +                     { .ep_name = "ep_pr_isolate_plp_00" },
>> +                     { NULL },
>> +             },
>> +             .xse_min_ep = 1,
>> +     },
>> +     { 0 },
>> +};
>> +
>> +static struct xrt_subdev_drvdata xrt_axigate_data = {
>> +     .xsd_dev_ops = {
>> +             .xsd_ioctl = xrt_axigate_leaf_ioctl,
>> +     },
>> +};
>> +
>> +static const struct platform_device_id xrt_axigate_table[] = {
>> +     { XRT_AXIGATE, (kernel_ulong_t)&xrt_axigate_data },
>> +     { },
>> +};
>> +
>> +static struct platform_driver xrt_axigate_driver = {
>> +     .driver = {
>> +             .name = XRT_AXIGATE,
>> +     },
>> +     .probe = xrt_axigate_probe,
>> +     .remove = xrt_axigate_remove,
>> +     .id_table = xrt_axigate_table,
>> +};
>> +
>> +void axigate_leaf_init_fini(bool init)
>> +{
>> +     if (init) {
>> +             xleaf_register_driver(XRT_SUBDEV_AXIGATE,
>> +                                   &xrt_axigate_driver, xrt_axigate_endpoints);
>> +     } else {
>> +             xleaf_unregister_driver(XRT_SUBDEV_AXIGATE);
>> +     }
>> +}

