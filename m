Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF9333DEFC
	for <lists+linux-fpga@lfdr.de>; Tue, 16 Mar 2021 21:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhCPUi4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 16 Mar 2021 16:38:56 -0400
Received: from mail-dm3nam07on2049.outbound.protection.outlook.com ([40.107.95.49]:27467
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231463AbhCPUiv (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 16 Mar 2021 16:38:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3700kFvMzhUStsVTuIROoacFdV466HMb3rdzk5UnRmaXrx33kAjx+sUYePtzeGuRe119ooAwtc9cTjGUNEHd+HrqpNvMOwgqE+GiViuSudE+zv7jA5+zhID8pKhdE6P2YRLTOvW+AUs/B2UrUxS3Hf6lNVLXqQC/+2tEuHiJDStJi0F6X3a+qWmYE9Xb3TKehXPHK/fIQWyU2EOX9sjYaLPXaADo/NS1DhMjDdEkgKUKaHFWDcYF1IzLJOZiKTWrXSg2xj3FTUJoFeAJW9P4KCLRTYK4sSdsJUQ39/ZK8IgnLW12QNj2J53kpt6sApQVOZSwqxtkONU5UA1+E9fZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sbI002qn+F/yaGmA3fqtjH+kM0O8NkPdKfR/nCc7CQ=;
 b=kQ8FaAdMu7U8jiDLs2ZPpIv/IrJ3PzcmKBAJqutEHQTdS1nwaY4zesUArsuWKDq/LrnDwprPG6WFWibKPNPQrKjP7k2jj7fASgYEZlR5DfV+3W/ql2UcTnRS+ffo8inyYq1hrq10pI825rsi+JaqRhG6180vhsChg7PAK+CXZxSsIgKr1qvL9aBvXQ3oJnBG2NMfcKny1L9sdr6PxCbYiaMG36z872g6laD7zDobZG1wrf1QfZEygwIvjlBFeM/LN+wN30rzvflC8dofvYWIueUGrGXgARIcErk0DiDtxS4YQZ3ecfix+nmFRW109HGNjHBUvglusxdr51b7t52E0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sbI002qn+F/yaGmA3fqtjH+kM0O8NkPdKfR/nCc7CQ=;
 b=r5Ke5SxjvdgHw1gzrvwrO1NYNk9htbzyVqejTpIg5Tpzm8gM7ybj8633e/v6XpKJri3NBPEbmenn9vt9t+htD72GMQd9MrW3QoRhyi2JlOHCW6b1n7/oK1AqVKODC5lpI9xTNJirZjS70zdKRYeFEjUex1QHv0blof3YwCO7P20=
Received: from DM6PR11CA0054.namprd11.prod.outlook.com (2603:10b6:5:14c::31)
 by BN7PR02MB4995.namprd02.prod.outlook.com (2603:10b6:408:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 20:38:47 +0000
Received: from DM3NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::68) by DM6PR11CA0054.outlook.office365.com
 (2603:10b6:5:14c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend
 Transport; Tue, 16 Mar 2021 20:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT033.mail.protection.outlook.com (10.13.4.101) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3933.32 via Frontend Transport; Tue, 16 Mar 2021 20:38:47 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Mar 2021 13:38:46 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 16 Mar 2021 13:38:46 -0700
Envelope-to: robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 mdf@kernel.org
Received: from [10.17.2.60] (port=54204)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lMGSk-0006hc-GO; Tue, 16 Mar 2021 13:38:46 -0700
Subject: Re: [PATCH V3 XRT Alveo 17/18] fpga: xrt: partition isolation
 platform driver
To:     Moritz Fischer <mdf@kernel.org>, Lizhi Hou <lizhi.hou@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <robh@kernel.org>,
        Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-18-lizhih@xilinx.com> <YDLEO6Bg6ySSoupI@archbook>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <299b66ff-817d-8a01-6fa9-56f7739fdd92@xilinx.com>
Date:   Tue, 16 Mar 2021 13:38:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <YDLEO6Bg6ySSoupI@archbook>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4cafcd3-2db1-47fb-1e56-08d8e8bb7fd7
X-MS-TrafficTypeDiagnostic: BN7PR02MB4995:
X-Microsoft-Antispam-PRVS: <BN7PR02MB4995B207896F75CE0138A04AA16B9@BN7PR02MB4995.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: taP3pu90DxDbMKNOOVPC9c970tVLl22rFx51vWsZJND+w2Hr/qBh65fh43P9VlNqdHUxfrVuuQKuevYH9OSy6RyAcsXlNP3N3ESNaTs1B4szgAsquVA/N1xUz0h9wTCuGIixDu80CX0dldGSKu4d+lBbGAdWGMWdIi0Rls1Lpp3gpwDUKiLgeDbvryXtOblpj/M/U27Rxjq/svjOd9CEeH5Yif6X0rSX7jOICea4bbHeU3gSRXQ3+pV7gVb1NBmTydPvnwnLVYRJ71AwBebW+U8j0vyHv5YVCpVVlEyPikGKtDHVrLmsnwFGcC2C3XPMYkb1NNw2ypQry/yZmsEggLyOWbU0O8rD1fo7zeN48FKiR7P8hyKyB8Aev30v70c41TtS0xPKCTtT3cAIyX83dRaMAx3n0tW+sqop4+70dps8GPpmTizpFwGWJIdqakTWfYjDwtj4MvKsiKI/gdjKbuqPfg/2DToU63tbMwd9un++ChQsDRv6B9sHg60KUNM3cCSrV+JSq61EBaXfBVCHiPsLz8MCcAJriDJQn1qB66qwLqm49ZlVmTXPDIGvX0WlZcrjU+j5fR7r+iJFLlDuGr3oXLX0IZeOV2Lg/XX2wACXp6luwACnUZ8OHn9T2SQWgP5g+VY8CINNKPe8Ej5V8uscZHksat6R5FlIKSNHh5uATc6jXnANyi8uystOd3a3LOT7fK6wZevfivh0UqdE7Q==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(376002)(39850400004)(396003)(346002)(46966006)(36840700001)(44832011)(107886003)(8676002)(30864003)(426003)(7636003)(5660300002)(9786002)(47076005)(2906002)(356005)(36756003)(26005)(36860700001)(2616005)(53546011)(82310400003)(478600001)(82740400003)(70206006)(4326008)(83380400001)(316002)(110136005)(31686004)(54906003)(8936002)(31696002)(70586007)(186003)(336012)(36906005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 20:38:47.3358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4cafcd3-2db1-47fb-1e56-08d8e8bb7fd7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT033.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4995
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,


On 02/21/2021 12:36 PM, Moritz Fischer wrote:
>
> On Wed, Feb 17, 2021 at 10:40:18PM -0800, Lizhi Hou wrote:
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
> Just make them #defines, even more so if there are only 3 of them.
We will use #define and regmap.
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
>> +     ndelay(500);
>> +     reg_rd(gate, iag_rd);
>> +}
>> +
>> +static inline void free_gate(struct xrt_axigate *gate)
>> +{
>> +     reg_wr(gate, 0x2, iag_wr);
>> +     ndelay(500);
> Magic constants?
Will use #define for 500
>> +     (void)reg_rd(gate, iag_rd);
> At the very least add a comment on why? Is this for PCI synchronization
> reasons?
Will add comment. Some old board requires this extra read and it will 
not hurt performance.
>
>> +     reg_wr(gate, 0x3, iag_wr);
>> +     ndelay(500);
> Magic constants?
>> +     reg_rd(gate, iag_rd);
> Does it nead a (void) or not? Be consistent, again, why do we read here
> at all?
>> +}
>> +
>> +static int xrt_axigate_epname_idx(struct platform_device *pdev)
>> +{
>> +     int                     i;
>> +     int                     ret;
>> +     struct resource         *res;
> Nope. Indents:
>
> struct resource *res;
> int, i, ret;
Will change this.
>
>> +
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     if (!res) {
>> +             xrt_err(pdev, "Empty Resource!");
>> +             return -EINVAL;
>> +     }
>> +
>> +     for (i = 0; xrt_axigate_epnames[i]; i++) {
>> +             ret = strncmp(xrt_axigate_epnames[i], res->name,
>> +                           strlen(xrt_axigate_epnames[i]) + 1);
>> +             if (!ret)
>> +                     break;
>> +     }
>> +
>> +     ret = (xrt_axigate_epnames[i]) ? i : -EINVAL;
> Why not just:
>
>          if (xrt_axigate_epnames[i])
>                  return i;
>
>          return -EINVAL;
Will change this.
>> +     return ret;
>> +}
>> +
>> +static void xrt_axigate_freeze(struct platform_device *pdev)
>> +{
>> +     struct xrt_axigate      *gate;
>> +     u32                     freeze = 0;
> Indents. Fix everywhere.
Will fix this.
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
> s/freezed/frozen
Will change terms to open / close.
>> +     mutex_unlock(&gate->gate_lock);
>> +
>> +     xrt_info(pdev, "freeze gate %s", gate->ep_name);
> debug?
axigate is a very critical part for programming FPGA. We hope to have an 
explicit printk to indicate the axigate open/close.
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
> Reverse x-mas tree;
> xxxxxxxxxx
> xxxxxxxxx
> xxxxxxxx
> xxxxxx
Will fix this.
>> +
>> +     switch (e) {
>> +     case XRT_EVENT_POST_CREATION:
>> +             break;
>> +     default:
>> +             return;
>> +     }
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
> No! The point of using devres is so cleanup happens on removal.
> While you're at it, if you move the ioremap to a devres version, this
> function can basically go away entirely.
Will fix this.
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
> This thing is duplicated in every file, maybe a macro would be an idea.
Will define a macro.

Thanks,
Lizhi
>> --
>> 2.18.4
>>
> - Moritz

